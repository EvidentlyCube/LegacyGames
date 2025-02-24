package net.retrocade.tacticengine.monstro.global.core{
    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;

    public class MonstroConsts{
		public static const N:uint = 0;
		public static const W:uint = 1;
		public static const E:uint = 2;
		public static const S:uint = 3;
		public static const NO_ORIENTATION:uint = 4;

		public static function get version():String {
			return "1.0.5.1";
		}

		public static function get versionString():String{
            var versionString:String = "v." + version;

			CF::isRelease{
				versionString += " Release";
			}

			CF::debug{
				versionString += " Debug";
			}

			CF::enableCheats{
				versionString += " (Cheats)";
			}
            return versionString;
        }

		public static function get tileWidth():int{
			return 32;
		}

		public static function get tileHeight():int{
			return 32;
		}

        public static function get timeToThink():int{
            return 10;
        }

        public static function get gameWidth():int{
            return RetrocamelDisplayManager.flashStage.stageWidth;
        }

        public static function get gameHeight():int{
            return RetrocamelDisplayManager.flashStage.stageHeight;
        }

        public static function get bottomBarHeight():int{
            return 40;
        }

        public static function get fingerWidth():Number{
            return 32;
        }

        public static function get hudSpacer():Number{
            return fingerWidth / 6;
        }

        public static function get hasToConfirmEnemyAttack():Boolean{
            return MonstroData.getWaitForConfirmation();
        }

        public static function get displayMonsterThinking():Boolean{
            return false;
        }

        public static function get monsterThinkingDelay():Number{
            return 10;
        }

        public static function get enableZoomButtons():Boolean{
            return true;
        }

        public static function get enableZoomPinch():Boolean{
            return false;
        }

        public static const FONT_NATIVE:String = "eboracum_embed";
        public static const FONT_EBORACUM_48:String = "FONT_EBORACUM_48";
        public static const FONT_EBORACUM_64:String = "FONT_EBORACUM_64";
        public static const FONT_NEW_ROCKER_64:String = "FONT_NEW_ROCKER_64";
        public static const FONT_NEW_ROCKER_40_SHADOW:String = "FONT_NEW_ROCKER_40_SHADOW";
        public static const FONT_NEW_ROCKER_48_SHADOW:String = "FONT_NEW_ROCKER_48_SHADOW";
        public static const FONT_NEW_ROCKER_64_SHADOW:String = "FONT_NEW_ROCKER_64_SHADOW";
        public static const FONT:String = "tactic_font_vector";

		public static const MARK_TYPE_RESET:uint = 0;
		public static const MARK_TYPE_MOVE:uint = 1;
		public static const MARK_TYPE_SELECTED_UNIT:uint = 2;
		public static const MARK_TYPE_ATTACK_TARGET:uint = 3;
		public static const MARK_TYPE_ATTACKABLE:uint = 4;
		public static const MARK_TYPE_ENEMY_SELECTED_UNIT:uint = 5;
		public static const MARK_TYPE_MOVE_TARGET:uint = 6;
		public static const MARK_TYPE_ENEMY_MOVE:uint = 8;

        public static const EVENT_DRAGGED_MOVED_UNIT:uint = 0;
        public static const EVENT_DRAGGED_ATTACKED_ENEMY:uint = 1;
        public static const EVENT_SHOWN_STATS_FOR_SPECIALIZATION:uint = 2;
        public static const EVENT_HOVERED_OVER_TRAP:uint = 3;
        public static const EVENT_UNIT_STOPPED:uint = 4;
        public static const EVENT_UNIT_GRABBED:uint = 5;
        public static const EVENT_UNIT_RELEASED_NO_MOVE:uint = 6;
        public static const EVENT_UNIT_RELEASED_MOVE:uint = 7;
        public static const EVENT_UNIT_RELEASED_ATTACK:uint = 8;
        public static const EVENT_UNIT_RELEASED:uint = 9;
        public static const EVENT_UNIT_DOUBLE_CLICKED:uint = 10;
        public static const EVENT_TURN_ENDED:uint = 11;
        public static const EVENT_UNIT_CLICK_TO_ATTACK:uint = 12;
        public static const EVENT_UNIT_KILLED:uint = 13;
        public static const EVENT_DEFENSE_RESTORED:uint = 14;
        public static const EVENT_UNIT_DAMAGED:uint = 15;
        public static const EVENT_TRAP_ACTIVATED:uint = 16;
        public static const EVENT_PAUSE_MENU_OPENED:uint = 17;

		public static const EVENT_UNIT_SELECTED:uint = 18;
		public static const EVENT_UNIT_MOVED:uint = 19;
		public static const EVENT_UNIT_WAS_ATTACKED:uint = 20;
		public static const EVENT_UNIT_ATTACKED_OTHER_UNIT:uint = 21;
		public static const EVENT_UNIT_TURN_ENDED:uint = 22;
		public static const EVENT_UNIT_DESELECTED:uint = 23;
		public static const EVENT_SHOW_TILEMARKS:uint = 24;
		public static const EVENT_HOVERED_OVER_STATS:uint = 25;


        public static const EVENT_COUNT:uint = 26;
	}
}