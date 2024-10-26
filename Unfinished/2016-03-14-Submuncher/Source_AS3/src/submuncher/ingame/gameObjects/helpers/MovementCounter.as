package submuncher.ingame.gameObjects.helpers {
    public class MovementCounter {
        private var _currentPosition:Number = 0;
        private var _speed:Number = 0;

        public function startMove(speed:uint):void {
            _speed = speed;
            _currentPosition = 0;
        }

        public function update():void {
            _currentPosition++;
        }

        public function isFinished():Boolean {
            return _currentPosition >= _speed;
        }

        public function get position():Number{
            if (_speed === 0) {
                return 0;
            } else if (_currentPosition >= _speed){
                return 1;
            } else {
                return _currentPosition / _speed;
            }
        }
        
        public function set position(value:Number):void {
            _currentPosition = value * _speed;
        }

        public function set speed(value:Number):void {
            if (_speed === 0){
                _currentPosition = value;
            } else {
                _currentPosition = (_currentPosition / _speed) * value;
            }

            _speed = value;
        }

        public function dispose():void {}
    }
}
