package net.retrocade.tacticengine.monstro.ingame.events
{
	import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.core.IEvent;
	import net.retrocade.tacticengine.core.Tile;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
	
	import starling.display.DisplayObject;
	
	public class MonstroEventUnitMoved extends MonstroEvent{
		public static const NAME:String = "unit_moved";
		
		public var unit:MonstroEntity;
		public var movementPath:Vector.<Tile>;
        public var onFinished:Function;
		
		public function MonstroEventUnitMoved(unit:MonstroEntity, movementPath:Vector.<Tile>, onFinished:Function = null){
			this.unit = unit;
			this.movementPath = movementPath;
            this.onFinished = onFinished;

            dispatch(NAME);
		}
		
		override public function dispose():void{
			unit = null;
			movementPath = null;
            onFinished = null;
		}
	}
}