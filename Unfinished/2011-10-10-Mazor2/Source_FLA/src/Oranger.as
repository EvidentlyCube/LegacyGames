package src{
    import com.mauft.pixelBall.PixelBallEngine;
    
    import flash.display.Shape;
    import flash.events.Event;
    
    import src.linkedlist.rLinkedList;
    
    public class Oranger extends Shape{
        public static var list:rLinkedList = new rLinkedList();
        
        private var mx:Number;
        private var my:Number;
        
        private var dx:Number = 0;
        private var dy:Number = 0;
        
        private var rad:Number;
        
        private var color:uint;

        public function Oranger(x:Number, y:Number){
            this.x = x;
            this.y = y;
            
            var dir:Number = Math.random() * Math.PI * 2;
            var spd:Number = Math.random() * 6 + 1;
            
            rad = Math.random() * 5 + 4;
            
            mx = Math.cos(dir) * rad / 2;
            my = Math.sin(dir) * rad / 2;
            
            
            
            addEventListener(Event.ENTER_FRAME, onStep);
            addEventListener(Event.REMOVED_FROM_STAGE, kill);
            
            cacheAsBitmap = true;
            
            switch(Math.random() * 8 | 0){
                case(0): color = 0xfcc526; break;
                case(1): color = 0xf8a31d; break;
                case(2): color = 0xdd9b27; break;
                case(3): color = 0xcb6b28; break;
                case(4): color = 0xeca321; break;
                case(5): color = 0xcd6d28; break;
                case(6): color = 0xc26a28; break;
                case(7): color = 0xfaa61d; break;
            }
            
            list.addLast(this);
        }
        
        private function onStep(e:Event):void{
            graphics.beginFill(color);
            graphics.drawCircle(dx, dy, rad);
            
            rad *= 0.95;
            dx += mx;
            dy += my;
            
            mx *= 0.95;
            my *= 0.95;
            
            if (PixelBallEngine.terrain.hitTestPoint(x + dx, y + dy, true) || rad < 0.5){
                removeEventListener(Event.ENTER_FRAME, onStep);
            }
        }
        
        public function kill(e:Event):void{
            removeEventListener(Event.ENTER_FRAME, onStep);
            removeEventListener(Event.REMOVED_FROM_STAGE, kill);
            
            list.remove(this);
        }
    }
}