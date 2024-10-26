package net.retrocade.collision {
    public class CollisionShapePolygonPoint {
        private var _x:Number;
        private var _y:Number;

        private var _rotation:Number;
        private var _initialAngle:Number;
        private var _distance:Number;

        public function CollisionShapePolygonPoint(x:Number, y:Number) {
            _x = x;
            _y = y;

            _rotation = 0;
            _initialAngle = Math.atan2(_y, _x);
            _distance = Math.sqrt(_x*_x + _y*_y);
        }

        public function get x():Number {
            return _x;
        }

        public function get y():Number {
            return _y;
        }

        public function get rotation():Number {
            return _rotation;
        }

        public function get distance():Number {
            return _distance;
        }

        public function set rotation(value:Number):void {
            if (_rotation !== value){
                _rotation = value;
                recalculatePositions();
            }
        }

        private function recalculatePositions():void {
            _x = Math.cos(_rotation + _initialAngle) * _distance;
            _y = Math.sin(_rotation + _initialAngle) * _distance;
        }
    }
}
