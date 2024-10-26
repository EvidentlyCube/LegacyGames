package net.retrocade.tacticengine.core{
    public class Tile extends FieldObject{
        private var _floor:Floor;
        private var _entity:Entity;
        
        public function Tile(x:int, y:int, field:Field){
            super(field);
            
            _x = x;
            _y = y;
        }
        
        public function get floor():Floor{
            return _floor;
        }
        
        public function set floor(floor:Floor):void{
            _floor = floor;
        }
        
        
        public function get entity():Entity{
            return _entity;
        }
        
        public function set entity(entity:Entity):void{
            _entity = entity;
        }
        
        public function canStep(dx:int, dy:int, entity:Entity):Boolean{
            var tile:Tile = field.getTileAt(_x + dx, _y + dy);
            
            if (!tile){
                return false;
            }
            
            return tile.canMoveTo(dx, dy, entity);
        }
        
        private function canMoveTo(dx:int, dy:int, entity:Entity):Boolean{
            return _floor.canMoveTo(dx, dy, entity) && (!_entity || _entity === entity || _entity.canMoveTo(dx, dy, entity));
        }

        public function canStandOn(entity:Entity):Boolean{
            return _floor.canStandOn(entity) && (!_entity || _entity === entity);
        }
        
        public function getTilesAround(entity:Entity, fillVector:Vector.<Tile>):Vector.<Tile>{
            if (!fillVector){
                fillVector = new Vector.<Tile>();
            }
            
            if (entity){
                if (canStep(1, 0, entity)){
                    fillVector.push(field.getTileAt(_x + 1, _y));
                }
                
                if (canStep(0, 1, entity)){
                    fillVector.push(field.getTileAt(_x, _y + 1));
                }
                
                if (canStep(-1, 0, entity)){
                    fillVector.push(field.getTileAt(_x - 1, _y));
                }
                
                if (canStep(0, -1, entity)){
                    fillVector.push(field.getTileAt(_x, _y - 1));
                }
            } else {
                var tile:Tile = field.getTileAt(_x + 1, _y);
                if (tile){fillVector.push(tile);}
                
                tile = field.getTileAt(_x, _y + 1);
                if (tile){fillVector.push(tile);}
                
                tile = field.getTileAt(_x - 1, _y);
                if (tile){fillVector.push(tile);}
                
                tile = field.getTileAt(_x, _y - 1);
                if (tile){fillVector.push(tile);}
            }
            
            return fillVector;
        }
        
        override public function destruct():void{
            _floor = null;
            _entity = null;
        }

        public function toString():String{
            return "Tile: " + _x + "x" + _y;
        }
    }
}