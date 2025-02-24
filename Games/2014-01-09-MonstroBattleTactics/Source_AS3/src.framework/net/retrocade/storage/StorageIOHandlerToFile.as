


package net.retrocade.storage {
	import net.retrocade.tacticengine.monstro.global.core.MonstroFile;

	import net.retrocade.utils.UtilsBase64;
    import net.retrocade.utils.UtilsByteArray;
    import net.retrocade.utils.UtilsSecure;

    public class StorageIOHandlerToFile implements IStorageIOHandler{
        private var _storagePath:MonstroFile;
        private var _cryptoKey:String = "9dn2pr0kOjSU82o";
        private var _scrambleKey:int = 174763;

        public function StorageIOHandlerToFile(file:MonstroFile, cryptoKey:String, scrambleKey:int){
            _l("new StorageIOHandlerToFile()");
            _storagePath = file;
            _cryptoKey = cryptoKey;
            _scrambleKey = scrambleKey;
        }

        public function write(data:Object):void{
			_storagePath.write(data);
        }

        public function read():Object{
			return _storagePath.read();
		}
    }
}
