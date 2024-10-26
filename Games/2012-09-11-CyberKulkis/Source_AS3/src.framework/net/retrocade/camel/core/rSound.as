package net.retrocade.camel.core{
    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    import flash.utils.Dictionary;

    use namespace retrocamel_int;

    public class rSound{

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Music Variables
        // ::::::::::::::::::::::::::::::::::::::::::::::

        retrocamel_int static var _musicTransform    :SoundTransform = new SoundTransform(1);
        retrocamel_int static var _musicVolume       :Number = 1;
        retrocamel_int static var _musicLastPlayed   :Sound;
        retrocamel_int static var _musicPausePosition:Number = NaN;
        retrocamel_int static var _musicLastPosition :Number = NaN;



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Music Volume
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Accesses the volume of music, the one set in the options. Changing this will nullify the temporary volume
         */
        public static function get musicVolume():Number{
            return _musicVolume;
        }

        /**
         * @private
         */
        public static function set musicVolume(value:Number):void{
            _musicVolume = value;
            _musicTransform.volume = _musicVolume;

            if (_currentMusic)
                _currentMusic.soundTransform = _musicTransform;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Music Temporary Volume
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Changes a temporary music volume (mostly using for fading and stuff)
         */
        public static function set musicTempVolume(value:Number):void{
            _musicTransform.volume = value;

            if (_currentMusic)
                _currentMusic.soundTransform = _musicTransform;
        }

        /**
         * @private
         */
        public static function get musicTempVolume():Number{
            return _musicTransform.volume;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Music Misc
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Resets the temporary volume and sets the volume the one set in options
         */
        public static function musicVolumeResetTemp():void{
            musicVolume = musicVolume;
        }

        /**
         * Returns the position of the music when it was stopped last time
         */
        public static function get musicLastPosition():Number{
            return _musicLastPosition;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Music Status
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Returns true if the music is paused
         */
        public static function musicIsPaused():Boolean{
            return !isNaN(_musicPausePosition);
        }

        /**
         * Returns true if music is currently playing
         */
        public static function musicIsPlaying():Boolean{
            return _currentMusic != null;
        }

        public static function get musicPosition():Number{
            return _currentMusic ? _currentMusic.position : 0;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Sound
        // ::::::::::::::::::::::::::::::::::::::::::::::

        retrocamel_int static var _soundVolume:SoundTransform = new SoundTransform(1);

        public static function get soundVolume():Number{
            return _soundVolume.volume;
        }

        public static function set soundVolume(value:Number):void{
            _soundVolume.volume = value;
        }

        private static var _soundsLibrary:Dictionary = new Dictionary();



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Current Music
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private static var _currentMusic:SoundChannel;

        private static var _currentMusicRepeatCount:uint;



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: SoundChannel Library
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private static var _allPlayedSounds:Array = [];
        private static var _namedSounds    :Array = [];




        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        public static function playMusic(sfx:Sound, position:Number = 0, repeats:Number = NaN, onRepeat:Function = null):void{
            if (isNaN(repeats))
                repeats = _currentMusicRepeatCount;

            stopMusic();

            _currentMusicRepeatCount = repeats;

            if (position != 0){
                _currentMusic       = sfx.play(position, 0, _musicTransform);

                if (onRepeat == null)
                    _currentMusic.addEventListener(Event.SOUND_COMPLETE, loopMusic, false, 0, true);
                else
                    _currentMusic.addEventListener(Event.SOUND_COMPLETE, onRepeat, false, 0, true);

            } else {
                _currentMusic       = sfx.play(0, repeats, _musicTransform);

                if (onRepeat != null)
                    _currentMusic.addEventListener(Event.SOUND_COMPLETE, onRepeat, false, 0, true);
                else
                    _currentMusic.addEventListener(Event.SOUND_COMPLETE, musicFinished, false, 0, true);
            }

            _musicLastPlayed    = sfx;
            _musicPausePosition = NaN;
        }

        public static function pauseMusic():void{
            if (_currentMusic){
                _musicPausePosition = _currentMusic.position;
                _currentMusic.stop();
                _currentMusic = null;
            }
        }

        public static function resumeMusic():void{
            if (!_currentMusic && _musicLastPlayed && !isNaN(_musicPausePosition))
                playMusic(_musicLastPlayed, _musicPausePosition);
        }

        public static function stopMusic():void{
            if (_currentMusic){
                _musicLastPosition = _currentMusic.position;
                _currentMusic.stop();
                musicVolumeResetTemp();
                _currentMusic    = null;
                _musicLastPlayed = null;
            }
        }

        public static function stopAllSounds():void{
            var i:uint = _allPlayedSounds.length;

            while (i--){
                var sound:SoundChannel = _allPlayedSounds[i] as SoundChannel;

                if (sound)
                    sound.stop();
            }

            _allPlayedSounds.length = 0;
        }

        /**
         * Plays a sound effect. If you specify a soundName, the sound is remembered to be played and will be stopped
         * before playing another sound with the same name. You can also provide a custom volume.
         * @param sound Sound effect to play, be it Class (in which case it will be instantiated and saved in the
         * library) or Sound.
         * @param soundName Name of the sound to make sure only one sound with the same name is playing at the same time
         * @param soundVolume Custom volume, if set to NaN it will use the default volume
         * @param soundPan Panning of the sound effect
         * @return SoundChannel of the sound played
         */
        public static function playSound(sound:*, soundName:String = null, soundVolume:Number = NaN, soundPan:Number = 0):SoundChannel{
            if (sound is Class){
                if (!_soundsLibrary[sound])
                    _soundsLibrary[sound] = new sound();

                sound = _soundsLibrary[sound];
            }

            var volume:SoundTransform = _soundVolume;

            if (!isNaN(soundVolume))
                volume = new SoundTransform(soundVolume, soundPan);

            if (volume.volume < 0.01) {
                return null;
            }

            var sc:SoundChannel = Sound(sound).play(25, 0, volume);

            if (!sc)
                return null;

            sc.addEventListener(Event.SOUND_COMPLETE, onSoundPlaybackFinished);

            _allPlayedSounds.push(sc);

            if (soundName){
                if (_namedSounds[soundName])
                    SoundChannel(_namedSounds[soundName]).stop();

                _namedSounds[soundName] = sc;
            }

            return sc;
        }

        private static function loopMusic(e:Event):void{
            if (_currentMusicRepeatCount > 0)
                playMusic(_musicLastPlayed, 0, _currentMusicRepeatCount - 1);

            else
                musicFinished(e);
        }

        private static function musicFinished(e:Event):void{
            _currentMusic = null;
        }

        private static function onSoundPlaybackFinished(e:Event):void{
            var index:int = _allPlayedSounds.indexOf(e.target);

            if (index != -1)
                _allPlayedSounds.splice(index, 1);
        }
    }
}