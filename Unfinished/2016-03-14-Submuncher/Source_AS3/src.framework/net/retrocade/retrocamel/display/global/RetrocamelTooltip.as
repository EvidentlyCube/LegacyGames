/*
 * Copyright (C) 2013 Maurycy Zarzycki
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package net.retrocade.retrocamel.display.global {
    import flash.display.BlendMode;
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.DropShadowFilter;
    import flash.utils.Dictionary;

    import net.retrocade.retrocamel.core.RetrocamelCore;
    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;

    import net.retrocade.retrocamel.core.retrocamel_int;

    import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
    import net.retrocade.retrocamel.display.flash.RetrocamelGrid9Flash;
    import net.retrocade.retrocamel.display.flash.RetrocamelTextField;

    use namespace retrocamel_int;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class RetrocamelTooltip extends Sprite {
        private static var self:RetrocamelTooltip;
        private static var _hooksList:Dictionary = new Dictionary;

        public static function init():void{
            if (self){
                throw new Error("RetrocamelTooltip is already initialized");
            }

            self = new RetrocamelTooltip();

            RetrocamelDisplayManager._flashStage.addEventListener(Event.ENTER_FRAME, self.update);
            RetrocamelDisplayManager._tooltip = self;
            RetrocamelDisplayManager.flashApplication.addChild(self);
        }

        public static function hook(object:InteractiveObject, text:String, permanent:Boolean = false):void {
            _hooksList[object] = text;

            if (object.hasEventListener(MouseEvent.ROLL_OVER)) {
                object.removeEventListener(MouseEvent.ROLL_OVER, _onHookOver);
            }

            if (object.hasEventListener(MouseEvent.ROLL_OUT)) {
                object.removeEventListener(MouseEvent.ROLL_OUT, _onHookOut);
            }

            object.addEventListener(MouseEvent.ROLL_OVER, _onHookOver, false, 0, true);
            object.addEventListener(MouseEvent.ROLL_OUT, _onHookOut, false, 0, true);

            if (!permanent) {
                object.addEventListener(Event.REMOVED_FROM_STAGE, _onHookRemove, false, 0, true);
            }
        }

        public static function unhook(object:InteractiveObject):void {
            delete _hooksList[object];

            object.removeEventListener(MouseEvent.ROLL_OVER, _onHookOver);
            object.removeEventListener(MouseEvent.ROLL_OUT, _onHookOut);
            object.removeEventListener(Event.REMOVED_FROM_STAGE, _onHookRemove);
        }

        public static function hookToObject(object:*, text:String):void {
            _hooksList[object] = text;
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Appearance
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function setShadow(angle:Number = NaN, blur:Number = 4, distance:Number = 5, strength:Number = 1, alpha:Number = 1, color:Number = 0):void {
            if (isNaN(angle)) {
                self.filters = null;
            }
            else {
                self.filters = [ new DropShadowFilter(distance, angle, color, alpha, blur, blur, strength) ];
            }
        }

        public static function setPadding(top:int = 0, right:int = 0, bottom:int = 0, left:int = 0):void {
            self._paddingTop = top;
            self._paddingRight = right;
            self._paddingBottom = bottom;
            self._paddingLeft = left;
        }

        public static function setBackground(bg:*):void {
            if (bg is RetrocamelGrid9Flash) {
                self.bgGrid(bg);
            }

            else if (bg is String) {
                if (!isNaN(parseInt(bg))) {
                    self.bgColor(parseInt(bg));
                }
                else {
                    self.bgGrid(RetrocamelGrid9Flash.getGrid(bg));
                }

            } else if (bg is Number) {
                self.bgColor(bg);
            }
        }

        public static function useFontText(fontName:String):void {
            self.useText(fontName);
        }

        /**
         * If using RetrocamelBitmapText sets the scale to size,
         * if using Text sets the fontSize to size
         */
        public static function setSize(size:uint):void {
            self.setSize(size);
        }

        /**
         * If using RetrocamelBitmapText sets the coloring,
         * if using Text sets the font color
         */
        public static function setColor(color:uint):void {
            self.setColor(color);
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Display
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function show(o:*):void {
            if (o is Event) {
                _onHookOver(o);
            }
            else {
                self.setText(_hooksList[o]);
                self._hide = false;
            }
        }

        /**
         * Manually hide the Tooltip. It doesn't stop Tooltip from appearing again!
         */
        public static function hide():void {
            self._hide = true;
        }

        public static function retrieveTextObject():RetrocamelTextField {
            return self._text;
        }


        /****************************************************************************************************************/
        /**                                                                                                    PRIVATE  */
        /****************************************************************************************************************/

        private var _bitext:RetrocamelBitmapText;
        private var _text:RetrocamelTextField;
        private var _txt:DisplayObject;


        /****************************************************************************************************************/
        /**                                                                                                   INSTANCE  */
        private var _bgGrid:RetrocamelGrid9Flash;
        private var _bgColor:uint = 0;
        private var _hide:Boolean = true;
        private var _paddingTop:int = 5;
        private var _paddingRight:int = 5;
        private var _paddingBottom:int = 5;
        private var _paddingLeft:int = 5;
        private var _useText:Boolean = false;

        public function RetrocamelTooltip() {
            self = this;

            this.blendMode = BlendMode.LAYER;

            _bitext = new RetrocamelBitmapText();
            _bitext.align = 1;
            _bitext.multiline = true;

            _text = new RetrocamelTextField("", "font", 14);
            _text.width = 1;
            _text.height = 1;
            _text.autoSizeCenter();
            _text.alignCenter();
            _text.visible = false;

            _txt = _bitext;

            addChild(_bitext);
            addChild(_text);

            alpha = 0;

            this.mouseEnabled = false;
            this.mouseChildren = false;
        }

        public function useText(font:String):void {
            if (_useText) {
                return;
            }

            _useText = true;
            _text.font = font;
            _text.visible = true;
            _bitext.visible = false;
            _txt = _text;

            setText(_bitext.text);

            _text.apply();
        }

        public function setSize(size:uint):void {
            if (_useText) {
                _text.size = size;
            }
            else {
                _bitext.setScale(size);
            }
        }

        public function setColor(color:uint):void {
            if (_useText) {
                _text.color = color;
            }
            else {
                _bitext.color = color;
            }
        }

        public function setText(text:String):void {
            if (_useText) {
                setTextText(text);
            }

            else {
                setTextBitext(text);
            }

            if (_bgGrid) {
                _bgGrid.width = _txt.width + _paddingLeft + _paddingRight;
                _bgGrid.height = _txt.height + _paddingTop + _paddingBottom;
                _bgGrid.x = 0;
                _bgGrid.y = 0;

            } else {
                graphics.clear();
                graphics.beginFill(_bgColor);
                graphics.drawRect(0,
                    0,
                    _txt.width + _paddingLeft + _paddingRight,
                    _txt.height + _paddingTop + _paddingBottom);
            }
        }

        public function bgColor(color:uint):void {
            _bgColor = color;
        }

        public function bgGrid(grid9:RetrocamelGrid9Flash):void {
            if (_bgGrid) {
                removeChild(_bgGrid);
            }

            _bgGrid = grid9;

            if (_bgGrid) {
                addChildAt(_bgGrid, 0);
            }
        }

        private function setTextText(text:String):void {
            _text.width = 1;
            _text.height = 1;

            _text.textAlignCenter();
            _text.autoSizeLeft();

            _text.text = text;
            _text.apply();

            _text.x = _paddingLeft;
            _text.y = _paddingTop;
        }

        private function setTextBitext(text:String):void {
            _bitext.x = _paddingLeft;
            _bitext.y = _paddingTop;

            _bitext.text = text;
        }

        /****************************************************************************************************************/

        private static function _onHookOver(e:MouseEvent):void {
            self.setText(_hooksList[e.target]);
            self._hide = false;
        }

        private static function _onHookOut(e:MouseEvent):void {
            self._hide = true;
        }

        private static function _onHookRemove(e:Event):void {
            e.target.removeEventListener(MouseEvent.ROLL_OVER, _onHookOver);
            e.target.removeEventListener(MouseEvent.ROLL_OUT, _onHookOut);
            e.target.removeEventListener(Event.REMOVED_FROM_STAGE, _onHookRemove);
        }

        retrocamel_int function update(event:Event):void {
            if (_hide) {
                if (alpha > 0) {
                    alpha -= 0.125;
                }

            } else if (alpha < 1) {
                alpha += 0.125;
            }

            x = (RetrocamelDisplayManager._flashStage.mouseX - RetrocamelDisplayManager.viewportOffsetX) / RetrocamelDisplayManager.viewportScaleX - _txt.width / 2 - (_paddingLeft + _paddingRight) / 2 | 0;
            y = (RetrocamelDisplayManager._flashStage.mouseY - RetrocamelDisplayManager.viewportOffsetY) / RetrocamelDisplayManager.viewportScaleY - _txt.height - _paddingTop - _paddingBottom - 8 | 0;

            if (x < 0) {
                x = 0;
            }
            if (x + width > RetrocamelCore.settings.gameWidth) {
                x = RetrocamelCore.settings.gameWidth - width;
            }

            if (y < 0) {
                y = 0;
            }
            if (y + height > RetrocamelCore.settings.gameHeight) {
                y = RetrocamelCore.settings.gameHeight - height;
            }
        }
    }
}