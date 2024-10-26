package net.retrocade.tacticengine.monstro.events
{
	import net.retrocade.tacticengine.core.IDestruct;
	import net.retrocade.tacticengine.core.IEvent;
	import net.retrocade.tacticengine.monstro.actions.IMonstroAction;
	
	public class MonstroEventNewAction extends MonstroEvent{
		public static const NAME:String = "new_effect";
		
		public var action:IMonstroAction;
		
		public function MonstroEventNewAction(effect:IMonstroAction){
			this.action = effect;

            dispatch(NAME);
		}
		
		override public function destruct():void{
			action = null;
		}
	}
}