package submuncher.editor.core {
    import submuncher.ingame.core.Tiles;

    public class EditorTile {
        private static const NW:int = 0;
        private static const N:int = 1;
        private static const NE:int = 2;
        private static const W:int = 3;
        private static const E:int = 4;
        private static const SW:int = 5;
        private static const S:int = 6;
        private static const SE:int = 7;

        private var _extEditedLevel:EditorLevel;
        private var _x:int;
        private var _y:int;
        private var _tileType:uint;
        private var _connections:Vector.<Boolean>;
        private var _myLayer:EditorTilesArray;
        private var _relatedLayer:EditorTilesArray;
        private var _isVariation:Boolean;

        public function EditorTile(x:int, y:int, level:EditorLevel, myLayer:EditorTilesArray, relatedLayer:EditorTilesArray, isVariation:Boolean) {
            _x = x;
            _y = y;
            _isVariation = isVariation;
            _extEditedLevel = level;
            _connections = new <Boolean>[false, false, false, false, false, false, false, false];
            _myLayer = myLayer;
            _relatedLayer = relatedLayer;

            forceEdgeConnections();
        }

        public function get computedTile():uint{
            if (_tileType === 0){
                return 0;
            } else {
                return EditorAutoTiler.calculateTile(_tileType, _connections, _isVariation);
            }
        }

        public function draw(tile:uint):void {
            if (_tileType !== tile){
                _tileType = tile;
                resetConnections();
            }
        }

        public function drawAndConnectTo(tile:uint, x:int, y:int):void {
            draw(tile);

            connectTo(x, y);
        }

        public function connectToIfSame(x:int, y:int):void {
            if (isSame(x - _x, y - _y)){
                connectTo(x, y);
            }
        }
        public function connectTo(x:int, y:int):void {
            x = x - _x;
            y = y - _y;

            if (x === -1 && y === -1){
                _connections[NW] = true;

            } else if (x === 0  && y === -1){
                _connections[N] = true;

            } else if (x === 1 && y === -1){
                _connections[NE] = true;

            } else if (x === -1 && y === 0){
                _connections[W] = true;

            } else if (x === 1 && y === 0){
                _connections[E] = true;

            } else if (x === -1 && y === 1){
                _connections[SW] = true;

            } else if (x === 0  && y === 1){
                _connections[S] = true;

            } else if (x === 1 && y === 1){
                _connections[SE] = true;
            }
        }

        public function drawAndCut(tile:uint):void{
            draw(tile);
            cutConnections();
        }

        public function drawAndConnect(tile:uint):void{
            draw(tile);
            forceMakeConnections();
        }

        public function setConnect(direction:uint, value:Boolean = true):void {
            _connections[direction] = value;
        }

        public function forceMakeConnections():void{
            _connections[0] = !_connections[0] ? isSame(-1, -1) : true;
            _connections[1] = !_connections[1] ? isSame(0, -1) : true;
            _connections[2] = !_connections[2] ? isSame(1, -1) : true;
            _connections[3] = !_connections[3] ? isSame(-1, 0) : true;
            _connections[4] = !_connections[4] ? isSame(1, 0) : true;
            _connections[5] = !_connections[5] ? isSame(-1, 1) : true;
            _connections[6] = !_connections[6] ? isSame(0, 1) : true;
            _connections[7] = !_connections[7] ? isSame(1, 1) : true;
        }

        public function cutConnections():void{
            _connections[0] = _connections[0] ? isSame(-1, -1) : false;
            _connections[1] = _connections[1] ? isSame(0, -1) : false;
            _connections[2] = _connections[2] ? isSame(1, -1) : false;
            _connections[3] = _connections[3] ? isSame(-1, 0) : false;
            _connections[4] = _connections[4] ? isSame(1, 0) : false;
            _connections[5] = _connections[5] ? isSame(-1, 1) : false;
            _connections[6] = _connections[6] ? isSame(0, 1) : false;
            _connections[7] = _connections[7] ? isSame(1, 1) : false;

            forceEdgeConnections();
        }

        public function connectToAll():void {
            _connections[0] = true;
            _connections[1] = true;
            _connections[2] = true;
            _connections[3] = true;
            _connections[4] = true;
            _connections[5] = true;
            _connections[6] = true;
            _connections[7] = true;

        }

        private function resetConnections():void {
            _connections[0] = false;
            _connections[1] = false;
            _connections[2] = false;
            _connections[3] = false;
            _connections[4] = false;
            _connections[5] = false;
            _connections[6] = false;
            _connections[7] = false;

            forceEdgeConnections();
        }
        private function isSame(dx:int, dy:int):Boolean{
            var x:int = _x + dx;
            var y:int = _y + dy;

            if (x < 0 || y < 0 || x >= _extEditedLevel.tileWidth - 1 || y >= _extEditedLevel.tileHeight){
                return true;
            } else if (Tiles.isSameType(_tileType, _myLayer.getTile(x, y).tileType)){
                return true;
            } else if (_relatedLayer && Tiles.isSameType(_tileType, _relatedLayer.getTile(x, y).tileType)){
                return true;
            } else {
                return false;
            }
        }

        private function forceEdgeConnections():void{
            if (_x === 0){
                _connections[NW] = true;
                _connections[W] = true;
                _connections[SW] = true;
            } else if (_x === _extEditedLevel.tileWidth - 1){
                _connections[NE] = true;
                _connections[E] = true;
                _connections[SE] = true;
            }

            if (_y === 0){
                _connections[NW] = true;
                _connections[N] = true;
                _connections[NE] = true;
            } else if (_y === _extEditedLevel.tileHeight - 1){
                _connections[SW] = true;
                _connections[S] = true;
                _connections[SE] = true;
            }
        }

        public function get tileType():uint {
            return _tileType;
        }
    }
}
