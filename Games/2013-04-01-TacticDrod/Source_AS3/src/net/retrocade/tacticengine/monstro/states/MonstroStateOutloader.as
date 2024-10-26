/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 30.03.13
 * Time: 20:57
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.states {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rGfx;

    import net.retrocade.camel.global.rState;
    import net.retrocade.camel.layers.rLayerFlashSprite;
    import net.retrocade.camel.layers.rLayerStarling;
    import net.retrocade.starling.rStarling;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.utils.Rand;

    import starling.display.Image;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;
    import starling.textures.Texture;

    public class MonstroStateOutloader extends rState{
        private var _layerStarling:rLayerStarling;

        private var _preloaderStarlingImage:Image;
        private var _starlingText:TextField;

        public function MonstroStateOutloader() {

        }

        override public function create():void {
            _layerStarling = new rLayerStarling();

            _preloaderStarlingImage = new Image(Texture.fromBitmapData(rGfx.getBD(MonstroStatePreloader._preloader_class)));
            _preloaderStarlingImage.alpha = 0;

            _starlingText = new TextField(800, 60, "Just kidding, it wasn't The Second Sky. Hope you liked it though!\nClick anywhere to be taken to some real TSS goodies!", Monstro.FONT_MEDIUM, -1, 0xFFFFFF);
            _starlingText.alpha = 0;
            _starlingText.y = 400;

            _layerStarling.add(_preloaderStarlingImage);
            _layerStarling.add(_starlingText);

            _starlingText.touchable = false;
            _layerStarling.inputEnabled = true;

            _preloaderStarlingImage.addEventListener(TouchEvent.TOUCH, onClick);

            super.create();
        }

        override public function update():void {
            _preloaderStarlingImage.alpha = _starlingText.alpha = Math.min(1, _starlingText.alpha += 0.01);
        }

        private function onClick(e:TouchEvent):void{
            if (e.getTouch(_preloaderStarlingImage, TouchPhase.ENDED) && _starlingText.alpha > 0.25){
                navigateToURL(new URLRequest("http://forum.caravelgames.com/tsslp.php"), "_self");
            }
        }
    }
}
