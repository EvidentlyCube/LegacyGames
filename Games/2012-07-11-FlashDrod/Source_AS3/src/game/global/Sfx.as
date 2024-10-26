package game.global{
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    import game.interfaces.TEffMusicCrossFade;

    import net.retrocade.camel.core.rSound;
    import net.retrocade.utils.Rand;

    CF::play
    public class Sfx {
        [Embed(source = "/../assets/sfx/BeethroScared1.mp3")] private static var _beethroScared1:Class;
        [Embed(source = "/../assets/sfx/BeethroScared2.mp3")] private static var _beethroScared2:Class;
        [Embed(source = "/../assets/sfx/BeethroScared3.mp3")] private static var _beethroScared3:Class;

        [Embed(source = "/../assets/sfx/Bell.mp3")] private static var _bell:Class;

        [Embed(source="/../assets/sfx/BrainsKilled.mp3")] private static var _brainsKilled:Class;

        [Embed(source="/../assets/sfx/ButtonClick.mp3")] private static var _buttonClick:Class;

        [Embed(source="/../assets/sfx/Checkpoint.mp3")] private static var _checkpoint:Class;

        [Embed(source="/../assets/sfx/CrumblyDestroy_1.mp3")] private static var _crumblyDestroy1:Class;
        [Embed(source="/../assets/sfx/CrumblyDestroy_2.mp3")] private static var _crumblyDestroy2:Class;
        [Embed(source="/../assets/sfx/CrumblyDestroy_3.mp3")] private static var _crumblyDestroy3:Class;

        [Embed(source="/../assets/sfx/EvilEyeWake_1.mp3")] private static var _evilEyeWake1:Class;
        [Embed(source="/../assets/sfx/EvilEyeWake_2.mp3")] private static var _evilEyeWake2:Class;
        [Embed(source="/../assets/sfx/EvilEyeWake_3.mp3")] private static var _evilEyeWake3:Class;

        [Embed(source="/../assets/sfx/Gates.mp3")] private static var _gates:Class;

        [Embed(source="/../assets/sfx/HitObstacle_1.mp3")] private static var _hitObstacle1:Class;
        [Embed(source="/../assets/sfx/HitObstacle_2.mp3")] private static var _hitObstacle2:Class;
        [Embed(source="/../assets/sfx/HitObstacle_3.mp3")] private static var _hitObstacle3:Class;

        [Embed(source="/../assets/sfx/MimicPlaced.mp3")] private static var _mimicPlaced:Class;

        [Embed(source="/../assets/sfx/MonsterKilled_1.mp3")] private static var _monsterKill1:Class;
        [Embed(source="/../assets/sfx/MonsterKilled_2.mp3")] private static var _monsterKill2:Class;
        [Embed(source="/../assets/sfx/MonsterKilled_3.mp3")] private static var _monsterKill3:Class;
        [Embed(source="/../assets/sfx/MonsterKilled_4.mp3")] private static var _monsterKill4:Class;
        [Embed(source="/../assets/sfx/MonsterKilled_5.mp3")] private static var _monsterKill5:Class;
        [Embed(source="/../assets/sfx/MonsterKilled_6.mp3")] private static var _monsterKill6:Class;
        [Embed(source="/../assets/sfx/MonsterKilled_7.mp3")] private static var _monsterKill7:Class;
        [Embed(source="/../assets/sfx/MonsterKilled_8.mp3")] private static var _monsterKill8:Class;
        [Embed(source="/../assets/sfx/MonsterKilled_9.mp3")] private static var _monsterKill9:Class;

        [Embed(source="/../assets/sfx/OrbHit.mp3")] private static var _orbHit:Class;

        [Embed(source="/../assets/sfx/PlayerDeath_1.mp3")] private static var _playerDeath1:Class;
        [Embed(source="/../assets/sfx/PlayerDeath_2.mp3")] private static var _playerDeath2:Class;

        [Embed(source="/../assets/sfx/PotionDrank.mp3")] private static var _potionDrank:Class;

        [Embed(source="/../assets/sfx/RoomConquered_1.mp3")] private static var _roomConquered1:Class;
        [Embed(source="/../assets/sfx/RoomConquered_2.mp3")] private static var _roomConquered2:Class;
        [Embed(source="/../assets/sfx/RoomConquered_3.mp3")] private static var _roomConquered3:Class;

        [Embed(source="/../assets/sfx/ScrollRead.mp3")] private static var _scrollRead:Class;

        [Embed(source="/../assets/sfx/ShortHarps.mp3")] private static var _shortHarps:Class;

        [Embed(source="/../assets/sfx/Step_1.mp3")] private static var _step1:Class;
        [Embed(source="/../assets/sfx/Step_2.mp3")] private static var _step2:Class;
        [Embed(source="/../assets/sfx/Step_3.mp3")] private static var _step3:Class;

        [Embed(source="/../assets/sfx/SwordSwing_1.mp3")] private static var _swordSwing1:Class;
        [Embed(source="/../assets/sfx/SwordSwing_2.mp3")] private static var _swordSwing2:Class;
        [Embed(source="/../assets/sfx/SwordSwing_3.mp3")] private static var _swordSwing3:Class;

        [Embed(source="/../assets/sfx/TarSplatter_1.mp3")] private static var _tarSplatter1:Class;
        [Embed(source="/../assets/sfx/TarSplatter_2.mp3")] private static var _tarSplatter2:Class;
        [Embed(source="/../assets/sfx/TarSplatter_3.mp3")] private static var _tarSplatter3:Class;

        [Embed(source="/../assets/sfx/Trapdoor_1.mp3")] private static var _trapdoor1:Class;
        [Embed(source="/../assets/sfx/Trapdoor_2.mp3")] private static var _trapdoor2:Class;
        [Embed(source="/../assets/sfx/Trapdoor_3.mp3")] private static var _trapdoor3:Class;

        private static function play(name:String, random:uint):SoundChannel{
            return rSound.playSound(Sfx["_" + name + (random == 1 ? "" : Rand.u(1, random + 1).toString())], name, Core.volumeEffects);
        }

        public static function beethroScared     ():SoundChannel { return play("beethroScared",  3); }
        public static function brainsKilled      ():SoundChannel { return play("brainsKilled",   1); }
        public static function buttonClick       ():SoundChannel { return play("buttonClick",    1); }
        public static function checkpoint        ():SoundChannel { return play("checkpoint",     1); }
        public static function crumblyWallDestroy():SoundChannel { return play("crumblyDestroy", 3); }
        public static function doublePlaced      ():SoundChannel { return play("mimicPlaced",    1); }
        public static function evilEyeWoke       ():SoundChannel { return play("evilEyeWake",    3); }
        public static function gates             ():SoundChannel { return play("gates",          1); }
        public static function holdMastered      ():SoundChannel { return play("gates",          1); }
        public static function levelCompleted    ():SoundChannel { return play("shortHarps",     1); }
        public static function monsterKilled     ():SoundChannel { return play("monsterKill",    9); }
        public static function orbHit            ():SoundChannel { return play("orbHit",         1); }
        public static function playerDies        ():SoundChannel { return play("playerDeath",    2); }
        public static function playerHitsObstacle():SoundChannel { return play("hitObstacle",    3); }
        public static function playerStep        ():SoundChannel { return play("step",           3); }
        public static function potionDrank       ():SoundChannel { return play("potionDrank",    1); }
        public static function roomConquered     ():SoundChannel { return play("roomConquered",  3); }
        public static function roomLock          ():SoundChannel { return play("bell",           1); }
        public static function scrollRead        ():SoundChannel { return play("scrollRead",     1); }
        public static function secretFound       ():SoundChannel { return play("shortHarps",     1); }
        public static function swordSwing        ():SoundChannel { return play("swordSwing",     3); }
        public static function tarSplatter       ():SoundChannel { return play("tarSplatter",    3); }
        public static function trapdoorFell      ():SoundChannel { return play("trapdoor",       3); }

        public static function optionVoiceText():void {
            rSound.playSound(_roomConquered3, null, Core.volumeVoices);
        }


        /******************************************************************************************************/
        /**                                                                                   MUSIC PLAYBACK  */
        /******************************************************************************************************/


        CF::holdKdd1{
            [Embed(source = "/../assets/music/Kdd1_Ambient.mp3")]  private static var _music_ambient  :Class;
            [Embed(source = "/../assets/music/Kdd1_Attack_1.mp3")] private static var _music_attack_1 :Class;
            [Embed(source = "/../assets/music/Kdd1_Attack_2.mp3")] private static var _music_attack_2 :Class;
            [Embed(source = "/../assets/music/Kdd1_Puzzle_1.mp3")] private static var _music_puzzle_1 :Class;
            [Embed(source = "/../assets/music/Kdd1_Puzzle_2.mp3")] private static var _music_puzzle_2 :Class;
            [Embed(source = "/../assets/music/Kdd1_WinLevel.mp3")] private static var _music_win_level:Class;
        }

        CF::holdKdd2{
            [Embed(source = "/../assets/music/Kdd2_Ambient.mp3")]  private static var _music_ambient  :Class;
            [Embed(source = "/../assets/music/Kdd2_Attack_1.mp3")] private static var _music_attack_1 :Class;
            [Embed(source = "/../assets/music/Kdd2_Attack_2.mp3")] private static var _music_attack_2 :Class;
            [Embed(source = "/../assets/music/Kdd2_Puzzle_1.mp3")] private static var _music_puzzle_1 :Class;
            [Embed(source = "/../assets/music/Kdd2_Puzzle_2.mp3")] private static var _music_puzzle_2 :Class;
            [Embed(source = "/../assets/music/Kdd2_WinLevel.mp3")] private static var _music_win_level:Class;
        }

        CF::holdKdd3{
            [Embed(source = "/../assets/music/Kdd3_Ambient.mp3")]  private static var _music_ambient  :Class;
            [Embed(source = "/../assets/music/Kdd3_Attack_1.mp3")] private static var _music_attack_1 :Class;
            [Embed(source = "/../assets/music/Kdd3_Attack_2.mp3")] private static var _music_attack_2 :Class;
            [Embed(source = "/../assets/music/Kdd3_Puzzle_1.mp3")] private static var _music_puzzle_1 :Class;
            [Embed(source = "/../assets/music/Kdd3_Puzzle_2.mp3")] private static var _music_puzzle_2 :Class;
            [Embed(source = "/../assets/music/Kdd3_WinLevel.mp3")] private static var _music_win_level:Class;
        }

        [Embed(source = "/../assets/music/Credits.mp3")]  private static var _music_credits  :Class;
        [Embed(source = "/../assets/music/Title.mp3")]    private static var _music_title    :Class;


        private static var _currentMusic  :String;
        private static var _currentChannel:SoundChannel;

        public static function get currentChannel():SoundChannel {
            return _currentChannel;
        }

        private static var _crossFades    :Array = [];
        private static var _musicLibrary  :Array = [];

        { init(); }

        private static function init():void {
            _musicLibrary[C.MUSIC_ACTION] = [];
            _musicLibrary[C.MUSIC_PUZZLE] = [];

            _musicLibrary[C.MUSIC_ACTION][0]  = new _music_attack_1;
            _musicLibrary[C.MUSIC_ACTION][1]  = new _music_attack_2;
            _musicLibrary[C.MUSIC_AMBIENT]    = new _music_ambient;
            _musicLibrary[C.MUSIC_LEVEL_EXIT] = new _music_win_level;
            _musicLibrary[C.MUSIC_OUTRO]      = new _music_credits;
            _musicLibrary[C.MUSIC_PUZZLE][0]  = new _music_puzzle_1;
            _musicLibrary[C.MUSIC_PUZZLE][1]  = new _music_puzzle_2;
            _musicLibrary[C.MUSIC_TITLE]      = new _music_title;
        }

        public static function getMusicInstance(musicName:String):Sound {
            var music:* = _musicLibrary[musicName];

            if (music is Array)
                music = music[Rand.u(0, music.length)];

            return music;
        }

        public static function getVolumeTransform():SoundTransform {
            return new SoundTransform(Core.volumeMusic);
        }

        public static function playMusic(music:String):void {
            if (music == _currentMusic)
                return;

            while (_crossFades.length) {
                TEffMusicCrossFade(_crossFades.shift()).stop();
            }

            if (_currentChannel) {
                _crossFades.push(
                    new TEffMusicCrossFade(_currentChannel, false, Core.volumeMusic, 250, soundFinishedCallback)
                );
            }

            ASSERT(getMusicInstance(music));

            _currentMusic   = music;
            _currentChannel = getMusicInstance(music).play(0, 9999, getVolumeTransform());

            _crossFades.push(
                new TEffMusicCrossFade(_currentChannel, true, Core.volumeMusic, 250, soundFinishedCallback)
            );
        }

        public static function crossFadeMusic(music:String):void {
            if (music == _currentMusic)
                return;

            var adds:Array = [];
            for (var i:int = _crossFades.length - 1; i >= _crossFades.length; i--) {
                var effect:TEffMusicCrossFade = TEffMusicCrossFade(_crossFades[i]).invert();

                if (effect){
                    adds.push(effect);
                }
            }
            _crossFades = _crossFades.concat(adds);

            if (_currentChannel){
                _crossFades.push(
                    new TEffMusicCrossFade(_currentChannel, false, Core.volumeMusic, 2500)
                );
            }

            ASSERT(getMusicInstance(music));

            _currentMusic   = music;
            _currentChannel = getMusicInstance(music).play(0, 9999, getVolumeTransform());

            _crossFades.push(
                new TEffMusicCrossFade(_currentChannel, true, Core.volumeMusic, 2500, soundFinishedCallback)
            );
        }

        private static function soundFinishedCallback(effect:TEffMusicCrossFade):void {
            var index:int = _crossFades.indexOf(effect);

            if (index)
                _crossFades.splice(index, 1);
        }

        public static function set volume(vol:Number):void{
            if (_currentChannel)
                _currentChannel.soundTransform = new SoundTransform(vol);
        }
    }

    CF::lib
    public class Sfx {
        public static function beethroScared     ():SoundChannel { return null; }
        public static function brainsKilled      ():SoundChannel { return null; }
        public static function buttonClick       ():SoundChannel { return null; }
        public static function checkpoint        ():SoundChannel { return null; }
        public static function crumblyWallDestroy():SoundChannel { return null; }
        public static function doublePlaced      ():SoundChannel { return null; }
        public static function evilEyeWoke       ():SoundChannel { return null; }
        public static function gates             ():SoundChannel { return null; }
        public static function holdMastered      ():SoundChannel { return null; }
        public static function levelCompleted    ():SoundChannel { return null; }
        public static function monsterKilled     ():SoundChannel { return null; }
        public static function orbHit            ():SoundChannel { return null; }
        public static function playerDies        ():SoundChannel { return null; }
        public static function playerHitsObstacle():SoundChannel { return null; }
        public static function playerStep        ():SoundChannel { return null; }
        public static function potionDrank       ():SoundChannel { return null; }
        public static function roomConquered     ():SoundChannel { return null; }
        public static function roomLock          ():SoundChannel { return null; }
        public static function scrollRead        ():SoundChannel { return null; }
        public static function secretFound       ():SoundChannel { return null; }
        public static function swordSwing        ():SoundChannel { return null; }
        public static function tarSplatter       ():SoundChannel { return null; }
        public static function trapdoorFell      ():SoundChannel { return null; }

        public static function getMusicInstance(musicName:String):Sound { return null; }
        public static function getVolumeTransform():SoundTransform { return null; }
        public static function playMusic(music:String):void {}
        public static function crossFadeMusic(music:String):void {}
        public static function set volume(vol:Number):void { }

        public static function optionVoiceText():void{}
    }
}