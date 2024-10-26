package{
    import com.mauft.pixelBall.IPixelBall;
    import com.mauft.pixelBall.PixelBallEngine;
    
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.media.Sound;
    import flash.media.SoundTransform;
    
    public class Player extends MovieClip implements IPixelBall{
        private var _speedH:Number = 0;
        private var _speedV:Number = 0;
        
        public static const MAX_SPEED:Number = 3;
        public static const ACCELERATION:Number = 1/6;
        
        private var timer:int = 0
            
        private var sfx:Boolean = true
        
        public function Player(){
            filters = []
            
            M.player = this;
            
            addEventListener(Event.ENTER_FRAME, step);
            addEventListener(Event.REMOVED_FROM_STAGE, kill);
            
        }
        
        public function step(e:Event):void{
            if (!M._play){return; }
            var ang:Number 	 = Math.atan2(mouseY, mouseX);
            _speedH += Math.cos(ang) * ACCELERATION;    
            _speedV += Math.sin(ang) * ACCELERATION;
            
            ang = Math.atan2(_speedV, _speedH);
            
            var spd:Number = Math.sqrt(_speedH*_speedH + _speedV*_speedV);
            
            _speedH = Math.cos(ang)*Math.min(MAX_SPEED, spd);
            _speedV = Math.sin(ang)*Math.min(MAX_SPEED, spd);
            
            sfx = false;
            
            PixelBallEngine.updateObject(this, 0, 0);
            
            timer++
                
            if (timer==2){
                timer = 0;
                var pf:player_fake = new player_fake;
                pf.x=x;
                pf.y=y;
                parent.addChildAt(pf, parent.getChildIndex(this)-1);
            }
            
            if (M.sfx && sfx){
                spd = Math.sqrt(_speedH*_speedH + _speedV*_speedV) / MAX_SPEED;
                var st:SoundTransform = new SoundTransform(spd, (x - 300)/600)
                switch(Math.floor(Math.random()*6)){
                    case(0): Sound(new IMPACT_1).play(0, 0, st); return;
                    case(1): Sound(new IMPACT_2).play(0, 0, st); return;
                    case(2): Sound(new IMPACT_3).play(0, 0, st); return;
                    case(3): Sound(new IMPACT_4).play(0, 0, st); return;
                    case(4): Sound(new IMPACT_5).play(0, 0, st); return;
                    case(5): Sound(new IMPACT_6).play(0, 0, st); return;
                }
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
            sfx = true
        }
    }
}