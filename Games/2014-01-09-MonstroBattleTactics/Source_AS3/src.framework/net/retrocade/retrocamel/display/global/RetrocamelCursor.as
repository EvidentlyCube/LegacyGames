


package net.retrocade.retrocamel.display.global {

    import flash.ui.Mouse;

    import net.retrocade.retrocamel.core.RetrocamelInputManager;

    import net.retrocade.retrocamel.core.retrocamel_int;
    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;

    import starling.display.Image;
    import starling.textures.Texture;

    use namespace retrocamel_int;

    public class RetrocamelCursor {
        private static var _isStartlingCursorEnabled:Boolean = false;
        private static var _cursorStarling:Image;
        private static var _cursorStarlingTexture:Texture;
        private static var _cursorOffsetX:int;
        private static var _cursorOffsetY:int;
        private static var _isMouseHidden:Boolean = false;

        public static function get isMouseHidden():Boolean {
            return _isMouseHidden;
        }

        public static function set isMouseHidden(value:Boolean):void {
            if (value != _isMouseHidden) {
                if (value) {
                    Mouse.hide();
                } else {
                    Mouse.show();
                }

                _isMouseHidden = value;
            }
        }

        public static function setCursorTexture(texture:Texture, offsetX:int, offsetY:int):void {
            _cursorOffsetX = offsetX;
            _cursorOffsetY = offsetY;

            if (_isStartlingCursorEnabled) {
                setStarlingCursor(texture);
            }
        }

        public static function update():void {
            isMouseHidden = (_cursorStarling != null);

            if (_cursorStarling) {
                _cursorStarling.moveToFront();

                _cursorStarling.x = RetrocamelInputManager.mouseX + _cursorOffsetX;
                _cursorStarling.y = RetrocamelInputManager.mouseY + _cursorOffsetY;
            }
        }

        private static function setStarlingCursor(texture:Texture):void {
            if (_cursorStarlingTexture == texture) {
                return;
            }

            if (_cursorStarling) {
                _cursorStarlingTexture.dispose();
                _cursorStarlingTexture = null;

                if (!texture) {
                    RetrocamelStarlingCore.starlingRoot.removeChild(_cursorStarling);

                    _cursorStarling.dispose();
                    _cursorStarling = null;
                    return;
                }
            }

            if (texture) {
                _cursorStarlingTexture = texture;

                if (!_cursorStarling) {
                    _cursorStarling = new Image(_cursorStarlingTexture);
                    _cursorStarling.touchable = false;
                    RetrocamelStarlingCore.starlingRoot.addChild(_cursorStarling);
                } else {
                    _cursorStarling.texture = _cursorStarlingTexture;
                    _cursorStarling.readjustSize();
                }
            }
        }

        retrocamel_int static function initializeStarling():void {
            _isStartlingCursorEnabled = true;
        }
    }
}
