package net.retrocade.utils {
    import flash.utils.ByteArray;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    /**
     * ...
     * @author 
     */
    public class UObjects {        
        public static function getClass(obj:Object):Class {
            return Class(getDefinitionByName(getQualifiedClassName(obj)));
        }
        
        public static function getClassName(obj:Object):String {
            return getQualifiedClassName(obj);
        }

        public static function toString(object:Object):String{
            var byteArray:ByteArray = new ByteArray();
            byteArray.writeObject(object);

            byteArray.position = 0;

            return byteArray.readUTFBytes(byteArray.length);
        }

        public static function serialize(object:Object):String{
            var byteArray:ByteArray = new ByteArray();
            byteArray.writeObject(object);
            byteArray.position = 0;

            return Base64.encodeByteArray(byteArray);
        }

        public static function unserialize(serializedString:String):Object{
            var byteArray:ByteArray = Base64.decodeByteArray(serializedString);
            byteArray.position = 0;

            return byteArray.readObject();
        }
    }
}