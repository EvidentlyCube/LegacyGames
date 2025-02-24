
package net.retrocade.tacticengine.monstro.ingame.events {
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

	public class MonstroEventUndidUnit extends MonstroEvent{
        public static const NAME:String = "MonstroEventUndidUnit";

		private var _entity:MonstroEntity;

		public function get entity():MonstroEntity {
			return _entity;
		}

		public function MonstroEventUndidUnit(entity:MonstroEntity){
			_entity = entity;
            dispatch(NAME);
        }
    }
}
