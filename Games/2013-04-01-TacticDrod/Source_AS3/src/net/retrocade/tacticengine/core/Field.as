package net.retrocade.tacticengine.core{
    public class Field implements IDestruct{
        private var _tiles:Vector.<Vector.<Tile>>;
        
        private var _width:int;
        private var _height:int;
        
        public function get width():int{
            return _width;
        }
        
        public function get height():int{
            return _height;
        }
        
        public function Field(){}
        
        public function init(width:int, height:int):void{
            _width = width;
            _height = height;
            
            _tiles = new Vector.<Vector.<Tile>>(width, true);
            
            for (var i:int = 0; i < width; i++){
                _tiles[i] = new Vector.<Tile>(height, true);
                
                for (var j:int = 0; j < height; j++){
                    _tiles[i][j] = new Tile(i, j, this);
                }
            }
        }
        
        public function getTileAt(x:int, y:int):Tile{
            if (x < 0 || y < 0 || x >= _width || y >= _height){
                return null;
            }
            
            return _tiles[x][y];
        }

        public function getAllEntities():Vector.<Entity>{
            var entities:Vector.<Entity> = new Vector.<Entity>();

            for each(var column:Vector.<Tile> in _tiles){
                for each(var tile:Tile in column){
                    if (tile.entity){
                        entities.push(tile.entity);
                    }
                }
            }

            return entities;
        }
        
        public function destruct():void{
            
        }
    }
}