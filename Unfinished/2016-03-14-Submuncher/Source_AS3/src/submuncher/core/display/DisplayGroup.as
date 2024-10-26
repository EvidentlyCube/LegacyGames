package submuncher.core.display {
    import net.retrocade.retrocamel.core.retrocamel_int;

    import starling.display.DisplayObject
    import starling.display.DisplayObjectContainer;

    use namespace retrocamel_int;

    final public class DisplayGroup extends DisplayObject {
        private var _elements:Vector.<DisplayObject>;

        final public function DisplayGroup(){
            _elements = new Vector.<DisplayObject>();
        }

        final public function addElement(element:DisplayObject):void{
            if (_elements.indexOf(element) === -1){
                _elements.push(element);
            }
        }

        final public function addElements(elements:*):void{
            for each(var element:DisplayObject in elements){
                addElement(element);
            }
        }

        override public function get x():Number{
            var minX:Number = Number.MAX_VALUE;

            for each(var element:DisplayObject in _elements){
                if (element.x < minX){
                    minX = element.x;
                }
            }

            return minX;
        }

        override public function set x(value:Number):void{
            var deltaX:Number = value - x;

            for each(var element:DisplayObject in _elements){
                element.x += deltaX;
            }
        }

        override public function get y():Number{
            var minY:Number = Number.MAX_VALUE;

            for each(var element:DisplayObject in _elements){
                if (element.y < minY){
                    minY = element.y;
                }
            }

            return minY;
        }

        override public function set y(value:Number):void{
            var deltaY:Number = value - y;

            for each(var element:DisplayObject in _elements){
                element.y += deltaY;
            }
        }

        override public function get width():Number{
            var left:Number = Number.MAX_VALUE;
            var right:Number = Number.MIN_VALUE;

            for each(var element:DisplayObject in _elements){
                left = Math.min(left, element.x);
                right = Math.max(right, element.right);
            }

            return right - left;
        }

        override public function get height():Number{
            var top:Number = Number.MAX_VALUE;
            var bottom:Number = Number.MIN_VALUE;

            for each(var element:DisplayObject in _elements){
                top = Math.min(top, element.y);
                bottom = Math.max(bottom, element.bottom);
            }

            return bottom - top;
        }


        final public function alignAllCenter():void{
            var widthCache:Number = width;
            for each(var element:DisplayObject in _elements){
                element.center = widthCache / 2;
            }
        }

        override public function dispose():void{
            _elements.length = 0;
            _elements = null;

            super.dispose();
        }

        public function verticalize(spacing:Number = 0, offset:Number = 0):void{
            for each(var element:Object in _elements){
                element.y = offset;

                offset += element.height + spacing;
            }
        }

        public function verticalizePrecise(spacing:Number = 0, offset:Number = 0, elementsToDoubleSpace:Array = null, multiFactor:Number = 2):void{
            for each(var element:Object in _elements){
                element.y = offset;

                offset += element.height + spacing;
                if (elementsToDoubleSpace && elementsToDoubleSpace.indexOf(element) !== -1){
                    element.y += spacing * (multiFactor - 1);
                    offset += spacing * (multiFactor - 1);
                }
            }
        }


        override public function set alpha(value:Number):void {
            for each(var element:Object in _elements){
                element.alpha = value;
            }
        }

        override public function get alpha():Number {
            return _elements.length > 0 ? _elements[0].alpha : 1;
        }

        public function addSelfTo(target:DisplayObjectContainer):void {
            for each (var object:DisplayObject in _elements) {
                target.addChild(object);
            }
        }

        override public function get touchable():Boolean {
            return _elements.length > 0 ? _elements[0].touchable : true;
        }

        override public function set touchable(value:Boolean):void {
            for each(var element:Object in _elements){
                element.touchable = value;
            }
        }

        public function makeTouchable():void {
            touchable = true;
        }

        public function makeUntouchable():void {
            touchable = false;
        }
    }
}
