package net.retrocade.tacticengine.monstro.ingame.events
{
	import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.core.IEvent;
	import net.retrocade.tacticengine.monstro.ingame.actions.IMonstroAction;
	
	public class MonstroEventNewAction extends MonstroEvent{
		public static const NAME:String = "new_effect";
		
		public var action:IMonstroAction;
		
		public function MonstroEventNewAction(effect:IMonstroAction){
			this.action = effect;

            dispatch(NAME);
		}
		
		override public function dispose():void{
			action = null;
		}
	}
}