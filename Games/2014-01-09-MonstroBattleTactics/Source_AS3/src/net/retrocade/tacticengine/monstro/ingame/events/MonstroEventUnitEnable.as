
package net.retrocade.tacticengine.monstro.ingame.events {
    import net.retrocade.tacticengine.core.IEvent;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

    public class MonstroEventUnitEnable extends MonstroEvent{
        public static const NAME:String = "unit_enable";
        public var unit:MonstroEntity;

        public function MonstroEventUnitEnable(unit:MonstroEntity){
            this.unit = unit;

            dispatch(NAME);
        }

        override public function dispose():void{
            unit = null;
        }
    }
}
