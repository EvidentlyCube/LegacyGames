package game.global.tutorial{
	import game.global.Permit;
	import game.global.newTutorial.NewTutorial;
	import game.standalone.THelpMessage;
	
	import net.retrocade.camel.global.rEvents;

	public class TTutorialEntry{
		private var _events:Array = [];
		private var _message:String;
		private var _permissions:Array;
		private var _x:int;
        private var _y:int;
        private var _function:Function;
        
		public function get message():String{
			return _message;
		}
		
		public function TTutorialEntry(message:String, events:Array, permissions:Array, x:int, y:int, func:Function = null){
			_message = message;
			_events  = events;
			_permissions = permissions;
            _x = x;
            _y = y;
            _function = func;
		}
		
		public function set():void{
			Permit.setPermission(_permissions);
			
            NewTutorial.set(_message, _x, _y, _function);
		}
		
		internal function update():Boolean{
			var doneEvents:Array = [];
			
			for(var i:int = _events.length - 1; i >= 0; i--){
                var event:int = _events[i];
				if (rEvents.occured(event)){
                    if (doneEvents[event] && doneEvents[event] >= rEvents.getOccurenceCount(_events[event])){
                        continue;
                    } else {
                        doneEvents[event] = (!doneEvents[event] ? 1 : doneEvents[event] + 1);
    					_events.splice(i, 1);
                    }
				}
			}
			
			return _events.length == 0;
		}
	}
}