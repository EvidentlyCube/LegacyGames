package net.retrocade.utils {
    import flash.utils.ByteArray;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import net.retrocade.camel.objects.rObjectDisplay;

    /**
     * ...
     * @author 
     */
    public class UObjects {        
        public static function distance(o1:rObjectDisplay, o2:rObjectDisplay):Number {
            return (o1.center - o2.center) * (o1.center - o2.center) + (o1.middle - o2.middle) * (o1.middle - o2.middle);
        }
        
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
    }

}