package submuncher.core.repositories {
    // import flash.filesystem.File;

    public class CustomLevelMetadata extends LevelMetadata{
        private var _fileLastModified:Number;
        // private var _file:File;
        private var _xmlCache:XML;

        override public function get id():String {
            return xml.@id.toString();
        }

        override public function get title():String {
            return xml.@title.toString();
        }

        override public function get width():int {
            return parseInt(xml.width.toString()) / 16;
        }

        override public function get height():int {
            return parseInt(xml.height.toString()) / 16;
        }

        override public function get parTime():int {
            return parseInt(xml.@parTime.toString());
        }

        override public function get isCustom():Boolean {
            return true;
        }

        public function get file():* {
            return null;
            // return _file;
        }

        public function get fileLastModified():Number {
            return _fileLastModified;
        }

        override public function get xml():XML {
            // if (_fileLastModified !== _file.modificationDate.time){
                // invalidateLevelCache();
                // _fileLastModified = _file.modificationDate.time;
                // _xmlCache = super.xml;
            // }

            return _xmlCache;
        }

        public function CustomLevelMetadata(file:*) {
            super("", "", 0, 0, 0, file);

            // _file = file;
        }
    }
}
