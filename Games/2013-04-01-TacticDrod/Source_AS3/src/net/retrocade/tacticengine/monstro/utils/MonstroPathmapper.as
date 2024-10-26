package net.retrocade.tacticengine.monstro.utils{
    import net.retrocade.standalone.PriorityQueue;

    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.actions.MonstroUnitStepData;
    import net.retrocade.tacticengine.monstro.core.MonstroFunctions;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.floors.MonstroTileFloor;
    import net.retrocade.utils.UNumber;
    import net.retrocade.utils.UString;

    public class MonstroPathmapper{
        private static var QUERY_PATH_X:Vector.<int> = new Vector.<int>(8, true);
        private static var QUERY_PATH_Y:Vector.<int> = new Vector.<int>(8, true);

        private static var _cache:Array;
        private static var _caching:Boolean = false;

        { init(); }
        
        private static function init():void{
            QUERY_PATH_X[0] = 0;
            QUERY_PATH_X[1] = 0;
            QUERY_PATH_X[2] = 1;
            QUERY_PATH_X[3] = -1;
            QUERY_PATH_X[4] = 1;
            QUERY_PATH_X[5] = 1;
            QUERY_PATH_X[6] = -1;
            QUERY_PATH_X[7] = -1;

            QUERY_PATH_Y[0] = -1;
            QUERY_PATH_Y[1] = 1;
            QUERY_PATH_Y[2] = 0;
            QUERY_PATH_Y[3] = 0;
            QUERY_PATH_Y[4] = -1;
            QUERY_PATH_Y[5] = 1;
            QUERY_PATH_Y[6] = 1;
            QUERY_PATH_Y[7] = -1;
        }

        public static function startCache():void{
            _caching = true;
            _cache = [];
        }

        public static function stopCache():void{
            _caching = false;
            _cache = null;
        }

		public static function getPathFromTo(fromX:int, fromY:int, toX:int, toY:int, entity:MonstroEntity, field:Field):Vector.<MonstroUnitStepData>{
            var pathmap:Vector.<Vector.<PathmapTile>> = getPathmap(toX, toY, entity, field);

            tracePathmap(pathmap, field);

            var path:Vector.<MonstroUnitStepData> = new Vector.<MonstroUnitStepData>(pathmap[fromX][fromY].score + 1, true);

            if (path.length > entity.movesLeft + 1){
                tracePathmap(pathmap, field, true);
                throw new Error("Invalid path length");
            }
            
            var tileX:int = fromX;
            var tileY:int = fromY;
            var pathStep:int = 0;

            var bestScore:int;
            var bestScoreTileX:int;
            var bestScoreTileY:int;

            var testX:uint;
            var testY:uint;
            var lastX:uint;
            var lastY:uint;
            
            while (tileX != toX || tileY != toY){
                path[pathStep++] = new MonstroUnitStepData(tileX, tileY, MonstroFunctions.getOrientationTowards(lastX, lastY, tileX, tileY));

                lastX = tileX;
                lastY = tileY;

                bestScore = pathmap[tileX][tileY].score;
                bestScoreTileX = -1;
                bestScoreTileY = -1;
                
                for (var i:int = 0; i < 8; i++){
                    testX = tileX + QUERY_PATH_X[i];
                    testY = tileY + QUERY_PATH_Y[i];
                    
                    if (testX < field.width &&
                            testY < field.height &&
                            pathmap[testX][testY].score < bestScore &&
                            field.getTileAt(tileX, tileY).canStep(QUERY_PATH_X[i], QUERY_PATH_Y[i], entity))
                    {
                        bestScoreTileX = testX;
                        bestScoreTileY = testY;
                        bestScore = pathmap[bestScoreTileX][bestScoreTileY].score;
                    }
                }
                
                tileX = bestScoreTileX;
                tileY = bestScoreTileY;
            }
            
            path[pathStep] = new MonstroUnitStepData(tileX, tileY, MonstroFunctions.getOrientationTowards(lastX, lastY, tileX, tileY));
            
            return path;
        }

        public static function getClosestPoint(x:int, y:int, points:Vector.<Tile>, entity:MonstroEntity, field:Field):Tile{
            var pathmap:Vector.<Vector.<PathmapTile>> = getPathmap(x, y, entity, field);

            tracePathmap(pathmap, field);

            var bestPoint:Tile;
            var bestScore:uint = uint.MAX_VALUE;

            for each(var point:Tile in points){
                if (pathmap[point.x][point.y].score < bestScore){
                    bestPoint = point;
                    bestScore = pathmap[point.x][point.y].score;
                }
            }

            return bestPoint;
        }

        public static function getTilesInDistance(x:int, y:int, distanceMin:int, distanceMax:int, field:Field):Vector.<Tile>{
            var left:int = Math.max(0, x - distanceMax);
            var top:int = Math.max(0, y - distanceMax);
            var right:int = Math.min(field.width, x + distanceMax + 1);
            var bottom:int = Math.min(field.height, y + distanceMax + 1);

            var tiles:Vector.<Tile> = new Vector.<Tile>();

            for (var i:int = left; i < right; i++){
                for (var j:int = top; j < bottom; j++){
                    var distance:int = UNumber.distanceGrid(x, y, i, j);
                    if (distance >= distanceMin && distance <= distanceMax){
                        tiles.push(field.getTileAt(i, j));
                    }
                }
            }
            return tiles;
        }

        public static function getExpandedTilesInDistance(tiles:Vector.<Tile>, distanceMin:int, distanceMax:int, field:Field):Vector.<Tile>{
            var foundTilesMap:Vector.<Vector.<Boolean>> = createBooleanField(field, false);
            var foundTilesVector:Vector.<Tile> = new Vector.<Tile>();

            for each(var tile:Tile in tiles){
                var left:int = Math.max(0, tile.x - distanceMax);
                var top:int = Math.max(0, tile.y - distanceMax);
                var right:int = Math.min(field.width, tile.x + distanceMax + 1);
                var bottom:int = Math.min(field.height, tile.y + distanceMax + 1);

                for (var i:int = left; i < right; i++){
                    for (var j:int = top; j < bottom; j++){
                        if (foundTilesMap[i][j]){
                            continue;
                        }

                        var distance:int = UNumber.distanceGrid(tile.x, tile.y, i, j);
                        if (distance >= distanceMin && distance <= distanceMax){
                            foundTilesVector.push(field.getTileAt(i, j));
                            foundTilesMap[i][j] = true;
                        }
                    }
                }
            }

            return foundTilesVector;
        }
        
        public static function getMovableTiles(x:int, y:int, entity:MonstroEntity, field:Field):Vector.<Tile>{
            var tiles:Vector.<Tile> = new Vector.<Tile>();
            
            _getMovableTiles(x, y, entity.movesLeft, entity, field, tiles, new Vector.<int>);

            tiles = tiles.filter(function(item:Tile, index:int, vector:Vector.<Tile>):Boolean{
                return item.canStandOn(entity);
            });

            return tiles;
        }

        public static function getDistance(fromX:int, fromY:int, toX:int, toY:int, entity:MonstroEntity, field:Field):int{
            var pathmap:Vector.<Vector.<PathmapTile>> = getPathmap(toX, toY, entity, field);

            tracePathmap(pathmap, field);

            return pathmap[fromX][fromY].score;
        }

        private static function _getMovableTiles(x:int, y:int, movement:int, entity:MonstroEntity, field:Field, 
												 tiles:Vector.<Tile>, tilesValue:Vector.<int>):void{
            var tile:Tile = field.getTileAt(x, y);
            var tileIndex:int = tiles.indexOf(tile);
			
            if (tileIndex !== -1){
				if (movement <= tilesValue[tileIndex]){
                	return;
				} else {
					tilesValue[tileIndex] = movement;
				}
            } else if (tile.canStandOn(entity)){
	            tiles.push(tile);
				tilesValue.push(movement);
			}
            
            if (movement == 0){
                return;
            }
            
            if (tile.canStep(0, 1, entity)){
                _getMovableTiles(x, y + 1, movement - 1, entity, field, tiles, tilesValue);
            }
            
            if (tile.canStep(0, -1, entity)){
                _getMovableTiles(x, y - 1, movement - 1, entity, field, tiles, tilesValue);
            }
            
            if (tile.canStep(1, 0, entity)){
                _getMovableTiles(x + 1, y, movement - 1, entity, field, tiles, tilesValue);
            }
            
            if (tile.canStep(-1, 0, entity)){
                _getMovableTiles(x - 1, y, movement - 1, entity, field, tiles, tilesValue);
            }

            if (tile.canStep(1, -1, entity)){
                _getMovableTiles(x + 1, y - 1, movement - 1, entity, field, tiles, tilesValue);
            }

            if (tile.canStep(1, 1, entity)){
                _getMovableTiles(x + 1, y + 1, movement - 1, entity, field, tiles, tilesValue);
            }

            if (tile.canStep(-1, 1, entity)){
                _getMovableTiles(x - 1, y + 1, movement - 1, entity, field, tiles, tilesValue);
            }

            if (tile.canStep(-1, -1, entity)){
                _getMovableTiles(x - 1, y - 1, movement - 1, entity, field, tiles, tilesValue);
            }
        }

        private static function getPathmap(x:int, y:int, entity:MonstroEntity, field:Field):Vector.<Vector.<PathmapTile>>{
            var cacheIndex:String = x.toString() + y.toString();
            if (_caching && _cache[cacheIndex]){
                return _cache[cacheIndex];
            }

            var tilemap:Vector.<Vector.<PathmapTile>> = createPathmapTileField(field);

            var stack:PriorityQueue = new PriorityQueue();

            var score:int = 0;
            var pathmapTile:PathmapTile;
            var newPathmapTile:PathmapTile;

            pathmapTile = tilemap[x][y];
            pathmapTile.score = 0;
            stack.addFromEnd(pathmapTile, 0);

            while ( (pathmapTile = stack.shift()) !== null ){
                x = pathmapTile.x;
                y = pathmapTile.y;

                score = pathmapTile.score + 1;

                if (y > 0){
                    subTile(0, -1);
                }

                if (y < field.height - 1){
                    subTile(0, 1);
                }

                if (x < field.width - 1){
                    subTile(1, 0);
                }

                if (x > 0){
                    subTile(-1, 0);
                }

                if (x < field.width - 1 && y > 0){
                    subTile(1, -1);
                }

                if (y < field.height - 1 && x < field.width - 1){
                    subTile(1, 1);
                }

                if (x > 0 && y < field.height - 1){
                    subTile(-1, 1);
                }

                if (x > 0 && y > 0){
                    subTile(-1, -1);
                }

            }

            function subTile(dx:int, dy:int):void{
                var tile:Tile = field.getTileAt(x, y);
                newPathmapTile = tilemap[x + dx][y + dy];

                if (!entity || tile.canStep(dx, dy, entity)){
                    if (newPathmapTile.score > score){
                        newPathmapTile.score = score;
                        stack.addFromEnd(newPathmapTile, score);
                    }
                } else {
                    var toTile:Tile = field.getTileAt(x + dx, y + dy);

                    if (!toTile.canStep(dx, dy, null)){
                        if (newPathmapTile.score > score + 5000){
                            newPathmapTile.score = score + 5000;
                            stack.addFromEnd(newPathmapTile, score + 5000);
                        }
                    } else {
                        if (newPathmapTile.score > score + 1000){
                            newPathmapTile.score = score + 1000;
                            stack.addFromEnd(newPathmapTile, score + 1000);
                        }
                    }
                }
            }

            if (_caching){
                return _cache[cacheIndex] = tilemap;
            }

            return tilemap;
        }

        private static function createPathmapTileField(field:Field):Vector.<Vector.<PathmapTile>>{
            var tilemap:Vector.<Vector.<PathmapTile>> = new Vector.<Vector.<PathmapTile>>(field.width, true);

            const max_val:int = int.MAX_VALUE;

            for (var i:int = 0; i < field.width; i++){
                tilemap[i] = new Vector.<PathmapTile>(field.height, true);
                for (var j:int = 0; j < field.height; j++){
                    tilemap[i][j] = new PathmapTile(i, j, max_val);
                }
            }

            return tilemap;
        }

        private static function createBooleanField(field:Field, value:Boolean):Vector.<Vector.<Boolean>>{
            var tilemap:Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>(field.width, true);

            for (var i:int = 0; i < field.width; i++){
                tilemap[i] = new Vector.<Boolean>(field.height, true);
                for (var j:int = 0; j < field.height; j++){
                    tilemap[i][j] = value;
                }
            }

            return tilemap;
        }

        private static function tracePathmap(pathmap:Vector.<Vector.<PathmapTile>>, field:Field, force:Boolean = false):void{
            if (!force){
                return;
            }

            for (var i:int = 0; i < field.height; i++){
                var string:String = "";
                for (var j:int = 0; j < field.width; j++){
                    var tile:Tile = field.getTileAt(j, i);
                    var type:String = (tile.floor is MonstroTileFloor ? "." : "X");
                    string += UString.padLeft(pathmap[j][i].score, 5, " ") + type + " ";
                }
                trace(string);
            }
            trace("-------");
        }
    }
}

class PathmapTile{
    public var x:int;
    public var y:int;
    public var score:int;

    public function PathmapTile(x:int, y:int, score:int){
        this.x = x;
        this.y = y;
        this.score = score;
    }
}