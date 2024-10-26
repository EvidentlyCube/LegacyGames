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
    import flash.geom.Rectangle;

    import starling.core.RenderSupport;
    import starling.display.DisplayObject;
    import starling.display.QuadBatch;
    import starling.events.Event;

    public class TextScreen extends DisplayObject {
        private static const BOUNDS_RECTANGLE:Rectangle = new Rectangle();
        private var _fontName:String;
        private var _requiresRedraw:Boolean;
        private var _batchable:Boolean;
        private var _textFragments:Vector.<TextScreenFragment>;
        private var _quadBatch:QuadBatch;

        /** Create a new text field with the given properties. */
        public function TextScreen(fontName:String) {
            this.fontName = fontName;

            _textFragments = new Vector.<TextScreenFragment>();
            _quadBatch = new QuadBatch();
            _quadBatch.touchable = false;

            addEventListener(Event.FLATTEN, onFlatten);
        }

        /** Disposes the underlying texture data. */
        public override function dispose():void {
            removeEventListener(Event.FLATTEN, onFlatten);
            if (_quadBatch) {
                _quadBatch.dispose();
            }
            super.dispose();
        }

        /** @inheritDoc */
        public override function render(support:RenderSupport, parentAlpha:Number):void {
            if (_requiresRedraw) {
                redraw();
            }

            support.batchQuadBatch(_quadBatch, parentAlpha * this.alpha);
        }

        /** @inheritDoc */
        public override function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null):Rectangle {
            return BOUNDS_RECTANGLE;
        }

        /** Forces the text field to be constructed right away. Normally,
         *  it will only do so lazily, i.e. before being rendered. */
        public function redraw():void {
            if (_requiresRedraw) {
                createComposedContents();
                _requiresRedraw = false;
            }
        }

        internal function fragmentChanged():void {
            _requiresRedraw = true;
        }

        private function onFlatten():void {
            if (_requiresRedraw) {
                redraw();
            }
        }

        private function createComposedContents():void {
            _quadBatch.reset();

            var bitmapFont:BitmapFont = this.bitmapFont;
            if (bitmapFont == null) {
                throw new Error("Bitmap font not registered: " + _fontName);
            }

            for each (var fragment:TextScreenFragment in _textFragments) {
                bitmapFont.addTextFragmentToBatch(_quadBatch, fragment);
            }

            _quadBatch.batchable = _batchable;
        }

        /** @inheritDoc */
        public override function set width(value:Number):void {
        }

        /** @inheritDoc */
        public override function set height(value:Number):void {
        }

        public function get bitmapFont():BitmapFont {
            return TextField.getBitmapFont(_fontName);
        }

        /** The name of the font (true type or bitmap font). */
        public function get fontName():String {
            return _fontName;
        }

        public function set fontName(value:String):void {
            if (_fontName != value) {
                if (value == BitmapFont.MINI && TextField.bitmapFonts[value] == undefined) {
                    TextField.registerBitmapFont(new BitmapFont());
                }

                _fontName = value;
                _requiresRedraw = true;
            }
        }

        /** Indicates if TextField should be batched on rendering. This works only with bitmap
         *  fonts, and it makes sense only for TextFields with no more than 10-15 characters.
         *  Otherwise, the CPU costs will exceed any gains you get from avoiding the additional
         *  draw call. @default false */
        public function get batchable():Boolean {
            return _batchable;
        }

        public function set batchable(value:Boolean):void {
            _batchable = value;
            if (_quadBatch) {
                _quadBatch.batchable = value;
            }
        }

        public function addFragment(fragment:TextScreenFragment):void{
            if (_textFragments.indexOf(fragment) > -1){
                return;
            }

            fragment.removeFromParent();

            _textFragments.push(fragment);
            fragment.textScreen = this;
        }

        public function removeFragment(fragment:TextScreenFragment):void{
            var index:int = _textFragments.indexOf(fragment);
            if (index === -1){
                return;
            }

            _textFragments.splice(index, 1);
            fragment.textScreen = null;
        }

        public function containsFragment(fragment:TextScreenFragment):Boolean{
            return _textFragments.indexOf(fragment) !== -1;
        }

        public function sortFragmentsByColor():void{
            _textFragments = _textFragments.sort(sortByColor);
        }

        private function sortByColor(leftFragment:TextScreenFragment, rightFragment:TextScreenFragment):int{
            if (leftFragment.color > rightFragment.color){
                return -1;
            } else if (leftFragment.color > rightFragment.color){
                return 1;
            } else {
                return 0;
            }
        }
    }
}
