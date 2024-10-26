package net.retrocade.camel.effects{
    import flash.events.Event;
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.retrocamel_int;
    import net.retrocade.camel.objects.rObject;
    
    use namespace retrocamel_int;
    
    public class rEffFadeScreen extends rEffectScreen{
        private var _alphaFrom:Number;
        private var _alphaTo  :Number;
        private var _color    :uint;
        
        public function rEffFadeScreen(alphaFrom:Number = 1, alphaTo:Number = 1, color:uint = 0, duration:uint = 200, callback:Function = null){
            super(duration, callback);
            
            _color = color;
            
            layer.graphics.beginFill(color, 1);
            layer.graphics.drawRect(0, 0, rCore.settings.swfWidth, rCore.settings.swfHeight);
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
        
        override protected function onResize(e:Event):void{
            layer.graphics.clear();
            layer.graphics.beginFill(_color, 1);
            layer.graphics.drawRect(0, 0, rCore.settings.gameWidth, rCore.settings.gameHeight);
            layer.graphics.endFill();
        }
    }
}