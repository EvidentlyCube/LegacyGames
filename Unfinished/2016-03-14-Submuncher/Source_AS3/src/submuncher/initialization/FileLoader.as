package submuncher.initialization {
    // import flash.filesystem.File;

    import net.retrocade.signal.SignalPromiseOnce;

    import submuncher.core.constants.GameFile;
    import submuncher.core.constants.GameFileType;

    public class FileLoader {
        private static var _isLoading:Boolean;
        private static var _loaders:Array;

        public static var onLoadingFinished:SignalPromiseOnce = new SignalPromiseOnce();

        public static function startLoading():void {
            if (_isLoading) {
                return;
            }

            _isLoading = true;
            _loaders = new Array();

            try {
                checkFilesExist();
                loadFiles();
            } catch (e:Error){
                trace(e.getStackTrace());
                onLoadingFinished.call(e.message);
            }
        }

        private static function checkFilesExist():void {
            for each(var gameFile:GameFile in GameFile.getAll()) {
                // var path:File = gameFile.file;
                // if (!path.exists) {
                    // throw new Error("File '" + gameFile.path + "' does not exist.");
                // } else if (path.isDirectory) {
                    // throw new Error("'" + gameFile.path + "' is a directory, not a file.");
                // }
            }
        }

        private static function loadFiles():void {
            for each(var file:GameFile in GameFile.getAll()) {
                switch (file.type) {
                    case(GameFileType.BITMAP):
                        var imageLoader:FileLoaderImage = new FileLoaderImage(file);
                        _loaders.push(imageLoader);

                        imageLoader.onSuccess.add(fileLoadedHandler);
                        imageLoader.onFailure.add(fileLoadFailedHandler);
                        break;

                    case(GameFileType.DATA):
                        var dataLoader:FileLoaderData = new FileLoaderData(file);
                        _loaders.push(dataLoader);

                        dataLoader.onSuccess.add(fileLoadedHandler);
                        dataLoader.onFailure.add(fileLoadFailedHandler);
                        break;
                }
            }

            for each(var loader:* in _loaders.concat()) {
                loader.load();
            }
        }

        private static function fileLoadedHandler(loader:*):void {
            _loaders.splice(_loaders.indexOf(loader), 1);

            checkIfLoadFinished();
        }

        private static function fileLoadFailedHandler(loader:*):void {
            trace("ERROR");
            onLoadingFinished.call("Failed to load file " + loader.gameFile.path + " as " + loader.gameFile.type.name);
        }

        private static function checkIfLoadFinished():void {
            if (_loaders.length > 0) {
                return;
            }

            trace("LOADED");
            onLoadingFinished.call(true);
        }
    }
}
