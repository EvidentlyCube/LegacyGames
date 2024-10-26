package net.retrocade.tacticengine.monstro.events{
	import net.retrocade.tacticengine.monstro.entities.MonstroEntity;

	public class MonstroEventUnitSelected extends MonstroEvent{
		public static const NAME:String = "unit_selected";
		
		public var unit:MonstroEntity;
		
		public function MonstroEventUnitSelected(unit:MonstroEntity){
			this.unit = unit;

            dispatch(NAME);
		}
		
		override public function destruct():void{
			unit = null;
		}
	}
}