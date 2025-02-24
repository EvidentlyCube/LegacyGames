package net.retrocade.tacticengine.monstro.ingame.events
{
	import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.core.IEvent;
	import net.retrocade.tacticengine.core.Tile;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
	
	import starling.display.DisplayObject;
	
	public class MonstroEventUnitKilled extends MonstroEvent{
		public static const NAME:String = "unit_killed";
		
		public var unit:MonstroEntity;
		
		public function MonstroEventUnitKilled(unit:MonstroEntity){
			this.unit = unit;

            dispatch(NAME);
		}
		
		override public function dispose():void{
			unit = null;
		}
	}
}