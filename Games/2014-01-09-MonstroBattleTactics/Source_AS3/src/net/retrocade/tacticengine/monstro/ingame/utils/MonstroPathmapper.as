package net.retrocade.tacticengine.monstro.ingame.utils{
    import net.retrocade.data.RetrocamelPriorityQueue;
	import net.retrocade.tacticengine.core.Eventer;
	import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndo;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitKilled;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitMoved;
	import net.retrocade.tacticengine.monstro.ingame.floors.MonstroTileFloor;
    import net.retrocade.utils.UtilsNumber;
    import net.retrocade.utils.UtilsString;

    public class MonstroPathmapper{
        private static var QUERY_PATH_X:Vector.<int> = new Vector.<int>(4, true);
        private static var QUERY_PATH_Y:Vector.<int> = new Vector.<int>(4, true);

        private static var _cache:Object;
        private static var _caching:Boolean = false;

        { init(); }
        
        private static function init():void{
            QUERY_PATH_X[0] = 1;
            QUERY_PATH_X[1] = 0;
            QUERY_PATH_X[2] = -1;
            QUERY_PATH_X[3] = 0;
            
            QUERY_PATH_Y[0] = 0;
            QUERY_PATH_Y[1] = 1;
            QUERY_PATH_Y[2] = 0;
            QUERY_PATH_Y[3] = -1;

			Eventer.listen(MonstroEventUnitKilled.NAME, clearCache, MonstroPathmapper);
			Eventer.listen(MonstroEventUnitMoved.NAME, clearCache, MonstroPathmapper);
			Eventer.listen(MonstroEventUndo.NAME, clearCache, MonstroPathmapper);
        }

        public static function startCache():void{
            _caching = true;
            _cache = {};
        }

		public static function clearCache():void{
			_cache = {};
		}

        public static function stopCache():void{
            _caching = false;
            _cache = null;
        }

		public static function getPathFromTo(fromX:int, fromY:int, toX:int, toY:int, entity:MonstroEntity, field:MonstroField):Vector.<Tile>{
            var pathmap:Vector.<Vector.<PathmapTile>> = getPathmap(toX, toY, entity, field);

            tracePathmap(pathmap, field);

            var path:Vector.<Tile> = new Vector.<Tile>(pathmap[fromX][fromY].score + 1, true);

            if (path.length > entity.getStatistics().movesMax + 1){
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
            
            while (tileX != toX || tileY != toY){
                path[pathStep++] = field.getTileAt(tileX, tileY);
                
                bestScore = pathmap[tileX][tileY].score;
                bestScoreTileX = -1;
                bestScoreTileY = -1;
                
                for (var i:int = 0; i < 4; i++){
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
            
            path[pathStep] = field.getTileAt(tileX, tileY);
            
            return path;
        }

        public static function getClosestPoint(x:int, y:int, points:Vector.<Tile>, entity:MonstroEntity, field:MonstroField):Tile{
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

        public static function getTilesInDistance(x:int, y:int, distanceMin:int, distanceMax:int, field:MonstroField):Vector.<Tile>{
            var left:int = Math.max(0, x - distanceMax);
            var top:int = Math.max(0, y - distanceMax);
            var right:int = Math.min(field.width, x + distanceMax + 1);
            var bottom:int = Math.min(field.height, y + distanceMax + 1);

            var tiles:Vector.<Tile> = new Vector.<Tile>();

            for (var i:int = left; i < right; i++){
                for (var j:int = top; j < bottom; j++){
                    var distance:int = UtilsNumber.distanceManhattan(x, y, i, j);
                    if (distance >= distanceMin && distance <= distanceMax){
                        tiles.push(field.getTileAt(i, j));
                    }
                }
            }
            return tiles;
        }

        public static function getExpandedTilesInDistance(tiles:Vector.<Tile>, distanceMin:int, distanceMax:int, field:MonstroField):Vector.<Tile>{
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

                        var distance:int = UtilsNumber.distanceManhattan(tile.x, tile.y, i, j);
                        if (distance >= distanceMin && distance <= distanceMax){
                            foundTilesVector.push(field.getTileAt(i, j));
                            foundTilesMap[i][j] = true;
                        }
                    }
                }
            }

            return foundTilesVector;
        }
        
        public static function getMovableTiles(x:int, y:int, moves:int, entity:MonstroEntity, field:MonstroField):Vector.<Tile>{
//            var tiles:Vector.<Tile> = new Vector.<Tile>();
            
//            _getMovableTiles(x, y, moves, entity, field, tiles, new Vector.<int>);
            var tiles:Vector.<Tile> = _getMovableTiles2(x, y, moves, entity, field);

//            tiles = tiles.filter(function(item:Tile, index:int, vector:Vector.<Tile>):Boolean{
//                return item.canStandOn(entity);
//            });

            return tiles;
        }

        public static function getDistance(fromX:int, fromY:int, toX:int, toY:int, entity:MonstroEntity, field:MonstroField):int{
            var pathmap:Vector.<Vector.<PathmapTile>> = getPathmap(toX, toY, entity, field);

            tracePathmap(pathmap, field);

            return pathmap[fromX][fromY].score;
        }

        public static function hasOpenPath(fromX:int, fromY:int, toX:int, toY:int, entity:MonstroEntity, field:MonstroField):Boolean{
            var pathmap:Vector.<Vector.<PathmapTile>> = getPathmap(toX, toY, entity, field);

            tracePathmap(pathmap,  field);

            return pathmap[fromX][fromY].score < 1000;
        }

        private static function _getMovableTiles2(x:int, y:int, movement:int, entity:MonstroEntity, field:MonstroField):Vector.<Tile>{
            const FIELD_WIDTH:uint = field.width;
            const FIELD_TOTAL_TILES:uint = field.width * field.height;

            var tileScores:Vector.<PathmapTile> = new Vector.<PathmapTile>(FIELD_TOTAL_TILES, true);
            tileScores[x + y * FIELD_WIDTH] = new PathmapTile(x, y, movement);

            var finalTiles:Vector.<Tile> = new Vector.<Tile>();
            finalTiles.push(field.getTileAt(x, y));
            var tiles:Vector.<Tile> = new Vector.<Tile>();
            tiles.push(field.getTileAt(x, y));

            var currentlyCheckedTileIndex:uint = 0;

            while (currentlyCheckedTileIndex < tiles.length){
                var tile:Tile = tiles[currentlyCheckedTileIndex++];
                var tileIndex:int = tile.x + tile.y * FIELD_WIDTH;

                if (tileScores[tileIndex].score === 0){
                    continue;
                }

                _getMovableTiles2_sub(1, 0);
                _getMovableTiles2_sub(-1, 0);
                _getMovableTiles2_sub(0, 1);
                _getMovableTiles2_sub(0, -1);
            }

            return finalTiles;

            function _getMovableTiles2_sub(dx:int, dy:int):void{
                if (tile.x + dx < 0 || tile.x + dx >= field.width || tile.y + dy < 0 || tile.y + dy >= field.height){
                    return;
                }

                var newTileIndex:uint = tile.x + dx + (tile.y + dy) * FIELD_WIDTH;
                var newTileScore:uint = tileScores[tileIndex].score - 1;
                if (tileScores[newTileIndex] && tileScores[newTileIndex].score <= newTileScore){
                    return;
                }

                var newTile:Tile = field.getTileAt(tile.x + dx, tile.y + dy);
                if (tile.canStep(dx, dy, entity)){
                    tileScores[newTileIndex] = new PathmapTile(newTile.x, newTile.y, newTileScore);
                    tiles.push(newTile);

                    if (newTile.canStandOn(entity)){
                        finalTiles.push(newTile);
                    }
                }
            }
        }

        private static function _getMovableTiles(x:int, y:int, movement:int, entity:MonstroEntity, field:MonstroField,
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
            
            if (movement <= 0){
                return;
            }
            
            if (tile.canStep(1, 0, entity)){
                _getMovableTiles(x + 1, y, movement - 1, entity, field, tiles, tilesValue);
            }
            
            if (tile.canStep(0, 1, entity)){
                _getMovableTiles(x, y + 1, movement - 1, entity, field, tiles, tilesValue);
            }
            
            if (tile.canStep(-1, 0, entity)){
                _getMovableTiles(x - 1, y, movement - 1, entity, field, tiles, tilesValue);
            }
            
            if (tile.canStep(0, -1, entity)){
                _getMovableTiles(x, y - 1, movement - 1, entity, field, tiles, tilesValue);
            }
        }

        private static function getPathmap(x:int, y:int, entity:MonstroEntity, field:MonstroField):Vector.<Vector.<PathmapTile>>{
            var cacheIndex:String = x.toString() +":"+ y.toString();
            if (_caching && _cache[cacheIndex]){
				return _cache[cacheIndex];
            }

            var tilemap:Vector.<Vector.<PathmapTile>> = createPathmapTileField(field);

            var stack:RetrocamelPriorityQueue = new RetrocamelPriorityQueue();

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

                if (x < field.width - 1){
                    subTile(1, 0);
                }

                if (x > 0){
                    subTile(-1, 0);
                }

                if (y < field.height - 1){
                    subTile(0, 1);
                }

                if (y > 0){
                    subTile(0, -1);
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

        private static function createPathmapTileField(field:MonstroField):Vector.<Vector.<PathmapTile>>{
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

        private static function createBooleanField(field:MonstroField, value:Boolean):Vector.<Vector.<Boolean>>{
            var tilemap:Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>(field.width, true);

            for (var i:int = 0; i < field.width; i++){
                tilemap[i] = new Vector.<Boolean>(field.height, true);
                for (var j:int = 0; j < field.height; j++){
                    tilemap[i][j] = value;
                }
            }

            return tilemap;
        }

        private static function tracePathmap(pathmap:Vector.<Vector.<PathmapTile>>, field:MonstroField, force:Boolean = false):void{
            if (!force){
                return;
            }

            for (var i:int = 0; i < field.height; i++){
                var string:String = "";
                for (var j:int = 0; j < field.width; j++){
                    var tile:Tile = field.getTileAt(j, i);
                    var tileType:String = (tile.floor is MonstroTileFloor ? "." : "X");
                    string += UtilsString.padLeft(pathmap[j][i].score, 5, " ") + tileType + " ";
                }
                trace(string);
            }
            trace("-------");
        }

        public static function tracePositions(positions:*, field:MonstroField):void{
            var map:Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>();
            for (var i:int = 0; i < field.height; i++){
                map[i] = new Vector.<Boolean>();
                for (var j:int = 0; j < field.width; j++){
                    map[i][j] = false;
                }
            }

            for each(var position:* in positions){
                if (!position || !position.hasOwnProperty("x") || !position.hasOwnProperty("y")){
                    continue;
                }

                map[position.y][position.x] = true;
            }

            for (i = 0; i < field.height; i++){
                var string:String = "";
                for (j = 0; j < field.width; j++){
                    var isMarked:Boolean = map[i][j];

                    string += field.getTileAt(j, i).entity ? "O" :
                        isMarked ? "x" : ".";
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