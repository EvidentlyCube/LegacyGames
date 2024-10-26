package submuncher.ingame.gameObjects.helpers {
    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.gameObjects.GameObject;
    import submuncher.ingame.gameObjects.ObjectFakeWall;

    public class FakeWallGroup {
        private var _fakeWalls:Vector.<ObjectFakeWall>;

        public function FakeWallGroup() {
            _fakeWalls = new Vector.<ObjectFakeWall>();
        }

        public function addFakeWall(fakeWall:ObjectFakeWall):void {
            _fakeWalls.push(fakeWall);

            addFakeWallNeighbor(fakeWall.level, fakeWall.x - 16, fakeWall.y);
            addFakeWallNeighbor(fakeWall.level, fakeWall.x + 16, fakeWall.y);
            addFakeWallNeighbor(fakeWall.level, fakeWall.x, fakeWall.y - 16);
            addFakeWallNeighbor(fakeWall.level, fakeWall.x, fakeWall.y + 16);
        }

        public function isPositionInGroup(x:int, y:int):Boolean {
            for each (var fakeWall:ObjectFakeWall in _fakeWalls) {
                if (fakeWall.x === x && fakeWall.y === y){
                    return true;
                }
            }

            return false;
        }

        public function set isDiscovered(value:Boolean):void {
            for each (var wall:ObjectFakeWall in _fakeWalls) {
                wall.isDiscovered = value;
            }
        }

        private function addFakeWallNeighbor(level:Level, x:int, y:int):void {
            for each (var gameObject:GameObject in level.gameObjectCollisionMap.getAllAtStrict(x, y)) {
                if (gameObject.objectType === GameObjectType.FAKE_WALL){
                    var fakeWall:ObjectFakeWall = gameObject as ObjectFakeWall;

                    if (!fakeWall.wallsGroup){
                        fakeWall.wallsGroup = this;
                        addFakeWall(fakeWall);
                    }
                }
            }
        }
    }
}
