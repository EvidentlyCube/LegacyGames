package net.retrocade.tacticengine.core{
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.floors.MonstroTileFloor;

    public class Tile extends FieldObject{
        private var _floor:MonstroTileFloor;
        private var _entity:MonstroEntity;
        
        public function Tile(x:int, y:int, field:MonstroField){
            super(field);
            
            _x = x;
            _y = y;
        }
        
        public function get floor():MonstroTileFloor{
            return _floor;
        }
        
        public function set floor(floor:MonstroTileFloor):void{
            _floor = floor;
        }
        
        
        public function get entity():MonstroEntity{
            return _entity;
        }
        
        public function set entity(entity:MonstroEntity):void{
            _entity = entity;
        }
        
        public function canStep(dx:int, dy:int, entity:MonstroEntity):Boolean{
            var tile:Tile = field.getTileAt(_x + dx, _y + dy);
            
            if (!tile){
                return false;
            }
            
            return tile.canMoveTo(dx, dy, entity);
        }
        
        private function canMoveTo(dx:int, dy:int, entity:MonstroEntity):Boolean{
            return _floor.canMoveTo(dx, dy, entity) && (!_entity || _entity === entity || _entity.canMoveTo(dx, dy, entity));
        }

        public function canStandOn(entity:MonstroEntity):Boolean{
            return _floor.canStandOn(entity) && (!_entity || _entity === entity);
        }
        
        override public function dispose():void{
            _floor.dispose();
            _floor = null;

            if (_entity){
                _entity.dispose();
                _entity = null;
            }
        }

        public function toString():String{
            return "Tile: " + _x + "x" + _y;
        }
    }
}