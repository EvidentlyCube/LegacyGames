/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 16.02.13
 * Time: 22:28
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.actions {
    import net.retrocade.camel.layers.rLayerStarling;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTap;
    import net.retrocade.utils.UNumber;

    import starling.display.Image;

    import starling.text.TextField;

    public class MonstroActionTurnPhase extends MonstroAction{
        private var _layer:rLayerStarling;
        private var _phaseImage:Image;
        private var _bg:Image;

        private var _fadeIn:Boolean = true;
        private var _waiter:int = 0;

        private var _isPlayerTurn:Boolean;

        public function MonstroActionTurnPhase(isPlayerTurn:Boolean) {
            super(null);

            _isPlayerTurn = isPlayerTurn;
        }

        override public function update():Boolean{
            if (!_layer){
                init();
            }

            _phaseImage.x = (Monstro.gameWidth - _phaseImage.width) / 2;
            _phaseImage.y = (Monstro.gameHeight - _phaseImage.height) / 2;

            _bg.y = (Monstro.gameHeight - _bg.height) / 2;

            if (_waiter > 0){
                _waiter--;
            } else if (_fadeIn){
                _bg.alpha = UNumber.approach(_bg.alpha, 0.7, 0.25, 0.01);

                if (_bg.alpha >= 0.3){
                    _phaseImage.alpha = UNumber.approach(_phaseImage.alpha, 1, 0.25, 0.01);

                    if (_phaseImage.alpha == 1){
                        _fadeIn = false;
                        _waiter = 60;
                    }
                }
            } else {
                _bg.alpha = UNumber.approach(_bg.alpha, 0, 0.4, 0.01);
                _phaseImage.alpha = UNumber.approach(_phaseImage.alpha, 0, 0.4, 0.01);

            }

            return _bg.alpha == 0 && _phaseImage.alpha == 0 ;
        }

        private function init():void{
            _layer = new rLayerStarling();

            _phaseImage = _isPlayerTurn ? MonstroGfx.getPlayerTurn() : MonstroGfx.getEnemyTurn();
            _bg = MonstroGfx.getPhaseBackground();

            _bg.width = Monstro.gameWidth;
            _bg.height = _phaseImage.height + 120;

            _phaseImage.alpha = 0;
            _bg.alpha = 0;

            _layer.add(_bg);
            _layer.add(_phaseImage);

            Eventer.listen(MonstroEventTap.NAME, onTap);
        }

        private function onTap():void{
            if (_bg.alpha > 0.05){
                _waiter = 0;
                _fadeIn = false;
            }
        }

        override public function destruct():void{
            Eventer.release(MonstroEventTap.NAME, onTap);

            _layer.remove(_phaseImage);
            _layer.remove(_bg);

            _layer.removeLayer();

            _phaseImage = null;
            _bg = null;
            _layer = null;

            super.destruct();
        }
    }
}
