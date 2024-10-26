package net.retrocade.stats.pusher
{
	import flash.errors.IllegalOperationError;

    import net.retrocade.stats.core.StatsData;

    import net.retrocade.stats.outputs.IStatsOutput;


	public class BaseAnalyticPusher implements IStatsPusher
	{
		private var _outputs:Vector.<IStatsOutput>;
		
		public function set outputs(outputs:Vector.<IStatsOutput>):void
		{
			_outputs = outputs;
		}
		
		protected function pushAllOutputs():void
		{
			if (_outputs)
			{
				for each(var output:IStatsOutput in _outputs)
				{
					output.pushAllData();
				}
			}
		}
		
		public function dataAdded(data:StatsData, module:IStatsOutput):void
		{
			throw new IllegalOperationError("dataAdded has to be overriden in a subclass");
		}
	}
}