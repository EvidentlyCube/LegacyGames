package net.retrocade.camel.engines.linkedlist{
    import net.retrocade.camel.global.retrocamel_int;
    
    use namespace retrocamel_int;
    public class rLinkedList{
        retrocamel_int var _first:rLinkedListLink;
        retrocamel_int var _length:uint = 0;
        
        public function rLinkedList(array:Array = null){
            _first = new rLinkedListLink(this);
            _first._next = _first;
            _first._prev = _first;
            
            if (array){
                for(var i:uint = 0, l:uint = array.length; i < l; i++){
                    addLast(array[i]);
                }
            }
        }
        
        
        
        /****************************************************************************************************************/
        /**                                                                                               MISCELLANOUS  */
        /****************************************************************************************************************/
        
        public function clear():void{
            while (_first._next != _first)
                _first.remove();
        }
        
        public function isEmpty():Boolean{
            return _first._next == _first;
        }
        
        public function contains(value:*):Boolean{
            var link:rLinkedListLink = _first._next;
            while (link != _first){
                if (link.value == value)
                    return true;
                link = link._next;
            }
            
            return false;
        }
        
        public function clone():rLinkedList{
            var list:rLinkedList = new rLinkedList();
            var link:rLinkedListLink = _first._next;
            
            while (link != _first){
                list.addLast(link.value);
                link = link._next;
            }
            
            return list;
        }
        
        public function reverse():void{
            var prev:rLinkedListLink = _first;
            var next:rLinkedListLink = prev._next;
            var link:rLinkedListLink;
            
            do{
                link = next._next;
                prev._prev = next;
                next._next = prev;
                
                prev = next;
                next = link;
                
            } while (prev != _first);
        }
        
        public function sort(sortFunction:Function, ascending:Boolean = true):void{
            var sortSign:int = ascending ? 1 : -1;
            
            var insize:uint = 1;
            do {
                var merges:int = 0;
                var tail:rLinkedListLink = _first;
                var p:rLinkedListLink = _first._next;
                
                while (p != _first){
                    merges++;
                    var q:rLinkedListLink = p._next;
                    var qsize:int = insize;
                    var psize:int = 1;
                    
                    while (psize < insize && q != _first){
                        psize++;
                        q = q._next;
                    }
                    
                    do {
                        var t:rLinkedListLink;
                        
                        if (psize && qsize && q != _first){
                            var cc:int = sortFunction(p.value, q.value) * sortSign;
                            if (cc < 0){
                                t = p;
                                p = p._next;
                                psize--;
                            } else {
                                t = q;
                                q = q._next;
                                qsize--;
                            }
                        } else if (psize){
                            t = p;
                            p = p._next;
                            psize--;
                        } else if (qsize && q != _first){
                            t = q;
                            q = q._next;
                            qsize--;
                        } else
                            break;
                        
                        t._prev = tail;
                        tail._next = t;
                        tail = t;
                    } while (true);
                    
                    p = q;
                }
                tail._next = _first;
                _first._prev = tail;
                
                if (merges <= 1)
                    return;
                
                insize *= 2
            } while (true);
        }
        
        public function toArray():Array{
            var array:Array           = [];
            var index:uint            = 0;
            var link :rLinkedListLink = _first._next;
            
            while (link != _first){
                array[index++] = link.value;
                link           = link._next;
            }
            
            return array;
        }
        
        public function length():uint{
            return _length;
        }
        
        public function swap(value1:*, value2:*):void{
            var link1:rLinkedListLink = getLinkByValue(value1);
            var link2:rLinkedListLink = getLinkByValue(value2);
            
            if (!link1 || !link2)
                return;
            
            swapLinks(link1, link2);
        }
        
        public function swapLinks(link1:rLinkedListLink, link2:rLinkedListLink):void{
            var tempVal:* = link1.value;
            link1.value = link2.value;
            link2.value = tempVal;
        }
        
        public function move(value:*, offset:int):void{
            var index:uint = getIndex(value);
            if (index == -1)
                return;
            
            var toIndex:uint = index + offset + (offset > 0 ? 1 : 0);
            if (toIndex < 0 || toIndex > _length)
                return;
            
            var currentLink:rLinkedListLink = getLinkAtIndex(index);
            if (toIndex == _length){
                currentLink.remove();
                addLast(value);
                
            } else {
                var toLink     :rLinkedListLink = getLinkAtIndex(toIndex);
                
                currentLink.remove();
                addBeforeLink(value, toLink);
            }
        }
        
        
        
        
        /****************************************************************************************************************/
        /**                                                                                               GETTER LINKS  */
        /****************************************************************************************************************/
        
        public function getLinkByValue(value:*):rLinkedListLink{
            var link:rLinkedListLink = _first._next;
            while (link != _first){
                if (link.value == value)
                    return link;
                
                link = link._next;
            }
            
            return null;
        }
        
        public function getLinkFirst():rLinkedListLink{
            if (_first._next == _first)
                return null;
            
            return _first._next;
        }
        
        public function getLinkLast():rLinkedListLink{
            if (_first._prev == _first)
                return null;
            
            return _first._prev;
        }
        
        
        
        /****************************************************************************************************************/
        /**                                                                                              GETTER VALUES  */
        /****************************************************************************************************************/
        
        public function getAtIndex(index:uint):*{
            if (index >= _length)
                return null;
            
            var link:rLinkedListLink = _first._next;
            while (link != _first){
                if (index == 0)
                    return link.value;
                else {
                    index--;
                    link = link._next;
                }
            }
            
            return null;
        }
        
        public function getLinkAtIndex(index:uint):rLinkedListLink{
            if (index >= _length)
                return null;
            
            var link:rLinkedListLink = _first._next;
            while (link != _first){
                if (index == 0)
                    return link;
                else {
                    index--;
                    link = link._next;
                }
            }
            
            return null;
        }
        
        public function getFirst():*{
            return _first._next.value;
        }
        
        public function getLast():*{
            return _first._prev.value;
        }
        
        public function getIndex(value:*):int{
            var link:rLinkedListLink = _first._next;
            var index:uint = 0;
            while (link != _first){
                if (link.value == value)
                    return index;
                
                link = link._next;
                index++;
            }
            
            return -1;
        }
        
        public function getLinkIndex(linkToCheck:rLinkedListLink):int{
            var link:rLinkedListLink = _first._next;
            var index:uint = 0;
            while (link != _first){
                if (link == linkToCheck)
                    return index;
                
                link = link._next;
                index++;
            }
            
            return -1;
        }
        
        
        
        /****************************************************************************************************************/
        /**                                                                                                    SETTERS  */
        /****************************************************************************************************************/
        
        public function addAfterLink(value:*, prev:rLinkedListLink):rLinkedListLink{
            var link:rLinkedListLink = new rLinkedListLink(this);
            
            link.value       = value;
            link._prev       = prev;
            link._next       = prev._next;
            
            link._next._prev = link;
            prev._next       = link;
            
            _length++;
            
            return link;
        }
        
        public function addBeforeLink(value:*, next:rLinkedListLink):rLinkedListLink{
            var link:rLinkedListLink = new rLinkedListLink(this);
            
            link.value       = value;
            link._next       = next;
            link._prev       = next._prev;
            
            link._prev._next = link;
            next._prev       = link;
            
            _length++;
            
            return link;
        }
        
        public function addAfterValue(value:*, prevValue:*):rLinkedListLink{
            var prevLink:rLinkedListLink = getLinkByValue(prevValue);
            if (!prevLink)
                return null;
            
            return addAfterLink(value, prevLink);
        }
        
        public function addBeforeValue(value:*, nextValue:*):rLinkedListLink{
            var prevLink:rLinkedListLink = getLinkByValue(nextValue);
            if (!prevLink)
                return null;
            
            return addBeforeLink(value, prevLink);
        }
        
        public function addFirst(value:*):rLinkedListLink{
            return addAfterLink(value, _first);
        }
        
        public function addLast(value:*):rLinkedListLink{
            return addBeforeLink(value, _first);
        }
        
        public function removeFirst():*{
            if (_first._next == _first)
                return null;
            
            var value:* = _first._next.value;
            _first._next.remove();
            return value;
        }
        
        public function removeLast():*{
            if (_first._next == _first)
                return null;
            
            var value:* = _first._prev.value;
            _first._next.remove();
            return value;
        }
        
        public function remove(value:*):Boolean{
            var link:rLinkedListLink = getLinkByValue(value);
            
            if (!link)
                return false;
            
            link.remove();
            return true;
        }
    }
}