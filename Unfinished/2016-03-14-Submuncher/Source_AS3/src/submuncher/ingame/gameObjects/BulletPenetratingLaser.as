package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapePolygon;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class BulletPenetratingLaser extends GameObject {
        private var _angleRadians:Number;
        private var _speed:Number;
        private var _speedDelta:Number;

        override public function get objectType():GameObjectType {
            return GameObjectType.BULLET_PENETRATING_LASER;
        }

        public function BulletPenetratingLaser(level:Level, x:Number, y:Number, angleDeg:Number, speed:uint, speedDelta:Number = 0) {
            super(level, x + 8, y + 8);

            _angleRadians = angleDeg * Math.PI / 180;
            _speed = speed;
            _speedDelta = speedDelta;

            var polygon:CollisionShapePolygon = new CollisionShapePolygon(x, y, 0, 0);
            polygon.addPoint(-7, -4);
            polygon.addPoint(7, -4);
            polygon.addPoint(7, 4);
            polygon.addPoint(-7, 4);
            polygon.rotation = _angleRadians;
            collisionShape = polygon;

            level.gameObjectCollisionMap.removeSingle(this);
        }


        override public function update():void {
            x += Math.cos(_angleRadians) * _speed;
            y += Math.sin(_angleRadians) * _speed;
            _speed += _speedDelta;

            calculateCollisions();

            if (isOutsideMap()) {
                dispose();
            }
        }

        private function calculateCollisions():void {
            refreshCollisionShapePosition();
            if (player && doesCollideWith(player)){
                player.damagedByHazard(this);
            }
        }

        private function isOutsideMap():Boolean {
            return x < -width || y < -width || x > level.tileWidth * 16 + width || y > level.tileHeight * 16 + height;
        }

        public function get angleRadians():Number {
            return _angleRadians;
        }
    }
}