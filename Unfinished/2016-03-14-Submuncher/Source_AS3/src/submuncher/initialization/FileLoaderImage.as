package submuncher.initialization {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    // import flash.filesystem.File;
    // import flash.filesystem.FileMode;
    // import flash.filesystem.FileStream;
    import flash.utils.ByteArray;

    import net.retrocade.helpers.RetrocamelLoader;

    import net.retrocade.signal.Signal;

    import submuncher.core.constants.GameFile;

    public class FileLoaderImage {
        private var _gameFile:GameFile;
        private var _onSuccess:Signal;
        private var _onFailure:Signal;
        private var _loader:RetrocamelLoader;

        public function get gameFile():GameFile {
            return _gameFile;
        }

        public function get onSuccess():Signal {
            return _onSuccess;
        }

        public function get onFailure():Signal {
            return _onFailure;
        }

        public function FileLoaderImage(gameFile:GameFile) {
            _gameFile = gameFile;

            _onSuccess = new Signal();
            _onFailure = new Signal();
        }

        public function load():void {
            var data:* = _gameFile.data;

            if (data is Class) {
                var inst:* = new data();

                if (inst is flash.display.Bitmap) {
                    _gameFile.initializeData(inst.bitmapData)
                    _onSuccess.call(this);
                } else {
                    _onFailure.call(this);
                }
            } else if (data is flash.display.BitmapData) {
                _onSuccess.call(this);
            } else {
                _onFailure.call(this);
            }

            _onSuccess.dispose();
            _onFailure.dispose();
            _onSuccess = null;
            _onFailure = null;
        }
    }
}
