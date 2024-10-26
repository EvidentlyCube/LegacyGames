package net.retrocade.stats.outputs
{
    import net.retrocade.stats.core.StatsData;

    public class TraceStatsOutput implements IStatsOutput
	{
		private var _queuedData:Vector.<StatsData>;
		
		public function TraceStatsOutput()
		{
			_queuedData = new Vector.<StatsData>();
		}
		
		public function addData(entry:StatsData):void
		{
			_queuedData.push(entry);
		}
		
		public function pushAllData():void
		{
			for each(var data:StatsData in _queuedData)
			{
				pushSingleData(data);
			}
			
			clearData();
		}
		
		private function pushSingleData(data:StatsData):void{
			trace(dataToString(data));
		}
		
		public function get dataCount():uint
		{
			return _queuedData.length;
		}
		
		public function clearData():void
		{
			_queuedData.length = 0;
		}
		
		private function dataToString(data:StatsData):String{
			var string:String = data.timestamp + ": ";
			string += data.key + "::" + data.value;
			
			for (var field:String in data.meta)
			{
				string += "@ " + field + "::" + data.meta[field];
			}
			
			return string;
		}
	}
}