package game.global{
    import flash.utils.ByteArray;
    public class Commands{
        private static var _list  :Array   = [];
        private static var _frozen:Boolean = false;

        /** Position of the internal pointer **/
        private static var _index:uint = 0;

        public static function add(command:uint):void{
            _list.push({command:command});
        }

        public static function addWithData(command:uint, wx:uint, wy:uint):void{
            _list.push({command:command, wx:wx, wy:wy});
        }

        public static function clear():void{
            _list.length = 0;
            _frozen = false;
        }

        public static function count():uint{
            return _list.length;
        }

        public static function freeze():void{
            _frozen = true;
        }

        public static function unfreeze():void{
            _frozen = false;
        }

        public static function isFrozen():Boolean{
            return _frozen;
        }

        public static function removeLast():void{
            _list.length--;
        }

        /** Truncates the list to contain only Count commands **/
        public static function truncate(count:uint):void{
            _list.length = count;
        }

        public static function getCommand(index:uint):uint{
            return _list[_index = index].command;
        }

        public static function getComplexX():uint{
            return _list[_index].wx;
        }

        public static function getComplexY():uint{
            return _list[_index].wy;
        }

        public static function getFirst():uint{
            _index = 0;
            return _list[_index].command;
        }

        public static function getLast():uint{
            return _list.length ? _list[_list.length - 1].command : C.CMD_UNSPECIFIED;
        }

        public static function getNext():uint{
            if (++_index >= _list.length)
                return uint.MAX_VALUE;

            return _list[_index].command;
        }

        public static function getPrev():uint{
            if (_index-- < 0)
                return uint.MAX_VALUE;

            return _list[_index].command;
        }

        public static function getBuffer():ByteArray {
            var ba:ByteArray = new ByteArray();

            ba.writeObject(_list);

            return ba;
        }

        public static function loadBuffer(buffer:ByteArray):void {
            buffer.position = 0;
            _list = buffer.readObject();
        }
    }
}