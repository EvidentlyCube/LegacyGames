package net.retrocade.tacticengine.monstro.ingame.events
{
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

	public class MonstroEventDefenseRestored extends MonstroEvent{
		public static const NAME:String = "MonstroEventDefenseRestored";
		
		public var unit:MonstroEntity;
		
		public function MonstroEventDefenseRestored(unit:MonstroEntity){
			this.unit = unit;

            dispatch(NAME);
		}
		
		override public function dispose():void{
			unit = null;
		}
	}
}