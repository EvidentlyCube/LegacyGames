/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 30.03.13
 * Time: 20:57
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.states {
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.global.rState;
    import net.retrocade.camel.layers.rLayerStarling;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroLevels;
    import net.retrocade.tacticengine.monstro.events.MonstroEventLoadLevel;
    import net.retrocade.tacticengine.monstro.render.MonstroTextButton;

    import starling.display.Image;
    import starling.text.TextField;
    import starling.textures.Texture;

    public class MonstroStateTitle extends rState {
        private var _layerStarling:rLayerStarling;
        private var _background:Image;

        private var _levelName:TextField;
        private var _buttonNextLevel:MonstroTextButton;
        private var _buttonPlayLevel:MonstroTextButton;

        private var _currentlySelectedLevel:int;

        public function MonstroStateTitle() {

        }

        override public function create():void {
            _layerStarling = new rLayerStarling();

            _background = new Image(Texture.fromBitmapData(rGfx.getBD(MonstroStatePreloader._preloader_class)));
            _levelName = new TextField(400, 80, "", Monstro.FONT_MEDIUM, -1, 0xFFFFFF);
            _buttonNextLevel = new MonstroTextButton(">>>", onNextLevel);
            _buttonPlayLevel = new MonstroTextButton("Play this level", onPlayLevel);


            _levelName.alignCenter();
            _levelName.alignMiddle();

            _buttonPlayLevel.alignCenter();
            _buttonPlayLevel.y = _levelName.bottom + Monstro.hudSpacer;
            _buttonNextLevel.x = _buttonPlayLevel.right + Monstro.hudSpacer;
            _buttonNextLevel.y = _buttonPlayLevel.y;

            _layerStarling.add(_background);
            _layerStarling.add(_levelName);
            _layerStarling.add(_buttonPlayLevel);
            _layerStarling.add(_buttonNextLevel);

            _layerStarling.layer.alpha = 0;

            selectLevel(0);

            super.create();
        }

        override public function destroy():void {
            _layerStarling.clear();

            _layerStarling.removeLayer();

            _background.texture.dispose();
            _background.dispose();

            _layerStarling = null;
            _background = null;

            super.destroy();
        }

        override public function update():void {
            if (_layerStarling.layer.alpha < 1){
                _layerStarling.layer.alpha += 0.0625;
            }
        }

        private function selectLevel(index:int):void{
            _currentlySelectedLevel = index;
            _levelName.text = _currentlySelectedLevel.toString() + ". " + MonstroLevels.getLevelName(index);
        }

        private function onNextLevel():void{
            selectLevel((_currentlySelectedLevel + 1) % MonstroLevels.getLevelCount());
        }

        private function onPlayLevel():void{
            rCore.setState(new MonstroStateIngame(true));
            new MonstroEventLoadLevel(_currentlySelectedLevel);
        }
    }
}
