package net.retrocade.tacticengine.monstro.core{
    import net.retrocade.camel.global.rWindows;
    import net.retrocade.camel.interfaces.rIStarlingRoot;
    import net.retrocade.camel.layers.rLayerStarling;
    import net.retrocade.tacticengine.monstro.data.MonstroFont24;

    import starling.display.Sprite;
    import starling.text.TextField;

    public class MonstroRoot extends Sprite implements rIStarlingRoot{
        private var _windowLayer:rLayerStarling;

        public function MonstroRoot(){}

        public function init():void{
            TextField.registerBitmapFont(new MonstroFont24(), Monstro.FONT_MEDIUM);

            _windowLayer = new rLayerStarling();

            rWindows.hookStarlingLayer(_windowLayer);
        }
    }
}