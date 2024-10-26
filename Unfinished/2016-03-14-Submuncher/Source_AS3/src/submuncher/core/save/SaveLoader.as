package submuncher.core.save {
    // import flash.filesystem.File;
    // import flash.filesystem.FileMode;
    // import flash.filesystem.FileStream;
    // import flash.system.Capabilities;

    // import net.retrocade.utils.UtilsMd5;

    public class SaveLoader {

        // private static var _playerId:String;
        // private static var _file:File;

        // {
            // init();
        // }

        private static function init():void {
            // _playerId = File.userDirectory.name + "-" + UtilsMd5.encrypt(Capabilities.serverString).substr(0, 8);
            // _file = new File(File.applicationDirectory.resolvePath("save/").nativePath);
            // if (!_file.exists){
            //     _file.createDirectory()
            // }
            // _file = _file.resolvePath(_playerId + ".txt");
        }

        public static function restoreFromFile():Save {
            var save:Save = new Save();

            // try{
                // var stream:FileStream = new FileStream();
                // stream.open(_file, FileMode.READ);
                // save.fromJson(JSON.parse(stream.readUTFBytes(stream.bytesAvailable)));
                // stream.close();
            // } catch (e:Error){
                // return new Save();
            // }

            return save;
        }

        public static function storeInFile(save:Save):void {
            // var stream:FileStream = new FileStream();
            // stream.open(_file, FileMode.WRITE);
            // stream.writeUTFBytes(JSON.stringify(save.toJson()));
            // stream.close();
        }
    }
}
