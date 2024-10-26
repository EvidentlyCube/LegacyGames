package{
    public class Body{
        public function get current() :GamePoint{ return _points[0];          }
        public function get isFirst() :Boolean  { return _isFirst;            }
        public function get isLast()  :Boolean  { return _points.length == 0; }
        public function get isSingle():Boolean  { return _isSingle;           }
        
        public function get firstX()   :Number { return _firstX;             }
        public function get firstY()   :Number { return _firstY;             }
        public function get firstRad() :Number { return _firstRad;           }
        
        private var _points:Array = new Array();
        
        private var _firstX:Number;
        private var _firstY:Number;
        private var _firstRad:Number;
        
        private var randomID:Number = Math.random();
        
        private var _isFirst :Boolean = true;
        private var _isSingle:Boolean = false;
        
        public function getPoint():GamePoint{
            return _points.shift();
        }
        
        public function hovered():void{
            _isFirst = false;
        }
        
        public function addChild(gp:GamePoint):void{
            _isSingle = false;
            
            if (_points.length == 0){
                _firstX   = gp.x;
                _firstY   = gp.y;
                _firstRad = gp.rad;
                _isSingle = true;
            }
            
            _points.push(gp);
        }
        
        public function sleep():void{
            for each (var i:GamePoint in _points){
                i.sleep();
            }
        }
        
        public function wake():void{
            for each (var i:GamePoint in _points){
                i.wake();
            }
        }
    }
}