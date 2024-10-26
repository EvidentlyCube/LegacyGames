// ActionScript file
package Classes.Data{
	import Classes.BGHandler;
	import Classes.CustomLevels;
	import Classes.Items.*;
	import Classes.TLevel;
    import Classes.Data.LocalStorageLevelData;

	import Editor.TextToNum;
	import Editor.MakeThumbnail;

	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.display.BitmapData;
    import flash.utils.getTimer;

    public class LevelDatabase {
        public static var EMPTY_LEVEL_CODE: String = "TPDBEG&Nonam(Unnamed!!!TPDEND";

        public static var userLevels: Array;
        public static var customLevels: Array;
        public static function init(): void {
            userLevels = [];
            customLevels = [];

            try {
                userLevels = LocalStorageLevelData.parseMany(SimpleSave.read('own-levels', '').split('~~~~~'))
                customLevels = LocalStorageLevelData.parseMany(SimpleSave.read('custom-levels', '').split('~~~~~'))
            } catch (e: Error) {
                trace(e.message);
            }

            if (customLevels.length === 0) {
                customLevels = LocalStorageLevelData.parseMany(CustomLevels());
            }
        }

        public static function flushUserLevels(): void {
            var levelsDatas: Array = userLevels.map(function (level: LocalStorageLevelData, _1:*,_2:*): String {
                return level.toString();
            })
            var levelsString: String = levelsDatas.join('~~~~~');
            SimpleSave.writeFlush('own-levels', levelsString);
        }

        public static function flushCustomLevels(): void {
            var levelsDatas: Array = customLevels.map(function (level: LocalStorageLevelData, _1:*,_2:*): String {
                return level.toString();
            })
            var levelsString: String = levelsDatas.join('~~~~~');
            SimpleSave.writeFlush('custom-levels', levelsString);
        }

        public static function saveCustomLevel(code: String): Boolean {
            if (code.indexOf('TPDBEG') === 0) {
                code = generateCustomLevelId() + code;
            }

            var levelData: LocalStorageLevelData = new LocalStorageLevelData(code);

            if (!levelData.isValid) {
                return false;
            }

            for (var i: Number = 0; i < customLevels.length; i++) {
                var other: LocalStorageLevelData = customLevels[i];

                if (other.id === levelData.id) {
                    customLevels[i] = levelData;
                    flushCustomLevels();
                    return true;
                }
            }

            customLevels.push(levelData);
            flushCustomLevels();
            return true;
        }

        public static function saveUserLevel(id: String, newCode: String): Boolean {
            var levelData: LocalStorageLevelData = new LocalStorageLevelData(id + newCode);

            if (!levelData.isValid) {
                return false;
            }

            for (var i: Number = 0; i < userLevels.length; i++) {
                var other: LocalStorageLevelData = userLevels[i];

                if (other.id === levelData.id) {
                    userLevels[i] = levelData;
                    flushUserLevels();
                    return true;
                }
            }

            userLevels.push(levelData);
            flushUserLevels();
            return true;
        }

        public static function deleteUserMadeLevel(id: String): void {
            for (var i: Number = 0; i < userLevels.length; i++) {
                var other: LocalStorageLevelData = userLevels[i];

                if (other.id === id) {
                    userLevels.splice(i, 1);
                    flushUserLevels();
                    break;
                }
            }
        }

        public static function deleteCustomLevel(id: String): void {
            for (var i: Number = 0; i < customLevels.length; i++) {
                var other: LocalStorageLevelData = customLevels[i];

                if (other.id === id) {
                    customLevels.splice(i, 1);
                    flushCustomLevels();
                    break;
                }
            }
        }

        public static function generateEditorId(): String {
            return "editor-"
                + getTimer()
                + "-"
                + Math.random().toFixed(6).substr(2, 6);
        }

        public static function generateCustomLevelId(): String {
            return "custom-"
                + getTimer()
                + "-"
                + Math.random().toFixed(6).substr(2, 6);
        }
    }
}
