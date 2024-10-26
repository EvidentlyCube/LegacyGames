package net.retrocade.tacticengine.monstro.events
{
	public class MonstroEventTransition extends MonstroEvent{
		public static const NAME:String = "return_to_menu";

        public static const TRANSITION_RESTART_MISSION:int = 0;
        public static const TRANSITION_RETURN_TO_MENU:int = 1;
        public static const TRANSITION_NEXT_MISSION:int = 2;

        public var type:int;

		public function MonstroEventTransition(type:int){
            this.type = type;

            dispatch(NAME);
		}
	}
}