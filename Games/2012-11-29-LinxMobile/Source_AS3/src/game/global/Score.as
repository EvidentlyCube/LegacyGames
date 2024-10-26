package game.global{
    import net.retrocade.camel.global.rSave;
    import net.retrocade.vault.Safe;

    public class Score {
        public static const MODE_NORMAL:uint = 0;
        public static const MODE_EASY  :uint = 1;
        public static const MODE_HARD  :uint = 2;
        public static const MODE_BRANDED  :uint = 3;
        public static const MODE_COUNT :uint = 4;

        public static var gameMode:uint = 0;

        public static var pathsMax:Safe = new Safe(0);
        public static var pathsPlaced:Safe = new Safe(0);
        public static var level:Safe = new Safe(1);
        public static var completedLevels:Array = [];

        public static var wasNormalCompleted:Boolean = false;

        public static function getPrevGameMode(gameMode:uint):uint{
            switch(gameMode){
                case(MODE_EASY):
                    return MODE_EASY
                case(MODE_NORMAL):
                    return MODE_EASY;
                case(MODE_HARD):
                    return MODE_BRANDED;
                case(MODE_BRANDED):
                    return MODE_NORMAL;
                default:
                    return MODE_NORMAL;
            }
        }

        public static function getNextGameMode(gameMode:uint):uint{
            switch(gameMode){
                case(MODE_EASY):
                    return MODE_NORMAL
                case(MODE_NORMAL):
                    return MODE_BRANDED;
                case(MODE_HARD):
                    return MODE_HARD;
                case(MODE_BRANDED):
                    return MODE_HARD;
                default:
                    return MODE_NORMAL;
            }
        }

        /** Returns -1 when all levels are completed **/
        public static function getNextUncompletedLevel(start:uint = 0):int{
            var i:uint = start;

            do{
                if (completedLevels[gameMode * S().totalLevels + (i % S().totalLevels)] == false)
                    return i;

                if (++i == S().totalLevels)
                    i = 0;

            } while (i != start);

            return gameMode * S().totalLevels + ((start + 1) % S().totalLevels);
        }

        public static function saveLevels():void{
            for(var i:uint = 0; i < MODE_COUNT * S().totalLevels; i++){
                rSave.write("completed" + i, completedLevels[i]);
            }

            rSave.write("wnc", wasNormalCompleted);

            rSave.flush();
        }

        public static function loadLevels():void{
            for(var i:uint = 0; i < MODE_COUNT * S().totalLevels; i++){
                completedLevels[i] = rSave.read("completed" + i, false);
            }

            wasNormalCompleted = rSave.read("wnc", false);
        }

        public static function countCompleted(mode:int = -1):uint{
            if (mode == -1)
                mode = gameMode;

            var count:uint = 0;

            for(var i:uint = mode * S().totalLevels; i < mode * S().totalLevels + S().totalLevels; i++){
                if (completedLevels[i] == true)
                    count++;
            }

            return count;
        }

        public static function isLevelCompleted(id:uint):Boolean{
            return completedLevels[id + gameMode * S().totalLevels];
        }
    }
}