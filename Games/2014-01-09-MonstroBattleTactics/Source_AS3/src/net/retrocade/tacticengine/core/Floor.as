package net.retrocade.tacticengine.core{
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

    public class Floor extends FieldObject{
        public function Floor(field:MonstroField){
            super(field);
        }

        public function canMoveTo(dx:int, dy:int, entity:MonstroEntity):Boolean{
            return true;
        }

        public function canStandOn(entity:MonstroEntity):Boolean{
            return true;
        }
    }
}