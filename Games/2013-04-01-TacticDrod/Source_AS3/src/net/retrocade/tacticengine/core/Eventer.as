package net.retrocade.tacticengine.core{
	public class Eventer{
        private static var _listeners:Array = [];
        
		public static function listen(event:String, listener:Function):void{
            var listeners:Array = _listeners[event];
            
			if (listeners){
                if (listeners.indexOf(listener) === -1){
                    listeners.push(listener);
                }
            } else {
                _listeners[event] = [listener];
            }
		}
		
		public static function release(event:String, listener:Function):void{
			var listeners:Array = _listeners[event];
            
            if (listeners){
				if (listener != null){
	                var index:int = listeners.indexOf(listener);
	                
	                if (index !== -1){
	                    listeners.splice(index, 1);
	                }
				} else {
					listeners.length = 0;
				}
            }
		}
		
		public static function dispatch(eventName:String, event:IEvent):void{
            var listeners:Array = _listeners[eventName];
            
            if (listeners){
                for each(var listener:Function in listeners){
                    if (listener.length == 1){
                        listener.call(null, event);
                    } else {
                        listener();
                    }

                    if (event.isPropagationStopped){
                        break;
                    }
                }
            }

            event.destruct();
		}
	}
}