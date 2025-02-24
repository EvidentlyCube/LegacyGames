package net.retrocade.tacticengine.monstro.global.core {
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;

    public class VoicesSfx {
        public static function init():void{
            VoicesSfxImpl.init();
        }

        public static function playReady(unit:EnumUnitType):Boolean {
            return VoicesSfxImpl.playReady(unit);
        }
        public static function playMove(unit:EnumUnitType):Boolean {
            return VoicesSfxImpl.playMove(unit);
        }
        public static function playHit(unit:EnumUnitType):Boolean {
            return VoicesSfxImpl.playHit(unit);
        }
        public static function playDie(unit:EnumUnitType):Boolean {
            return VoicesSfxImpl.playDie(unit);
        }
    }
}

CF::desktop {
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.filesystem.File;
    import flash.media.Sound;
    import flash.media.SoundTransform;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;

    import net.retrocade.tacticengine.monstro.global.core.MonstroData;

    import net.retrocade.random.Random;
    import net.retrocade.retrocamel.core.RetrocamelSoundManager;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
    import net.retrocade.utils.UtilsArray;

    class VoicesSfxImpl {
        private static var _readyDictionary:Dictionary;
        private static var _moveDictionary:Dictionary;
        private static var _hitDictionary:Dictionary;
        private static var _dieDictionary:Dictionary;

        private static var _soundTransform:SoundTransform = new SoundTransform();

        public static function init():void{
            _readyDictionary = new Dictionary();
            _moveDictionary = new Dictionary();
            _hitDictionary = new Dictionary();
            _dieDictionary = new Dictionary();

            _readyDictionary[EnumUnitType.ARCHER] = [loadSound('Archer_ready_1'), loadSound('Archer_ready_2'), loadSound('Archer_ready_3')];
            _readyDictionary[EnumUnitType.CAVALRY] = [loadSound('Cavalry_ready_1'), loadSound('Cavalry_ready_2'), loadSound('Cavalry_ready_3')];
            _readyDictionary[EnumUnitType.GARGOYLE] = [loadSound('Gargoyle_ready_1'), loadSound('Gargoyle_ready_2'), loadSound('Gargoyle_ready_3')];
            _readyDictionary[EnumUnitType.GOO] = [loadSound('Goo_ready_1'), loadSound('Goo_ready_2'), loadSound('Goo_ready_3')];
            _readyDictionary[EnumUnitType.GRUNT] = [loadSound('Grunt_ready_1'), loadSound('Grunt_ready_2'), loadSound('Grunt_ready_3')];
            _readyDictionary[EnumUnitType.KNIGHT] = [loadSound('Knight_ready_1'), loadSound('Knight_ready_2'), loadSound('Knight_ready_3')];
            _readyDictionary[EnumUnitType.MANTICORE] = [loadSound('Manticore_ready_1'), loadSound('Manticore_ready_2'), loadSound('Manticore_ready_3')];
            _readyDictionary[EnumUnitType.MINOTAUR] = [loadSound('Minotaur_ready_1'), loadSound('Minotaur_ready_2'), loadSound('Minotaur_ready_3')];
            _readyDictionary[EnumUnitType.PIKEMAN] = [loadSound('Pikeman_ready_1'), loadSound('Pikeman_ready_2'), loadSound('Pikeman_ready_3')];
            _readyDictionary[EnumUnitType.SHROOM] = [loadSound('Shroom_ready_1'), loadSound('Shroom_ready_2'), loadSound('Shroom_ready_3')];
            _readyDictionary[EnumUnitType.SLIME] = [loadSound('Slime_ready_1'), loadSound('Slime_ready_2'), loadSound('Slime_ready_3')];
            _readyDictionary[EnumUnitType.SOLDIER] = [loadSound('Soldier_ready_1'), loadSound('Soldier_ready_2'), loadSound('Soldier_ready_3')];

            _moveDictionary[EnumUnitType.ARCHER] = [loadSound('Archer_move_1'), loadSound('Archer_move_2'), loadSound('Archer_move_3')];
            _moveDictionary[EnumUnitType.CAVALRY] = [loadSound('Cavalry_move_1'), loadSound('Cavalry_move_2'), loadSound('Cavalry_move_3')];
            _moveDictionary[EnumUnitType.GARGOYLE] = [loadSound('Gargoyle_move_1'), loadSound('Gargoyle_move_2'), loadSound('Gargoyle_move_3')];
            _moveDictionary[EnumUnitType.GOO] = [loadSound('Goo_move_1'), loadSound('Goo_move_2'), loadSound('Goo_move_3')];
            _moveDictionary[EnumUnitType.GRUNT] = [loadSound('Grunt_move_1'), loadSound('Grunt_move_2'), loadSound('Grunt_move_3')];
            _moveDictionary[EnumUnitType.KNIGHT] = [loadSound('Knight_move_1'), loadSound('Knight_move_2'), loadSound('Knight_move_3')];
            _moveDictionary[EnumUnitType.MANTICORE] = [loadSound('Manticore_move_1'), loadSound('Manticore_move_2'), loadSound('Manticore_move_3')];
            _moveDictionary[EnumUnitType.MINOTAUR] = [loadSound('Minotaur_move_1'), loadSound('Minotaur_move_2'), loadSound('Minotaur_move_3')];
            _moveDictionary[EnumUnitType.PIKEMAN] = [loadSound('Pikeman_move_1'), loadSound('Pikeman_move_2'), loadSound('Pikeman_move_3')];
            _moveDictionary[EnumUnitType.SHROOM] = [loadSound('Shroom_move_1'), loadSound('Shroom_move_2'), loadSound('Shroom_move_3')];
            _moveDictionary[EnumUnitType.SLIME] = [loadSound('Slime_move_1'), loadSound('Slime_move_2'), loadSound('Slime_move_3')];
            _moveDictionary[EnumUnitType.SOLDIER] = [loadSound('Soldier_move_1'), loadSound('Soldier_move_2'), loadSound('Soldier_move_3')];

            _hitDictionary[EnumUnitType.ARCHER] = [loadSound('Archer_hit_1'), loadSound('Archer_hit_2'), loadSound('Archer_hit_3')];
            _hitDictionary[EnumUnitType.CAVALRY] = [loadSound('Cavalry_hit_1'), loadSound('Cavalry_hit_2'), loadSound('Cavalry_hit_3')];
            _hitDictionary[EnumUnitType.GARGOYLE] = [loadSound('Gargoyle_hit_1'), loadSound('Gargoyle_hit_2'), loadSound('Gargoyle_hit_3')];
            _hitDictionary[EnumUnitType.GOO] = [loadSound('Goo_hit_1'), loadSound('Goo_hit_2'), loadSound('Goo_hit_3')];
            _hitDictionary[EnumUnitType.GRUNT] = [loadSound('Grunt_hit_1'), loadSound('Grunt_hit_2'), loadSound('Grunt_hit_3')];
            _hitDictionary[EnumUnitType.KNIGHT] = [loadSound('Knight_hit_1'), loadSound('Knight_hit_2'), loadSound('Knight_hit_3')];
            _hitDictionary[EnumUnitType.MANTICORE] = [loadSound('Manticore_hit_1'), loadSound('Manticore_hit_2'), loadSound('Manticore_hit_3')];
            _hitDictionary[EnumUnitType.MINOTAUR] = [loadSound('Minotaur_hit_1'), loadSound('Minotaur_hit_2'), loadSound('Minotaur_hit_3')];
            _hitDictionary[EnumUnitType.PIKEMAN] = [loadSound('Pikeman_hit_1'), loadSound('Pikeman_hit_2'), loadSound('Pikeman_hit_3')];
            _hitDictionary[EnumUnitType.SHROOM] = [loadSound('Shroom_hit_1'), loadSound('Shroom_hit_2'), loadSound('Shroom_hit_3')];
            _hitDictionary[EnumUnitType.SLIME] = [loadSound('Slime_hit_1'), loadSound('Slime_hit_2'), loadSound('Slime_hit_3')];
            _hitDictionary[EnumUnitType.SOLDIER] = [loadSound('Soldier_hit_1'), loadSound('Soldier_hit_2'), loadSound('Soldier_hit_3')];

            _dieDictionary[EnumUnitType.ARCHER] = [loadSound('Archer_die_1'), loadSound('Archer_die_2'), loadSound('Archer_die_3')];
            _dieDictionary[EnumUnitType.CAVALRY] = [loadSound('Cavalry_die_1'), loadSound('Cavalry_die_2'), loadSound('Cavalry_die_3')];
            _dieDictionary[EnumUnitType.GARGOYLE] = [loadSound('Gargoyle_die_1'), loadSound('Gargoyle_die_2'), loadSound('Gargoyle_die_3')];
            _dieDictionary[EnumUnitType.GOO] = [loadSound('Goo_die_1'), loadSound('Goo_die_2'), loadSound('Goo_die_3')];
            _dieDictionary[EnumUnitType.GRUNT] = [loadSound('Grunt_die_1'), loadSound('Grunt_die_2'), loadSound('Grunt_die_3')];
            _dieDictionary[EnumUnitType.KNIGHT] = [loadSound('Knight_die_1'), loadSound('Knight_die_2'), loadSound('Knight_die_3')];
            _dieDictionary[EnumUnitType.MANTICORE] = [loadSound('Manticore_die_1'), loadSound('Manticore_die_2'), loadSound('Manticore_die_3')];
            _dieDictionary[EnumUnitType.MINOTAUR] = [loadSound('Minotaur_die_1'), loadSound('Minotaur_die_2'), loadSound('Minotaur_die_3')];
            _dieDictionary[EnumUnitType.PIKEMAN] = [loadSound('Pikeman_die_1'), loadSound('Pikeman_die_2'), loadSound('Pikeman_die_3')];
            _dieDictionary[EnumUnitType.SHROOM] = [loadSound('Shroom_die_1'), loadSound('Shroom_die_2'), loadSound('Shroom_die_3')];
            _dieDictionary[EnumUnitType.SLIME] = [loadSound('Slime_die_1'), loadSound('Slime_die_2')];
            _dieDictionary[EnumUnitType.SOLDIER] = [loadSound('Soldier_die_1'), loadSound('Soldier_die_2'), loadSound('Soldier_die_3')];

            var array:Array;
            for each (array in _readyDictionary) {
                if (array){
                    UtilsArray.shuffleArray(array);
                }
            }
            for each (array in _moveDictionary) {
                if (array){
                    UtilsArray.shuffleArray(array);
                }
            }
            for each (array in _hitDictionary) {
                if (array){
                    UtilsArray.shuffleArray(array);
                }
            }
            for each (array in _dieDictionary) {
                if (array){
                    UtilsArray.shuffleArray(array);
                }
            }
        }

        private static function loadSound(name:String):Sound{
            var urlRequest:URLRequest = new URLRequest(File.applicationDirectory.resolvePath('voices').resolvePath(name + ".mp3").url);
            var sound:Sound = new Sound(urlRequest);

            return sound;
        }
        private static function playRandomVoice(voices:Array):Boolean{
            if (!voices || voices.length < 1 || !MonstroData.getVoicesEnabled()){
                return false;
            }

            _soundTransform.volume = MonstroData.getVoicesVolume();

            var s:Sound = voices.shift();
            voices.push(s);
            if (Random.defaultEngine.getPercentChance(10)){
                UtilsArray.shuffleArray(voices);
            }
            s.play(0, 0, _soundTransform);

            return true;
        }

        public static function playReady(unit:EnumUnitType):Boolean {
            return playRandomVoice(_readyDictionary[unit]);
        }
        public static function playMove(unit:EnumUnitType):Boolean {
            return playRandomVoice(_moveDictionary[unit]);
        }
        public static function playHit(unit:EnumUnitType):Boolean {
            return playRandomVoice(_hitDictionary[unit]);
        }
        public static function playDie(unit:EnumUnitType):Boolean {
            return playRandomVoice(_dieDictionary[unit]);
        }

    }
}

CF::flash {
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.media.Sound;
    import flash.media.SoundTransform;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;

    import net.retrocade.tacticengine.monstro.global.core.MonstroData;

    import net.retrocade.random.Random;
    import net.retrocade.retrocamel.core.RetrocamelSoundManager;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
    import net.retrocade.utils.UtilsArray;

    class VoicesSfxImpl {
        [Embed(source="/../assets/voices/Archer_ready_1.mp3")] private static var Archer_ready_1_class: Class;
        [Embed(source="/../assets/voices/Archer_ready_2.mp3")] private static var Archer_ready_2_class: Class;
        [Embed(source="/../assets/voices/Archer_ready_3.mp3")] private static var Archer_ready_3_class: Class;
        [Embed(source="/../assets/voices/Cavalry_ready_1.mp3")] private static var Cavalry_ready_1_class: Class;
        [Embed(source="/../assets/voices/Cavalry_ready_2.mp3")] private static var Cavalry_ready_2_class: Class;
        [Embed(source="/../assets/voices/Cavalry_ready_3.mp3")] private static var Cavalry_ready_3_class: Class;
        [Embed(source="/../assets/voices/Gargoyle_ready_1.mp3")] private static var Gargoyle_ready_1_class: Class;
        [Embed(source="/../assets/voices/Gargoyle_ready_2.mp3")] private static var Gargoyle_ready_2_class: Class;
        [Embed(source="/../assets/voices/Gargoyle_ready_3.mp3")] private static var Gargoyle_ready_3_class: Class;
        [Embed(source="/../assets/voices/Goo_ready_1.mp3")] private static var Goo_ready_1_class: Class;
        [Embed(source="/../assets/voices/Goo_ready_2.mp3")] private static var Goo_ready_2_class: Class;
        [Embed(source="/../assets/voices/Goo_ready_3.mp3")] private static var Goo_ready_3_class: Class;
        [Embed(source="/../assets/voices/Grunt_ready_1.mp3")] private static var Grunt_ready_1_class: Class;
        [Embed(source="/../assets/voices/Grunt_ready_2.mp3")] private static var Grunt_ready_2_class: Class;
        [Embed(source="/../assets/voices/Grunt_ready_3.mp3")] private static var Grunt_ready_3_class: Class;
        [Embed(source="/../assets/voices/Knight_ready_1.mp3")] private static var Knight_ready_1_class: Class;
        [Embed(source="/../assets/voices/Knight_ready_2.mp3")] private static var Knight_ready_2_class: Class;
        [Embed(source="/../assets/voices/Knight_ready_3.mp3")] private static var Knight_ready_3_class: Class;
        [Embed(source="/../assets/voices/Manticore_ready_1.mp3")] private static var Manticore_ready_1_class: Class;
        [Embed(source="/../assets/voices/Manticore_ready_2.mp3")] private static var Manticore_ready_2_class: Class;
        [Embed(source="/../assets/voices/Manticore_ready_3.mp3")] private static var Manticore_ready_3_class: Class;
        [Embed(source="/../assets/voices/Minotaur_ready_1.mp3")] private static var Minotaur_ready_1_class: Class;
        [Embed(source="/../assets/voices/Minotaur_ready_2.mp3")] private static var Minotaur_ready_2_class: Class;
        [Embed(source="/../assets/voices/Minotaur_ready_3.mp3")] private static var Minotaur_ready_3_class: Class;
        [Embed(source="/../assets/voices/Pikeman_ready_1.mp3")] private static var Pikeman_ready_1_class: Class;
        [Embed(source="/../assets/voices/Pikeman_ready_2.mp3")] private static var Pikeman_ready_2_class: Class;
        [Embed(source="/../assets/voices/Pikeman_ready_3.mp3")] private static var Pikeman_ready_3_class: Class;
        [Embed(source="/../assets/voices/Shroom_ready_1.mp3")] private static var Shroom_ready_1_class: Class;
        [Embed(source="/../assets/voices/Shroom_ready_2.mp3")] private static var Shroom_ready_2_class: Class;
        [Embed(source="/../assets/voices/Shroom_ready_3.mp3")] private static var Shroom_ready_3_class: Class;
        [Embed(source="/../assets/voices/Slime_ready_1.mp3")] private static var Slime_ready_1_class: Class;
        [Embed(source="/../assets/voices/Slime_ready_2.mp3")] private static var Slime_ready_2_class: Class;
        [Embed(source="/../assets/voices/Slime_ready_3.mp3")] private static var Slime_ready_3_class: Class;
        [Embed(source="/../assets/voices/Soldier_ready_1.mp3")] private static var Soldier_ready_1_class: Class;
        [Embed(source="/../assets/voices/Soldier_ready_2.mp3")] private static var Soldier_ready_2_class: Class;
        [Embed(source="/../assets/voices/Soldier_ready_3.mp3")] private static var Soldier_ready_3_class: Class;
        [Embed(source="/../assets/voices/Archer_move_1.mp3")] private static var Archer_move_1_class: Class;
        [Embed(source="/../assets/voices/Archer_move_2.mp3")] private static var Archer_move_2_class: Class;
        [Embed(source="/../assets/voices/Archer_move_3.mp3")] private static var Archer_move_3_class: Class;
        [Embed(source="/../assets/voices/Cavalry_move_1.mp3")] private static var Cavalry_move_1_class: Class;
        [Embed(source="/../assets/voices/Cavalry_move_2.mp3")] private static var Cavalry_move_2_class: Class;
        [Embed(source="/../assets/voices/Cavalry_move_3.mp3")] private static var Cavalry_move_3_class: Class;
        [Embed(source="/../assets/voices/Gargoyle_move_1.mp3")] private static var Gargoyle_move_1_class: Class;
        [Embed(source="/../assets/voices/Gargoyle_move_2.mp3")] private static var Gargoyle_move_2_class: Class;
        [Embed(source="/../assets/voices/Gargoyle_move_3.mp3")] private static var Gargoyle_move_3_class: Class;
        [Embed(source="/../assets/voices/Goo_move_1.mp3")] private static var Goo_move_1_class: Class;
        [Embed(source="/../assets/voices/Goo_move_2.mp3")] private static var Goo_move_2_class: Class;
        [Embed(source="/../assets/voices/Goo_move_3.mp3")] private static var Goo_move_3_class: Class;
        [Embed(source="/../assets/voices/Grunt_move_1.mp3")] private static var Grunt_move_1_class: Class;
        [Embed(source="/../assets/voices/Grunt_move_2.mp3")] private static var Grunt_move_2_class: Class;
        [Embed(source="/../assets/voices/Grunt_move_3.mp3")] private static var Grunt_move_3_class: Class;
        [Embed(source="/../assets/voices/Knight_move_1.mp3")] private static var Knight_move_1_class: Class;
        [Embed(source="/../assets/voices/Knight_move_2.mp3")] private static var Knight_move_2_class: Class;
        [Embed(source="/../assets/voices/Knight_move_3.mp3")] private static var Knight_move_3_class: Class;
        [Embed(source="/../assets/voices/Manticore_move_1.mp3")] private static var Manticore_move_1_class: Class;
        [Embed(source="/../assets/voices/Manticore_move_2.mp3")] private static var Manticore_move_2_class: Class;
        [Embed(source="/../assets/voices/Manticore_move_3.mp3")] private static var Manticore_move_3_class: Class;
        [Embed(source="/../assets/voices/Minotaur_move_1.mp3")] private static var Minotaur_move_1_class: Class;
        [Embed(source="/../assets/voices/Minotaur_move_2.mp3")] private static var Minotaur_move_2_class: Class;
        [Embed(source="/../assets/voices/Minotaur_move_3.mp3")] private static var Minotaur_move_3_class: Class;
        [Embed(source="/../assets/voices/Pikeman_move_1.mp3")] private static var Pikeman_move_1_class: Class;
        [Embed(source="/../assets/voices/Pikeman_move_2.mp3")] private static var Pikeman_move_2_class: Class;
        [Embed(source="/../assets/voices/Pikeman_move_3.mp3")] private static var Pikeman_move_3_class: Class;
        [Embed(source="/../assets/voices/Shroom_move_1.mp3")] private static var Shroom_move_1_class: Class;
        [Embed(source="/../assets/voices/Shroom_move_2.mp3")] private static var Shroom_move_2_class: Class;
        [Embed(source="/../assets/voices/Shroom_move_3.mp3")] private static var Shroom_move_3_class: Class;
        [Embed(source="/../assets/voices/Slime_move_1.mp3")] private static var Slime_move_1_class: Class;
        [Embed(source="/../assets/voices/Slime_move_2.mp3")] private static var Slime_move_2_class: Class;
        [Embed(source="/../assets/voices/Slime_move_3.mp3")] private static var Slime_move_3_class: Class;
        [Embed(source="/../assets/voices/Soldier_move_1.mp3")] private static var Soldier_move_1_class: Class;
        [Embed(source="/../assets/voices/Soldier_move_2.mp3")] private static var Soldier_move_2_class: Class;
        [Embed(source="/../assets/voices/Soldier_move_3.mp3")] private static var Soldier_move_3_class: Class;
        [Embed(source="/../assets/voices/Archer_hit_1.mp3")] private static var Archer_hit_1_class: Class;
        [Embed(source="/../assets/voices/Archer_hit_2.mp3")] private static var Archer_hit_2_class: Class;
        [Embed(source="/../assets/voices/Archer_hit_3.mp3")] private static var Archer_hit_3_class: Class;
        [Embed(source="/../assets/voices/Cavalry_hit_1.mp3")] private static var Cavalry_hit_1_class: Class;
        [Embed(source="/../assets/voices/Cavalry_hit_2.mp3")] private static var Cavalry_hit_2_class: Class;
        [Embed(source="/../assets/voices/Cavalry_hit_3.mp3")] private static var Cavalry_hit_3_class: Class;
        [Embed(source="/../assets/voices/Gargoyle_hit_1.mp3")] private static var Gargoyle_hit_1_class: Class;
        [Embed(source="/../assets/voices/Gargoyle_hit_2.mp3")] private static var Gargoyle_hit_2_class: Class;
        [Embed(source="/../assets/voices/Gargoyle_hit_3.mp3")] private static var Gargoyle_hit_3_class: Class;
        [Embed(source="/../assets/voices/Goo_hit_1.mp3")] private static var Goo_hit_1_class: Class;
        [Embed(source="/../assets/voices/Goo_hit_2.mp3")] private static var Goo_hit_2_class: Class;
        [Embed(source="/../assets/voices/Goo_hit_3.mp3")] private static var Goo_hit_3_class: Class;
        [Embed(source="/../assets/voices/Grunt_hit_1.mp3")] private static var Grunt_hit_1_class: Class;
        [Embed(source="/../assets/voices/Grunt_hit_2.mp3")] private static var Grunt_hit_2_class: Class;
        [Embed(source="/../assets/voices/Grunt_hit_3.mp3")] private static var Grunt_hit_3_class: Class;
        [Embed(source="/../assets/voices/Knight_hit_1.mp3")] private static var Knight_hit_1_class: Class;
        [Embed(source="/../assets/voices/Knight_hit_2.mp3")] private static var Knight_hit_2_class: Class;
        [Embed(source="/../assets/voices/Knight_hit_3.mp3")] private static var Knight_hit_3_class: Class;
        [Embed(source="/../assets/voices/Manticore_hit_1.mp3")] private static var Manticore_hit_1_class: Class;
        [Embed(source="/../assets/voices/Manticore_hit_2.mp3")] private static var Manticore_hit_2_class: Class;
        [Embed(source="/../assets/voices/Manticore_hit_3.mp3")] private static var Manticore_hit_3_class: Class;
        [Embed(source="/../assets/voices/Minotaur_hit_1.mp3")] private static var Minotaur_hit_1_class: Class;
        [Embed(source="/../assets/voices/Minotaur_hit_2.mp3")] private static var Minotaur_hit_2_class: Class;
        [Embed(source="/../assets/voices/Minotaur_hit_3.mp3")] private static var Minotaur_hit_3_class: Class;
        [Embed(source="/../assets/voices/Pikeman_hit_1.mp3")] private static var Pikeman_hit_1_class: Class;
        [Embed(source="/../assets/voices/Pikeman_hit_2.mp3")] private static var Pikeman_hit_2_class: Class;
        [Embed(source="/../assets/voices/Pikeman_hit_3.mp3")] private static var Pikeman_hit_3_class: Class;
        [Embed(source="/../assets/voices/Shroom_hit_1.mp3")] private static var Shroom_hit_1_class: Class;
        [Embed(source="/../assets/voices/Shroom_hit_2.mp3")] private static var Shroom_hit_2_class: Class;
        [Embed(source="/../assets/voices/Shroom_hit_3.mp3")] private static var Shroom_hit_3_class: Class;
        [Embed(source="/../assets/voices/Slime_hit_1.mp3")] private static var Slime_hit_1_class: Class;
        [Embed(source="/../assets/voices/Slime_hit_2.mp3")] private static var Slime_hit_2_class: Class;
        [Embed(source="/../assets/voices/Slime_hit_3.mp3")] private static var Slime_hit_3_class: Class;
        [Embed(source="/../assets/voices/Soldier_hit_1.mp3")] private static var Soldier_hit_1_class: Class;
        [Embed(source="/../assets/voices/Soldier_hit_2.mp3")] private static var Soldier_hit_2_class: Class;
        [Embed(source="/../assets/voices/Soldier_hit_3.mp3")] private static var Soldier_hit_3_class: Class;
        [Embed(source="/../assets/voices/Archer_die_1.mp3")] private static var Archer_die_1_class: Class;
        [Embed(source="/../assets/voices/Archer_die_2.mp3")] private static var Archer_die_2_class: Class;
        [Embed(source="/../assets/voices/Archer_die_3.mp3")] private static var Archer_die_3_class: Class;
        [Embed(source="/../assets/voices/Cavalry_die_1.mp3")] private static var Cavalry_die_1_class: Class;
        [Embed(source="/../assets/voices/Cavalry_die_2.mp3")] private static var Cavalry_die_2_class: Class;
        [Embed(source="/../assets/voices/Cavalry_die_3.mp3")] private static var Cavalry_die_3_class: Class;
        [Embed(source="/../assets/voices/Gargoyle_die_1.mp3")] private static var Gargoyle_die_1_class: Class;
        [Embed(source="/../assets/voices/Gargoyle_die_2.mp3")] private static var Gargoyle_die_2_class: Class;
        [Embed(source="/../assets/voices/Gargoyle_die_3.mp3")] private static var Gargoyle_die_3_class: Class;
        [Embed(source="/../assets/voices/Goo_die_1.mp3")] private static var Goo_die_1_class: Class;
        [Embed(source="/../assets/voices/Goo_die_2.mp3")] private static var Goo_die_2_class: Class;
        [Embed(source="/../assets/voices/Goo_die_3.mp3")] private static var Goo_die_3_class: Class;
        [Embed(source="/../assets/voices/Grunt_die_1.mp3")] private static var Grunt_die_1_class: Class;
        [Embed(source="/../assets/voices/Grunt_die_2.mp3")] private static var Grunt_die_2_class: Class;
        [Embed(source="/../assets/voices/Grunt_die_3.mp3")] private static var Grunt_die_3_class: Class;
        [Embed(source="/../assets/voices/Knight_die_1.mp3")] private static var Knight_die_1_class: Class;
        [Embed(source="/../assets/voices/Knight_die_2.mp3")] private static var Knight_die_2_class: Class;
        [Embed(source="/../assets/voices/Knight_die_3.mp3")] private static var Knight_die_3_class: Class;
        [Embed(source="/../assets/voices/Manticore_die_1.mp3")] private static var Manticore_die_1_class: Class;
        [Embed(source="/../assets/voices/Manticore_die_2.mp3")] private static var Manticore_die_2_class: Class;
        [Embed(source="/../assets/voices/Manticore_die_3.mp3")] private static var Manticore_die_3_class: Class;
        [Embed(source="/../assets/voices/Minotaur_die_1.mp3")] private static var Minotaur_die_1_class: Class;
        [Embed(source="/../assets/voices/Minotaur_die_2.mp3")] private static var Minotaur_die_2_class: Class;
        [Embed(source="/../assets/voices/Minotaur_die_3.mp3")] private static var Minotaur_die_3_class: Class;
        [Embed(source="/../assets/voices/Pikeman_die_1.mp3")] private static var Pikeman_die_1_class: Class;
        [Embed(source="/../assets/voices/Pikeman_die_2.mp3")] private static var Pikeman_die_2_class: Class;
        [Embed(source="/../assets/voices/Pikeman_die_3.mp3")] private static var Pikeman_die_3_class: Class;
        [Embed(source="/../assets/voices/Shroom_die_1.mp3")] private static var Shroom_die_1_class: Class;
        [Embed(source="/../assets/voices/Shroom_die_2.mp3")] private static var Shroom_die_2_class: Class;
        [Embed(source="/../assets/voices/Shroom_die_3.mp3")] private static var Shroom_die_3_class: Class;
        [Embed(source="/../assets/voices/Slime_die_1.mp3")] private static var Slime_die_1_class: Class;
        [Embed(source="/../assets/voices/Slime_die_2.mp3")] private static var Slime_die_2_class: Class;
        [Embed(source="/../assets/voices/Soldier_die_1.mp3")] private static var Soldier_die_1_class: Class;
        [Embed(source="/../assets/voices/Soldier_die_2.mp3")] private static var Soldier_die_2_class: Class;
        [Embed(source="/../assets/voices/Soldier_die_3.mp3")] private static var Soldier_die_3_class: Class;

        private static var _readyDictionary:Dictionary;
        private static var _moveDictionary:Dictionary;
        private static var _hitDictionary:Dictionary;
        private static var _dieDictionary:Dictionary;

        private static var _soundTransform:SoundTransform = new SoundTransform();

        public static function init():void{
            _readyDictionary = new Dictionary();
            _moveDictionary = new Dictionary();
            _hitDictionary = new Dictionary();
            _dieDictionary = new Dictionary();

            _readyDictionary[EnumUnitType.ARCHER] = [
                loadSound(Archer_ready_1_class),
                loadSound(Archer_ready_2_class),
                loadSound(Archer_ready_3_class)
            ];
            _readyDictionary[EnumUnitType.CAVALRY] = [
                loadSound(Cavalry_ready_1_class),
                loadSound(Cavalry_ready_2_class),
                loadSound(Cavalry_ready_3_class)
            ];
            _readyDictionary[EnumUnitType.GARGOYLE] = [
                loadSound(Gargoyle_ready_1_class),
                loadSound(Gargoyle_ready_2_class),
                loadSound(Gargoyle_ready_3_class)
            ];
            _readyDictionary[EnumUnitType.GOO] = [
                loadSound(Goo_ready_1_class),
                loadSound(Goo_ready_2_class),
                loadSound(Goo_ready_3_class)
            ];
            _readyDictionary[EnumUnitType.GRUNT] = [
                loadSound(Grunt_ready_1_class),
                loadSound(Grunt_ready_2_class),
                loadSound(Grunt_ready_3_class)
            ];
            _readyDictionary[EnumUnitType.KNIGHT] = [
                loadSound(Knight_ready_1_class),
                loadSound(Knight_ready_2_class),
                loadSound(Knight_ready_3_class)
            ];
            _readyDictionary[EnumUnitType.MANTICORE] = [
                loadSound(Manticore_ready_1_class),
                loadSound(Manticore_ready_2_class),
                loadSound(Manticore_ready_3_class)
            ];
            _readyDictionary[EnumUnitType.MINOTAUR] = [
                loadSound(Minotaur_ready_1_class),
                loadSound(Minotaur_ready_2_class),
                loadSound(Minotaur_ready_3_class)
            ];
            _readyDictionary[EnumUnitType.PIKEMAN] = [
                loadSound(Pikeman_ready_1_class),
                loadSound(Pikeman_ready_2_class),
                loadSound(Pikeman_ready_3_class)
            ];
            _readyDictionary[EnumUnitType.SHROOM] = [
                loadSound(Shroom_ready_1_class),
                loadSound(Shroom_ready_2_class),
                loadSound(Shroom_ready_3_class)
            ];
            _readyDictionary[EnumUnitType.SLIME] = [
                loadSound(Slime_ready_1_class),
                loadSound(Slime_ready_2_class),
                loadSound(Slime_ready_3_class)
            ];
            _readyDictionary[EnumUnitType.SOLDIER] = [
                loadSound(Soldier_ready_1_class),
                loadSound(Soldier_ready_2_class),
                loadSound(Soldier_ready_3_class)
            ];

            _moveDictionary[EnumUnitType.ARCHER] = [
                loadSound(Archer_move_1_class),
                loadSound(Archer_move_2_class),
                loadSound(Archer_move_3_class)
            ];
            _moveDictionary[EnumUnitType.CAVALRY] = [
                loadSound(Cavalry_move_1_class),
                loadSound(Cavalry_move_2_class),
                loadSound(Cavalry_move_3_class)
            ];
            _moveDictionary[EnumUnitType.GARGOYLE] = [
                loadSound(Gargoyle_move_1_class),
                loadSound(Gargoyle_move_2_class),
                loadSound(Gargoyle_move_3_class)
            ];
            _moveDictionary[EnumUnitType.GOO] = [
                loadSound(Goo_move_1_class),
                loadSound(Goo_move_2_class),
                loadSound(Goo_move_3_class)
            ];
            _moveDictionary[EnumUnitType.GRUNT] = [
                loadSound(Grunt_move_1_class),
                loadSound(Grunt_move_2_class),
                loadSound(Grunt_move_3_class)
            ];
            _moveDictionary[EnumUnitType.KNIGHT] = [
                loadSound(Knight_move_1_class),
                loadSound(Knight_move_2_class),
                loadSound(Knight_move_3_class)
            ];
            _moveDictionary[EnumUnitType.MANTICORE] = [
                loadSound(Manticore_move_1_class),
                loadSound(Manticore_move_2_class),
                loadSound(Manticore_move_3_class)
            ];
            _moveDictionary[EnumUnitType.MINOTAUR] = [
                loadSound(Minotaur_move_1_class),
                loadSound(Minotaur_move_2_class),
                loadSound(Minotaur_move_3_class)
            ];
            _moveDictionary[EnumUnitType.PIKEMAN] = [
                loadSound(Pikeman_move_1_class),
                loadSound(Pikeman_move_2_class),
                loadSound(Pikeman_move_3_class)
            ];
            _moveDictionary[EnumUnitType.SHROOM] = [
                loadSound(Shroom_move_1_class),
                loadSound(Shroom_move_2_class),
                loadSound(Shroom_move_3_class)
            ];
            _moveDictionary[EnumUnitType.SLIME] = [
                loadSound(Slime_move_1_class),
                loadSound(Slime_move_2_class),
                loadSound(Slime_move_3_class)
            ];
            _moveDictionary[EnumUnitType.SOLDIER] = [
                loadSound(Soldier_move_1_class),
                loadSound(Soldier_move_2_class),
                loadSound(Soldier_move_3_class)
            ];

            _hitDictionary[EnumUnitType.ARCHER] = [
                loadSound(Archer_hit_1_class),
                loadSound(Archer_hit_2_class),
                loadSound(Archer_hit_3_class)
            ];
            _hitDictionary[EnumUnitType.CAVALRY] = [
                loadSound(Cavalry_hit_1_class),
                loadSound(Cavalry_hit_2_class),
                loadSound(Cavalry_hit_3_class)
            ];
            _hitDictionary[EnumUnitType.GARGOYLE] = [
                loadSound(Gargoyle_hit_1_class),
                loadSound(Gargoyle_hit_2_class),
                loadSound(Gargoyle_hit_3_class)
            ];
            _hitDictionary[EnumUnitType.GOO] = [
                loadSound(Goo_hit_1_class),
                loadSound(Goo_hit_2_class),
                loadSound(Goo_hit_3_class)
            ];
            _hitDictionary[EnumUnitType.GRUNT] = [
                loadSound(Grunt_hit_1_class),
                loadSound(Grunt_hit_2_class),
                loadSound(Grunt_hit_3_class)
            ];
            _hitDictionary[EnumUnitType.KNIGHT] = [
                loadSound(Knight_hit_1_class),
                loadSound(Knight_hit_2_class),
                loadSound(Knight_hit_3_class)
            ];
            _hitDictionary[EnumUnitType.MANTICORE] = [
                loadSound(Manticore_hit_1_class),
                loadSound(Manticore_hit_2_class),
                loadSound(Manticore_hit_3_class)
            ];
            _hitDictionary[EnumUnitType.MINOTAUR] = [
                loadSound(Minotaur_hit_1_class),
                loadSound(Minotaur_hit_2_class),
                loadSound(Minotaur_hit_3_class)
            ];
            _hitDictionary[EnumUnitType.PIKEMAN] = [
                loadSound(Pikeman_hit_1_class),
                loadSound(Pikeman_hit_2_class),
                loadSound(Pikeman_hit_3_class)
            ];
            _hitDictionary[EnumUnitType.SHROOM] = [
                loadSound(Shroom_hit_1_class),
                loadSound(Shroom_hit_2_class),
                loadSound(Shroom_hit_3_class)
            ];
            _hitDictionary[EnumUnitType.SLIME] = [
                loadSound(Slime_hit_1_class),
                loadSound(Slime_hit_2_class),
                loadSound(Slime_hit_3_class)
            ];
            _hitDictionary[EnumUnitType.SOLDIER] = [
                loadSound(Soldier_hit_1_class),
                loadSound(Soldier_hit_2_class),
                loadSound(Soldier_hit_3_class)
            ];

            _dieDictionary[EnumUnitType.ARCHER] = [
                loadSound(Archer_die_1_class),
                loadSound(Archer_die_2_class),
                loadSound(Archer_die_3_class)
            ];
            _dieDictionary[EnumUnitType.CAVALRY] = [
                loadSound(Cavalry_die_1_class),
                loadSound(Cavalry_die_2_class),
                loadSound(Cavalry_die_3_class)
            ];
            _dieDictionary[EnumUnitType.GARGOYLE] = [
                loadSound(Gargoyle_die_1_class),
                loadSound(Gargoyle_die_2_class),
                loadSound(Gargoyle_die_3_class)
            ];
            _dieDictionary[EnumUnitType.GOO] = [
                loadSound(Goo_die_1_class),
                loadSound(Goo_die_2_class),
                loadSound(Goo_die_3_class)
            ];
            _dieDictionary[EnumUnitType.GRUNT] = [
                loadSound(Grunt_die_1_class),
                loadSound(Grunt_die_2_class),
                loadSound(Grunt_die_3_class)
            ];
            _dieDictionary[EnumUnitType.KNIGHT] = [
                loadSound(Knight_die_1_class),
                loadSound(Knight_die_2_class),
                loadSound(Knight_die_3_class)
            ];
            _dieDictionary[EnumUnitType.MANTICORE] = [
                loadSound(Manticore_die_1_class),
                loadSound(Manticore_die_2_class),
                loadSound(Manticore_die_3_class)
            ];
            _dieDictionary[EnumUnitType.MINOTAUR] = [
                loadSound(Minotaur_die_1_class),
                loadSound(Minotaur_die_2_class),
                loadSound(Minotaur_die_3_class)
            ];
            _dieDictionary[EnumUnitType.PIKEMAN] = [
                loadSound(Pikeman_die_1_class),
                loadSound(Pikeman_die_2_class),
                loadSound(Pikeman_die_3_class)
            ];
            _dieDictionary[EnumUnitType.SHROOM] = [
                loadSound(Shroom_die_1_class),
                loadSound(Shroom_die_2_class),
                loadSound(Shroom_die_3_class)
            ];
            _dieDictionary[EnumUnitType.SLIME] = [
                loadSound(Slime_die_1_class),
                loadSound(Slime_die_2_class)
            ];
            _dieDictionary[EnumUnitType.SOLDIER] = [
                loadSound(Soldier_die_1_class),
                loadSound(Soldier_die_2_class),
                loadSound(Soldier_die_3_class)
            ];

            var array:Array;
            for each (array in _readyDictionary) {
                if (array){
                    UtilsArray.shuffleArray(array);
                }
            }
            for each (array in _moveDictionary) {
                if (array){
                    UtilsArray.shuffleArray(array);
                }
            }
            for each (array in _hitDictionary) {
                if (array){
                    UtilsArray.shuffleArray(array);
                }
            }
            for each (array in _dieDictionary) {
                if (array){
                    UtilsArray.shuffleArray(array);
                }
            }
        }

        private static function loadSound(cls:Class):Sound{
            return new cls();
        }
        private static function playRandomVoice(voices:Array):Boolean{
            if (!voices || voices.length < 1 || !MonstroData.getVoicesEnabled()){
                return false;
            }

            _soundTransform.volume = MonstroData.getVoicesVolume();

            var s:Sound = voices.shift();
            voices.push(s);
            if (Random.defaultEngine.getPercentChance(10)){
                UtilsArray.shuffleArray(voices);
            }
            s.play(0, 0, _soundTransform);

            return true;
        }

        public static function playReady(unit:EnumUnitType):Boolean {
            return playRandomVoice(_readyDictionary[unit]);
        }
        public static function playMove(unit:EnumUnitType):Boolean {
            return playRandomVoice(_moveDictionary[unit]);
        }
        public static function playHit(unit:EnumUnitType):Boolean {
            return playRandomVoice(_hitDictionary[unit]);
        }
        public static function playDie(unit:EnumUnitType):Boolean {
            return playRandomVoice(_dieDictionary[unit]);
        }

    }
}
