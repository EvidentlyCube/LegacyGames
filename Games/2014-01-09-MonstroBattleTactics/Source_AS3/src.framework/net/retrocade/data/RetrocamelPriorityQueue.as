


package net.retrocade.data {
    public class RetrocamelPriorityQueue {
        private var _firstElement:PriorityElement;
        private var _lastElement:PriorityElement;

        public function addFromEnd(item:Object, priority:int):void {
            var addedElement:PriorityElement = PriorityElement.newInstance;
            addedElement.item = item;
            addedElement.priority = priority;

            if (!_lastElement) {
                _lastElement = addedElement;
                _firstElement = addedElement;
            } else {
                var smallerPriorityElement:PriorityElement = _lastElement;
                while (smallerPriorityElement && smallerPriorityElement.priority > priority) {
                    smallerPriorityElement = smallerPriorityElement.prevItem;
                }

                if (!smallerPriorityElement) {
                    addedElement.nextItem = _firstElement;
                    _firstElement.prevItem = addedElement;
                    _firstElement = addedElement;
                } else {
                    addedElement.prevItem = smallerPriorityElement;
                    addedElement.nextItem = smallerPriorityElement.nextItem;

                    if (addedElement.nextItem) {
                        addedElement.nextItem.prevItem = addedElement;
                    } else {
                        _lastElement = addedElement;
                    }

                    smallerPriorityElement.nextItem = addedElement;
                }
            }
        }

        public function shift():* {
            if (_firstElement) {
                var returnedItem:* = _firstElement.item;

                var toDestroy:PriorityElement = _firstElement;
                _firstElement = toDestroy.nextItem;
                if (!toDestroy.nextItem) {
                    _lastElement = null;
                }
                toDestroy.destroy();

                return returnedItem;
            } else {
                return null;
            }
        }
    }
}


class PriorityElement {
    private static var _pool:Vector.<PriorityElement>;
    private static var _poolIndex:int = 0;
    private static var _poolLength:int = 512;

    {
        _pool = new Vector.<PriorityElement>();
        _pool.length = _poolLength;
    }

    public static function get newInstance():PriorityElement {
        if (_poolIndex > 0) {
            return _pool[--_poolIndex];
        } else {
            return new PriorityElement();
        }
    }

    public var item:*;
    public var priority:int;
    public var nextItem:PriorityElement;
    public var prevItem:PriorityElement;

    public function destroy():void {
        item = null;
        priority = 0;

        if (nextItem) {
            nextItem.prevItem = prevItem;
        }

        if (prevItem) {
            prevItem.nextItem = nextItem;
        }

        nextItem = null;
        prevItem = null;

        if (_poolIndex == _poolLength) {
            _poolLength *= 2;
            _pool.length = _poolLength;
        }

        _pool[_poolIndex++] = this;
    }
}
