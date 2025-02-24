package net.retrocade.tacticengine.core{
	public class Eventer{
        private static var _listeners:Object = {};
        
		public static function listen(event:String, listenerFunction:Function, listenerContext:Object):void{
            var listeners:Vector.<EventerListener> = _listeners[event];
            
			if (_listeners[event]){
				for each (var listener:EventerListener in listeners) {
					if (listener.callback === listenerFunction && listener.context === listenerContext){
						return;
					}
				}

				listeners.push(new EventerListener(listenerFunction, listenerContext));
            } else {
				_listeners[event] = new <EventerListener>[new EventerListener(listenerFunction, listenerContext)];
            }
		}
		
		public static function release(event:String, callback:Function):void{
			var listeners:Vector.<EventerListener> = _listeners[event];
            
            if (listeners){
				for (var i:int = listeners.length - 1; i >= 0; i--) {
					if (listeners[i].callback === callback){
						listeners.splice(i, 1);
					}
				}
            }
		}

		public static function releaseContext(context:Object):void {
			for each (var listeners:Vector.<EventerListener> in _listeners) {
				if (!listeners){
					continue;
				}

				for (var i:int = listeners.length - 1; i >= 0; i--) {
					if (listeners[i].context === context){
						listeners.splice(i, 1);
					}
				}
			}
		}
		
		public static function dispatch(eventName:String, event:IEvent):void{
            var listeners:Vector.<EventerListener> = _listeners[eventName];
            
            if (listeners){
                var i:int = listeners.length - 1;
                for (; i >= 0; i--){
                    var listener:EventerListener = listeners[i];

                    if (listener.callback.length == 1){
                        listener.callback.call(null, event);
                    } else {
                        listener.callback();
                    }

                    if (event.isPropagationStopped){
                        break;
                    }
                }
            }

            event.dispose();
		}
	}
}

class EventerListener{
	public var callback:Function;
	public var context:Object;


	public function EventerListener(callbackFunction:Function, context:Object) {
		this.callback = callbackFunction;
		this.context = context;
	}
}