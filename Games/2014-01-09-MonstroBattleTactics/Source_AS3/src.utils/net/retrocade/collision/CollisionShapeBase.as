

/**
 * Created by Skell on 09.11.13.
 */
package net.retrocade.collision {
    public class CollisionShapeBase {
        protected var _x:Number;
        protected var _y:Number;

        public function get x():Number {
            return _x;
        }

        public function set x(value:Number):void {
            _x = value;
        }

        public function get y():Number {
            return _y;
        }

        public function set y(value:Number):void {
            _y = value;
        }

        public function collide(shape:CollisionShapeBase):Boolean{
            return CollisionManager.checkCollision(this, shape);
        }

        public function get shapeType():CollisionShapeType{
            throw new Error("Base collision shape has no shape type");
        }

        public function CollisionShapeBase(x:Number = 0, y:Number = 0) {
            _x = x;
            _y = y;
        }
    }
}
