package net.retrocade.camel.effects{
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.retrocamel_int;
    import net.retrocade.camel.objects.rObject;
    
    use namespace retrocamel_int;
    
    public class rEffFadeScreen extends rEffectScreen{
        private var _alphaFrom:Number;
        private var _alphaTo  :Number;
        
        public function rEffFadeScreen(alphaFrom:Number = 1, alphaTo:Number = 1, color:uint = 0, duration:uint = 200, callback:Function = null){
            super(duration, callback);
            layer.graphics.beginFill(color, 1);
            layer.graphics.drawRect(0, 0, rCore._settings.SIZE_GAME_WIDTH, rCore._settings.SIZE_GAME_HEIGHT);
            layer.graphics.endFill();
            
            _alphaFrom = alphaFrom;
            _alphaTo   = alphaTo;
            
            update();
        }
        
        override public function update():void {
            if (_blocked) return blockUpdate();
            
            layer.alpha = 1 - _alphaFrom - (_alphaTo - _alphaFrom) * interval;
            
            super.update();
        }
        
        override protected function finish():void{
            super.finish();
        }
    }
}