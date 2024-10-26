package game.global.tutorial{
	

	public class TTutorial{
		private static var _entries:Array;
		
		public static function init(entries:Array):void{
			_entries = entries;
			
			showCurrent();
		}
		
		public static function update():void{
			if (!_entries)
				return;
			
			var currentEntry:TTutorialEntry;
			
			if (!_entries.length)
				return;
			
			currentEntry = _entries[0];
			
			if (currentEntry.update()){
				_entries.splice(0, 1);
				
				showCurrent();
			}
		}
		
		public static function showCurrent():void{
			if (!_entries.length)
				return;
			
			var currentEntry:TTutorialEntry = _entries[0];
			currentEntry.set();
		}
	}
}