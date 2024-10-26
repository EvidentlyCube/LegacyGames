package submuncher.core.repositories {
    // import flash.filesystem.File;
    // import flash.filesystem.FileMode;
    // import flash.filesystem.FileStream;
    import flash.utils.ByteArray;

    import submuncher.core.constants.GameFile;

    public class LevelMetadata {
        public static function classToXml(levelData:Class):XML {
            var byteArray:ByteArray = new levelData;

            byteArray.position = 0;
            return new XML(byteArray.readUTFBytes(byteArray.length));
        }

        private var _id:String;
        private var _title:String;
        private var _width:int;
        private var _height:int;
        private var _parTime:int;
        private var _data:*;
        private var _xmlCache:XML;

        public function get id():String {
            return _id;
        }

        public function get title():String {
            return _title;
        }

        public function get width():int {
            return _width;
        }

        public function get height():int {
            return _height;
        }

        public function get parTime():int {
            return _parTime;
        }

        public function get isCustom():Boolean {
            return false;
        }

        public function get xml():XML {
            if (!_xmlCache) {
                if (_data is Class) {
                    _xmlCache = classToXml(_data);
                } else if (_data is GameFile) {
                    _xmlCache = GameFile(_data).getXml();
                // } else if (_data is File) {
                //     var bs:ByteArray = new ByteArray();
                //     var fs:FileStream = new FileStream();
                //     var done:Boolean = false;
                //     while (!done) {
                //         try {
                //             fs.open(_data as File, FileMode.READ);
                //             done = true;
                //         } catch (e:Error) {
                //         }
                //     }
                //     fs.readBytes(bs);
                //     fs.close();

                //     _xmlCache = new XML(bs.readUTFBytes(bs.length));
                } else {
                    throw new Error("Invalid data type");
                }
            }

            return _xmlCache;
        }

        public function LevelMetadata(id:String, title:String, width:int, height:int, parTime:int, data:*) {
            _id = id;
            _title = title;
            _width = width;
            _height = height;
            _parTime = parTime;
            _data = data;
        }

        protected function invalidateLevelCache():void{
            _xmlCache = null;
        }
    }
}
