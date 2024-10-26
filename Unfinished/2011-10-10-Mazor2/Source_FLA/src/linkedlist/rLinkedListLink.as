package src.linkedlist{
    public class rLinkedListLink{
        public var value:*;
        
        internal var _next:rLinkedListLink;
        internal var _prev:rLinkedListLink;
        internal var _list:rLinkedList;
        
        public function rLinkedListLink(list:rLinkedList){
            _list = list;
        }
        
        public function get next():rLinkedListLink{
            return _next;
        }
        
        public function get prev():rLinkedListLink{
            return _prev;
        }
        
        public function get list():rLinkedList{
            return _list;
        }
        
        public function remove():void{
            _list._length--;
            
            _next._prev = _prev;
            _prev._next = _next;
            _next = null;
            _prev = null;
            value = null;
            _list = null;
        }
    }
}