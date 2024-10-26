/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 03.03.13
 * Time: 12:41
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.windows {
    import net.retrocade.camel.objects.rWindowStarling;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.events.MonstroEventLoadLevel;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTransition;
    import net.retrocade.tacticengine.monstro.render.MonstroTextButton;
    import net.retrocade.utils.UNumber;

    import starling.display.DisplayObject;

    public class MonstroWindowMissionFinished extends rWindowStarling{
        private static const BUTTON_WIDTH:int = 250;

        private static var _instance:MonstroWindowMissionFinished;

        public static function show(isVictory:Boolean, hookToBottom:DisplayObject, onClose:Function):void{
            if (!_instance){
                _instance = new MonstroWindowMissionFinished();
            }

            _instance.setVictory(isVictory);
            _instance.setHookedObject(hookToBottom);
            _instance.setCallback(onClose);
            _instance.show();
        }



        private var _restart:MonstroTextButton;
        private var _playNext:MonstroTextButton;
        private var _returnToMenu:MonstroTextButton;

        private var _isVictory:Boolean;
        private var _hookedTo:DisplayObject;
        private var _onCloseCallback:Function;

        private var _fadeOut:Boolean = false;

        private var _transitionToUse:int;

        public function MonstroWindowMissionFinished() {
            _restart = new MonstroTextButton("Restart Mission", onRestart, BUTTON_WIDTH);
            _playNext = new MonstroTextButton("Play Next Mission", onPlayNext, BUTTON_WIDTH);
            _returnToMenu = new MonstroTextButton("Return to Menu", onReturnToMenu, BUTTON_WIDTH);

            addChild(_restart);
            addChild(_playNext);
            addChild(_returnToMenu);

            _blockUnder = false;
            _pauseGame = false;
        }

        public function setVictory(isVictory:Boolean):void{
            _isVictory = isVictory;
        }

        public function setHookedObject(object:DisplayObject):void{
            _hookedTo = object;
        }

        public function setCallback(callback:Function):void{
            _onCloseCallback = callback;
        }

        override public function show():void{
            super.show();

            _fadeOut = false;

            alpha = 0;

            resize();
        }

        override public function update():void{
            if (alpha < 1 && !_fadeOut){
                alpha += 0.025;
            } else if (_fadeOut && alpha > 0){
                alpha -= 0.025;
            } else if (_fadeOut && alpha <= 0){
                new MonstroEventTransition(_transitionToUse);
                onClose();
            }
        }

        override public function resize():void{
            _playNext.visible = _isVictory;

            var offset:Number = Monstro.gameWidth / (_isVictory ? 3 : 2);
            _restart.alignCenterParent(0, offset);
            _playNext.alignCenterParent(offset, offset);
            _returnToMenu.alignCenterParent(_isVictory ? offset * 2 : offset, offset);

            y = _hookedTo.bottom + Monstro.hudSpacer | 0;
        }

        override public function hide():void{
            super.hide();
            _hookedTo = null;
        }

        private function onRestart():void{
            _onCloseCallback();

            _transitionToUse = MonstroEventTransition.TRANSITION_RESTART_MISSION;
            _fadeOut = true;
        }

        private function onPlayNext():void{
            new MonstroEventTransition(MonstroEventTransition.TRANSITION_NEXT_MISSION);
            onClose();
        }

        private function onReturnToMenu():void{
            _onCloseCallback();

            _transitionToUse = MonstroEventTransition.TRANSITION_RETURN_TO_MENU;
            _fadeOut = true;
        }

        private function onClose():void{
            hide();
        }
    }
}
