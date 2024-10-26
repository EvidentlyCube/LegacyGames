package submuncher.levelSelection {
    import net.retrocade.retrocamel.components.RetrocamelStateBase;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.retrocamel.effects.RetrocamelEffectFadeStarling;

    import starling.display.Image;

    import submuncher.core.constants.Gfx;

    public class StateLevelSelection extends RetrocamelStateBase {

        private var _layer:RetrocamelLayerStarling;
        private var _background:Image;

        override public function create():void {
            initCreateObjects();

            _layer.add(_background);

            RetrocamelEffectFadeStarling.make(_background).alpha(0, 1).duration(300).run();

            resize();
        }

        private function initCreateObjects():void {
            _layer = new RetrocamelLayerStarling();
            _background = new Image(Gfx.levelSelectionMap);
        }


        override public function destroy():void {
            _layer.dispose();
            _background.dispose();

            super.destroy();
        }

        override public function update():void {
            super.update();
        }

        override public function resize():void {
        }
    }
}
