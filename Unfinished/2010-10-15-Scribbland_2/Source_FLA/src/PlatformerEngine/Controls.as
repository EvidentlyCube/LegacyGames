/*Platformer Engine by Mauft.com
__Controls__
This static class controls all controls-related things. 
*/

package src.PlatformerEngine{
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.ui.Keyboard;
    public class Controls{
        public static const TYPE_ONE_BUTTON  :uint = 0;
        public static const TYPE_TWO_BUTTON  :uint = 1;
        public static const TYPE_THREE_BUTTON:uint = 2;
        
        public static var anyKeyHit  :Boolean = false;
        
        public static var moveForward:Boolean = false;
        public static var moveJump   :Boolean = false;
        public static var moveLeft   :Boolean = false;
        public static var moveUp     :Boolean = false;
        public static var moveRight  :Boolean = false;
        
        public static var moveType   :uint    = TYPE_THREE_BUTTON; 
        
        public static var disabled :Boolean   = false        //If set to true, the game stops reading Input signals, use puppet() to control player then
        
        public function Controls():void{
            Engine.stage.addEventListener(KeyboardEvent.KEY_DOWN, Controls.listenerDown)
            Engine.stage.addEventListener(KeyboardEvent.KEY_UP,   Controls.listenerUp)
            
            Engine.stage.addEventListener(MouseEvent.MOUSE_DOWN,  Controls.mouseDown);
            Engine.stage.addEventListener(MouseEvent.MOUSE_UP,    Controls.mouseUp);
        }
        
        public static function Reset():void{
            anyKeyHit = false;
        }
        
        public static function listenerDown(e:KeyboardEvent):void{
            if (disabled){ return; }
            
            switch (e.keyCode){
                case(Keyboard.LEFT):
                    anyKeyHit   = true;
                    moveLeft    = true;
                    moveForward = true;
                    break;
                case(Keyboard.RIGHT):
                    anyKeyHit   = true;
                    moveRight   = true;
                    moveForward = true;
                    break;
                case(Keyboard.UP):
                    anyKeyHit   = true;
                    moveUp      = true;
                    break;
            }
        }
        
        public static function listenerUp(e:KeyboardEvent):void{
            if (disabled){ return; }
            
            switch (e.keyCode){
                case(Keyboard.LEFT):
                    moveLeft   = false;
                    if (!moveRight){ moveForward = false; }
                    break;
                case(Keyboard.RIGHT):
                    moveRight   = false;
                    if (!moveLeft){ moveForward = false; }
                    break;
                case(Keyboard.UP):
                    moveUp      = false;
                    break;
            }
        }
        
        public static function mouseDown(e:MouseEvent):void{
            if (!moveRight && !moveLeft && moveType == TYPE_ONE_BUTTON && !disabled){
                moveJump    = false;
                moveForward = true;
                anyKeyHit   = true;
            }
        }
        
        public static function mouseUp(e:MouseEvent):void{
            if (!moveRight && !moveLeft && moveType == TYPE_ONE_BUTTON && !disabled){
                moveJump    = true;
                moveForward = false;
            }
        }
    }
}