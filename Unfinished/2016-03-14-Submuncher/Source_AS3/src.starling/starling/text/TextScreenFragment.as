/*
 * Copyright (C) 2013 Maurycy Zarzycki
 * Unless stated otherwise in the rest of the source file
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package starling.text {
    final public class TextScreenFragment {
        private var _text:String = "";
        private var _x:int = 0;
        private var _y:int = 0;
        private var _color:int = 0;
        private var _leading:int = 0;
        private var _fontSize:int = -1;
        private var _textScreen:TextScreen;

        internal var _lastCalculatedWidth:uint;
        internal var _lastCalculatedHeight:uint;
        internal var _dimensionsAreDirty:Boolean = true;

        public function TextScreenFragment(text:String, x:int = 0, y:int = 0, color:uint = 0xFFFFFFFF) {
            _text = text;
            _x = x;
            _y = y;
            _color = color;
        }

        [Inline]
        final public function removeFromParent():void{
            if (_textScreen){
                _textScreen.removeFragment(this);
            }
        }

        [Inline]
        final private function markAsDirty():void {
            if (_textScreen) {
                _dimensionsAreDirty = true;
                _textScreen.fragmentChanged();
            }
        }

        [Inline]
        final public function get leading():int {
            return _leading;
        }

        [Inline]
        final public function set leading(value:int):void {
            if (value !== _leading) {
                _leading = value;
                markAsDirty();
            }
        }

        [Inline]
        final public function get text():String {
            return _text;
        }

        [Inline]
        final public function set text(value:String):void {
            if (value !== _text) {
                _text = value;
                markAsDirty();
            }
        }

        [Inline]
        final public function get x():int {
            return _x;
        }

        [Inline]
        final public function set x(value:int):void {
            if (value !== _x) {
                _x = value;
                markAsDirty();
            }
        }

        [Inline]
        final public function get y():int {
            return _y;
        }

        [Inline]
        final public function set y(value:int):void {
            if (value !== _y) {
                _y = value;
                markAsDirty();
            }
        }

        [Inline]
        final public function get color():int {
            return _color;
        }

        [Inline]
        final public function set color(value:int):void {
            if (_color !== value) {
                _color = value;
                markAsDirty();
            }
        }

        [Inline]
        final internal function get textScreen():TextScreen{
            return _textScreen;
        }

        [Inline]
        final internal function set textScreen(value:TextScreen):void {
            _textScreen = value;
        }

        [Inline]
        final public function get fontSize():int {
            return _fontSize;
        }

        [Inline]
        final public function set fontSize(value:int):void {
            if (value !== _fontSize){
                _fontSize = value;
                markAsDirty();
            }
        }

        [Inline]
        final public function get right():Number {
            return x + width;
        }

        [Inline]
        final public function set right(value:Number):void {
            x = value - width | 0;
        }

        /** Mock ASDoc */
        [Inline]
        final public function get bottom():Number {
            return y + height;
        }

        [Inline]
        final public function set bottom(value:Number):void {
            y = value - height | 0;
        }

        /** Mock ASDoc */
        [Inline]
        final public function get center():Number {
            return x + width / 2;
        }

        [Inline]
        final public function set center(value:Number):void {
            x = value - width / 2 | 0;
        }

        /** Mock ASDoc */
        [Inline]
        final public function get middle():Number {
            return y + height / 2;
        }

        [Inline]
        final public function set middle(value:Number):void {
            y = value - height / 2 | 0;
        }


        final public function get width():uint {
            if (_textScreen){
                if (_dimensionsAreDirty){
                    _textScreen.bitmapFont.fillTextFragmentDimensions(this);
                }

                return _lastCalculatedWidth;
            } else {

                return 0;
            }
        }

        final public function get height():uint {
            if (_textScreen){
                if (_dimensionsAreDirty){
                    _textScreen.bitmapFont.fillTextFragmentDimensions(this);
                }

                return _lastCalculatedHeight;
            } else {

                return 0;
            }
        }
    }
}
