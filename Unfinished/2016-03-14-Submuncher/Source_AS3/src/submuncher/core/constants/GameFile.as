package submuncher.core.constants {
    import flash.display.BitmapData;
    import flash.errors.MemoryError;
    // import flash.filesystem.File;
    import flash.utils.ByteArray;

    public class GameFile {
        private static var _counter:uint = 0;
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<GameFile> = new Vector.<GameFile>();

        public static var SPRITES_PNG:GameFile = new GameFile(Embeds.SPRITES_PNG, GameFileType.BITMAP);
        public static var TILESET_PNG:GameFile = new GameFile(Embeds.TILESET_PNG, GameFileType.BITMAP);
        public static var TILESET_BACKGROUND_PNG:GameFile = new GameFile(Embeds.TILESET_BACKGROUND_PNG, GameFileType.BITMAP);
        public static var SPRITES_JSON:GameFile = new GameFile(Embeds.SPRITES_JSON, GameFileType.DATA);
        public static var BACKGROUND_WATER_PNG:GameFile = new GameFile(Embeds.BACKGROUND_WATER_PNG, GameFileType.BITMAP);
        public static var BACKGROUND_A_PNG:GameFile = new GameFile(Embeds.BACKGROUND_A_PNG, GameFileType.BITMAP);
        public static var BACKGROUND_A_JSON:GameFile = new GameFile(Embeds.BACKGROUND_A_JSON, GameFileType.DATA);
        public static var EDGE_COVER_GRID9_PNG:GameFile = new GameFile(Embeds.EDGE_COVER_GRID9_PNG, GameFileType.BITMAP);
        public static var GUI_PNG:GameFile = new GameFile(Embeds.GUI_PNG, GameFileType.BITMAP);
        public static var GUI_JSON:GameFile = new GameFile(Embeds.GUI_JSON, GameFileType.DATA);
        public static var FONT_OLD_DATA:GameFile = new GameFile(Embeds.FONT_OLD_DATA, GameFileType.DATA);
        public static var FONT_OLD_SHADOW_DATA:GameFile = new GameFile(Embeds.FONT_OLD_SHADOW_DATA, GameFileType.DATA);
        public static var FONT_REGULAR_DATA:GameFile = new GameFile(Embeds.FONT_REGULAR_DATA, GameFileType.DATA);
        public static var FONT_BOLD_DATA:GameFile = new GameFile(Embeds.FONT_BOLD_DATA, GameFileType.DATA);
        public static var I18N_ENGLISH:GameFile = new GameFile(Embeds.I18N_ENGLISH, GameFileType.DATA);
        public static var LEVEL_SELECTION_MAP_PNG:GameFile = new GameFile(Embeds.LEVEL_SELECTION_MAP_PNG, GameFileType.BITMAP);
        public static var EDITOR_BASE_FG_TILESET_PNG:GameFile = new GameFile(Embeds.EDITOR_BASE_FG_TILESET_PNG, GameFileType.BITMAP);
        public static var EDITOR_BASE_FG_VAR_TILESET_PNG:GameFile = new GameFile(Embeds.EDITOR_BASE_FG_VAR_TILESET_PNG, GameFileType.BITMAP);

        private var _id:int;
        private var _path:String;
        private var _type:GameFileType;
        private var _data:*;

        public function get id():int {
            return _id;
        }

        public function get path():String {
            return _path;
        }

        public function get type():GameFileType {
            return _type;
        }

        public function get data():* {
            return _data;
        }

        public function getBitmapData():BitmapData {
            return _data as BitmapData;
        }

        public function getString():String {
            var string:String = ByteArray(_data).readUTFBytes(_data.length);
            _data.position = 0;

            return string;
        }

        public function getJsonObject():Object{
            return JSON.parse(getString());
        }

        public function getXml():XML {
            return new XML(getString());
        }

        public function initializeData(value:*):void {
            if (_data && !(_data is Class)){
                throw new Error("Data for file " + _path + " is already set!");
            }

            _data = value;
        }

        public function GameFile(data:*, type:GameFileType) {
            _id = _counter++;
            _path = path;
            _type = type;
            _data = data;

            _collection.push(this);
        }

        public static function byId(id:int):GameFile {
            for each(var element:GameFile in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }

        public static function byPath(path:String):GameFile {
            for each(var element:GameFile in _collection) {
                if (element._path == path) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasId(id:int):Boolean {
            for each(var element:GameFile in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasPath(path:String):Boolean {
            for each(var element:GameFile in _collection) {
                if (element._path == path) {
                    return true;
                }
            }

            return false;
        }

        public static function getAll():Vector.<GameFile> {
            return _collection.concat();
        }
    }
}
