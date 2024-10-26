package submuncher.ingame.renderers.general.hud {
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;

    import starling.display.Image;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.GuiNames;
    import submuncher.core.constants.LockColor;
    import submuncher.ingame.core.Game;
    import submuncher.ingame.core.LevelScore;
    import submuncher.ingame.core.Utils;

    public class HudLayer extends RetrocamelLayerStarling {
        private var _extGame:Game;

        private var _timeIcon:Image;
        private var _timeDigits:HudDigits;

        private var _ammoDisplay:HudAmmoDisplay;
        private var _keys:Vector.<HudKeyDisplay>;

        public function HudLayer(game:Game) {
            _extGame = game;
            _keys = new Vector.<HudKeyDisplay>(LockColor.count);

            initCreateObjects();
            initSetObjectProperties();
            initSetObjectPositions();
            initAddObjects();
        }

        override public function dispose():void {
            for each (var keyDisplay:HudKeyDisplay in _keys) {
                keyDisplay.dispose();
            }

            _timeIcon.dispose();
            _timeDigits.dispose();
            super.dispose();
        }

        private function initCreateObjects():void {
            _timeIcon = new Image(Gfx.guiAtlas.getTexture(GuiNames.HUD_TIME));
            _timeDigits = new HudDigits();
            _ammoDisplay = new HudAmmoDisplay();

            for each (var color:LockColor in LockColor.getAllOriginal()) {
                _keys[color.id] = new HudKeyDisplay(color);
            }
        }

        private function initSetObjectProperties():void {
            _timeDigits.text = Utils.timeAsString(time, _extGame.save.displayTimeAsFrames);
        }

        private function initSetObjectPositions():void {
            var belowScreenBottom:uint = S.gameHeight + 8;
            _timeIcon.x = 8;
            _timeIcon.y = 8;

            _timeDigits.x = 24;
            _timeDigits.y = 9;

            _ammoDisplay.x = S.gameWidth - 48;
            _ammoDisplay.y = belowScreenBottom;

            for (var i:int = 0; i < _keys.length; i++) {
                var keyDisplay:HudKeyDisplay = _keys[i];
                keyDisplay.x = 8 + 32 * i;
                keyDisplay.y = belowScreenBottom;
            }
        }

        private function initAddObjects():void {
            add(_timeIcon);
            add(_timeDigits);
            add(_ammoDisplay);

            for each (var keyDisplay:HudKeyDisplay in _keys) {
                add(keyDisplay);
            }
        }

        public function update():void {
            _timeDigits.text = Utils.timeAsString(time, _extGame.save.displayTimeAsFrames);

            _ammoDisplay.ammo = score.ammo;
            _ammoDisplay.update();

            for each (var color:LockColor in LockColor.getAllOriginal()) {
                _keys[color.id].numberOfKeys = score.getKeys(color);
                _keys[color.id].update();
            }
        }


        public function get score():LevelScore {
            return _extGame.currentLevel.score;
        }

        public function get time():int {
            return score.currentTime;
        }

    }
}
