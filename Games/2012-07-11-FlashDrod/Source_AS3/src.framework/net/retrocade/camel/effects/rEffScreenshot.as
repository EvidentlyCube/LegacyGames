package net.retrocade.camel.effects{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.filters.BevelFilter;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.retrocamel_int;
    import net.retrocade.camel.objects.rObject;

    use namespace retrocamel_int;

    public class rEffScreenshot extends rEffectScreen{
        private var _screenshot:Bitmap;
        private var _screenshotData:BitmapData;

        public function get screenshot():Bitmap {
            return screenshot;
        }

        public function rEffScreenshot(duration:uint = uint.MAX_VALUE, callback:Function = null){
            super(duration, callback);

            _screenshotData = new BitmapData(rCore._settings.SIZE_GAME_WIDTH, rCore._settings.SIZE_GAME_HEIGHT);
            _screenshotData.draw(rDisplay._application);

            _screenshot = new Bitmap(_screenshotData);

            layer.add2(_screenshot);
        }

        public function moveForward():void {
            rDisplay.removeLayer(layer);
            rDisplay.addLayer(layer);
        }

        /**
         * Stops and removes this effect
         */
        public function stop():void{
            this.finish();
        }
    }
}