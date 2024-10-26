package net.retrocade.collision {
    public class CollisionShapeRectangle extends CollisionShapeBase{
        private var _width:Number;
        private var _height:Number;

        public function get right():Number{
            return _x + _width;
        }

        public function get bottom():Number{
            return _y + _height;
        }

        public function get width():Number {
            return _width;
        }

        public function set width(value:Number):void {
            _width = value;
        }

        public function get height():Number {
            return _height;
        }

        public function set height(value:Number):void {
            _height = value;
        }

        override public function get shapeType():CollisionShapeType {
            return CollisionShapeType.RECTANGLE;
        }

        override public function collide(shape:CollisionShapeBase):Boolean {
            switch(shape.shapeType){
                case(CollisionShapeType.CIRCLE):
                    return CollisionManager.shapesCircleRectangle(shape as CollisionShapeCircle, this);
                case(CollisionShapeType.RECTANGLE):
                    return CollisionManager.shapesRectangleRectangle(this, shape as CollisionShapeRectangle);
                default:
                    throw new Error("Unknown shape type");
            }
        }

        public function CollisionShapeRectangle(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0) {
            super(x, y);

            _width = width;
            _height = height;
        }
    }
}
