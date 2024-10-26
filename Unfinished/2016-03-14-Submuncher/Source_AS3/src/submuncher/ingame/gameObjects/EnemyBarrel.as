package submuncher.ingame.gameObjects {
    import net.retrocade.collision.CollisionShapeRectangle;

    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class EnemyBarrel extends GameObject{
        override public function get objectType():GameObjectType {
            return GameObjectType.BARREL;
        }

        override public function get isObstacle():Boolean {
            return true;
        }

        public function EnemyBarrel(level:Level, x:Number, y:Number) {
            super(level, x, y);
            collisionShape = new CollisionShapeRectangle(x, y, 4, 2, 8, 12);
        }


        override public function update():void {
            if (player && doesCollideWith(player)){
                level.player.damagedByHazard(this);
            }

            super.update();
        }

        override public function damagedByHazard(hazard:GameObject):void {
            if (hazard.objectType === GameObjectType.TORPEDO){
                level.player.damagedByHazard(this);
            }
        }
    }
}