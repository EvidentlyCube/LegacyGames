package net.retrocade.camel.effects{
    import flash.display.DisplayObject;
    
    import net.retrocade.camel.global.rGroup;
    
    public class rEffFade extends rEffect{
        private var _alphaFrom:Number;
        private var _alphaTo  :Number;
        
        private var _toFade   :DisplayObject;
        
        public static function doMany(toFade:Array, alphaFrom:Number = 1, alphaTo:Number = 1, duration:uint = 200, 
                                      callback:Function = null, addTo:rGroup = null):void
        {
            for each (var displayObject:DisplayObject in toFade)
                new rEffFade(displayObject, alphaFrom, alphaTo, duration, callback, addTo);
        }
        
        public function rEffFade(toFade:DisplayObject, alphaFrom:Number = 1, alphaTo:Number = 1, duration:uint = 200, 
                                 callback:Function = null, addTo:rGroup = null)
        {
            super(duration, callback, addTo);
            
            _toFade = toFade;
            
            _alphaFrom = alphaFrom;
            _alphaTo   = alphaTo;
        
            _toFade.visible = true;
            
            update();
        }
        
        override public function update():void {
            if (_blocked) return blockUpdate();
            
            _toFade.visible = true;
            _toFade.alpha   = _alphaFrom + (_alphaTo - _alphaFrom) * interval;
            
            super.update();
        }
        
        override protected function finish():void{
            if (_alphaTo == 0)
                _toFade.visible = false;
            
            super.finish();
        }
        
        public function skip():void{
            _toFade.alpha = _alphaTo;
            finish();
        }
    }
}