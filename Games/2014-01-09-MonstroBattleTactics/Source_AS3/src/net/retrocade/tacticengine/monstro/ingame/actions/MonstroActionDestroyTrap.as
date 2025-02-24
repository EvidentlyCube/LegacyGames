package net.retrocade.tacticengine.monstro.ingame.actions{
    import net.retrocade.tacticengine.monstro.global.core.MonstroData;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGameplayDefinition;
    import net.retrocade.tacticengine.monstro.global.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;

    import starling.display.DisplayObject;


    public class MonstroActionDestroyTrap extends MonstroAction{
        [Inject]
        public var gameplayDefinition:MonstroGameplayDefinition;

        private var _trapGraphic:DisplayObject;
        private var _trap:IMonstroTrap;
        private var _started:Boolean = false;

        public function MonstroActionDestroyTrap(){
            super(null);
        }

        public function init(trapGraphic:DisplayObject, trap:IMonstroTrap):void{
            _trapGraphic = trapGraphic;
            _trap = trap;
        }

        override public function update():Boolean{
            if (!_started){
                _started = true;
            }

            _trapGraphic.alpha -= fadeDelta;

            if (_trapGraphic.alpha <= 0){
                _trapGraphic.visible = false;
                return true;
            }

            return false;
        }

        private function get fadeDelta():Number{
            if (SmartTouch.isRightButtonDown){
                return 1;
            } else {
                return gameplayDefinition.gameSpeed;
            }
        }

        override public function dispose():void{
            super.dispose();
            _trapGraphic = null;
            _trap = null;
        }
    }
}