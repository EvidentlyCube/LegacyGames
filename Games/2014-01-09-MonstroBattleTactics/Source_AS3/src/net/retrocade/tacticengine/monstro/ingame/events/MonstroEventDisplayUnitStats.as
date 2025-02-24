
package net.retrocade.tacticengine.monstro.ingame.events {
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

    public class MonstroEventDisplayUnitStats extends MonstroEvent{
        public static const NAME:String = "display_unit_stats";

        public var unit:MonstroEntity;

        public function MonstroEventDisplayUnitStats(unit:MonstroEntity){
            this.unit = unit;

            dispatch(NAME);
        }
    }
}
