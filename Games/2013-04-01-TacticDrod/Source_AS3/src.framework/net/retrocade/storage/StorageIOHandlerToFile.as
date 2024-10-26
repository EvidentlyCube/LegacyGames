/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 16.03.13
 * Time: 16:54
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.storage {
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.utils.ByteArray;
    import flash.utils.getQualifiedClassName;

    import net.retrocade.utils.Base64;
    import net.retrocade.utils.USecure;

    public class StorageIOHandlerToFile implements IStorageIOHandler{
        private var _storagePath:File;
        private var _cryptoKey:String = "9dn2pr0kOjSU82o";
        private var _scrambleKey:int = 174763;

        public function StorageIOHandlerToFile(filePath:String, cryptoKey:String, scrambleKey:int){
            _storagePath = File.applicationStorageDirectory.resolvePath(filePath);
            _cryptoKey = cryptoKey;
            _scrambleKey = scrambleKey;
        }

        public function write(data:Object):void{
            var byteArray:ByteArray = new ByteArray();
            byteArray.writeObject(data);

            byteArray = Base64.encodeByteArrayByteArray(byteArray);
            USecure.scrambleByteArray(byteArray, _scrambleKey);

            byteArray.position = 0;

            var fileStream:FileStream = new FileStream();
            fileStream.open(_storagePath, FileMode.WRITE);

            fileStream.writeBytes(byteArray);

            fileStream.close();
        }

        public function read():Object{
            try{
                if (_storagePath.exists){
                    var fileStream:FileStream = new FileStream();
                    fileStream.open(_storagePath, FileMode.READ);

                    var byteArray:ByteArray = new ByteArray();
                    fileStream.readBytes(byteArray);
                    fileStream.close();

                    USecure.unscrambleByteArray(byteArray, _scrambleKey);

                    byteArray = Base64.decodeByteArrayByteArray(byteArray);
                    var result:Object = byteArray.readObject();

                    var className:String = getQualifiedClassName(result);
                    if (className != "Object"){
                        return {};
                    } else {
                        return result;
                    }
                } else {
                    return null;
                }
            } catch (error:Error){
                return {};
            }

            return {};
        }
    }
}
