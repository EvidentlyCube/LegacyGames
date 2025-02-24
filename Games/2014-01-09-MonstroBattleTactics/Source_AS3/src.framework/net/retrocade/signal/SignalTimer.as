package net.retrocade.signal{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class SignalTimer{
		private var _timer:Timer;

		private var _onTimerCycle:Signal;
		private var _onTimerFinished:Signal;

		public function SignalTimer(delay:Number, repeatCount:int = 0) {
			_timer = new Timer(delay, repeatCount);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);

			_onTimerCycle = new Signal();
			_onTimerFinished = new Signal();
		}

		public function dispose():void {
			_onTimerCycle.clear();
			_onTimerFinished.clear();

			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_timer = null;
		}

		public function stop():void {
			_timer.stop();
		}

		public function reset():void {
			_timer.reset();
		}

		public function start():void {
			_timer.start();
		}

		private function onTimer(event:TimerEvent):void {
			_onTimerCycle.call(this);
		}

		private function onTimerComplete(event:TimerEvent):void {
			_onTimerFinished.call(this);
		}


		public function get onTimerCycle():Signal {
			return _onTimerCycle;
		}

		public function get onTimerFinished():Signal {
			return _onTimerFinished;
		}
	}
}
