package net.retrocade.camel.animations{
    import flash.display.BitmapData;
    
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.camel.objects.rObjectDisplay;
    
    public class rAnimSprite extends rObject{
        private var _gfxes:Array = [];
        
        private var _x:Number;
        private var _y:Number;
        
        public  var animSpeed:Number;
        private var _drawTo:rLayerBlit;
        
        private var _timer:Number = 0;
        private var _currentFrame:Number = 0;
        
        public  var onFinishCallback:Function;
        
        public function rAnimSprite(x:Number, y:Number, animationSpeed:Number, drawTo:rLayerBlit){
            _x = x;
            _y = y;
            
            animSpeed = animationSpeed;
            
            _drawTo = drawTo;
            
            addDefault();
        }
        
        public function addFrame(frame:BitmapData):void{
            _gfxes.push(frame);
        }
        
        override public function update():void{
            _timer++;
            if (_timer >= animSpeed){
                _currentFrame++;
                if (_currentFrame == _gfxes.length){
                    if (onFinishCallback != null)
                        onFinishCallback();

                    _drawTo.draw(_gfxes[_currentFrame-1], _x, _y);
                    nullifyDefault();
                    return;
                }
                
                _timer = 0;
            }
            
            _drawTo.draw(_gfxes[_currentFrame], _x, _y);
        }
    }
}