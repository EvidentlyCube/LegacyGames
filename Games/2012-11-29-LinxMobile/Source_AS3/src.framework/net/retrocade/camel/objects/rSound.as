package net.retrocade.camel.objects{
    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.camel.global.retrocamel_int;

    use namespace retrocamel_int;
    
    public class rSound{
        /****************************************************************************************************************/
        /**                                                                                                     STATIC  */
        /****************************************************************************************************************/
        
        /**
         * A static SoundTransform used for all volume changes 
         */
        private static var _staticTransform:SoundTransform = new SoundTransform();
        /**
         * Generates a SoundTransform object with a preset 
         * @return SoundTransform object 
         */
        private static function getSoundTransform(volume:Number, pan:Number):SoundTransform{
            _staticTransform.volume = rSfx.soundVolume * volume;
            _staticTransform.pan    = pan;
            
            return _staticTransform;
        }
        
        
        
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Sound properties
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        /**
         * The actual sound instance which is played 
         */
        private var _sound      :Sound;
        
        /**
         * The offset which is applied to each played sound. It indicates in milliseconds where the sound
         * should start playback. 
         */
        private var _startOffset:uint;
        
        /**
         * SoundChannel instance of the currently played sound 
         */
        private var _soundChannel:SoundChannel;
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Current sound playback information
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        /**
         * The time when the sound has been paused 
         */
        private var _pauseTime :int    = -1;
        
        /**
         * Time in milliseconds when the sound was paused. -1 if it is not paused
         */
        public function get pauseTime():int{
            return _pauseTime;
        }
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Loops
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        /**
         * The amount of loops left 
         */
        private var _loops     :uint   = 0;
        
        /**
         * The amount of loops left. Does nothing if sound is not currently being played 
         */
        public function get loops():uint{
            return _loops
        }
        
        /**
         * @private 
         */
        public function set loops(value:uint):void{
            _loops = value;
        }
       
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Runtime :: Volume
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        /**
         * The volume modifier <0-1> 
         */
        private var _playVolume:Number = 1;
        
        /**
         * Volume modifier of the played sound (if the sound is not playing it does nothing) 
         */
        public function get volume():Number{
            return _playVolume;
        }
        
        /**
         * @private 
         */
        public function set volume(value:Number):void{
            _playVolume = value;
            
            updateSoundTransform();
        }
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Runtime :: Pan
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        /**
         * Current sound's pan <-1 - 1> 
         */
        private var _playPan:Number = 0;
        
        /**
         * Pan modifier of the played sound (if the sound is not playing it does nothing) 
         */
        public function get pan():Number{
            return _playPan;
        }
        
        /**
         * @private 
         */
        public function set pan(value:Number):void{
            _playPan = value;
            
            updateSoundTransform();
        }
        
        
        
        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/
        
        /**
         * Creates a new instance of the rSound class 
         * @param sound Sound instance or a class which, when instantiated, extends Sound
         * @param startOffset Starting offset in milliseconds if the sound begins with some silence
         */
        public function rSound(sound:*, startOffset:uint = 0){
            if (sound is Class)
                sound = rSfx.getS(sound);
            
            if (sound is Sound)
                _sound = sound;
            else
                throw new ArgumentError("Sound has to be either an instance of Sound or a class which instantiates to Sound");
            
            _startOffset = startOffset;
        }
        
        /**
         * Plays this sound 
         * @param loop The number of times the sound should loop
         * @param volumeModifier The volume modifier <0, 1>
         */
        public function play(loop:uint = 0, volumeModifier:Number = 1, pan:Number = 0):void{
            if (volumeModifier < 0 || volumeModifier > 1)
                throw new ArgumentError("volumeModifier has to be a float number between 0 and 1 (both inclusive)");
            
            if (pan < -1 || pan > 1)
                throw new ArgumentError("pan has to be a float number between -1 and 1 (both inclusive)");
            
            var soundTransform:SoundTransform = getSoundTransform(volumeModifier, pan);
            
            soundTransform.volume *= volumeModifier;
            
            _pauseTime  = -1;
            _playVolume = volumeModifier;
            _playPan    = pan;
            _loops      = loop;
            
            _soundChannel = _sound.play(_startOffset, 0, soundTransform);
            
            _soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundCompleted, false, 0, true);
        }
        
        /**
         * Pauses the sound. It can be later resumed with rSound:resume()
         */
        public function pause():void{
            if (!_soundChannel)
                return;
            
            _pauseTime = _soundChannel.position;
            _soundChannel.stop();
            _soundChannel = null;
            _loops        = 0;
        }
        
        /**
         * Stops the sound playback 
         */
        public function stop():void{
            if (!_soundChannel)
                return;
            
            _soundChannel.stop();
            _soundChannel = null;
            _loops        = 0;
        }
        
        /**
         * Resumes a previously paused sound. 
         */
        public function resume():void{
            if (_pauseTime == -1)
                return;
            
            var soundTransform:SoundTransform = getSoundTransform(_playVolume, _playPan);
            
            soundTransform.volume *= _playVolume;
            
            _soundChannel = _sound.play(_pauseTime, 0, soundTransform);
            _soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundCompleted, false, 0, true);
            
            _pauseTime = -1;
        }
        
        retrocamel_int function updateSoundTransform():void{
            if (_soundChannel)
                _soundChannel.soundTransform = getSoundTransform(_playVolume, _playPan);
        }
        
        
        
        
        /****************************************************************************************************************/
        /**                                                                                            EVENT LISTENERS  */
        /****************************************************************************************************************/
        
        /**
         * Called when sound stops playing, clears data and optionally loops the sound.
         */
        private function onSoundCompleted(e:Event):void{
            _soundChannel = null;
            
            if (_loops > 0){
                _loops--;
                play(_loops, _playVolume);
            } else {
                _soundChannel = null;
                _loops        = 0;
            }
        }
    }
}