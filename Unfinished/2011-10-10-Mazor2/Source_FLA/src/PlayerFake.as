package src{
    import flash.display.MovieClip;
    import flash.events.Event;
    
    public class PlayerFake extends MovieClip{
        public function PlayerFake()
        {
            addEventListener(Event.ENTER_FRAME, step);
            
            alpha = 1 +Math.random()*0.2 - Math.random()*0.2
            scaleX = scaleY = 1 +Math.random()*0.2 - Math.random()*0.2
        }
        
        public function step(e:Event):void{
            if (!parent){
                removeEventListener(Event.ENTER_FRAME, step);
                return;
            }
            
            alpha -= 0.05;
            scaleX -= 0.02;
            scaleY -= 0.02;
            if (alpha < 0 || MovieClip(parent).currentFrame == 4){ 
                parent.removeChild(this); 
                removeEventListener(Event.ENTER_FRAME, step);
            }
        }
    }
}