package game.global{
    import flash.display.BitmapData;
    
    import game.objects.TGameObject;
    
    import net.retrocade.standalone.BitextFont;

    public class Pathmap{
        public static const dxDir:Array = [-1,  0, 1,  -1, 1, -1, 0, 1];
        public static const dyDir:Array = [-1, -1, -1,  0, 0,  1, 1, 1];
        
        public var queue         :Array = [];
        public var queueTop      :uint  = 0;
        public var queueBottom   :uint  = 0;
        
        public var tiles         :Array = [];
        
        public var lastCalcTurn:uint  = 0; 
        
        public var targetX       :uint = uint.MAX_VALUE;
        public var targetY       :uint = uint.MAX_VALUE;
        
        public var movementType:uint;
        public var supportPartialObstacles:Boolean;
        
        public var room          :Room;

        /* TODO: Update tile
         * TODO: Smart recalculate (if possible?)
         */
        
        public function Pathmap(movementType:uint, supportPartialObstacles:Boolean) {
            this.movementType            = movementType;
            this.supportPartialObstacles = supportPartialObstacles;
            
            for(var i:uint = 0; i < S.LEVEL_WIDTH; i++){
                for (var j:uint = 0; j < S.LEVEL_HEIGHT; j++){
                    tiles[i + j * S.LEVEL_WIDTH] = new PathmapTile(i, j);
                }
            }

            for(i = 0; i < 256; i++)
                queue[i] = null;
        }
        
        public function clear():void{
            queue = null;
            tiles = null;
        }
        
        public function setTarget(targetX:uint, targetY:uint):void {
            if (this.targetX == targetX && this.targetY == targetY)
                return;
                
            this.targetX = targetX;
            this.targetY = targetY;
            reset();
        }
        
        public function squareChanged(x:uint, y:uint):void {
            var square:PathmapTile = tiles[x + y * S.LEVEL_WIDTH];
            var oldIsObstacle:Boolean = square.isObstacle;
            
            setSquareObstacle(x, y);
            if (square.isObstacle == oldIsObstacle)
                return;
                
            setSquareNeighboursPaths(x, y);
            
            reset();
        }
        
        public function calculate():void {
            var currentSquare:PathmapTile;
            var newSquare    :PathmapTile;
            var newScore     :uint;

            while (queueBottom < queueTop) {
                currentSquare = queue[queueBottom++];

                for each(newSquare in currentSquare.destinationSquares) {
                    newScore = currentSquare.steps + 1;
                    
                    if (newScore < newSquare.targetDistance) {
                        newSquare.targetDistance = newScore;
                        newSquare.steps          = currentSquare.targetDistance + 1;
                        queue[queueTop++]        = newSquare;
                        
                        //room.layerDebug.drawLine(currentSquare.x * 22 + 11, currentSquare.y * 22 + 11, newSquare.x * 22 + 11, newSquare.y * 22 + 11)
                    }
                }
            }
            /*
             TD ST
             0  0
             1  
            */
        }
        
        public function resetDeep():void{
            for(var i:uint = 0; i < S.LEVEL_WIDTH; i++){
                for (var j:uint = 0; j < S.LEVEL_HEIGHT; j++){
                    tiles[i + j * S.LEVEL_WIDTH] = new PathmapTile(i, j);
                    setSquareObstacle(i, j);
                }
            }
            
            for (i = 0; i < S.LEVEL_WIDTH; i++) {
                for (j = 0; j < S.LEVEL_HEIGHT; j++) {
                    setSquarePaths(i, j);
                }
            }
            
            reset();
        }
        
        public function reset():void {
            for (var i:uint = 0, k:uint = S.LEVEL_WIDTH * S.LEVEL_HEIGHT; i < k; i++) {
                tiles[i].targetDistance = tiles[i].steps = uint.MAX_VALUE;
            }
            
            queueBottom = 0;
            queueTop    = 0;
            
            if (targetX >= S.LEVEL_WIDTH || targetY >= S.LEVEL_HEIGHT)
                return;
            
            var firstSquare:PathmapTile = tiles[targetX + targetY * S.LEVEL_WIDTH];
            firstSquare.steps = firstSquare.targetDistance = 0;
            queue[queueTop++] = firstSquare;
            
        }
        
        public function debug(layer:BitmapData, font:BitextFont):void{
            for(var i:uint = 0; i < S.LEVEL_WIDTH; i++){
                for (var j:uint = 0; j < S.LEVEL_HEIGHT; j++){
                    var pos :uint = i + j * S.LEVEL_WIDTH;
                    font.drawSimpleLine(layer, (tiles[pos].targetDistance < 999 ? tiles[pos].targetDistance : ""), 
                        i * S.LEVEL_TILE_WIDTH, j * S.LEVEL_TILE_HEIGHT);
                }
            }
        }
        
        internal function setSquareObstacle(x:uint, y:uint):void {
            var square:PathmapTile = tiles[x + y * S.LEVEL_WIDTH];
            
            var tileO:uint = room.tilesOpaque[x + y * S.LEVEL_WIDTH];
            switch(movementType) {
                case(C.MOVEMENT_GROUND):
                    if (!(F.isFloor(tileO) || F.isOpenDoor(tileO) || F.isPlatform(tileO))) {
                        square.isObstacle = true;
                        return;
                    }
                    break;
                    
                case(C.MOVEMENT_AIR):
                    if (!(F.isFloor(tileO) || F.isOpenDoor(tileO) || F.isPlatform(tileO) || tileO == C.T_PIT))
                        switch(tileO) {
                            default:
                                square.isObstacle = true;
                                return;
                        }
                    break;
            }
            
            // @TODO Add monster blocking movement
            
            // @TODO Add partial obstacles support... if ever needed
            
            if (!supportPartialObstacles) {
                var tileT:uint = room.tilesTransparent[x + y * S.LEVEL_WIDTH];
                if (!(tileT == C.T_EMPTY || tileT == C.T_FUSE || tileT == C.T_TOKEN) ||
                    F.isArrow(room.tilesFloor[x + y * S.LEVEL_WIDTH])) {
                    square.isObstacle = true;
                    return;
                }
            }
            
            square.isObstacle = false;
        }
        
        internal function setSquarePaths(x:uint, y:uint):void {
            if (x >= S.LEVEL_WIDTH || y >= S.LEVEL_HEIGHT)
                return;
            
            var thisSquare:PathmapTile = tiles[x + y * S.LEVEL_WIDTH];
            var otherSquare:PathmapTile;
            
            thisSquare.destinationSquares.length = 0;
            
            for (var i:uint = 0; i < 8; i++) {
                otherSquare = getSquareIfNotObstacle(x + dxDir[i], y + dyDir[i]);
                
                if (otherSquare)
                    thisSquare.destinationSquares.push(otherSquare);
            }
        }
        
        internal function setSquareNeighboursPaths(x:uint, y:uint):void {
            for (var i:uint = 0; i < 8; i++) {
                setSquarePaths(x + dxDir[i], y + dyDir[i]);
            }
        }
        
        internal function getSquareIfNotObstacle(x:uint, y:uint):PathmapTile {
            if (x >= S.LEVEL_WIDTH || y >= S.LEVEL_HEIGHT)
                return null;
                
            var square:PathmapTile = tiles[x + y * S.LEVEL_WIDTH];
            return (square.isObstacle ? null : square);
        }
    }
}