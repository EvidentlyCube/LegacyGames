package net.retrocade.tacticengine.monstro.core{
    import flash.system.Capabilities;

    import net.retrocade.camel.global.rDisplay;

    public class Monstro{
        public static function get versionString():String{
            return "Beta Iteration I Hotfix 1";
        }
		public static function get tileWidth():int{
			return 22;
		}
		
		public static function get tileHeight():int{
			return 22;
		}

        public static function get timeToThink():int{
            return 100;
        }

        public static function get gameWidth():int{
            return rDisplay.flashStage.stageWidth;
        }

        public static function get gameHeight():int{
            return rDisplay.flashStage.stageHeight;
        }

        public static function get gameSmaller():int{
            return Math.min(rDisplay.flashStage.stageWidth, rDisplay.flashStage.stageHeight);
        }

        public static function get bottomBarHeight():int{
            return 40;
        }

        public static function get fingerWidth():Number{
            return Capabilities.screenDPI / 2;
        }

        public static function get hudSpacer():Number{
            return fingerWidth / 6;
        }

        public static function get movementSpeed():Number{
            //return 1;
            //return 0.0625;
            return MonstroData.gameSpeed;
        }

        public static function get hasToConfirmEnemyAttack():Boolean{
            return MonstroData.getWaitForConfirmation();
        }
        public static function get singleClickActions():Boolean{
            return true;
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

        public static const FONT_MEDIUM:String = "tactic_font";

        public static const MARK_RESET:uint = 0x666666;
        public static const MARK_MOVABLE:uint = 0x0088FF;
        public static const MARK_MOVABLE_MOVED:uint = 0xA0A0A0;
        public static const MARK_MOVE_TO:uint = 0x00FFFF;
        public static const MARK_ATTACKABLE:uint = 0xFF0000;
        public static const MARK_ATTACKABLE_WEAK:uint = 0xFF6666;
        public static const MARK_ATTACKER:uint = 0xFF0088;
        public static const MARK_ATTACK_AT:uint = 0xFF8800;
        
        public static const PROP_isPlayerControlled:String = "isPlayer";
        public static const PROP_canFly:String = "canFly";
        public static const PROP_name:String = "name";
	}
}