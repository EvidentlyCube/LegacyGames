package net.retrocade.tacticengine.monstro.global.core {
    public class MonstroFile {
        public var impl:MonstroFileImpl;
        public function MonstroFile(path: String) {
            this.impl = new MonstroFileImpl(path);
        }

        public function write(data:Object):void{
            impl.write(data);
        }

        public function read():Object{
            return impl.read();
        }

    }
}

CF::desktop {
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.utils.ByteArray;
    import flash.utils.getQualifiedClassName;
    import net.retrocade.tacticengine.monstro.global.core.MonstroData;
    import net.retrocade.utils.UtilsByteArray;

    class MonstroFileImpl {
        public var file: File;
        public function MonstroFileImpl(path: String) {
            file = new File(path);

			if (!file.parent.exists){
				file.parent.createDirectory();
			}
        }

        public function write(data:Object):void{
            var byteArray:ByteArray = new ByteArray();
            byteArray.writeObject(data);

            byteArray.position = 0;
            var fileStream:FileStream = new FileStream();
            fileStream.open(file, FileMode.WRITE);

            fileStream.writeBytes(byteArray);

            fileStream.close();
        }

        public function read():Object{
			var result:Object = {};

			if (file.exists){
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);

				try {
					result = fileStream.readObject();
				} catch(error:Error) {
					result = readLegacy();
				}

				fileStream.close();

				var className:String = getQualifiedClassName(result);
				if (className != "Object"){
					result = {};
				}
			}

            return result;
        }

		private function readLegacy():Object{

			try{
				if (file.exists){
					var fileStream:FileStream = new FileStream();
					fileStream.open(file, FileMode.READ);

					var byteArray:ByteArray = UtilsByteArray.fromHexString(fileStream.readUTFBytes(fileStream.bytesAvailable));
					fileStream.close();

					byteArray.position = 0;
					var result:Object = byteArray.readObject();

					var className:String = getQualifiedClassName(result);
					if (className != "Object"){
						return {};
					} else {
						return result;
					}
				} else {
					return {};
				}
			} catch (error:Error){
				return {};
			}

			return {};
		}
    }
}

CF::flash {
    import flash.net.SharedObject;
    import net.retrocade.utils.UtilsByteArray;
    import flash.utils.ByteArray;
    import flash.utils.getQualifiedClassName;

    class MonstroFileImpl {
        public var path: String;
        public var sharedObject: SharedObject;
        public function MonstroFileImpl(_path: String) {
            path = _path;

            sharedObject = SharedObject.getLocal(_path, "/");
        }

        public function write(data:Object):void{
            var byteArray:ByteArray = new ByteArray();
            byteArray.writeObject(data);
            byteArray.position = 0;

            sharedObject.data['contents'] = UtilsByteArray.toHexString(byteArray);
            sharedObject.flush();
        }

        public function read():Object{
			if (!sharedObject.data['contents']) {
                return {};
            }
            var byteArray: ByteArray = UtilsByteArray.fromHexString(sharedObject.data['contents']);
            byteArray.position = 0;

            var result:Object = byteArray.readObject();

            var className:String = getQualifiedClassName(result);
            if (className != "Object"){
                return {};
            } else {
                return result;
            }
        }
    }
}