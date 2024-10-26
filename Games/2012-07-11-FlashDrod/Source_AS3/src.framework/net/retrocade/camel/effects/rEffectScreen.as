package net.retrocade.camel.effects{
    import flash.utils.getTimer;
    
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.layers.rLayerSprite;
    import net.retrocade.camel.objects.rObject;

    public class rEffectScreen extends rEffect{
        /**
         * Instance of the layer used for this effect
         */
        public var layer   :rLayerSprite;
        
        public function rEffectScreen(duration:int, callback:Function){
            super(duration, callback);
            
            layer = new rLayerSprite();
        }
        
        override protected function finish():void{
            rDisplay.removeLayer(layer);
            super.finish();
        } 
    }
}