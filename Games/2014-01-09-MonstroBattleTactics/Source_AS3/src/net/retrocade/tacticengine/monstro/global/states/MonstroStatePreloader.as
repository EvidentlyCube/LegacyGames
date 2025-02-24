
package net.retrocade.tacticengine.monstro.global.states {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.utils.setTimeout;

    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;

    import net.retrocade.retrocamel.components.RetrocamelStateBase;
    import net.retrocade.retrocamel.display.flash.RetrocamelBitmap;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashSprite;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
    import net.retrocade.retrocamel.locale._;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.Preloader;
    import net.retrocade.utils.UtilsDisplay;

    import starling.display.Image;
    import starling.text.TextField;
    import starling.textures.Texture;

    public class MonstroStatePreloader extends RetrocamelStateBase{
        [Embed(source="/assets/bg/loadingscreen.jpg")] public static const _preloader_class:Class;

        private var _layerStarling:RetrocamelLayerStarling;
        private var _layerFlash:RetrocamelLayerFlashSprite;

        private var _preloaderBitmap:RetrocamelBitmap;
        private var _preloaderBitmapData:BitmapData;
        private var _preloaderStarlingImage:Image;
        private var _starlingText:TextField;
        private var _starlingModal:Image;

        private var _imageAlpha:Number = 0;
        private var _textAlpha :Number = 0;

        private var _isInitialized:Boolean = false;

        private var _isEnding:Boolean = false;

        public function MonstroStatePreloader() {
        }

        override public function create():void {
            _layerFlash = new RetrocamelLayerFlashSprite();

            var bitmap:Bitmap = new _preloader_class;
            _preloaderBitmap = new RetrocamelBitmap(bitmap.bitmapData);
            _preloaderBitmapData = _preloaderBitmap.bitmapData;

            _preloaderBitmap.width = MonstroConsts.gameWidth;
            _preloaderBitmap.height = MonstroConsts.gameHeight;

            _preloaderBitmap.alpha = 0;

            _layerFlash.add(_preloaderBitmap);

            super.create();
        }

        override public function destroy():void {
            _layerFlash.clear();
            _layerStarling.clear();

            _layerFlash.removeLayer();
            _layerStarling.removeLayer();

            _starlingModal.texture.dispose();
            _starlingModal.dispose();
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
            _starlingModal = null;

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
                _starlingModal.alpha = _textAlpha;
                _starlingText.alpha = _textAlpha;
                _starlingModal.alignCenter();
                _starlingModal.alignMiddle();
                _starlingText.alignCenter();
                _starlingText.alignMiddle();

                var INFO:String;

                if (!Preloader.afterLoad){
                    INFO = _("preloader_loading", (Preloader.progress * 100).toFixed(1));
                } else {
                    INFO = _("preloader_loaded");
                }

                _starlingText.text = _("preloader_info", MonstroConsts.versionString, INFO);

            } else {
                _preloaderBitmap.alpha = _imageAlpha;
            }
        }

        private function initStarlingView():void{
            if (RetrocamelStarlingCore.isInitialized){
                var modalWidth:int = MonstroConsts.gameWidth * 6 / 7;
                var modalHeight:int = MonstroConsts.gameHeight *2/ 3;

                _isInitialized = true;

                _layerStarling = new RetrocamelLayerStarling();

                _preloaderStarlingImage = new Image(Texture.fromBitmapData(_preloaderBitmapData));
                _preloaderStarlingImage.alpha = _imageAlpha;
                _preloaderStarlingImage.width = MonstroConsts.gameWidth;
                _preloaderStarlingImage.height = MonstroConsts.gameHeight;


                _starlingText = new TextField(modalWidth, modalHeight, "", MonstroConsts.FONT_EBORACUM_48, 24, 0xFFFFFF);
                _starlingText.alpha = 0;

                _starlingModal = new Image(Texture.fromColor(100, 100, 0xCC000000));
                _starlingModal.width = modalWidth;
                _starlingModal.height = modalHeight;

                _layerStarling.add(_preloaderStarlingImage);
                _layerStarling.add(_starlingModal);
                _layerStarling.add(_starlingText);

                _layerStarling.inputEnabled = true;

                _preloaderBitmap.alpha = 0;

                RetrocamelDisplayManager.flashApplication.addEventListener(MouseEvent.CLICK, onClick);
            }
        }

        private function onClick(e:Event):void{
            if (Preloader.progress >= 1 && Preloader.adsFinished){
                _isEnding = true;
            }
        }

        override public function resize():void {
            super.resize();
            setTimeout(realResize, 50);
        }

        private function realResize():void{
            var modalWidth:int = MonstroConsts.gameWidth * 6 / 7;
            var modalHeight:int = MonstroConsts.gameHeight *2/ 3;

            if (_starlingModal){
                _starlingModal.width = modalWidth;
                _starlingModal.height = modalHeight;
                _starlingModal.alignCenter();
                _starlingModal.alignMiddle();
            }

            if (_starlingText){
                _starlingText.width = modalWidth;
                _starlingText.height = modalHeight;
                _starlingText.alignCenter();
                _starlingText.alignMiddle();
            }

            if (_preloaderStarlingImage){
                UtilsDisplay.calculateScale(_preloaderStarlingImage.realWidth, _preloaderStarlingImage.realHeight, MonstroConsts.gameWidth, MonstroConsts.gameHeight, UtilsDisplay.NO_BORDER);
                _preloaderStarlingImage.scaleX = UtilsDisplay.lastScaleX;
                _preloaderStarlingImage.scaleY = UtilsDisplay.lastScaleY;
                _preloaderStarlingImage.alignCenter();
                _preloaderStarlingImage.alignMiddle();
            }

            if (_preloaderBitmap){
                UtilsDisplay.scaleDisplayObject(_preloaderBitmap, MonstroConsts.gameWidth, MonstroConsts.gameHeight, UtilsDisplay.NO_BORDER);
                _preloaderBitmap.alignCenter();
                _preloaderBitmap.alignMiddle();
            }
        }
    }
}
