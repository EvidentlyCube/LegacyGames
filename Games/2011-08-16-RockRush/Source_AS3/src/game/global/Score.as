package game.global {
	import game.global.levels.LevelList;

	import net.retrocade.retrocamel.global.RetrocamelSimpleSave;

	public class Score {
		private static var _diamondsToGet:int = 0;

		public static function get diamondsToGet():int {
			return _diamondsToGet;
		}

		public static function set diamondsToGet(value:int):void {
			_diamondsToGet = value;
		}

		private static var _diamondsGot:int = 0;

		public static function get diamondsGot():int {
			return _diamondsGot;
		}

		public static function set diamondsGot(value:int):void {
			_diamondsGot = value;
		}

		private static var _time:int = 0;

		public static function get time():int {
			return _time;
		}

		public static function set time(value:int):void {
			_time = value;
		}
		private static var _score:int = 0;

		public static function get score():int {
			return _score;
		}
		public static function set score(value:int):void {
			_score = value;
		}
		public static var powerup:uint = 0;
		public static var keys:Array = [];

		public static function isCompleted(levelIndex:uint):Boolean {
			return RetrocamelSimpleSave.read('level-completion-' + S().currentVersion + "-" + levelIndex.toString(), 0) === 1;
		}

		public static function setCompleted(level:uint, isCompleted:Boolean):void {
			RetrocamelSimpleSave.writeFlush('level-completion-' + S().currentVersion + "-" + level.toString(), isCompleted ? 1 : 0);
		}

		public static function setScore(level:uint, score:uint):void {
			RetrocamelSimpleSave.writeFlush('level-score-' + S().currentVersion + "-" + level.toString(), score);
		}

		public static function getScore(level:uint):uint {
			return RetrocamelSimpleSave.read('level-score-' + S().currentVersion + "-" + level.toString(), 0);
		}

		public static function getTotalScore():uint {
			var total:uint = 0;
			for (var i:uint = 1; i <= LevelList.levelCount(S().currentVersion); i++) {
				total += getScore(i);
			}
			return total;
		}

		public static function resetLevelStart():void {
			diamondsToGet = 0;
			diamondsGot = 0;

			keys[0] = 0;
			keys[1] = 0;
			keys[2] = 0;
			keys[3] = 0;
		}

		public static function gameCompleted():Boolean {
			for (var i:uint = 1; i <= LevelList.levelCount(S().currentVersion); i++) {
				if (!isCompleted(i)) {
					return false;
				}
			}

			return true;
		}

		public static function totalCompletedLevels():uint {
			var total:uint = 0;
			for (var i:uint = 1; i <= LevelList.levelCount(S().currentVersion); i++) {
				if (isCompleted(i)) {
					total++;
				}
			}

			return total;
		}

		public static function getNextUncompleted(index:uint):uint {
			var i:uint = index;

			do {
				i++;

				if (i == LevelList.levelCount(S().currentVersion) + 1) {
					i = 1;
				}

				if (!isCompleted(i)) {
					return i;
				}

			} while (i != index);

			return index;
		}
	}
}