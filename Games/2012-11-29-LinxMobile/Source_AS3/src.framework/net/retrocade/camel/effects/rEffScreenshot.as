package net.retrocade.camel.effects{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.filters.BevelFilter;

    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rGroup;
    import net.retrocade.camel.global.retrocamel_int;
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

            _screenshotData = new BitmapData(rCore.settings.gameWidth, rCore.settings.gameHeight);
            _screenshotData.draw(rDisplay._application);

            _screenshot = new Bitmap(_screenshotData);

            layer.add(_screenshot);
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