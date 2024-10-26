package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class ObjectSponge extends GameObject{
        private var _hasConsumed:Boolean;
        private var _isFrozen:Boolean;

        override public function get objectType():GameObjectType {
            return GameObjectType.SPONGE;
        }

        override public function get isObstacle():Boolean {
            return _isFrozen;
        }

        public function ObjectSponge(level:Level, x:Number, y:Number) {
            super(level, x, y);

            _isFrozen = false;
            _hasConsumed = false;

            collisionShape = new CollisionShapeRectangle(x, y, 0, 0, 16, 16);
        }

        override public function update():void {
            if (_hasConsumed){
                return;
            }

            for each (var object:GameObject in level.gameObjectCollisionMap.getAllAt(x, y)) {
                if (object.preciseX !== x || object.preciseY !== y){
                    continue;
                }

                switch(object.objectType){
                    case(GameObjectType.FISH):
                    case(GameObjectType.TURTLE):
                    case(GameObjectType.JELLYFISH):
                    case(GameObjectType.BLOB):
                        object.dispose();
                        _hasConsumed = true;
                        return;
                    case(GameObjectType.PLAYER):
                        object.dispose();
                        _hasConsumed = true;
                        return;
                }
            }


            super.update();
        }

        public function get hasConsumed():Boolean {
            return _hasConsumed;
        }


        override public function damagedByHazard(hazard:GameObject):void {
            if (hazard.objectType === GameObjectType.TORPEDO){
                _isFrozen = true;
            }
        }

        public function get isFrozen():Boolean {
            return _isFrozen;
        }
    }
}