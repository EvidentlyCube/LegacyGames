

package net.retrocade.utils {
    import flash.display.DisplayObject;
    import flash.utils.ByteArray;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;

    import game.objects.TExit;
    import game.objects.TPlayer;

    import net.retrocade.retrocamel.components.RetrocamelDisplayObject;

    /**
     * ...
     * @author 
     */
    public class UtilsObjects {
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

            return UtilsBase64.encodeByteArray(byteArray);
        }

        public static function unserialize(serializedString:String):Object{
            var byteArray:ByteArray = UtilsBase64.decodeByteArray(serializedString);
            byteArray.position = 0;

            return byteArray.readObject();
        }

        public static function distanceSquared(left:Object, right:Object):Number {
            return UtilsNumber.distanceSquared(left.x, left.y, right.x, right.y);
        }
        public static function distanceSquaredFromCenter(left:Object, right:Object):Number {
            return UtilsNumber.distanceSquared(left.x + left.width / 2, left.y + left.height / 2, right.x + right.width / 2, right.y + right.height / 2);
        }
    }
}