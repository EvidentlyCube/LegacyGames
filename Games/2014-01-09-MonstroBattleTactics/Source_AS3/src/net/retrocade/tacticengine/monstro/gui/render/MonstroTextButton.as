
package net.retrocade.tacticengine.monstro.gui.render {
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;

    import starling.display.Image;

    import starling.events.TouchEvent;

    import starling.text.TextField;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    public class MonstroTextButton extends MonstroButton implements IDisposable{
        private var _textField:TextField;
        private var _forcedWidth:Number = NaN;
        private var _icon:Image;

        public function set forcedWidth(value:Number):void{
            _forcedWidth = value;

            reposition();
        }

        public function MonstroTextButton(text:String, callback:Function, forcedWidth:Number = NaN, color:uint = COLOR_BLUE) {
            super(callback, color);

            _textField = new TextField(40, 46, "", MonstroConsts.FONT_EBORACUM_48, 28, 0xFFFFFF);
            _textField.hAlign = HAlign.CENTER;
            _textField.vAlign = VAlign.CENTER;

            _forcedWidth = forcedWidth;

            backgroundHeight = 50;

            addChild(_textField);

            reposition();

            this.text = text;
        }

        public function setIcon(icon:Image):void{
            if (_icon){
                removeChild(_icon);
            }

            _icon = icon;

            if(_icon){
                addChild(_icon);
                _icon.scaleX = _icon.scaleY = 32 / _icon.height;
                _icon.x = 7;
                _icon.y = 4;

                text = _textField.text;
            }
        }

        public function reposition():void{
            if (!isNaN(_forcedWidth)){
                if (_icon){
                    _textField.width = _forcedWidth - _icon.width - 12;
                } else {
                    _textField.width = _forcedWidth;
                }

                backgroundWidth = _forcedWidth;
            }
        }

        override protected function rollOverEffect():void{
            super.rollOverEffect();
        }

        override protected function onTouch(e:TouchEvent):void{
            super.onTouch(e);
        }

        public function set text(value:String):void{
            if (isNaN(_forcedWidth)){
                _textField.width = MonstroConsts.gameWidth;
                _textField.text = value;

                _textField.width = _textField.textWidth + 12;

                if (_icon){
                    backgroundWidth = _textField.width + _icon.width + 12;
                    _textField.x = _icon.width + 12;
                } else {
                    backgroundWidth = _textField.width;
                    _textField.x = 0;
                }
            } else {
                _textField.text = value;
                if (_icon){
                    _textField.x = _icon.width + 12;
                } else {
                    _textField.x = 0;
                }
                reposition();
            }
        }

		override public function dispose():void{
			_textField.dispose();

            super.dispose();
        }
    }
}
