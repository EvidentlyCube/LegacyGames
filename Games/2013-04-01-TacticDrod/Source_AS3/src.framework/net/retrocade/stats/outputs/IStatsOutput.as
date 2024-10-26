package net.retrocade.stats.outputs{
    import net.retrocade.stats.core.StatsData;

	public interface IStatsOutput{
		function addData(entry:StatsData):void;
		function pushAllData():void;
		function get dataCount():uint;
		function clearData():void;
	}
}