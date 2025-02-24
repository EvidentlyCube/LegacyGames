

/**
 * Created by Skell on 09.11.13.
 */
package net.retrocade.collision {
    public class CollisionShapeCircle extends CollisionShapeBase{
        private var _radius:Number;

        public function get radius():Number {
            return _radius;
        }

        override public function collide(shape:CollisionShapeBase):Boolean {
            switch(shape.shapeType){
                case(CollisionShapeType.CIRCLE):
                    return CollisionManager.shapesCircleCircle(this, shape as CollisionShapeCircle);
                case(CollisionShapeType.RECTANGLE):
                    return CollisionManager.shapesCircleRectangle(this, shape as CollisionShapeRectangle);
                case(CollisionShapeType.LINE):
                    return CollisionManager.shapesCircleLine(this, shape as CollisionShapeLine);
                case(CollisionShapeType.POLYGON):
                    return CollisionManager.shapesCirclePolygon(this, shape as CollisionShapePolygon);
                default:
                    throw new Error("Unknown shape type");
            }
        }

        public function set radius(value:Number):void {
            _radius = value;
        }

        override public function get shapeType():CollisionShapeType {
            return CollisionShapeType.CIRCLE;
        }

        public function CollisionShapeCircle(x:Number = 0, y:Number = 0, radius:Number = 0) {
            super(x, y);
            _radius = radius;
        }
    }
}
