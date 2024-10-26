package net.retrocade.data {
    public class RetrocamelContainsArray {
        public static const INDEX_NOT_FOUND:int = -1;

        private var _elements:Vector.<Object>;
        private var _length:uint;

        public function RetrocamelContainsArray() {
            _elements = new Vector.<Object>(0, false);
            _length = 0;
        }

        public function add(element:Object):void{
            if (!contains(element)){
                _elements[_length++] = element;
            }
        }

        public function getAt(index:uint):*{
            return index < _length ? _elements[index] : null;
        }

        public function remove(element:Object):void{
            var index:int = indexOf(element);

            if (index != INDEX_NOT_FOUND){
                _elements[index] = _elements[--_length];
            }
        }

        public function clear():void{
            _length = 0;
        }

        public function disposeContents():void{
            _elements.length = 0;
            _length = 0;
        }

        public function contains(element:Object):Boolean{
            for (var i:int = 0; i < _length; i++){
                if (_elements[i] === element){
                    return true;
                }
            }

            return false;
        }

        public function indexOf(element:Object):int{
            for (var i:int = 0; i < _length; i++){
                if (_elements[i] === element){
                    return i;
                }
            }

            return INDEX_NOT_FOUND;
        }

        public function get length():uint {
            return _length;
        }
    }
}
