/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 13.01.13
 * Time: 11:03
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.events {
    import net.retrocade.tacticengine.core.IEvent;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;

    public class MonstroEventUnitDisable extends MonstroEvent{
        public static const NAME:String = "unit_disable";
        public var unit:MonstroEntity;

        public function MonstroEventUnitDisable(unit:MonstroEntity){
            this.unit = unit;

            dispatch(NAME);
        }

        override public function destruct():void{
            unit = null;
        }
    }
}