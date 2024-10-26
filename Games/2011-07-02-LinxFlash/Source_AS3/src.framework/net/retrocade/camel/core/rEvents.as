package net.retrocade.camel.core {
	/**
     * ...
     * @author 
     */
    
    use namespace retrocamel_int;
    
    public class rEvents {
        private static var _isCIDSet:Array;
        private static var _CIDPrivateData:Array;
        
        private static var _eventCount:uint;
        
        { // INIT
            init();
        }
        
		private static function init():void{
			_isCIDSet = [];
			_CIDPrivateData = [];
			var i:uint = 0;
			for (; i < rCore.settings.eventsCount; i++) {
				_isCIDSet[i] = false;
				_CIDPrivateData[i] = [];
			}
		}
		
        /**
         * Clears all events
         */
        public static function clear():void {
            if (_eventCount == 0)
                return;
            
            for (var i:uint = 0; i < rCore.settings.eventsCount; i++) {
                _isCIDSet[i] = false;
                _CIDPrivateData[i].length = 0;
            }
            
            _eventCount = 0;
        }
        
        /**
         * Clears an event state
         */
        public static function clearEvent(eCID:uint):void {
            _CIDPrivateData[eCID].length = 0;
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
        
        public static function occured(eCID:uint):Boolean{
            return _isCIDSet[eCID];
        }
        
        public static function add(eCID:uint, data:* = null):void {
            if (!_isCIDSet[eCID]) {
                _isCIDSet[eCID] = true;
                _eventCount++;
            }
            
            if (data)
                _CIDPrivateData[eCID].push(data);
        }
        
        public static function getPrivateData(eCID:uint):Array{
            return _CIDPrivateData[eCID];
        }
        
        public static function occuredArray(arrayOfCID:Array):Boolean {
            for each(var i:uint in arrayOfCID) {
                if (_isCIDSet[i])
                    return true;
            }
            
            return false;
        }
        
        public static function occuredWith(eCID:uint, data:*):Boolean {
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