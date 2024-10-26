/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 24.02.13
 * Time: 14:09
 * To change this template use File | Settings | File Templates.
 */
package submuncher.core.display {
    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;

    import starling.events.TouchEvent;

    import starling.utils.HAlign;
    import starling.utils.VAlign;

    import S;

    public class SubmuncherTextButton extends SubmuncherButton{
        private var _textField:SubmuncherTextField;
        private var _forcedWidth:Number = NaN;

        public function set forcedWidth(value:Number):void{
            _forcedWidth = value;

            reposition();
        }

        public function SubmuncherTextButton(text:String, callback:Function, forcedWidth:Number = NaN) {
            super(callback);

            _textField = new SubmuncherTextField("", 1, 0xFFFFFF, 100, 18, S.FONT_OLD_SHADOW);
            _textField.disableAutoSize();
            _textField.hAlign = HAlign.CENTER;
            _textField.vAlign = VAlign.CENTER;

            _forcedWidth = forcedWidth;

            backgroundHeight = 20;

            addChild(_textField);

            reposition();

            this.text = text;
        }


        public function reposition():void{
            if (!isNaN(_forcedWidth)){
                _textField.width = _forcedWidth;

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
                _textField.width = RetrocamelDisplayManager.applicationWidth;
                _textField.text = value;

                _textField.width = _textField.textWidth + 12;

                backgroundWidth = _textField.width;
                _textField.x = 0;
            } else {
                _textField.text = value;
                _textField.x = 0;
                reposition();
            }
        }

        override public function dispose():void{
            _textField.dispose();

            super.dispose();
        }
    }
}
