package net.retrocade.stats.pusher
{
    import net.retrocade.stats.core.StatsData;
    import net.retrocade.stats.outputs.IStatsOutput;

	public interface IStatsPusher
	{
		function set outputs(outputs:Vector.<IStatsOutput>):void;
		function dataAdded(data:StatsData, module:IStatsOutput):void;
	}
}