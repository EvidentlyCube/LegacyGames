/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 24.02.13
 * Time: 14:09
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.render {
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.MobileButton;
    import net.retrocade.tacticengine.core.IDestruct;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.render.MonstroButton;

    import starling.display.Image;
    import starling.display.Sprite;

    import starling.events.TouchEvent;

    import starling.text.TextField;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    public class MonstroCheckbox extends MobileButton implements IDestruct{
        private var _checkboxImage:Image;
        private var _textField:TextField;

        private var _isChecked:Boolean;

        public function MonstroCheckbox(text:String, isChecked:Boolean, callback:Function) {
            super(callback);

            _textField = new TextField(40, 30, "", Monstro.FONT_MEDIUM, -1, 0xFFFFFF);
            _textField.hAlign = HAlign.CENTER;
            _textField.vAlign = VAlign.CENTER;

            _checkboxImage = new Image(MonstroGfx.getCheckboxEmpty());
            _isChecked = false;

            addChild(_checkboxImage);
            addChild(_textField);

            _checkboxImage.alignMiddleParent();

            this.isChecked = isChecked;
            this.text = text;
        }


        override protected function effectDisabled():void{}
        override protected function effectEnabled():void{}
        override protected function rollOverEffect():void{}
        override protected function rollOutEffect():void{}
        override protected function clickEffect():void{}
        override protected function unclickEffect():void{}


        override protected function onClicked():void {
            if (canClick()){
                isChecked = !_isChecked;

                super.onClicked();
            }
        }

        public function set text(value:String):void{
            _textField.width = Monstro.gameWidth;
            _textField.text = value;

            _textField.width = _textField.textWidth + 12;

            _textField.x = _checkboxImage.width + 6;
        }

        public function destruct():void{
            destroy();

            _textField.dispose();
        }

        public function get isChecked():Boolean {
            return _isChecked;
        }

        public function set isChecked(value:Boolean):void {
            if (value != _isChecked){
                _isChecked = value;

                _checkboxImage.texture = (_isChecked ? MonstroGfx.getCheckboxSelected() : MonstroGfx.getCheckboxEmpty());
            }
        }
    }
}
