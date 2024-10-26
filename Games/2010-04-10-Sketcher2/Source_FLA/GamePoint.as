package{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    
    public class GamePoint extends MovieClip{
        public static var bodies:Array = new Array();
        public static var currentBody:Body;
        
        public static var lastPointX:Number;
        public static var lastPointY:Number;
        public static var lastPointRad:Number;
        
        public static var previousPoint:GamePoint;
        
        private var loop:Boolean;
        private var text:TextField;
        private var body:MovieClip;
        private var ID:Number = -1;
        protected var canKill:Boolean = false;
        
        public var rad:Number = randomRad();
        
        public function GamePoint(x:Number, y:Number, loop:Boolean = false):void{
        	this.x    = x;
        	this.y    = y;
        	this.loop = loop;
        	
        	currentBody.addChild(this);
        	
        	ID = Level.pointsCount;
        	Level.pointsCount++;
        	
        	Level.addPoint(this);
        	
        	gotoAndStop(totalFrames);
        }
        
        private function hover(e:MouseEvent):void{
    	   if (currentBody.current == this){
	           currentBody.getPoint();
	           kill();
               Level.hovered();
               
               M.playSketch()    	       
    	   } else if (!M.$canMiss$ && Level.pointsHovered > 0){
    	       if (ID == Level.pointsHovered + 1 || distance(x, y, previousPoint.x, previousPoint.y) < 3600 || distance(x, y, currentBody.current.x, currentBody.current.y) < 3600){
    	           
    	           return;
    	       }
    	       Level.restart();
    	   }
        }
        
        private function kill():void{
            previousPoint = this;
            canKill = true;
            
            body.removeEventListener(MouseEvent.ROLL_OVER, hover);
            
            mouseEnabled = false;
            mouseChildren = false;
            
            gotoAndPlay(41);
            
            if (currentBody.isSingle){
                Level.sketchCircle(x, y, 3+Math.random()*2);
            } else if (currentBody.isFirst){
                Level.sketchCircle(x, y, rad);
            } else {
                Level.sketch(lastPointX, lastPointY, lastPointRad, x, y, rad);
                Level.sketchCircle(x, y, rad);
            }
            
            currentBody.hovered();
            
            if (currentBody.isLast){
                if (loop){
                    Level.sketch(x, y, rad, currentBody.firstX, currentBody.firstY, currentBody.firstRad);
                }
                
                currentBody = bodies.shift();
                
                if (currentBody){
                    if (M.$sleepBody$){
                        currentBody.wake();
                    }
                    lastPointX   = currentBody.current.x;
                    lastPointY   = currentBody.current.y;
                    lastPointRad = currentBody.current.rad;
                }
                
            } else {
                lastPointX   = x;
                lastPointY   = y;
                lastPointRad = rad;
            }
        }
        
        public function wake():void{
            body.addEventListener(MouseEvent.ROLL_OVER, hover);
            
            gotoAndPlay(2);
            
            if (text){
                text.mouseEnabled = false;
                text.parent.mouseEnabled = false;
                text.text = (ID+1).toString();
                
                if (x > 570){
                    text.x = - text.textWidth + 8;
                }
            }
        }
        public function sleep():void{
            body.removeEventListener(MouseEvent.ROLL_OVER, hover);
            gotoAndStop(1);
        }
        
        public static function _newBody():void{
        	if (currentBody){
        		bodies.push(currentBody);
        		
        		if (M.$sleepBody$){
        			currentBody.sleep();
        		}
        	}
        	
        	currentBody = new Body;
        }
        
        public static function _endBodies():void{
            if (currentBody){
                bodies.push(currentBody);
                
                if (M.$sleepBody$){
                    currentBody.sleep();
                }
            }
            
            currentBody = bodies.shift();
                
            if (M.$sleepBody$){
                currentBody.wake();
            }
        }
        
        public static function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number{
            return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2);
        }
        public static function randomRad():Number{ return 0.2 + Math.random()*4; }
    }
}