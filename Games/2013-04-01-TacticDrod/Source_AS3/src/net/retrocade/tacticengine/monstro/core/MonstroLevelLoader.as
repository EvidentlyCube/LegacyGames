package net.retrocade.tacticengine.monstro.core{
    import net.retrocade.tacticengine.core.Entity;
    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.floors.MonstroTileFloor;

    public class MonstroLevelLoader{
        public static function loadLevel(level:XML, field:Field, isPlayerHuman:Boolean):void{
            var width:int = int(level.width) / Monstro.tileWidth;
            var height:int = int(level.height) / Monstro.tileHeight;
            
            field.init(width, height);

            fillFieldFloors(field);
            
            var tile:Tile;
            var floor:MonstroTileFloor;
            var tileXML:XML;

            var x:Number;
            var y:Number;

            var tx:Number;
            var ty:Number;

            for each(tileXML in level..tile){
                x = tileXML.@x / Monstro.tileWidth | 0;
                y = tileXML.@y / Monstro.tileHeight | 0;

                tile = field.getTileAt(x, y);
                floor = tile.floor as MonstroTileFloor;

                tx = tileXML.@tx / Monstro.tileWidth | 0;
                ty = tileXML.@ty / Monstro.tileHeight | 0;

                if (tx == 0 && ty == 0){
                    floor.isWall = true;
                    floor.isObstacle = true;
                    floor.tx = tx;
                    floor.ty = ty;

                } else if (tx >= 20 && tx <= 21 && ty >= 5 && ty <= 6){
                    floor.isFloor = true;
                    floor.addLayerItemIndex(getFloorTexture(x, y));
                } else {
                    floor.isObstacle = true;
                    floor.addLayerItem(tx, ty);
                }
            }

            for each(var actorXML:XML in level.actors.children()){
                tile = field.getTileAt(actorXML.@x / Monstro.tileWidth, actorXML.@y / Monstro.tileHeight);
                var entity:Entity = getEntity(actorXML, field, isPlayerHuman);
                if (entity){
                    entity.tile = tile;
                }
            }

            for (var i:int = 0; i < width; i++){
                for (var j:int = 0; j < height; j++){
                    tile = field.getTileAt(i, j);

                    floor = tile.floor as MonstroTileFloor;

                    if (floor.isWall){
                        floor.addLayerItemIndex(getWallTexture(tile.x, tile.y, field));
                    }

                    if (floor.layers.length == 0){
                        floor.isObstacle = true;
                    }
                }
            }
        }

        private static function fillFieldFloors(field:Field):void{
            for (var i:int = 0; i < field.width; i++){
                for (var j:int = 0; j < field.height; j++){
                    var tile:Tile = field.getTileAt(i, j);
                    tile.floor = new MonstroTileFloor(field);
                }
            }
        }


        private static function getEntity(entity:XML, field:Field, isPlayerHuman:Boolean):Entity{
            var entityName:String = entity.name().toString();

            return MonstroEntityFactory.getUnit(entityName, field, isPlayerHuman);
        }

        private static function getFloorTexture(x:int, y:int):int{
            x %= 8;
            y %= 8;

            return 253 + x + y * 23;
        }

        private static function getWallTexture(x:int, y:int, field:Field):int{
            var bytes:uint = getSurroundingByte(x, y, field);

            // Completely surrounded
            if ( bytes == 0xFF)  {
                return MonstroTileDefinition.TI_WALL_NSEW1234;
            }

            // Single block
            if ((bytes & 0xAA) == 0x00) {return MonstroTileDefinition.TI_WALL;}

            // Single Dead ends
            if ((bytes & 0xAA) == 0x20) {return MonstroTileDefinition.TI_WALL_S;}
            if ((bytes & 0xAA) == 0x08) {
                return MonstroTileDefinition.TI_WALL_W;
            }
            if ((bytes & 0xAA) == 0x02) {
                return MonstroTileDefinition.TI_WALL_N;
            }
            if ((bytes & 0xAA) == 0x80) {
                return MonstroTileDefinition.TI_WALL_E;
            }

            // Single turns
            if ((bytes & 0xEA) == 0xA0) {
                return MonstroTileDefinition.TI_WALL_SE;

            }
            if ((bytes & 0xBA) == 0x28) {
                return MonstroTileDefinition.TI_WALL_SW;
            }

            if ((bytes & 0xAE) == 0x0A) {
                return MonstroTileDefinition.TI_WALL_NW;
            }
            if ((bytes & 0xAB) == 0x82) {
                return MonstroTileDefinition.TI_WALL_NE;
            }

            // Single corridors
            if ((bytes & 0xAA) == 0x88) {
                return MonstroTileDefinition.TI_WALL_EW;
            }
            if ((bytes & 0xAA) == 0x22) {return MonstroTileDefinition.TI_WALL_NS; }

            // Single triple conjunction
            if ((bytes & 0xEB) == 0xA2) {return MonstroTileDefinition.TI_WALL_NSE; }
            if ((bytes & 0xFA) == 0xA8) {
                return MonstroTileDefinition.TI_WALL_SEW;
            }
            if ((bytes & 0xBE) == 0x2A) {return MonstroTileDefinition.TI_WALL_NSW;}
            if ((bytes & 0xAF) == 0x8A) {
                return MonstroTileDefinition.TI_WALL_NEW;
            }

            // Four way crossroad
            if ( bytes         == 0xAA) {
                return MonstroTileDefinition.TI_WALL_NSEW;
            }

            // Corners
            if ((bytes & 0xEA) == 0xE0) {return MonstroTileDefinition.TI_WALL_SE4;}
            if ((bytes & 0xBA) == 0x38) {return MonstroTileDefinition.TI_WALL_SW3;}
            if ((bytes & 0xAE) == 0x0E) {
                return MonstroTileDefinition.TI_WALL_NW1;
            }
            if ((bytes & 0xAB) == 0x83) {
                return MonstroTileDefinition.TI_WALL_NE2;
            }

            // Sides
            if ((bytes & 0xEB) == 0xE3) {return MonstroTileDefinition.TI_WALL_NSE24;}
            if ((bytes & 0xFA) == 0xF8) {return MonstroTileDefinition.TI_WALL_SEW34;}
            if ((bytes & 0xBE) == 0x3E) {return MonstroTileDefinition.TI_WALL_NSW13;}
            if ((bytes & 0xAF) == 0x8F) {
                return MonstroTileDefinition.TI_WALL_NEW12;
            }

            // (Lots of) Inner corners
            if ( bytes == 0xFB) {return MonstroTileDefinition.TI_WALL_NSEW234;}
            if ( bytes == 0xFE) {return MonstroTileDefinition.TI_WALL_NSEW134;}
            if ( bytes == 0xBF) {return MonstroTileDefinition.TI_WALL_NSEW123;}
            if ( bytes == 0xEF) {return MonstroTileDefinition.TI_WALL_NSEW124;}
            if ( bytes == 0xFA) {return MonstroTileDefinition.TI_WALL_NSEW34;}
            if ( bytes == 0xBB) {return MonstroTileDefinition.TI_WALL_NSEW23;}
            if ( bytes == 0xEB) {return MonstroTileDefinition.TI_WALL_NSEW24;}
            if ( bytes == 0xBE) {return MonstroTileDefinition.TI_WALL_NSEW13;}
            if ( bytes == 0xEE) {return MonstroTileDefinition.TI_WALL_NSEW14;}
            if ( bytes == 0xAF) {return MonstroTileDefinition.TI_WALL_NSEW12;}
            if ( bytes == 0xBA) {return MonstroTileDefinition.TI_WALL_NSEW3;}
            if ( bytes == 0xEA) {return MonstroTileDefinition.TI_WALL_NSEW4;}
            if ( bytes == 0xAB) {return MonstroTileDefinition.TI_WALL_NSEW2;}
            if ( bytes == 0xAE) {return MonstroTileDefinition.TI_WALL_NSEW1;}

            // Sides
            if ((bytes & 0xFA) == 0xE8) {
                return MonstroTileDefinition.TI_WALL_SEW4;
            }
            if ((bytes & 0xFA) == 0xB8) {
                return MonstroTileDefinition.TI_WALL_SEW3;
            }
            if ((bytes & 0xBE) == 0x3A) {return MonstroTileDefinition.TI_WALL_NSW3;}
            if ((bytes & 0xBE) == 0x2E) {
                return MonstroTileDefinition.TI_WALL_NSW1;
            }
            if ((bytes & 0xAF) == 0x8B) {
                return MonstroTileDefinition.TI_WALL_NEW2;
            }

            if ((bytes & 0xAF) == 0x8E) {
                return MonstroTileDefinition.TI_WALL_NEW1;
            }
            if ((bytes & 0xEB) == 0xE2) {return MonstroTileDefinition.TI_WALL_NSE4;}
            if ((bytes & 0xEB) == 0xA3) {
                return MonstroTileDefinition.TI_WALL_NSE2;
            }

            throw new Error("This shouldn't happen...");
        }

        private static function getSurroundingByte(x:uint, y:uint, field:Field):uint{
            var data:uint = 0;

            if (isWall(x, y - 1, field)){
                data |= 2;
            }

            if (isWall(x - 1, y, field)){
                data |= 8;
            }

            if (isWall(x + 1, y, field)){
                data |= 128;
            }

            if (isWall(x, y + 1, field)){
                data |= 32;
            }

            if (isWall(x - 1, y - 1, field)){
                data |= 4;
            }

            if (isWall(x - 1, y + 1, field)){
                data |= 16;
            }

            if (isWall(x + 1, y - 1, field)){
                data |= 1;
            }

            if (isWall(x + 1, y + 1, field)){
                data |= 64;
            }

            return data;
        }

        private static function isWall(x:int, y:int, field:Field):Boolean{
            if (x < 0 || y < 0 || x >= field.width || y >= field.height){
                return false;
            }

            return MonstroTileFloor(field.getTileAt(x, y).floor).isWall;
        }
    }
}