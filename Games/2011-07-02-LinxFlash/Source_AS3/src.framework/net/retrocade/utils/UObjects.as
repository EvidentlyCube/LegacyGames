package net.retrocade.utils {
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import net.retrocade.camel.objects.rObjectDisplay;

    /**
     * ...
     * @author 
     */
    public class UObjects {        
        public static function distance(o1:rObjectDisplay, o2:rObjectDisplay):Number {
            return (o1.xMid - o2.xMid) * (o1.xMid - o2.xMid) + (o1.yMid - o2.yMid) * (o1.yMid - o2.yMid);
        }
        
        public static function getClass(obj:Object):Class {
            return Class(getDefinitionByName(getQualifiedClassName(obj)));
        }
        
        public static function getClassName(obj:Object):String {
            return getQualifiedClassName(obj);
        }
    }

}