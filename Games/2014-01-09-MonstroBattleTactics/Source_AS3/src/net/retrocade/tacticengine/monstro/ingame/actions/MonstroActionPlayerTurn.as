
package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTap;
    import net.retrocade.utils.UtilsNumber;

    import starling.display.Image;

    import starling.text.TextField;

    public class MonstroActionPlayerTurn extends MonstroAction{
        private var _layer:RetrocamelLayerStarling;
        private var _text:Image;
        private var _bg:Image;

        private var _fadeIn:Boolean = true;
        private var _waiter:int = 0;

        private var _isPlayerTurn:Boolean;

        public function MonstroActionPlayerTurn(isPlayerTurn:Boolean) {
            super(null);

            _isPlayerTurn = isPlayerTurn;
        }

        override public function update():Boolean{
            if (!_layer){
                init();
            }

            _text.x = (MonstroConsts.gameWidth - _text.width) / 2;
            _text.y = (MonstroConsts.gameHeight - _text.height) / 2;

            _bg.y = (MonstroConsts.gameHeight - _bg.height) / 2;



            if (_waiter > 0){
                _waiter -= 1;
            } else if (_fadeIn){
                _bg.alpha = UtilsNumber.approach(_bg.alpha, 0.25, 0.12, 0.01);

                if (_bg.alpha == 0.25){
                    _text.alpha = UtilsNumber.approach(_text.alpha, 1, 0.12, 0.01);

                    if (_text.alpha == 1){
                        _fadeIn = false;
                        _waiter = 60;
                    }
                }
            } else {
                _bg.alpha = UtilsNumber.approach(_bg.alpha, 0, 0.12, 0.01);
                _text.alpha = UtilsNumber.approach(_text.alpha, 0, 0.12, 0.01);

            }

            return _bg.alpha == 0 && _text.alpha == 0 ;
        }

        private function init():void{
            _layer = new RetrocamelLayerStarling();

            _text = _isPlayerTurn ? MonstroGfx.getHumanTurn() : MonstroGfx.getMonsterTurn();
            _bg = MonstroGfx.getBlackColor();

            _bg.width = MonstroConsts.gameWidth;
            _bg.height = _text.height + 60;

            _text.alpha = 0;
            _bg.alpha = 0;

            _layer.add(_bg);
            _layer.add(_text);

            Eventer.listen(MonstroEventTap.NAME, onTap, this);
        }

		override public function dispose():void{
			Eventer.releaseContext(this);

			_layer.remove(_text);
			_layer.remove(_bg);

			_layer.removeLayer();

			_text = null;
			_bg = null;
			_layer = null;

			super.dispose();
		}

        private function onTap():void{
            if (_bg.alpha > 0.05){
                _waiter = 0;
                _fadeIn = false;
            }
        }


        override public function get canHaveMultipleInstances():Boolean {
            return false;
        }
    }
}
