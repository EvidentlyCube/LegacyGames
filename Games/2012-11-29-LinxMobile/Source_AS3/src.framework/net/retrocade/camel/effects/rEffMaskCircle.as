package net.retrocade.camel.effects{
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.retrocamel_int;

    use namespace retrocamel_int;
    
    public class rEffMaskCircle extends rEffectScreen{
        
        private var x:Number;
        
        private var y:Number;
        
        private var distanceMax:Number;
        
        public function rEffMaskCircle(x:Number, y:Number, duration:int, callback:Function = null, easing:Function = null){
            super(duration, callback);
            
            this.easing = easing;
            
            this.x = x;
            this.y = y;
            distanceMax = rCore.settings.gameWidth + rCore.settings.gameHeight;
            
            update();
        }
        
        
        override public function update():void{
            if (_blocked) return blockUpdate();
            
            layer.graphics.clear();
            layer.graphics.beginFill(0);
            layer.graphics.drawRect(0, 0, rCore.settings.gameWidth, rCore.settings.gameHeight);
            layer.graphics.drawCircle(x, y, distanceMax * (1 - interval));
            
            super.update();
        }
    }
}