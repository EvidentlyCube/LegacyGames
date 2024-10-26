package submuncher.disclaimer {
    import net.retrocade.retrocamel.components.RetrocamelStateBase;
    import net.retrocade.retrocamel.core.RetrocamelCore;
    import net.retrocade.retrocamel.display.flash.RetrocamelGrid9Starling;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.retrocamel.effects.RetrocamelEffectFadeStarling;
    import net.retrocade.retrocamel.locale._;

    import starling.text.TextField;

    import submuncher.core.constants.Gfx;

    import submuncher.core.display.DisplayGroup;
    import submuncher.core.display.SubmuncherTextButton;
    import submuncher.core.display.SubmuncherTextField;
    import submuncher.ingame.StateIngame;
    import submuncher.title.StateTitle;

    public class StateDisclaimer extends RetrocamelStateBase{

        private var _layer:RetrocamelLayerStarling;
        private var _disclaimerHeader:TextField;
        private var _disclaimerBody:SubmuncherTextField;
        private var _confirmButton:SubmuncherTextButton;
        private var _windowBackground:RetrocamelGrid9Starling;
        private var _displayGroup:DisplayGroup;

        override public function create():void {
            initCreateObjects();
            initPositionObjects();

            _layer.add(_windowBackground);
            _layer.add(_disclaimerHeader);
            _layer.add(_disclaimerBody);
            _layer.add(_confirmButton);

            _displayGroup.makeUntouchable();
            RetrocamelEffectFadeStarling.make(_displayGroup).alpha(0, 1).duration(300).callbacks([_displayGroup.makeTouchable]).run();

            super.create();
        }

        private function initCreateObjects():void {
            _layer = new RetrocamelLayerStarling();
            _disclaimerHeader = new SubmuncherTextField(_('disclaimer.header'), 2);
            _disclaimerBody = new SubmuncherTextField(_("disclaimer.body"), 1);
            _confirmButton = new SubmuncherTextButton(_("disclaimer.button.start_game"), startGamePressedHandler);
            _windowBackground = Gfx.createWindowGrid9();
        }

        private function initPositionObjects():void {
            _displayGroup = new DisplayGroup();
            _displayGroup.addElements([_disclaimerHeader, _disclaimerBody, _confirmButton]);
            _displayGroup.alignAllCenter();
            _displayGroup.verticalize(20);
            _windowBackground.wrapAround(_displayGroup);

            _displayGroup.addElement(_windowBackground);
            _displayGroup.alignCenter();
            _displayGroup.alignMiddle();
        }

        override public function destroy():void {
            _layer.dispose();
            _disclaimerHeader.dispose();
            _disclaimerBody.dispose();
            _confirmButton.dispose();
            _windowBackground.dispose();
            _displayGroup.dispose();

            super.destroy();
        }

        override public function update():void {
            super.update();
        }

        override public function resize():void {
            _displayGroup.alignCenter();
            _displayGroup.alignMiddle();
        }

        private function startGamePressedHandler():void{
            _displayGroup.makeUntouchable();
            RetrocamelEffectFadeStarling.make(_displayGroup).alpha(1, 0).duration(300).callback(startGame).run();
        }

        private function startGame():void{
            RetrocamelCore.setState(new StateTitle());
        }
    }
}
