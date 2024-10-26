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

    import net.retrocade.camel.global.rDisplay;

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

    public class MonstroStatePreloader extends rState{
        [Embed(source="/../assets/gfx/bg/preloader.jpg")] public static const _preloader_class:Class;

        private var _layerStarling:rLayerStarling;
        private var _layerFlash:rLayerFlashSprite;

        private var _preloaderBitmap:Bitmap;
        private var _preloaderBitmapData:BitmapData;
        private var _preloaderStarlingImage:Image;
        private var _starlingText:TextField;

        private var _imageAlpha:Number = 0;
        private var _textAlpha :Number = 0;

        private var _isInitialized:Boolean = false;

        private var _isEnding:Boolean = false;

        public function MonstroStatePreloader() {

        }

        override public function create():void {
            _layerFlash = new rLayerFlashSprite();

            _preloaderBitmap = new _preloader_class;
            _preloaderBitmapData = _preloaderBitmap.bitmapData;

            _preloaderBitmap.alpha = 0;

            _layerFlash.add(_preloaderBitmap);

            super.create();
        }

        override public function destroy():void {
            _layerFlash.clear();
            _layerStarling.clear();

            _layerFlash.removeLayer();
            _layerStarling.removeLayer();

            _preloaderBitmapData.dispose();
            _starlingText.dispose();
            _preloaderStarlingImage.texture.dispose();
            _preloaderStarlingImage.dispose();

            _layerFlash = null;
            _layerStarling = null;
            _preloaderBitmapData = null;
            _starlingText = null;
            _preloaderStarlingImage = null;
            _preloaderBitmap = null;

            super.destroy();
        }

        override public function update():void {
            if (_isEnding){
                _imageAlpha = Math.max(0, _imageAlpha - 0.075);
                _textAlpha = Math.max(0, _textAlpha - 0.075);

                if (_imageAlpha == 0){
                    dispatchEvent(new Event(Event.COMPLETE));
                }
            }

            if (!_isInitialized){
                initStarlingView();
            } else if (!_isEnding){
                _textAlpha = Math.min(1, _textAlpha + 0.03);
            }

            if (!_isEnding){
                _imageAlpha = Math.min(1, _imageAlpha + 0.01);
            }

            if (_isInitialized){
                _preloaderStarlingImage.alpha = _imageAlpha;
                _starlingText.alpha = _textAlpha;
                _starlingText.y = 400;

                var INFO:String = "\n\nThis is not a full game!\nTactic DROD v." + Monstro.versionString;

                if (Preloader.progress < 1){
                    _starlingText.text = "Loading " + (Preloader.progress * 100).toFixed(1) + "%" + INFO;
                } else {
                    _starlingText.text = "Click to start." + INFO;
                }

            } else {
                _preloaderBitmap.alpha = _imageAlpha;
            }
        }

        private function initStarlingView():void{
            if (rStarling.isInitialized){
                _isInitialized = true;

                _layerStarling = new rLayerStarling();

                _preloaderStarlingImage = new Image(Texture.fromBitmapData(_preloaderBitmapData));
                _preloaderStarlingImage.alpha = _imageAlpha;

                _starlingText = new TextField(800, 120, "", Monstro.FONT_MEDIUM, -1, 0xFFFFFF);
                _starlingText.alpha = 0;

                _layerStarling.add(_preloaderStarlingImage);
                _layerStarling.add(_starlingText);

                _layerStarling.inputEnabled = true;

                _preloaderBitmap.alpha = 0;

                rDisplay.flashApplication.addEventListener(MouseEvent.CLICK, onClick);

            }
        }

        private function onClick(e:Event):void{
            if (Preloader.progress >= 1){
                _isEnding = true;
            }
        }
    }
}
