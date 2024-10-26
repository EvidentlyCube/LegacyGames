package net.retrocade.tacticengine.monstro.events
{
	import net.retrocade.tacticengine.core.IDestruct;
	import net.retrocade.tacticengine.core.IEvent;
	import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.actions.MonstroUnitStepData;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
	
	import starling.display.DisplayObject;
	
	public class MonstroEventUnitMoved extends MonstroEvent{
		public static const NAME:String = "unit_moved";
		
		public var unit:MonstroEntity;
		public var movementPath:Vector.<MonstroUnitStepData>;
        public var onFinished:Function;
		
		public function MonstroEventUnitMoved(unit:MonstroEntity, movementPath:Vector.<MonstroUnitStepData>, onFinished:Function = null){
			this.unit = unit;
			this.movementPath = movementPath;
            this.onFinished = onFinished;

            dispatch(NAME);
		}
		
		override public function destruct():void{
			unit = null;
			movementPath = null;
            onFinished = null;
		}
	}
}