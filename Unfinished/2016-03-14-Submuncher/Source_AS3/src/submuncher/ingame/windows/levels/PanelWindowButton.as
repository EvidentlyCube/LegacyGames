package submuncher.ingame.windows.levels {
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;

    public class PanelWindowButton extends Sprite{
        private var _extButtonLeft:PanelWindowButton;
        private var _extButtonRight:PanelWindowButton;
        private var _extButtonUp:PanelWindowButton;
        private var _extButtonDown:PanelWindowButton;

        public var data:Object;

        private var _idleButton:Image;
        private var _selectedButton:Image;
        private var _isSelected:Boolean;

        public function PanelWindowButton(idleTexture:Texture, selectedTexture:Texture, isSelected:Boolean = false) {
            _idleButton = new Image(idleTexture);
            _selectedButton = new Image(selectedTexture);

            addChild(_idleButton);
            addChild(_selectedButton);

            _isSelected = isSelected;
            _idleButton.alpha = isSelected ? 0 : 1;
            _selectedButton.alpha = isSelected ? 1 : 0;
        }

        override public function dispose():void {
            super.dispose();

            _idleButton.dispose();
            _selectedButton.dispose();

            _extButtonLeft = null;
            _extButtonRight = null;
            _extButtonUp = null;
            _extButtonDown = null;
            _idleButton = null;
            _selectedButton = null;

            data = null;
        }

        public function update():void {
            if (_isSelected){
                _selectedButton.alpha += 0.15;
                _idleButton.alpha = 1 - _selectedButton.alpha;
            } else {
                _idleButton.alpha += 0.15;
                _selectedButton.alpha = 1 - _idleButton.alpha;
            }
        }

        public function set isSelected(value:Boolean):void {
            _isSelected = value;
        }

        public function forceRedraw():void {
            _idleButton.alpha = _isSelected ? 0 : 1;
            _selectedButton.alpha = _isSelected ? 1 : 0;
        }

        public function setTextures(idleTexture:Texture, selectedTexture:Texture):void {
            _idleButton.texture = idleTexture;
            _selectedButton.texture = selectedTexture;
        }

        override public function clone():* {
            var c:PanelWindowButton = new PanelWindowButton(_idleButton.texture, _selectedButton.texture, _isSelected);
            cloneSetProperties(c, false);

            return c;
        }

        override protected function cloneSetProperties(clone:*, cloneChildren:Boolean):void {
            super.cloneSetProperties(clone, cloneChildren);

            var c:PanelWindowButton = clone as PanelWindowButton;
            c._extButtonDown = _extButtonDown;
            c._extButtonLeft = _extButtonLeft;
            c._extButtonRight = _extButtonRight;
            c._extButtonUp = _extButtonUp;
            c.data = data;
        }


        public function get buttonLeft():PanelWindowButton {
            return _extButtonLeft;
        }

        public function set buttonLeft(value:PanelWindowButton):void {
            _extButtonLeft = value;
        }

        public function get buttonRight():PanelWindowButton {
            return _extButtonRight;
        }

        public function set buttonRight(value:PanelWindowButton):void {
            _extButtonRight = value;
        }

        public function get buttonUp():PanelWindowButton {
            return _extButtonUp;
        }

        public function set buttonUp(value:PanelWindowButton):void {
            _extButtonUp = value;
        }

        public function get buttonDown():PanelWindowButton {
            return _extButtonDown;
        }

        public function set buttonDown(value:PanelWindowButton):void {
            _extButtonDown = value;
        }
    }
}
