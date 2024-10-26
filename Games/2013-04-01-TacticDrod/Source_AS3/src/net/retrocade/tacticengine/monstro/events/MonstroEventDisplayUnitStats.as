/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 17.01.13
 * Time: 10:16
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.events {
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;

    public class MonstroEventDisplayUnitStats extends MonstroEvent{
        public static const NAME:String = "display_unit_stats";

        public var unit:MonstroEntity;

        public function MonstroEventDisplayUnitStats(unit:MonstroEntity){
            this.unit = unit;

            dispatch(NAME);
        }
    }
}
