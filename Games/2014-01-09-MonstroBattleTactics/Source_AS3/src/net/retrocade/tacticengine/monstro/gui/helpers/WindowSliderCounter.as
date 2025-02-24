package net.retrocade.tacticengine.monstro.gui.helpers {
	import net.retrocade.retrocamel.effects.RetrocamelEasings;
	import net.retrocade.signal.Signal;

	public class WindowSliderCounter {
		private var _position:Number = 1;
		private var _isShowing:Boolean = true;
		private var _isHiding:Boolean = false;

		public var speed:Number;
		public var onStartHiding:Signal;
		public var onFinishedShowing:Signal;
		public var onFinishedHiding:Signal;

		public function get position():Number {
			return _position;
		}

		public function get isShowing():Boolean {
			return _isShowing;
		}

		public function get isHiding():Boolean {
			return _isHiding;
		}

		public function get isFullyHidden():Boolean{
			return !_isShowing && !_isHiding && _position >= 1;
		}

		public function WindowSliderCounter(position:Number) {
			_position = position;

			speed = 0.07;

			onStartHiding = new Signal();
			onFinishedShowing = new Signal();
			onFinishedHiding = new Signal();
		}

		public function dispose():void {
			onStartHiding.clear();
			onFinishedShowing.clear();
			onFinishedHiding.clear();

			onStartHiding = null;
			onFinishedShowing = null;
			onFinishedHiding = null;
		}



		public function update():Boolean {
			if (isShowing){
				_position -= speed;

				if (_position <= 0){
					_isShowing = false;
					_position = 0;
					onFinishedShowing.call();
				}

				return true;
			}

			if (_isHiding){
				_position += speed;

				if (_position >= 1){
					_isHiding = false;
					_position = 1;
					onFinishedHiding.call();
				}

				return true;
			}

			return false;
		}

		public function set position(value:Number):void {
			_position = value;
		}

		public function get positionFactor():Number {
			return RetrocamelEasings.quadraticIn(_position);
		}

		public function show():void{
			_isShowing = true;
			_isHiding = false;
		}

		public function hide():void{
			_isShowing = false;
			_isHiding = true;

			onStartHiding.call();
		}
	}
}
