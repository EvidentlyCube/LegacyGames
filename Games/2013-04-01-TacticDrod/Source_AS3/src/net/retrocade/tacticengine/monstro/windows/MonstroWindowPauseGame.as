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
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTransition;
    import net.retrocade.tacticengine.monstro.render.MonstroDisplayGroup;
    import net.retrocade.tacticengine.monstro.render.MonstroGrid9;
    import net.retrocade.tacticengine.monstro.render.MonstroTextButton;

    import starling.display.Image;

    import starling.text.TextField;
    import starling.textures.TextureSmoothing;

    public class MonstroWindowPauseGame extends rWindowStarling{
        private static const BUTTON_WIDTH:Number = 250;
        private static function get EDGE_SIZE():Number{
            return Monstro.hudSpacer * 4;
        }
        private static var _instance:MonstroWindowPauseGame;

        public static function show():void{
            if (!_instance){
                _instance = new MonstroWindowPauseGame();
            }

            _instance.show();
        }

        private var _modal:Image;
        private var _background:MonstroGrid9;
        private var _header:TextField;
        private var _continue:MonstroTextButton;
        private var _restart:MonstroTextButton;
        private var _options:MonstroTextButton;
        private var _returnToMenu:MonstroTextButton;
        private var _buttonGroup:MonstroDisplayGroup;


        public function MonstroWindowPauseGame() {
            _blockUnder = true;
            _pauseGame = true;

            _modal = MonstroGfx.getBlackColor();
            _background = MonstroGfx.getGrid9WindowHeader();
            _header = new TextField(32, 32, "Game Paused:", Monstro.FONT_MEDIUM, -1, 0xFFFFFF);
            _continue = new MonstroTextButton("Continue Playing", onClose, BUTTON_WIDTH);
            _restart = new MonstroTextButton("Restart Mission", onRestart, BUTTON_WIDTH);
            _options = new MonstroTextButton("Options", onOptions, BUTTON_WIDTH);
            _returnToMenu = new MonstroTextButton("Return to Main Menu", onQuit, BUTTON_WIDTH);
            _buttonGroup = new MonstroDisplayGroup();

            _modal.smoothing = TextureSmoothing.NONE;
            _modal.alpha = 0.3;

            _buttonGroup.addElement(_background);
            _buttonGroup.addElement(_header);
            _buttonGroup.addElement(_continue);
            _buttonGroup.addElement(_restart);
            _buttonGroup.addElement(_options);
            _buttonGroup.addElement(_returnToMenu);

            _continue.x = EDGE_SIZE;
            _restart.x = EDGE_SIZE;
            _options.x = EDGE_SIZE;
            _returnToMenu.x = EDGE_SIZE;

            _continue.y = 32 + EDGE_SIZE;
            _restart.y = _continue.bottom + Monstro.hudSpacer;
            _options.y = _restart.bottom + Monstro.hudSpacer;
            _returnToMenu.y = _options.bottom + Monstro.hudSpacer;

            _background.width = _continue.right + EDGE_SIZE;
            _background.height = _returnToMenu.bottom + EDGE_SIZE;
            _header.width = _background.width;

            addChild(_modal);
            addChild(_background);
            addChild(_header);
            addChild(_continue);
            addChild(_restart);
            addChild(_options);
            addChild(_returnToMenu);

            resize();
        }

        override public function resize():void{
            _modal.width = Monstro.gameWidth;
            _modal.height = Monstro.gameHeight;

            _buttonGroup.alignCenter();
            _buttonGroup.alignMiddle();
        }

        private function onClose():void{
            hide();
        }

        private function onRestart():void{
            onClose();
            new MonstroEventTransition(MonstroEventTransition.TRANSITION_RESTART_MISSION);
        }

        private function onOptions():void{
            MonstroWindowOptions.show();
        }

        private function onQuit():void{
            onClose();
            new MonstroEventTransition(MonstroEventTransition.TRANSITION_RETURN_TO_MENU);
        }
    }
}
