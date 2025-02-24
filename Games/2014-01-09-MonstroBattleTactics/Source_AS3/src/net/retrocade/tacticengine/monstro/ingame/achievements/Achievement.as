package net.retrocade.tacticengine.monstro.ingame.achievements {
	public class Achievement{
		private static var _counter:uint = 0;
		public var isAcquired:Boolean = false;

		public var index:uint;
		public var id:String;
		public var onGeneralUpdate:Function;
		public var onIngameUpdate:Function;

		public function Achievement(id:String, onUpdate:Function, onGeneralRun:Function) {
			this.index = _counter++;
			this.id = id;
			this.onIngameUpdate = onUpdate;
			this.onGeneralUpdate = onGeneralRun;
		}
	}
}
