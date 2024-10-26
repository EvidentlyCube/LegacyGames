package submuncher.ingame.gameObjects {
    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.gameObjects.helpers.FakeWallGroup;

    public class ObjectFakeWall extends GameObject{
        private var _wallsGroup:FakeWallGroup;
        private var _isMainGroupElement:Boolean;
        private var _tileIndex:uint;
        private var _isDiscovered:Boolean;

        override public function get objectType():GameObjectType {
            return GameObjectType.FAKE_WALL;
        }

        public function ObjectFakeWall(level:Level, x:Number, y:Number) {
            super(level, x, y);

            _tileIndex = level.tilesForeground.getTile(tileX, tileY);
            _isMainGroupElement = false;
            _isDiscovered = false;

            gameCommunication.onFakeWallInitialized.call(tileX, tileY);
            gameCommunication.afterLevelLoaded.add(afterLevelLoadedHandler);
        }

        override public function dispose():void {
            super.dispose();
        }

        override public function update():void {
            if (_isMainGroupElement){
                var isPlayerDiscovered:Boolean = _wallsGroup.isPositionInGroup(player.x, player.y);

                if (_isDiscovered !== isPlayerDiscovered){
                    _wallsGroup.isDiscovered = isPlayerDiscovered;
                }
            }
        }

        private function afterLevelLoadedHandler():void {
            gameCommunication.afterLevelLoaded.remove(afterLevelLoadedHandler);

            if (!_wallsGroup){
                _isMainGroupElement = true;
                _wallsGroup = new FakeWallGroup();
                _wallsGroup.addFakeWall(this);
            }
        }

        public function get tileIndex():uint{
            return _tileIndex;
        }

        public function get isDiscovered():Boolean{
            return _isDiscovered;
        }

        public function set isDiscovered(value:Boolean):void {
            _isDiscovered = value;
        }

        public function get wallsGroup():FakeWallGroup {
            return _wallsGroup;
        }

        public function set wallsGroup(value:FakeWallGroup):void {
            _wallsGroup = value;
        }
    }
}