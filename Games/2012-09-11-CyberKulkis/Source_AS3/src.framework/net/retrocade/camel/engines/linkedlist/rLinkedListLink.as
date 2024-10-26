package net.retrocade.camel.engines.linkedlist{
    import net.retrocade.camel.core.retrocamel_int;

    use namespace retrocamel_int;
    public class rLinkedListLink{
        public var value:*;
        
        retrocamel_int var _next:rLinkedListLink;
        retrocamel_int var _prev:rLinkedListLink;
        retrocamel_int var _list:rLinkedList;
        
        public function rLinkedListLink(list:rLinkedList){
            _list = list;
        }
        
        /*public function get next():rLinkedListLink{
            return _next;
        }
        
        public function get prev():rLinkedListLink{
            return _prev;
        }
        
        public function get list():rLinkedList{
            return _list;
        }*/
        
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