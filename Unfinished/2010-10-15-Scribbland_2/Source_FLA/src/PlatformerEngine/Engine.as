package src.PlatformerEngine{
    import com.mauft.DataVault.Vault;
    
    import flash.display.MovieClip;
    import flash.display.Stage;
    
    public class Engine{
        private static var _initialized:Boolean = false;
        private static var _gamefield  :MovieClip;
        private static var _stage      :Stage;
        
        
        
        public static function init(STG:Stage, GMF:MovieClip):void{
            if (_initialized){ return; }
            
            _initialized = true;
            _stage       = STG;
            _gamefield   = GMF;
            
            new Controls();
            Level.init();
            
            Scrolling.setCorners(0, 0, Settings.LEVEL_WIDTH * Settings.TILE_WIDTH, Settings.LEVEL_HEIGHT * Settings.TILE_HEIGHT)
        }
        
        public static function levelGetName(levelID:int):String{
            switch(levelID + 1){
                case  1: return "Generic level name 001";
                case  2: return "Generic level name 002";
                case  3: return "Generic level name 003";
                case  4: return "Generic level name 004";
                case  5: return "Generic level name 005";
                case  6: return "Generic level name 006";
                case  7: return "Generic level name 007";
                case  8: return "Generic level name 008";
                case  9: return "Generic level name 009";
                case 10: return "Generic level name 000";
                case 11: return "Generic level name 011";
                case 12: return "Generic level name 012";
                case 13: return "Generic level name 013";
                case 14: return "Generic level name 014";
                case 15: return "Generic level name 015";
                case 16: return "Generic level name 016";
                case 17: return "Generic level name 017";
                case 18: return "Generic level name 018";
                case 19: return "Generic level name 019";
                case 20: return "Generic level name 020";
            }
            return "Um, error?"
        }
        
        public static function levelGetTime(levelID:int):int{
            return Vault.getVal("level_time" + levelID);
        }
        
        public static function levelGetBonu(levelID:int):int{
            return Vault.getVal("level_bonu" + levelID);
        }
        
        public static function levelGetBonm(levelID:int):int{
            return Vault.getVal("level_bonm" + levelID);
        }
        
        public static function levelGetDiff(levelID:int):int{
            return Vault.getVal("level_diff" + levelID);
        }
        
        public static function levelGetCont(levelID:int):int{
            return Vault.getVal("level_cont" + levelID);
        }
        
        public static function levelGetScor(levelID:int):int{
            return Vault.getVal("level_scor" + levelID);
        }
        
        public static function levelSet(levelID:int, time:int, bonuses:int, bonusesMax:int, difficulty:int, controls:int, score:int):void{
            Vault.setVal("level_time" + levelID, time);
            Vault.setVal("level_bonu" + levelID, bonuses);
            Vault.setVal("level_bonm" + levelID, bonusesMax);
            Vault.setVal("level_diff" + levelID, difficulty);
            Vault.setVal("level_cont" + levelID, controls);
            Vault.setVal("level_scor" + levelID, score);
            
        }
        
        public static function levelCalculateScore(time:int, bonuses:int, bonusesMax:int, difficulty:int, controls:int):int{
            var score:int = - time * 2;
            score += bonuses * 100 * Math.ceil(bonuses * 4 / bonusesMax + 0.001);
            score *= difficulty * 3 + controls * 3;
            return score;
        }
        
        public static function get stage():Stage    { return _stage;     }
        public static function get main() :MovieClip{ return _gamefield; }
    }
}