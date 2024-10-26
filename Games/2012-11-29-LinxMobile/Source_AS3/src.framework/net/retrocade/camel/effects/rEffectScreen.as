package net.retrocade.camel.effects{
    import flash.events.Event;
    import flash.utils.getTimer;
    
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.rDisplay;
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
            
            rDisplay.stage.addEventListener(Event.RESIZE, onResize);
        }
        
        override protected function finish():void{
            rDisplay.stage.removeEventListener(Event.RESIZE, onResize);
            
            rDisplay.removeLayer(layer);
            super.finish();
        } 
        
        protected function onResize(e:Event):void{}
    }
}