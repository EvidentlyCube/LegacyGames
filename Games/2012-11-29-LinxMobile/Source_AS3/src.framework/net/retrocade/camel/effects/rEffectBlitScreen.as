package net.retrocade.camel.effects{
    import flash.utils.getTimer;
    import net.retrocade.camel.layers.rLayerBlit;

    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.layers.rLayerSprite;
    import net.retrocade.camel.objects.rObject;

    public class rEffectBlitScreen extends rEffect{
        /**
         * Instance of the layer used for this effect
         */
        public var layer   :rLayerBlit;

        public function rEffectBlitScreen(duration:int, callback:Function){
            super(duration, callback);

            layer = new rLayerBlit();
        }

        override protected function finish():void{
            rDisplay.removeLayer(layer);
            super.finish();
        }
    }
}