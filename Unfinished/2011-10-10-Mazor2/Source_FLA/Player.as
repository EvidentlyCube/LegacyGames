package{
    import com.mauft.pixelBall.IPixelBall;
    import com.mauft.pixelBall.PixelBallEngine;
    
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.media.Sound;
    import flash.media.SoundTransform;
    
    import src.Oranger;
    import src.PlayerFake;
    
    public class Player extends MovieClip implements IPixelBall{
        private var _speedH:Number = 0;
        private var _speedV:Number = 0;
        
        public static const MAX_SPEED:Number = 3;
        public static const ACCELERATION:Number = 1/3;
        
        private var timer:int = 0
            
        private var sfx:Boolean = true;
        
        private var rotMod:Number = 0;
            
        
        public function Player(){
            filters = []
            
            M.player = this;
            
            addEventListener(Event.ENTER_FRAME, step);
            addEventListener(Event.REMOVED_FROM_STAGE, kill);
            
        }
        
        public function step(e:Event):void{
            if (!M._play){return; }
            
            rotMod += Math.PI / 41;
            rotation = Math.sin(rotMod) * 30;
            
            var mx:Number = stage.mouseX - x;
            var my:Number = stage.mouseY - y;
            
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
            
            sfx = false;
            
            PixelBallEngine.updateObject(this, 0, 0);
            
            timer++
                
            if (timer == 2 && parent){
                timer = 0;
                var pf:PlayerFake = new PlayerFake;
                pf.x=x;
                pf.y=y;
                parent.addChildAt(pf, parent.getChildIndex(this)-1);
            }
        }

        public function kill(e:Event):void{
            removeEventListener(Event.ENTER_FRAME, step);
            
            removeEventListener(Event.REMOVED_FROM_STAGE, kill);
        }
        
        public  function rOver(e:MouseEvent):void{
            M._play = true;
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
            return 6;
        }
        
        public function get friction():Number
        {
            return 0.9;
        }
        
        public function get precision():Number
        {
            return 64;
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
            sfx = true;
            
            M.player = null;
            
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            M.addUnderWall(new Oranger(x, y));
            
            if (M.sfx)
                Sound(new IMPACT).play(100);
            
            parent.removeChild(this);
        }
    }
}