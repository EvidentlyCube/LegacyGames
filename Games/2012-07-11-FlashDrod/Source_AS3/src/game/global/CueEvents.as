package game.global {
	/**
     * ...
     * @author
     */
    public class CueEvents {
        private static var _isCIDSet:Array;
        private static var _CIDPrivateData:Array;

        private static var _nextPrivateDataIndex:uint;
        private static var _nextCID:uint;

        private static var _eventCount:uint;

        { // INIT
            init();
        }

		private static function init():void{
			_isCIDSet = [];
			_CIDPrivateData = [];
			var i:uint = 0;
			for (; i < C.CID_COUNT; i++) {
				_isCIDSet[i] = false;
				_CIDPrivateData[i] = [];
			}
		}
		
        /**
         * Clears all events
         */
        public static function clear():void {
            for (var i:uint = 0; i < C.CID_COUNT; i++) {
                _isCIDSet[i] = false;
                _CIDPrivateData[i].length = 0;
            }

            _nextPrivateDataIndex = 0;
            _nextCID = uint.MAX_VALUE;
        }

        /**
         * Clears an event state
         */
        public static function clearEvent(eCID:uint):void {
            _CIDPrivateData[eCID].length = 0;
            if (_nextCID == eCID) {
                _nextPrivateDataIndex = 0;
                _nextCID = uint.MAX_VALUE;
            }

            if (_isCIDSet[eCID]) {
                _isCIDSet[eCID] = false;
                --_eventCount;
            }
        }

        /**
         * Number of times a specified event has occured
         */
        public static function getOccurenceCount(eCID:uint):uint {
            return _CIDPrivateData[eCID].length;
        }

        public static function add(eCID:uint, data:* = null):void {
            if (!_isCIDSet[eCID]) {
                _isCIDSet[eCID] = true;
                _eventCount++;
            }

            if (data !== null)
                _CIDPrivateData[eCID].push(data);
        }

        public static function getFirstPrivateData(eCID:uint):*{
            if (_CIDPrivateData[eCID].length > 0) {
                _nextCID = eCID;
                _nextPrivateDataIndex = 1;
                return _CIDPrivateData[eCID][0];
            }

            _nextPrivateDataIndex = 0;
            _nextCID = uint.MAX_VALUE;
            return null;
        }

        public static function getNextPrivateData():*{
            if (_nextCID >= _CIDPrivateData.length || _nextPrivateDataIndex >= _CIDPrivateData[_nextCID].length)
                return null;

            return _CIDPrivateData[_nextCID][_nextPrivateDataIndex++];
        }

        public static function hasOccured(eventCID:uint):Boolean {
            return _isCIDSet[eventCID];
        }

        public static function hasAnyOccured(arrayOfCID:Array):Boolean {
            for each(var i:uint in arrayOfCID) {
                if (_isCIDSet[i])
                    return true;
            }

            return false;
        }

        public static function hasOccuredWith(eCID:uint, data:*):Boolean {
            for each(var i:* in _CIDPrivateData[eCID]) {
                if (i == data)
                    return true;
            }
            return false;
        }

        public static function remove(eCID:uint, data:*):Boolean {
            var found:Boolean = false;
            for (var i:uint = 0, l:uint = _CIDPrivateData[eCID].length; i < l; i++) {
                if (found) {
                    _CIDPrivateData[eCID][i - 1] = _CIDPrivateData[eCID][i];

                } else if (_CIDPrivateData[eCID][i] == data){
                    found = true;
                }
            }

            if (found)
                _CIDPrivateData[eCID][i].length--;

            return found;
        }
    }
}