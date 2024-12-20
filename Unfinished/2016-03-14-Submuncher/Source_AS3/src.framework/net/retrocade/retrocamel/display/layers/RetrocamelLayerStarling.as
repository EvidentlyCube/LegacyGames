/*
 * Copyright (C) 2013 Maurycy Zarzycki
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package net.retrocade.retrocamel.display.layers{
    import net.retrocade.retrocamel.core.retrocamel_int;
    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
    
    import starling.display.DisplayObject;
    import starling.display.Sprite;

    use namespace retrocamel_int;
    
    public class RetrocamelLayerStarling extends RetrocamelLayer{
        
        retrocamel_int var _starlingSprite:Sprite;
        
        public function get layer():Sprite{
            return _starlingSprite;
        }
        
        public function RetrocamelLayerStarling(addAt:Number=-1){
            _starlingSprite = new Sprite();
            
            addLayer(addAt);
        }
        
        override public function get inputEnabled():Boolean{
            return layer.touchable;
        }
        
        override public function set inputEnabled(value:Boolean):void{
            layer.touchable = value;
        }
        
        override public function clear():void{
            _starlingSprite.removeChildren();
        }
        
        public function add(child:DisplayObject):void{
            _starlingSprite.addChildWithZ(child);
        }
        
        public function remove(child:DisplayObject):void{
            _starlingSprite.removeChild(child);
        }

        public function moveToFront():void{
            if (_starlingSprite.parent){
                _starlingSprite.parent.setChildIndex(_starlingSprite, _starlingSprite.parent.numChildren - 1);
            }
        }

        public function dispose():void{
            clear();
            removeLayer();
            _starlingSprite.dispose();
        }

        public function get alpha():Number {
            return _starlingSprite.alpha;
        }

        public function set alpha(value:Number):void {
            _starlingSprite.alpha = value;
        }
    }
}