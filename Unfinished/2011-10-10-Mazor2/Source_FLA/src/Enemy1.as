package src{
    import com.mauft.pixelBall.IPixelBall;
    import com.mauft.pixelBall.PixelBallEngine;
    
    import flash.display.MovieClip;
    import flash.events.Event;
    
    public class Enemy1 extends MovieClip implements IPixelBall{
        private var _speedH:Number = 0;
        private var _speedV:Number = 0;
        
        public static const MAX_SPEED:Number = 2;
        public static const ACCELERATION:Number = 1/8;
        
        private var rotMod:Number = 0;
        private var sY:Number;
        
        private var rad:Number;
        
        public function Enemy1(){
            addEventListener(Event.ENTER_FRAME, step);
            addEventListener(Event.REMOVED_FROM_STAGE, kill);
            
            sY = scaleY;
            
            rad = width - 12;
            rad /= 2;
        }
        
        public function step(e:Event):void{
            
            rotMod += Math.PI * (_speedH + _speedV) / 17;
            scaleY = (1 + Math.sin(rotMod) * 0.06) * sY;
            scaleX = (1 - Math.sin(rotMod) * 0.06) * sY * (_speedH < 0 ? 1 : -1);
            
            if (M.player){
                var mx:Number = M.player.x - x;
                var my:Number = M.player.y - y;
                
                var ang:Number 	 = Math.atan2(my, mx);
                _speedH += Math.cos(ang) * ACCELERATION;    
                _speedV += Math.sin(ang) * ACCELERATION;
                
                ang = Math.atan2(_speedV, _speedH);
                
                var spd:Number = Math.sqrt(_speedH * _speedH + _speedV * _speedV);
                
                if (Math.abs(_speedH) > Math.abs(_speedV)){
                    _speedV /= _speedH;
                    _speedH /= _speedH;
                } else if (_speedV != 0){
                    _speedH /= _speedV;
                    _speedV /= _speedV;
                }
                
                _speedH = Math.cos(ang)*Math.min(MAX_SPEED, spd);
                _speedV = Math.sin(ang)*Math.min(MAX_SPEED, spd);
                
                if (mx * mx + my * my < (width * width - 4) / 4 + M.player.radius * M.player.radius){
                    M.player.bounced();
                }
            }
            
            PixelBallEngine.updateObject(this, 0, 0);
        }
        
        public function kill(e:Event):void{
            removeEventListener(Event.ENTER_FRAME, step);
            removeEventListener(Event.REMOVED_FROM_STAGE, kill);
        }
        
        public function get speedH():Number
        {
            return _speedH;
        }
        
        public function get speedV():Number
        {
            return _speedV;
        }
        
        public function get maxSpeedH():Number
        {
            return 111;
        }
        
        public function get maxSpeedV():Number
        {
            return 111;
        }
        
        public function get radius():Number
        {
            return rad;
        }
        
        public function get friction():Number
        {
            return 0.9;
        }
        
        public function get precision():Number
        {
            return 16;
        }
        
        public function get steps():int
        {
            return 1;
        }
        
        public function set speedH(val:Number):void{
            _speedH = val
        }
        
        public function set speedV(val:Number):void
        {
            _speedV = val
        }
        
        public function bounced():void{
            
        }
    }
}