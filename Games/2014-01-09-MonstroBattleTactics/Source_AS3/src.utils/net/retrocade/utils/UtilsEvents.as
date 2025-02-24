package net.retrocade.utils {
    import flash.events.EventDispatcher;

    import starling.events.EventDispatcher;

    public class UtilsEvents {
        public static function addListeners(type:String, callback:Function, objects:Array):void{
            for each (var object:Object in objects){
                if (object is flash.events.EventDispatcher){
                    flash.events.EventDispatcher(object).addEventListener(type, callback);

                } else if (object is starling.events.EventDispatcher){
                    starling.events.EventDispatcher(object).addEventListener(type, callback);
                }
            }
        }
    }
}
