package net.retrocade.camel.effects{
    import flash.display.DisplayObject;
    import flash.filters.BevelFilter;
    
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.retrocamel_int;
    import net.retrocade.camel.objects.rObject;
    
    use namespace retrocamel_int;
    
    public class rEffSolidScreen extends rEffectScreen{
        public function rEffSolidScreen(color:uint, alpha:Number = 1, callback:Function = null){
            super(9999999, callback);
            
            layer.graphics.beginFill(color, alpha);
            layer.graphics.drawRect(0, 0, rCore.settings.gameWidth, rCore.settings.gameHeight);
            layer.graphics.endFill();
        }
        
        /**
         * Stops and removes this effect
         */
        public function stop():void{
            this.finish();
        }
    }
}