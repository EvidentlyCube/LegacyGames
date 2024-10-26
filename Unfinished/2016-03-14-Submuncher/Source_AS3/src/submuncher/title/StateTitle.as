package submuncher.title {
    // import flash.desktop.NativeApplication;

    import net.retrocade.retrocamel.components.RetrocamelStateBase;
    import net.retrocade.retrocamel.core.RetrocamelCore;
    import net.retrocade.retrocamel.display.flash.RetrocamelGrid9Starling;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.retrocamel.effects.RetrocamelEffectFadeStarling;
    import net.retrocade.retrocamel.locale._;

    import starling.display.Image;

    import starling.text.TextField;

    import submuncher.core.constants.Gfx;

    import submuncher.core.display.DisplayGroup;
    import submuncher.core.display.SubmuncherTextButton;
    import submuncher.ingame.StateIngame;

    public class StateTitle extends RetrocamelStateBase{

        private var _layer:RetrocamelLayerStarling;
        private var _header:Image;
        private var _buttonStart:SubmuncherTextButton;
        private var _buttonQuit:SubmuncherTextButton;
        private var _windowBackground:RetrocamelGrid9Starling;
        private var _displayGroup:DisplayGroup;

        override public function create():void {
            initCreateObjects();
            initPositionObjects();

            _layer.add(_windowBackground);
            _layer.add(_header);
            _layer.add(_buttonStart);
            _layer.add(_buttonQuit);

            _displayGroup.makeUntouchable();
            RetrocamelEffectFadeStarling.make(_displayGroup).alpha(0, 1).duration(300).callbacks([_displayGroup.makeTouchable]).run();
            RetrocamelEffectFadeStarling.make(_header).alpha(0, 1).duration(300).run();

            resize();
        }

        private function initCreateObjects():void {
            _layer = new RetrocamelLayerStarling();
            _header = new Image(Gfx.guiAtlas.getTexture('title'));
            _buttonStart = new SubmuncherTextButton(_("title.button.start_game"), startGamePressedHandler);
            _buttonQuit = new SubmuncherTextButton(_("title.button.quit"), quitGamePressedHandler);
            _windowBackground = Gfx.createWindowGrid9();
        }

        private function initPositionObjects():void {
            _displayGroup = new DisplayGroup();
            _displayGroup.addElements([_buttonStart, _buttonQuit]);
            _displayGroup.alignAllCenter();
            _displayGroup.verticalize(20);
            _windowBackground.wrapAround(_displayGroup);

            _displayGroup.addElement(_windowBackground);
            _displayGroup.alignCenter();
            _displayGroup.alignMiddle();
        }

        override public function destroy():void {
            _layer.dispose();
            _header.dispose();
            _buttonStart.dispose();
            _buttonQuit.dispose();
            _windowBackground.dispose();
            _displayGroup.dispose();

            super.destroy();
        }

        override public function update():void {
            super.update();
        }

        override public function resize():void {
            _header.alignCenter();
            _header.middle = _displayGroup.y / 2;
            _displayGroup.alignCenter();
            _displayGroup.alignMiddle();
        }

        private function startGamePressedHandler():void{
            _displayGroup.makeUntouchable();
            RetrocamelEffectFadeStarling.make(_displayGroup).alpha(1, 0).duration(300).callback(startGame).run();
            RetrocamelEffectFadeStarling.make(_header).alpha(1, 0).duration(300).run();
        }

        private function quitGamePressedHandler():void{
            _displayGroup.makeUntouchable();
            RetrocamelEffectFadeStarling.make(_displayGroup).alpha(1, 0).duration(300).callback(quitGame).run();
            RetrocamelEffectFadeStarling.make(_header).alpha(1, 0).duration(300).run();
        }

        private function startGame():void{
            RetrocamelCore.setState(new StateIngame());
        }
        private function quitGame():void{
            // NativeApplication.nativeApplication.exit();
        }
    }
}
