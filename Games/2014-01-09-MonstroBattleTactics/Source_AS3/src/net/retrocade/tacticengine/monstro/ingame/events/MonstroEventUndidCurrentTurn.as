
package net.retrocade.tacticengine.monstro.ingame.events {
	public class MonstroEventUndidCurrentTurn extends MonstroEvent{
        public static const NAME:String = "MonstroEventUndidCurrentTurn";

		private var _newCurrentTurn:uint;

		public function get newCurrentTurn():uint {
			return _newCurrentTurn;
		}

		public function MonstroEventUndidCurrentTurn(newCurrentTurn:uint){
			_newCurrentTurn = newCurrentTurn;
            dispatch(NAME);
        }
    }
}
