package game.global{
    import net.retrocade.camel.core.rSave;
    import net.retrocade.vault.Safe;

    public class Score {
        public static var pathsMax:Safe = new Safe(0);
        public static var pathsPlaced:Safe = new Safe(0);
        public static var level:Safe = new Safe(1);
        public static var completedLevelsEasy:Array = [];
        public static var completedLevelsRegular:Array = [];
        public static var completedLevelsHard:Array = [];

        public static function getCompletedArray(): Array {
            switch (Level.levelsMode) {
                case 'regular': return completedLevelsRegular;
                case 'easy': return completedLevelsEasy;
                case 'hard': return completedLevelsHard;
                default: return completedLevelsRegular;
            }
        }

        /** Returns -1 when all levels are completed **/
        public static function getNextUncompletedLevel():int{
            if (countCompleted() == 40)
                return -1;

            var i:uint = level.get();

            while(true){
                if (getCompletedArray()[i - 1] == false)
                    return i;

                i++;
                if (i > 40) {
                    i -= 40;
                }
            }

            return -1;
        }
        /** Returns -1 when all levels are completed **/
        public static function getNextLevel():int{
            var i:uint = level.get();

            i++;
            if (i > 40) {
                i -= 40;
            }

            return i;
        }

        public static function saveLevels():void{
            for(var i:uint = 0; i < 40; i++){
                rSave.save("completed-easy-" + i, completedLevelsEasy[i]);
                rSave.save("completed-regular-" + i, completedLevelsRegular[i]);
                rSave.save("completed-hard-" + i, completedLevelsHard[i]);
            }

            rSave.flush();
        }

        public static function loadLevels():void{
            for(var i:uint = 0; i < 40; i++){
                completedLevelsEasy[i] = rSave.read("completed-easy-" + i, false);
                completedLevelsRegular[i] = rSave.read("completed-regular-" + i, false);
                completedLevelsHard[i] = rSave.read("completed-hard-" + i, false);
            }
        }

        public static function countCompleted():uint{
            var count:uint = 0;
            for(var i:uint = 0; i < 40; i++){
                if (getCompletedArray()[i] == true)
                    count++;
            }

            return count;
        }
    }
}