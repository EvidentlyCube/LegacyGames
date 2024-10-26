package submuncher.ingame.vfx.shatter {
    import flash.geom.Point;

    import net.retrocade.random.Random;

    import net.retrocade.random.RandomEngineType;

    public class ShatterData {
        private var _points:Vector.<Point>;
        private var _uniquePoints:int = 0;
        private var _directionsRadians:Vector.<Number>;
        private var _directionSway:Number;
        private var _speedMultipler:Number;


        public function ShatterData(directionSway:Number, speedMultipler:Number) {
            _directionSway = directionSway * Math.PI / 180;
            _speedMultipler = speedMultipler;

            _directionsRadians = new Vector.<Number>();
            _points = new Vector.<Point>();
            _points.push(new Point(0, 0));
            _points.push(new Point(0, 0));
            _points.push(new Point(0, 0));
            _points.push(new Point(0, 0));
        }

        public function addPoint(x:Number, y:Number):void {
            for(var i:int = _uniquePoints; i < 4; i++){
                _points[i].x = x;
                _points[i].y = y;
            }

            _uniquePoints++;
        }

        public function addDirection(degrees:Number):void {
            _directionsRadians.push(degrees * Math.PI / 180);
        }

        public function get points():Vector.<Point> {
            return _points;
        }

        public function get uniquePoints():int {
            return _uniquePoints;
        }

        public function get directionsRadians():Vector.<Number> {
            return _directionsRadians;
        }

        public function get directionSway():Number {
            return _directionSway;
        }

        public function get speedMultipler():Number {
            return _speedMultipler;
        }

        public function get randomDirection():Number {
            return _directionsRadians[Random.defaultEngine.getUintRange(0, _directionsRadians.length)];
        }
    }
}
