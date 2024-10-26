package net.retrocade.storage{
    import flash.utils.ByteArray;

    import net.retrocade.camel.global.retrocamel_int;

    import net.retrocade.utils.Base64;
    import net.retrocade.utils.UObjects;
    import net.retrocade.utils.USecure;

    use namespace retrocamel_int;

    public class Storage{
        retrocamel_int static var _storageObject:Object;
        retrocamel_int static var _storageHash:String;

        retrocamel_int static var _cryptoKey:String = "9dn2pr0kOjSU82o";
        retrocamel_int static var _scrambleKey:int = 174763;
        retrocamel_int static var _salt:String;

        private static var _integrityViolationCallback:Function;

        private static var _ioHandler:IStorageIOHandler;

        public static function init(ioHandler:IStorageIOHandler, cryptoKey:String, salt:String, scrambleKey:int):void{
            _ioHandler = ioHandler;

            _cryptoKey = cryptoKey;
            _salt = salt;
            _scrambleKey = scrambleKey;

            load();
        }

        public static function writeObject(key:String, value:Object):void{
            var serializer:ByteArray = new ByteArray();
            serializer.writeObject(value);

            write(key, Base64.encodeByteArray(serializer));
        }

        public static function writeFlag(key:String, value:Boolean):void{
            write(key, value ? "TRUE" : "FALSE");
        }

        public static function writeNumber(key:String, value:Number):void{
            write(key, value.toString());
        }

        public static function writeString(key:String, value:String):void{
            write(key, value);
        }

        public static function readObject(key:String, defaultReturn:Object):Object{
            var value:String = read(key, null);

            if (!value){
                return defaultReturn;
            } else {
                var unserializer:ByteArray = Base64.decodeByteArray(value);
                unserializer.position = 0;

                return unserializer.readObject();
            }
        }

        public static function readFlag(key:String, defaultReturn:Boolean):Boolean{
            return read(key, defaultReturn ? "TRUE" : "FALSE") === "TRUE";
        }

        public static function readNumber(key:String, defaultReturn:Number):Number{
            return parseFloat(read(key, defaultReturn.toString()));
        }

        public static function readString(key:String, defaultReturn:String):String{
            return read(key, defaultReturn);
        }

        public static function registerIntegrityViolationCallback(callback:Function):void{
            _integrityViolationCallback = callback;
        }

        public static function has(key:String):Boolean{
            return _storageObject.hasOwnProperty(key);
        }

        retrocamel_int static function load():void{
            if (_ioHandler){
                _storageObject = _ioHandler.read();
            } else {
                _storageObject = {};
            }
        }

        public static function save():void{
            if (_ioHandler){
                _ioHandler.write(_storageObject);
            }
        }

        private static function write(key:String, value:String):void{
            if (value === null){
                delete _storageObject[key];
            } else {
                _storageObject[key] = value;
            }
        }

        private static function read(key:String, def:String):String{
            if (_storageObject.hasOwnProperty(key)){
                return _storageObject[key];
            } else {
                return def;
            }
        }
    }
}