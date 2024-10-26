package submuncher.ingame.core {
    import net.retrocade.vault.Safe;

    import submuncher.core.constants.LockColor;

    public class LevelScore {
        private var _keys:Vector.<Safe>;
        private var _dnaStrandsLeft:int;
        private var _secretDnaStrandsLeft:int;
        private var _isDocumentCollected:Boolean;
        private var _currentTime:int;
        private var _ammo:Safe;

        public function LevelScore() {
            _keys = new Vector.<Safe>(LockColor.count, true);
            _ammo = new Safe(0);
            _dnaStrandsLeft = 0;
            _secretDnaStrandsLeft = 0;
            _isDocumentCollected = false;
            _currentTime = 0;
            intializeKeys();
        }

        private function intializeKeys():void {
            for (var i:int = 0; i < _keys.length; i++) {
                _keys[i] = new Safe(0);
            }
        }

        public function getKeys(lockColor:LockColor):Number {
            return _keys[lockColor.id].get();
        }

        public function addKey(lockColor:LockColor):void {
            _keys[lockColor.id].add(1);
        }

        public function removeKey(lockColor:LockColor):void {
            _keys[lockColor.id].add(-1);
        }

        public function get dnaStrandsLeft():int {
            return _dnaStrandsLeft;
        }

        public function set dnaStrandsLeft(value:int):void {
            _dnaStrandsLeft = value;
        }

        public function get secretDnaStrandsLeft():int {
            return _secretDnaStrandsLeft;
        }

        public function set secretDnaStrandsLeft(value:int):void {
            _secretDnaStrandsLeft = value;
        }

        public function increaseTime():void {
            _currentTime++;
        }

        public function get isDocumentCollected():Boolean {
            return _isDocumentCollected;
        }

        public function set isDocumentCollected(value:Boolean):void {
            _isDocumentCollected = value;
        }

        public function get currentTime():int {
            return _currentTime;
        }

        public function get ammo():int {
            return _ammo.get();
        }

        public function set ammo(value:int):void {
            _ammo.set(value);
        }

    }
}
