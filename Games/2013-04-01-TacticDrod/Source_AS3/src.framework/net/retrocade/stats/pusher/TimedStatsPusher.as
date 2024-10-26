package net.retrocade.stats.pusher
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

    import net.retrocade.stats.core.StatsData;
    import net.retrocade.stats.outputs.IStatsOutput;

	public class TimedStatsPusher extends BaseAnalyticPusher
	{
		private var _timer:Timer;
		
		public function TimedStatsPusher(delayInSeconds:int = 1)
		{
			_timer = new Timer(delayInSeconds * 1000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
		}
		
		override public function dataAdded(data:StatsData, module:IStatsOutput):void
		{
			if (!_timer.running)
			{
				_timer.start();
			}
		}
		
		private function onTimer(e:TimerEvent):void
		{
			pushAllOutputs();
		}
	}
}