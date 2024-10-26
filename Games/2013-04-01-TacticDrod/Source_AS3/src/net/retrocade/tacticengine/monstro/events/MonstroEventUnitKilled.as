package net.retrocade.tacticengine.monstro.events
{
	import net.retrocade.tacticengine.core.IDestruct;
	import net.retrocade.tacticengine.core.IEvent;
	import net.retrocade.tacticengine.core.Tile;
	import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
	
	import starling.display.DisplayObject;
	
	public class MonstroEventUnitKilled extends MonstroEvent{
		public static const NAME:String = "unit_killed";
		
		public var unit:MonstroEntity;
        public var onFinished:Function;
		
		public function MonstroEventUnitKilled(unit:MonstroEntity, onFinished:Function = null){
			this.unit = unit;
            this.onFinished = onFinished;

            dispatch(NAME);
		}
		
		override public function destruct():void{
			unit = null;
            onFinished = null;
		}
	}
}