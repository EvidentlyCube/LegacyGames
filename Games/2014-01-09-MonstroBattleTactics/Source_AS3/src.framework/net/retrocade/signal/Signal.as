package net.retrocade.signal{
	public class Signal{
		private var _listeners:Vector.<Function>;

		public function Signal(){
			_listeners = new Vector.<Function>();
		}

		public function add(callback:Function):void{
			if (_listeners.indexOf(callback) === -1){
				_listeners.push(callback);
			}
		}

		public function remove(callback:Function):void{
			var index:int = _listeners.indexOf(callback);

			if (index !== -1){
				_listeners.splice(index, 1);
			}
		}

		public function call(...args):void{
			for each(var callback:Function in _listeners){
				if (callback.length === 0){
					callback();
				} else {
					callback.apply(null, args);
				}
			}
		}

		public function clear():void{
			_listeners.length = 0;
		}
	}
}
