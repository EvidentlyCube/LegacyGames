package net.retrocade.tacticengine.monstro.global.core {
    import flash.media.Sound;
    import flash.utils.Dictionary;

    import net.retrocade.random.Random;
    import net.retrocade.retrocamel.core.RetrocamelSoundManager;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
    import net.retrocade.utils.UtilsArray;

    public class VoicesSfxBackup {
//        [Embed(source="/assets/sfx/voices/Archer_ready_1.mp3")] private static var _archer_ready_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Archer_ready_2.mp3")] private static var _archer_ready_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Archer_ready_3.mp3")] private static var _archer_ready_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Archer_move_1.mp3")] private static var _archer_move_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Archer_move_2.mp3")] private static var _archer_move_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Archer_move_3.mp3")] private static var _archer_move_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Archer_die_1.mp3")] private static var _archer_die_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Archer_die_2.mp3")] private static var _archer_die_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Archer_die_3.mp3")] private static var _archer_die_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Archer_hit_1.mp3")] private static var _archer_hit_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Archer_hit_2.mp3")] private static var _archer_hit_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Archer_hit_3.mp3")] private static var _archer_hit_3_class:Class;
//
//        [Embed(source="/assets/sfx/voices/Cavalry_ready_1.mp3")] private static var _cavalry_ready_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Cavalry_ready_2.mp3")] private static var _cavalry_ready_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Cavalry_ready_3.mp3")] private static var _cavalry_ready_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Cavalry_move_1.mp3")] private static var _cavalry_move_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Cavalry_move_2.mp3")] private static var _cavalry_move_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Cavalry_move_3.mp3")] private static var _cavalry_move_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Cavalry_die_1.mp3")] private static var _cavalry_die_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Cavalry_die_2.mp3")] private static var _cavalry_die_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Cavalry_die_3.mp3")] private static var _cavalry_die_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Cavalry_hit_1.mp3")] private static var _cavalry_hit_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Cavalry_hit_2.mp3")] private static var _cavalry_hit_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Cavalry_hit_3.mp3")] private static var _cavalry_hit_3_class:Class;
//
//        [Embed(source="/assets/sfx/voices/Gargoyle_ready_1.mp3")] private static var _gargoyle_ready_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Gargoyle_ready_2.mp3")] private static var _gargoyle_ready_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Gargoyle_ready_3.mp3")] private static var _gargoyle_ready_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Gargoyle_move_1.mp3")] private static var _gargoyle_move_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Gargoyle_move_2.mp3")] private static var _gargoyle_move_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Gargoyle_move_3.mp3")] private static var _gargoyle_move_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Gargoyle_die_1.mp3")] private static var _gargoyle_die_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Gargoyle_die_2.mp3")] private static var _gargoyle_die_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Gargoyle_die_3.mp3")] private static var _gargoyle_die_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Gargoyle_hit_1.mp3")] private static var _gargoyle_hit_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Gargoyle_hit_2.mp3")] private static var _gargoyle_hit_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Gargoyle_hit_3.mp3")] private static var _gargoyle_hit_3_class:Class;
//
//        [Embed(source="/assets/sfx/voices/Goo_ready_1.mp3")] private static var _goo_ready_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Goo_ready_2.mp3")] private static var _goo_ready_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Goo_ready_3.mp3")] private static var _goo_ready_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Goo_move_1.mp3")] private static var _goo_move_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Goo_move_2.mp3")] private static var _goo_move_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Goo_move_3.mp3")] private static var _goo_move_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Goo_die_1.mp3")] private static var _goo_die_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Goo_die_2.mp3")] private static var _goo_die_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Goo_die_3.mp3")] private static var _goo_die_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Goo_hit_1.mp3")] private static var _goo_hit_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Goo_hit_2.mp3")] private static var _goo_hit_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Goo_hit_3.mp3")] private static var _goo_hit_3_class:Class;
//
//        [Embed(source="/assets/sfx/voices/Grunt_ready_1.mp3")] private static var _grunt_ready_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Grunt_ready_2.mp3")] private static var _grunt_ready_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Grunt_ready_3.mp3")] private static var _grunt_ready_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Grunt_move_1.mp3")] private static var _grunt_move_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Grunt_move_2.mp3")] private static var _grunt_move_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Grunt_move_3.mp3")] private static var _grunt_move_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Grunt_die_1.mp3")] private static var _grunt_die_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Grunt_die_2.mp3")] private static var _grunt_die_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Grunt_die_3.mp3")] private static var _grunt_die_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Grunt_hit_1.mp3")] private static var _grunt_hit_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Grunt_hit_2.mp3")] private static var _grunt_hit_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Grunt_hit_3.mp3")] private static var _grunt_hit_3_class:Class;
//
//        [Embed(source="/assets/sfx/voices/Knight_ready_1.mp3")] private static var _knight_ready_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Knight_ready_2.mp3")] private static var _knight_ready_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Knight_ready_3.mp3")] private static var _knight_ready_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Knight_move_1.mp3")] private static var _knight_move_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Knight_move_2.mp3")] private static var _knight_move_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Knight_move_3.mp3")] private static var _knight_move_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Knight_die_1.mp3")] private static var _knight_die_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Knight_die_2.mp3")] private static var _knight_die_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Knight_die_3.mp3")] private static var _knight_die_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Knight_hit_1.mp3")] private static var _knight_hit_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Knight_hit_2.mp3")] private static var _knight_hit_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Knight_hit_3.mp3")] private static var _knight_hit_3_class:Class;
//
//        [Embed(source="/assets/sfx/voices/Manticore_ready_1.mp3")] private static var _manticore_ready_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Manticore_ready_2.mp3")] private static var _manticore_ready_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Manticore_ready_3.mp3")] private static var _manticore_ready_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Manticore_move_1.mp3")] private static var _manticore_move_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Manticore_move_2.mp3")] private static var _manticore_move_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Manticore_move_3.mp3")] private static var _manticore_move_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Manticore_die_1.mp3")] private static var _manticore_die_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Manticore_die_2.mp3")] private static var _manticore_die_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Manticore_die_3.mp3")] private static var _manticore_die_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Manticore_hit_1.mp3")] private static var _manticore_hit_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Manticore_hit_2.mp3")] private static var _manticore_hit_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Manticore_hit_3.mp3")] private static var _manticore_hit_3_class:Class;
//
//        [Embed(source="/assets/sfx/voices/Minotaur_ready_1.mp3")] private static var _minotaur_ready_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Minotaur_ready_2.mp3")] private static var _minotaur_ready_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Minotaur_ready_3.mp3")] private static var _minotaur_ready_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Minotaur_move_1.mp3")] private static var _minotaur_move_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Minotaur_move_2.mp3")] private static var _minotaur_move_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Minotaur_move_3.mp3")] private static var _minotaur_move_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Minotaur_die_1.mp3")] private static var _minotaur_die_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Minotaur_die_2.mp3")] private static var _minotaur_die_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Minotaur_die_3.mp3")] private static var _minotaur_die_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Minotaur_hit_1.mp3")] private static var _minotaur_hit_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Minotaur_hit_2.mp3")] private static var _minotaur_hit_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Minotaur_hit_3.mp3")] private static var _minotaur_hit_3_class:Class;
//
//        [Embed(source="/assets/sfx/voices/Pikeman_ready_1.mp3")] private static var _pikeman_ready_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Pikeman_ready_2.mp3")] private static var _pikeman_ready_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Pikeman_ready_3.mp3")] private static var _pikeman_ready_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Pikeman_move_1.mp3")] private static var _pikeman_move_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Pikeman_move_2.mp3")] private static var _pikeman_move_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Pikeman_move_3.mp3")] private static var _pikeman_move_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Pikeman_die_1.mp3")] private static var _pikeman_die_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Pikeman_die_2.mp3")] private static var _pikeman_die_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Pikeman_die_3.mp3")] private static var _pikeman_die_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Pikeman_hit_1.mp3")] private static var _pikeman_hit_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Pikeman_hit_2.mp3")] private static var _pikeman_hit_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Pikeman_hit_3.mp3")] private static var _pikeman_hit_3_class:Class;
//
//        [Embed(source="/assets/sfx/voices/Shroom_ready_1.mp3")] private static var _shroom_ready_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Shroom_ready_2.mp3")] private static var _shroom_ready_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Shroom_ready_3.mp3")] private static var _shroom_ready_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Shroom_move_1.mp3")] private static var _shroom_move_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Shroom_move_2.mp3")] private static var _shroom_move_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Shroom_move_3.mp3")] private static var _shroom_move_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Shroom_die_1.mp3")] private static var _shroom_die_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Shroom_die_2.mp3")] private static var _shroom_die_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Shroom_die_3.mp3")] private static var _shroom_die_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Shroom_hit_1.mp3")] private static var _shroom_hit_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Shroom_hit_2.mp3")] private static var _shroom_hit_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Shroom_hit_3.mp3")] private static var _shroom_hit_3_class:Class;
//
//        [Embed(source="/assets/sfx/voices/Slime_ready_1.mp3")] private static var _slime_ready_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Slime_ready_2.mp3")] private static var _slime_ready_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Slime_ready_3.mp3")] private static var _slime_ready_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Slime_move_1.mp3")] private static var _slime_move_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Slime_move_2.mp3")] private static var _slime_move_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Slime_move_3.mp3")] private static var _slime_move_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Slime_die_1.mp3")] private static var _slime_die_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Slime_die_2.mp3")] private static var _slime_die_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Slime_hit_1.mp3")] private static var _slime_hit_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Slime_hit_2.mp3")] private static var _slime_hit_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Slime_hit_3.mp3")] private static var _slime_hit_3_class:Class;
//
//        [Embed(source="/assets/sfx/voices/Soldier_ready_1.mp3")] private static var _soldier_ready_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Soldier_ready_2.mp3")] private static var _soldier_ready_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Soldier_ready_3.mp3")] private static var _soldier_ready_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Soldier_move_1.mp3")] private static var _soldier_move_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Soldier_move_2.mp3")] private static var _soldier_move_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Soldier_move_3.mp3")] private static var _soldier_move_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Soldier_die_1.mp3")] private static var _soldier_die_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Soldier_die_2.mp3")] private static var _soldier_die_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Soldier_die_2.mp3")] private static var _soldier_die_3_class:Class;
//        [Embed(source="/assets/sfx/voices/Soldier_hit_1.mp3")] private static var _soldier_hit_1_class:Class;
//        [Embed(source="/assets/sfx/voices/Soldier_hit_2.mp3")] private static var _soldier_hit_2_class:Class;
//        [Embed(source="/assets/sfx/voices/Soldier_hit_3.mp3")] private static var _soldier_hit_3_class:Class;
//
//        private static var _readyDictionary:Dictionary;
//        private static var _moveDictionary:Dictionary;
//        private static var _hitDictionary:Dictionary;
//        private static var _dieDictionary:Dictionary;
//        {
//            init();
//        }
//
//        private static function init():void{
//            _readyDictionary[EnumUnitType.ARCHER] = [_archer_ready_1_class, _archer_ready_2_class, _archer_ready_3_class];
//            _readyDictionary[EnumUnitType.CAVALRY] = [_cavalry_ready_1_class, _cavalry_ready_2_class, _cavalry_ready_3_class];
//            _readyDictionary[EnumUnitType.GARGOYLE] = [_gargoyle_ready_1_class, _gargoyle_ready_2_class, _gargoyle_ready_3_class];
//            _readyDictionary[EnumUnitType.GOO] = [_goo_ready_1_class, _goo_ready_2_class, _goo_ready_3_class];
//            _readyDictionary[EnumUnitType.GRUNT] = [_grunt_ready_1_class, _grunt_ready_2_class, _grunt_ready_3_class];
//            _readyDictionary[EnumUnitType.KNIGHT] = [_knight_ready_1_class, _knight_ready_2_class, _knight_ready_3_class];
//            _readyDictionary[EnumUnitType.MANTICORE] = [_manticore_ready_1_class, _manticore_ready_2_class, _manticore_ready_3_class];
//            _readyDictionary[EnumUnitType.MINOTAUR] = [_minotaur_ready_1_class, _minotaur_ready_2_class, _minotaur_ready_3_class];
//            _readyDictionary[EnumUnitType.PIKEMAN] = [_pikeman_ready_1_class, _pikeman_ready_2_class, _pikeman_ready_3_class];
//            _readyDictionary[EnumUnitType.SHROOM] = [_shroom_ready_1_class, _shroom_ready_2_class, _shroom_ready_3_class];
//            _readyDictionary[EnumUnitType.SLIME] = [_slime_ready_1_class, _slime_ready_2_class, _slime_ready_3_class];
//            _readyDictionary[EnumUnitType.SOLDIER] = [_soldier_ready_1_class, _soldier_ready_2_class, _soldier_ready_3_class];
//
//            _moveDictionary[EnumUnitType.ARCHER] = [_archer_move_1_class, _archer_move_2_class, _archer_move_3_class];
//            _moveDictionary[EnumUnitType.CAVALRY] = [_cavalry_move_1_class, _cavalry_move_2_class, _cavalry_move_3_class];
//            _moveDictionary[EnumUnitType.GARGOYLE] = [_gargoyle_move_1_class, _gargoyle_move_2_class, _gargoyle_move_3_class];
//            _moveDictionary[EnumUnitType.GOO] = [_goo_move_1_class, _goo_move_2_class, _goo_move_3_class];
//            _moveDictionary[EnumUnitType.GRUNT] = [_grunt_move_1_class, _grunt_move_2_class, _grunt_move_3_class];
//            _moveDictionary[EnumUnitType.KNIGHT] = [_knight_move_1_class, _knight_move_2_class, _knight_move_3_class];
//            _moveDictionary[EnumUnitType.MANTICORE] = [_manticore_move_1_class, _manticore_move_2_class, _manticore_move_3_class];
//            _moveDictionary[EnumUnitType.MINOTAUR] = [_minotaur_move_1_class, _minotaur_move_2_class, _minotaur_move_3_class];
//            _moveDictionary[EnumUnitType.PIKEMAN] = [_pikeman_move_1_class, _pikeman_move_2_class, _pikeman_move_3_class];
//            _moveDictionary[EnumUnitType.SHROOM] = [_shroom_move_1_class, _shroom_move_2_class, _shroom_move_3_class];
//            _moveDictionary[EnumUnitType.SLIME] = [_slime_move_1_class, _slime_move_2_class, _slime_move_3_class];
//            _moveDictionary[EnumUnitType.SOLDIER] = [_soldier_move_1_class, _soldier_move_2_class, _soldier_move_3_class];
//
//            _hitDictionary[EnumUnitType.ARCHER] = [_archer_hit_1_class, _archer_hit_2_class, _archer_hit_3_class];
//            _hitDictionary[EnumUnitType.CAVALRY] = [_cavalry_hit_1_class, _cavalry_hit_2_class, _cavalry_hit_3_class];
//            _hitDictionary[EnumUnitType.GARGOYLE] = [_gargoyle_hit_1_class, _gargoyle_hit_2_class, _gargoyle_hit_3_class];
//            _hitDictionary[EnumUnitType.GOO] = [_goo_hit_1_class, _goo_hit_2_class, _goo_hit_3_class];
//            _hitDictionary[EnumUnitType.GRUNT] = [_grunt_hit_1_class, _grunt_hit_2_class, _grunt_hit_3_class];
//            _hitDictionary[EnumUnitType.KNIGHT] = [_knight_hit_1_class, _knight_hit_2_class, _knight_hit_3_class];
//            _hitDictionary[EnumUnitType.MANTICORE] = [_manticore_hit_1_class, _manticore_hit_2_class, _manticore_hit_3_class];
//            _hitDictionary[EnumUnitType.MINOTAUR] = [_minotaur_hit_1_class, _minotaur_hit_2_class, _minotaur_hit_3_class];
//            _hitDictionary[EnumUnitType.PIKEMAN] = [_pikeman_hit_1_class, _pikeman_hit_2_class, _pikeman_hit_3_class];
//            _hitDictionary[EnumUnitType.SHROOM] = [_shroom_hit_1_class, _shroom_hit_2_class, _shroom_hit_3_class];
//            _hitDictionary[EnumUnitType.SLIME] = [_slime_hit_1_class, _slime_hit_2_class, _slime_hit_3_class];
//            _hitDictionary[EnumUnitType.SOLDIER] = [_soldier_hit_1_class, _soldier_hit_2_class, _soldier_hit_3_class];
//
//            _dieDictionary[EnumUnitType.ARCHER] = [_archer_die_1_class, _archer_die_2_class, _archer_die_3_class];
//            _dieDictionary[EnumUnitType.CAVALRY] = [_cavalry_die_1_class, _cavalry_die_2_class, _cavalry_die_3_class];
//            _dieDictionary[EnumUnitType.GARGOYLE] = [_gargoyle_die_1_class, _gargoyle_die_2_class, _gargoyle_die_3_class];
//            _dieDictionary[EnumUnitType.GOO] = [_goo_die_1_class, _goo_die_2_class, _goo_die_3_class];
//            _dieDictionary[EnumUnitType.GRUNT] = [_grunt_die_1_class, _grunt_die_2_class, _grunt_die_3_class];
//            _dieDictionary[EnumUnitType.KNIGHT] = [_knight_die_1_class, _knight_die_2_class, _knight_die_3_class];
//            _dieDictionary[EnumUnitType.MANTICORE] = [_manticore_die_1_class, _manticore_die_2_class, _manticore_die_3_class];
//            _dieDictionary[EnumUnitType.MINOTAUR] = [_minotaur_die_1_class, _minotaur_die_2_class, _minotaur_die_3_class];
//            _dieDictionary[EnumUnitType.PIKEMAN] = [_pikeman_die_1_class, _pikeman_die_2_class, _pikeman_die_3_class];
//            _dieDictionary[EnumUnitType.SHROOM] = [_shroom_die_1_class, _shroom_die_2_class, _shroom_die_3_class];
//            _dieDictionary[EnumUnitType.SLIME] = [_slime_die_1_class, _slime_die_2_class];
//            _dieDictionary[EnumUnitType.SOLDIER] = [_soldier_die_1_class, _soldier_die_2_class, _soldier_die_3_class];
//
//        }
//        private static function playRandomVoice(voices:Array):Boolean{
//            if (!voices){
//                return false;
//            }
//
//            var soundClass:Class = voices[Random.defaultEngine.getIntRange(0, voices.length)];
//            var s:Sound = RetrocamelSoundManager.getS(soundClass);
//            s.play(100);
//
//            return true;
//        }
//
//        public static function playReady(unit:EnumUnitType):Boolean {
//            return playRandomVoice(_readyDictionary[unit]);
//        }
//        public static function playMove(unit:EnumUnitType):Boolean {
//            return playRandomVoice(_moveDictionary[unit]);
//        }
//        public static function playHit(unit:EnumUnitType):Boolean {
//            return playRandomVoice(_hitDictionary[unit]);
//        }
//        public static function playDie(unit:EnumUnitType):Boolean {
//            return playRandomVoice(_dieDictionary[unit]);
//        }
    }
}
