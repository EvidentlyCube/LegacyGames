/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 16.03.13
 * Time: 12:03
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.render {
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.retrocamel_int;
    import net.retrocade.tacticengine.core.IDestruct;

    import starling.display.DisplayObject

    use namespace retrocamel_int;

    public class MonstroDisplayGroup implements IDestruct{
        private var _elements:Vector.<DisplayObject>;

        public function MonstroDisplayGroup(){
            _elements = new Vector.<DisplayObject>();
        }

        public function addElement(element:DisplayObject):void{
            if (_elements.indexOf(element) === -1){
                _elements.push(element);
            }
        }

        public function get x():Number{
            var minX:Number = Number.MAX_VALUE;

            for each(var element:DisplayObject in _elements){
                if (element.x < minX){
                    minX = element.x;
                }
            }

            return minX;
        }

        public function set x(value:Number):void{
            var deltaX:Number = value - x;

            for each(var element:DisplayObject in _elements){
                element.x += deltaX;
            }
        }

        public function get y():Number{
            var minY:Number = Number.MAX_VALUE;

            for each(var element:DisplayObject in _elements){
                if (element.y < minY){
                    minY = element.y;
                }
            }

            return minY;
        }

        public function set y(value:Number):void{
            var deltaY:Number = value - y;

            for each(var element:DisplayObject in _elements){
                element.y += deltaY;
            }
        }

        public function get width():Number{
            var left:Number = Number.MAX_VALUE;
            var right:Number = Number.MIN_VALUE;

            for each(var element:DisplayObject in _elements){
                left = Math.min(left, element.x);
                right = Math.max(right, element.right);
            }

            return right - left;
        }

        public function get height():Number{
            var top:Number = Number.MAX_VALUE;
            var bottom:Number = Number.MIN_VALUE;

            for each(var element:DisplayObject in _elements){
                top = Math.min(top, element.y);
                bottom = Math.max(bottom, element.bottom);
            }

            return bottom - top;
        }

        final public function alignCenter(offset:Number = 0):void{
            x = ((rCore.settings.gameWidth - width) / 2 | 0) + offset | 0;
        }

        final public function alignMiddle(offset:Number = 0):void{
            y = ((rCore.settings.gameHeight - height) / 2) + offset | 0;
        }

        public function destruct():void{
            _elements.length = 0;
            _elements = null;
        }
    }
}
