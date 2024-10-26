package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeCircle;
    import net.retrocade.collision.CollisionShapeRectangle;

    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import S;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.core.Tiles;
    import submuncher.ingame.gameObjects.helpers.Ray;

    public class EnemyEye extends GameObject{
        private var _hp:uint;
        private var _ray:Ray;
        private var _beamCollisionShape:CollisionShapeRectangle;

        override public function get objectType():GameObjectType {
            return GameObjectType.EYE;
        }

        override public function get isObstacle():Boolean {
            return true;
        }

        public function EnemyEye(level:Level, x:Number, y:Number, startingDirection:Direction4, hp:uint) {
            super(level, x, y);

            _hp = hp;
            _ray = new Ray(4, x + 6, y + 6, startingDirection, level);
            _direction = startingDirection;
            _beamCollisionShape = new CollisionShapeRectangle(x, y, 0, 0, 0, 0);
            collisionShape = new CollisionShapeCircle(x, y, 8, 8, 8);
        }

        override public function dispose():void {
            _ray.dispose();
            super.dispose();
        }

        override public function update():void {
            resetBeam(_direction);

            if (doesBeamHitTarget(player)){
                level.player.damagedByHazard(this);
            }

            super.update();
        }

        private function doesBeamHitTarget(collidee:GameObject):Boolean{
            if (collidee && collidee.collisionShape){
                return _beamCollisionShape.collide(collidee.collisionShape);
            } else {
                return false;
            }
        }

        private function resetBeam(direction:Direction4):void{
            _ray.cast();
            _beamCollisionShape.setAll(
                _ray.collisionRectangle.x,
                _ray.collisionRectangle.y,
                _ray.collisionRectangle.width,
                _ray.collisionRectangle.height
            );
        }

        override public function damagedByHazard(hazard:GameObject):void {
            _hp--;

            if (_hp === 0){
                destroy();
            }
        }
    }
}