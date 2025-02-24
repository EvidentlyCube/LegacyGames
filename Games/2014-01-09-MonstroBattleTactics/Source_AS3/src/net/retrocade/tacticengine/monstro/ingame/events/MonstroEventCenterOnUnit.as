
package net.retrocade.tacticengine.monstro.ingame.events {
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

    public class MonstroEventCenterOnUnit extends MonstroEvent{
        public static const NAME:String = "center_on_unit";

        public var unit:MonstroEntity;

        public function MonstroEventCenterOnUnit(unit:MonstroEntity) {
            this.unit = unit;

            dispatch(NAME);
        }


        override public function dispose():void {
            super.dispose();

            unit = null;
        }
    }
}
