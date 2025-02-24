


package net.retrocade.storage {
	import flash.external.ExternalInterface;
    import flash.utils.ByteArray;
    import flash.utils.getQualifiedClassName;

    import net.retrocade.utils.UtilsBase64;
    import net.retrocade.utils.UtilsSecure;

    public class StorageIOHandlerToJsApi implements IStorageIOHandler{
        private var _cryptoKey:String = "9dn2pr0kOjSU82o";
        private var _scrambleKey:int = 174763;

        public function StorageIOHandlerToJsApi(scrambleKey:int){
            _scrambleKey = scrambleKey;
        }

        public function write(data:Object):void{
            var byteArray:ByteArray = new ByteArray();
            byteArray.writeObject(data);
            UtilsSecure.scrambleByteArray(byteArray, _scrambleKey);

			ExternalInterface.call('saveState', UtilsBase64.encodeByteArray(byteArray));
        }

        public function read():Object{
            try{
				var data:String = ExternalInterface.call('loadState');

				var byteArray:ByteArray = UtilsBase64.decodeByteArray(data);

				UtilsSecure.unscrambleByteArray(byteArray, _scrambleKey);

				var result:Object = byteArray.readObject();

				var className:String = getQualifiedClassName(result);
				if (className != "Object"){
					return {};
				} else {
					return result;
				}
            } catch (error:Error){
                return {};
            }

            return {};
        }
    }
}
