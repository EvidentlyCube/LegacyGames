/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 24.02.13
 * Time: 14:09
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.render {
    import net.retrocade.tacticengine.core.IDestruct;
    import net.retrocade.tacticengine.monstro.core.Monstro;

    import starling.display.Image;

    import starling.events.TouchEvent;

    import starling.text.TextField;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    public class MonstroTextButton extends MonstroButton implements IDestruct{
        private var _textField:TextField;
        private var _forcedWidth:Number = NaN;
        private var _icon:Image;

        public function set forcedWidth(value:Number):void{
            _forcedWidth = value;

            reposition();
        }


        public function MonstroTextButton(text:String, callback:Function, forcedWidth:Number = NaN) {
            super(callback);

            _textField = new TextField(40, 30, "", Monstro.FONT_MEDIUM, -1, 0xFFFFFF);
            _textField.hAlign = HAlign.CENTER;
            _textField.vAlign = VAlign.CENTER;
            _textField.y = -2;

            _forcedWidth = forcedWidth;

            backgroundHeight = 32;

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
                _textField.width = Monstro.gameWidth;
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
                }
                reposition();
            }
        }

        public function destruct():void{
            destroy();

            _textField.dispose();
        }
    }
}
