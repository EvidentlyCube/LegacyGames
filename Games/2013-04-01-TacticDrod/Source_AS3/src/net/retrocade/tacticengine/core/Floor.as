package net.retrocade.tacticengine.core{
    public class Floor extends FieldObject{
        public function Floor(field:Field){
            super(field);
        }

        public function canMoveTo(dx:int, dy:int, entity:Entity):Boolean{
            return true;
        }

        public function canStandOn(entity:Entity):Boolean{
            return true;
        }
    }
}