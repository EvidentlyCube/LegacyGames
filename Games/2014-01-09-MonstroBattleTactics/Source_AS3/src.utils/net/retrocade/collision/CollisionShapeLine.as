

/**
 * Created by Skell on 09.11.13.
 */
package net.retrocade.collision {
    public class CollisionShapeLine extends CollisionShapeBase{
        private var _endX:Number;
        private var _endY:Number;

        public function get right():Number{
            return _x + _endX;
        }

        public function get bottom():Number{
            return _y + _endY;
        }

        public function get endX():Number {
            return _endX;
        }

        public function set endX(value:Number):void {
            _endX = value;
        }

        public function get endY():Number {
            return _endY;
        }

        public function set endY(value:Number):void {
            _endY = value;
        }

        override public function get shapeType():CollisionShapeType {
            return CollisionShapeType.LINE;
        }

        override public function collide(shape:CollisionShapeBase):Boolean {
            switch(shape.shapeType){
                case(CollisionShapeType.CIRCLE):
                    return CollisionManager.shapesCircleLine(shape as CollisionShapeCircle, this);

                case(CollisionShapeType.LINE):
                    return CollisionManager.shapesLineLine(shape as CollisionShapeLine, this);

                default:
                    throw new Error("Unknown shape type");
            }
        }

        public function CollisionShapeLine(x:Number = 0, y:Number = 0, endX:Number = 0, endY:Number = 0) {
            super(x, y);

            _endX = endX;
            _endY = endY;
        }
    }
}
