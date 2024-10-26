package net.retrocade.tacticengine.monstro.events
{
	public class MonstroEventLoadLevel extends MonstroEvent{
		public static const NAME:String = "load_level";

        public var index:int;

		public function MonstroEventLoadLevel(index:int){
            this.index = index;

            dispatch(NAME);
		}
	}
}