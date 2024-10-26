package submuncher.initialization {
    import flash.utils.ByteArray;

    import net.retrocade.signal.Signal;

    import submuncher.core.constants.GameFile;

    public class FileLoaderData {
        private var _gameFile:GameFile;
        private var _onSuccess:Signal;
        private var _onFailure:Signal;

        public function get gameFile():GameFile {
            return _gameFile;
        }

        public function get onSuccess():Signal {
            return _onSuccess;
        }

        public function get onFailure():Signal {
            return _onFailure;
        }

        public function FileLoaderData(gameFile:GameFile) {
            _gameFile = gameFile;

            _onSuccess = new Signal();
            _onFailure = new Signal();
        }

        public function load():void {
            var data:* = _gameFile.data;

            if (data is Class) {
                var inst:* = new data();

                if (inst is flash.utils.ByteArray) {
                    _gameFile.initializeData(inst)
                    _onSuccess.call(this);
                } else {
                    _onFailure.call(this);
                }
            } else if (data is flash.utils.ByteArray) {
                _onSuccess.call(this);
            } else {
                _onFailure.call(this);
            }

            _onSuccess.dispose();
            _onFailure.dispose();
        }
    }
}
