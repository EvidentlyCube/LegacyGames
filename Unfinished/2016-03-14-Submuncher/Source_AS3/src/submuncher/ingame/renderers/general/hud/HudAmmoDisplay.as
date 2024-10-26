package submuncher.ingame.renderers.general.hud {
    import net.retrocade.utils.UtilsNumber;

    import starling.display.Image;
    import starling.display.Sprite;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.GuiNames;

    import S;

    public class HudAmmoDisplay extends Sprite{
        private var _icon:Image;
        private var _digits:HudDigits;

        private var _isVisible:Boolean;

        public function HudAmmoDisplay() {
            _icon = new Image(Gfx.guiAtlas.getTexture(GuiNames.HUD_AMMO));
            _digits = new HudDigits();

            _digits.x = 23;
            _digits.y = 1;
            _isVisible = false;

            addChild(_icon);
            addChild(_digits);
        }

        override public function dispose():void {
            _icon.dispose();
            _digits.dispose();

            super.dispose();
        }

        public function set ammo(value:int):void {
            _digits.text = value.toString();

            _isVisible = value > 0;
        }

        public function update():void {
            var targetY:Number;
            if (_isVisible){
                targetY = S.gameHeight - 8 - height;
            } else {
                targetY = S.gameHeight + 8;
            }

            y = UtilsNumber.approach(y, targetY, 0.2);
        }
    }
}
