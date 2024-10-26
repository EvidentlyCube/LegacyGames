package game.global{
    import flash.utils.getTimer;

    import net.retrocade.camel.core.rSave;
    import net.retrocade.utils.USecure;
    import net.retrocade.vault.Safe;

    public class Score{
        public static var bonusLeft:Safe = new Safe(0);

        public static var movesMade:Safe = new Safe(0);
        public static var time     :Safe = new Safe(0);

        public static var levelName  :String;
        public static var levelAuthor:String;

        public static var currentLevel:uint = 0;

        public static function isCompleted(id: uint): Boolean {
            return getLevelSteps(id) < 9999;
        }

        public static function getNextUncompletedLevel(start:uint = 0):uint{
            var i:uint = start;

            do{
                if (!isCompleted(i))
                    return i;

                if (++i >= 20)
                    i = 0;

            } while (i != start);

            return (start + 1) % 20;
        }

        public static function getLevelSteps(id:uint):uint{
            return rSave.read('level-steps-' + Game.gameMode + '-' + id, 9999);
        }

        public static function getLevelTime(id:uint):uint{
            return rSave.read('level-time-' + Game.gameMode + '-' + id, 999999999)
        }

        public static function setLevelSteps(id:uint, steps:uint):void{
            rSave.write('level-steps-' + Game.gameMode + '-' + id, steps);
        }

        public static function setLevelTime(id:uint, time:uint):void{
            rSave.write('level-time-' + Game.gameMode + '-' + id, time);
        }

        public static function getAllSteps():uint{
            var steps:uint = 0;

            for(var _i:uint = 0; _i < 20; _i++){
                steps += getLevelSteps(_i);
            }

            return steps;
        }

        public static function getAllTime():uint{
            var time:uint = 0;

            for(var _i:uint = 0; _i < 20; _i++){
                time += getLevelTime(_i);
            }

            return time;
        }

        public static function levelRestart():void{
            movesMade.set(0);
            time.set(getTimer());
            bonusLeft.set(0);
        }

        public static function countLevelsCompleted():uint{
            var count:uint = 0;

            for(var _i:uint = 0; _i < 20; _i++){
                if (isCompleted(_i)) {
                    count++;
                }
            }

            return count;
        }

        public static function get wasGameCompleted():Boolean{
            return rSave.read("completed", false);
        }

        public static function set wasGameCompleted(value:Boolean):void{
            rSave.write("completed", value);
        }
    }
}