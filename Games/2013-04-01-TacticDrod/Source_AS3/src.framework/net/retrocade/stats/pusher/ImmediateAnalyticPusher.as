package net.retrocade.stats.pusher
{
    import net.retrocade.stats.core.StatsData;
    import net.retrocade.stats.outputs.IStatsOutput;

	public class ImmediateAnalyticPusher extends BaseAnalyticPusher
	{
		override public function dataAdded(data:StatsData, module:IStatsOutput):void
		{
			module.pushAllData();
		}
	}
}