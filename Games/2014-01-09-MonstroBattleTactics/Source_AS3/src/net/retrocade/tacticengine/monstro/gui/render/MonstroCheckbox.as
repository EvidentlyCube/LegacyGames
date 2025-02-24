
package net.retrocade.tacticengine.monstro.gui.render {

    import net.retrocade.retrocamel.display.starling.RetrocamelButtonStarling;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;

	import starling.display.Image;
    import starling.text.TextField;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    public class MonstroCheckbox extends RetrocamelButtonStarling implements IDisposable {
        private var _checkboxImage:Image;
        private var _textField:TextField;
        private var _isChecked:Boolean;

        public function MonstroCheckbox(text:String, isChecked:Boolean, callback:Function) {
            super(callback);

            _textField = new TextField(40, 30, "", MonstroConsts.FONT_EBORACUM_48, 20, 0x382010);
            _textField.hAlign = HAlign.CENTER;
            _textField.vAlign = VAlign.CENTER;

            _checkboxImage = new Image(MonstroGfx.getCheckboxEmpty());
            _isChecked = false;

            addChild(_checkboxImage);
            addChild(_textField);

            this.text = text;
            this.isChecked = isChecked;
        }

        override protected function effectDisabled():void {
        }

        override protected function effectEnabled():void {
        }

        override protected function rollOverEffect():void {
        }

        override protected function rollOutEffect():void {
        }

        override protected function clickEffect():void {
			MonstroSfx.playButtonClick();
        }

        override protected function unclickEffect():void {
        }

        override protected function onClicked():void {
            if (canClick()) {
                isChecked = !_isChecked;

                super.onClicked();

            }
        }

        override public function dispose():void {
            super.dispose();

            _textField.dispose();
        }

        public function set text(value:String):void {
            _textField.width = MonstroConsts.gameWidth;
            _textField.text = value;

            _textField.width = _textField.textWidth + 12;

            _textField.x = _checkboxImage.width + 6;
        }

        public function get isChecked():Boolean {
            return _isChecked;
        }

        public function set isChecked(value:Boolean):void {
            if (value != _isChecked) {
                _isChecked = value;

                _checkboxImage.texture = (_isChecked ? MonstroGfx.getCheckboxSelected() : MonstroGfx.getCheckboxEmpty());
                _checkboxImage.readjustSize();
            }

            _checkboxImage.middle = _textField.middle;
            _checkboxImage.center = _textField.x / 2;
        }
    }
}
