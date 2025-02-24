
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventUndo extends MonstroEvent{
        public static const NAME:String = "undo_movement";

		private var _undidFromMissionEnd:Boolean;

		public function get undidFromMissionEnd():Boolean {
			return _undidFromMissionEnd;
		}

		public function MonstroEventUndo(undidFromMissionEnd:Boolean = false){
			_undidFromMissionEnd = undidFromMissionEnd;
            dispatch(NAME);
        }
    }
}
