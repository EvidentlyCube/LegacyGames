
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventSortUnitDisplay extends MonstroEvent{
        public static const NAME:String = "sort_unit_display";

        public function MonstroEventSortUnitDisplay(){
            dispatch(NAME);
        }
    }
}
