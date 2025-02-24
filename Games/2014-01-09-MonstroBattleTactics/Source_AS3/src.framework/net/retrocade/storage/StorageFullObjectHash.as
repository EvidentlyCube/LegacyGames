

package net.retrocade.storage{
    import flash.utils.ByteArray;

    import net.retrocade.retrocamel.core.retrocamel_int;

    import net.retrocade.utils.UtilsBase64;
	import net.retrocade.utils.UtilsMd5;
	import net.retrocade.utils.UtilsObjects;
    import net.retrocade.utils.UtilsSecure;

    use namespace retrocamel_int;

    public class StorageFullObjectHash implements IStorage{
        retrocamel_int  var _storageObject:Object;
        retrocamel_int  var _storageHash:String;

        retrocamel_int  var _cryptoKey:String = "9dn2pr0kOjSU82o";
        retrocamel_int  var _scrambleKey:int = 174763;
        retrocamel_int  var _salt:String;

        private  var _integrityViolationCallback:Function;

        private  var _ioHandler:IStorageIOHandler;

        public function StorageFullObjectHash(ioHandler:IStorageIOHandler, cryptoKey:String, salt:String, scrambleKey:int):void{
            _ioHandler = ioHandler;

            _cryptoKey = cryptoKey;
            _salt = salt;
            _scrambleKey = scrambleKey;

            load();
        }

        public function writeObject(key:String, value:Object):void{
            var serializer:ByteArray = new ByteArray();
            serializer.writeObject(value);

            write(key, UtilsBase64.encodeByteArray(serializer));
        }

        public  function writeFlag(key:String, value:Boolean):void{
            write(key, value ? "TRUE" : "FALSE");
        }

        public  function writeNumber(key:String, value:Number):void{
            write(key, value.toString());
        }

        public  function writeString(key:String, value:String):void{
            write(key, value);
        }

        public  function readObject(key:String, defaultReturn:Object):Object{
            var value:String = read(key, null);

            if (!value){
                return defaultReturn;
            } else {
                var unserializer:ByteArray = UtilsBase64.decodeByteArray(value);
                unserializer.position = 0;

                return unserializer.readObject();
            }
        }

        public  function readFlag(key:String, defaultReturn:Boolean):Boolean{
            return read(key, defaultReturn ? "TRUE" : "FALSE") === "TRUE";
        }

        public  function readNumber(key:String, defaultReturn:Number):Number{
            return parseFloat(read(key, defaultReturn.toString()));
        }

        public  function readString(key:String, defaultReturn:String):String{
            return read(key, defaultReturn);
        }

        public  function registerIntegrityViolationCallback(callback:Function):void{
            _integrityViolationCallback = callback;
        }

        public  function has(key:String):Boolean{
            verifyIntegrity();

            key = encodeKey(key);

            return _storageObject.hasOwnProperty(key);
        }

        public function load():void{
            if (_ioHandler){
                _storageObject = _ioHandler.read();
            } else {
                _storageObject = {};
            }

            regenerateHash();
        }

        public  function save():void{
            if (_ioHandler){
                _ioHandler.write(_storageObject);
            }
        }

        private  function write(key:String, value:String):void{
            verifyIntegrity();

            key = encodeKey(key);

            if (value === null){
                delete _storageObject[key];
            } else {
                value = encodeValue(value);
                _storageObject[key] = value;
            }

            regenerateHash();
        }

        private  function read(key:String, def:String):String{
            verifyIntegrity();

            key = encodeKey(key);

            if (_storageObject.hasOwnProperty(key)){
                var value:String = _storageObject[key];
                value = decodeValue(value);
                return value;
            } else {
                return def;
            }
        }

        retrocamel_int  function encodeKey(key:String):String{
            return UtilsMd5.encrypt(key);
        }

        private  function encodeValue(value:String):String{
            return UtilsSecure.rotComplexForward(value);
        }

        private  function decodeValue(value:String):String{
            return UtilsSecure.rotComplexBackwards(value);
        }

        private  function verifyIntegrity():void{
            if (_storageHash != generateHash(_storageObject)){
                onIntegrityViolation();
            }
        }

        private  function onIntegrityViolation():void{
            _storageObject = {};
            regenerateHash();

            save();

            if (_integrityViolationCallback != null){
                _integrityViolationCallback();
            }
        }

        private  function regenerateHash():void{
            _storageHash = generateHash(_storageObject);
        }

        private  function generateHash(toHash:Object):String{
            var string:String = UtilsObjects.toString(toHash);

            var targetHash:String = "";
            var i:int = 0;

            do {
                targetHash += UtilsSecure.hashStringJenkins(string.substr(i));

                i++;

                if (i >= string.length){
                    i = 0;
                }
            } while (targetHash.length < 32);

            return targetHash.substr(0, 32);
        }
    }
}