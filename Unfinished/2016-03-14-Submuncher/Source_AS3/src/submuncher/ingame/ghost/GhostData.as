package submuncher.ingame.ghost {
    import flash.utils.ByteArray;

    import net.retrocade.utils.UtilsBase64;

    public class GhostData {
        private var _isLocked:Boolean;
        private var _ghostData:Vector.<Number>;
        private var _currentIndex:int;
        private var _bufferSize:int;

        public function GhostData() {
            _ghostData = new Vector.<Number>(60 * 3 * 2);
            _currentIndex = 0;
            _bufferSize = _ghostData.length;
        }

        public function addPosition(x:Number, y:Number):void {
            if (_isLocked){
                throw new Error("Ghost data is locked and can't be changed");
            }

            if (_currentIndex === _bufferSize){
                _ghostData.length += 60 * 3 * 2;
                _bufferSize = _ghostData.length;
            }

            _ghostData[_currentIndex++] = x;
            _ghostData[_currentIndex++] = y;
        }

        public function commitData():void {
            _isLocked = true;

            _bufferSize = _currentIndex;
            _ghostData.length = _currentIndex;
        }

        public function resetPlaybackPosition():void {
            if (!_isLocked){
                throw new Error("Ghost data is still recording");
            }

            _currentIndex = 0;
        }

        public function getNextData():Number {
            if (_currentIndex >= _bufferSize){
                return NaN;
            } else {
                return _ghostData[_currentIndex++];
            }
        }

        public function get isFinished():Boolean {
            return _currentIndex >= _bufferSize;
        }

        public function get stringValue():String {
            var ba:ByteArray = new ByteArray();
            for (var i:int = 0; i < _ghostData.length; i++) {
                ba.writeFloat(_ghostData[i]);
            }
            ba.position = 0;
            ba.compress();

            return UtilsBase64.encodeByteArray(ba);
        }

        public function set stringValue(value:String):void {
            var ba:ByteArray = UtilsBase64.decodeByteArray(value);
            ba.position = 0;
            ba.uncompress();

            _ghostData.length = ba.length * 4;
            _currentIndex = 0;
            while(ba.position < ba.length){
                _ghostData[_currentIndex++] = ba.readFloat();
            }
            _bufferSize = _ghostData.length;
            _currentIndex = 0;
        }
    }
}
