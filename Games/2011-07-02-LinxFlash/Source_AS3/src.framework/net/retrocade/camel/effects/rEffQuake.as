package net.retrocade.camel.effects{
    import flash.display.DisplayObject;
    
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.core.retrocamel_int;
    
    use namespace retrocamel_int;
    
    public class rEffQuake extends rEffectScreen{
        public static const MODE_SINUS :uint = 0;
        public static const MODE_RANDOM:uint = 1;
        
        private var _mode :uint;
        private var _vPower:Number;
        private var _hPower:Number;
        private var _hSpeed :Number
        private var _vSpeed :Number
        private var _toQuake:DisplayObject;
        
        public function rEffQuake(duration:int, hPower:Number = 50, vPower:Number = 50, mode:uint = MODE_RANDOM, hSpeed:Number = 30, vSpeed:Number = 15, callback:Function = null){
            super(duration, callback);
            
            _mode   = mode;
            _vPower = vPower;
            _hPower = hPower;
            _hSpeed = hSpeed;
            _vSpeed = vSpeed;
            
            _toQuake = rDisplay._game;
            
            layer.graphics.beginFill(0);
            layer.graphics.drawRect(-hPower,          -vPower,                          rCore.settings.gameWidth + 2 * hPower, vPower);
            layer.graphics.drawRect(-hPower,          rCore.settings.gameHeight, rCore.settings.gameWidth + 2 * hPower, vPower);
            layer.graphics.drawRect(-hPower,          0,                                hPower,                                       rCore.settings.gameHeight);
            layer.graphics.drawRect(rCore.settings.swfWidth, 0,                  hPower,                                       rCore.settings.gameHeight);
            layer.graphics.endFill();
        }
        
        override public function update():void {
            if (_blocked) return blockUpdate();
            
            if (_mode == MODE_SINUS){
                _toQuake.x = Math.sin(interval * _hSpeed) * _hPower * (1 - interval) | 0;
                _toQuake.y = Math.sin(interval * _vSpeed) * _vPower * (1 - interval) | 0;
                
            } else {
                _toQuake.x = (Math.random() * 2 - 1) * _hPower * (1 - interval) | 0;
                _toQuake.y = (Math.random() * 2 - 1) * _vPower * (1 - interval) | 0;
            }
            
            super.update();
        }
        
        override protected function finish():void{
            _toQuake.x = 0;
            _toQuake.y = 0;
            
            super.finish();
        }
    }
}