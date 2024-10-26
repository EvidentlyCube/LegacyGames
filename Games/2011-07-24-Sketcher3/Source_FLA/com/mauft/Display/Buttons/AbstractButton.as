package com.mauft.Display.Buttons{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class AbstractButton extends MovieClip{
        public function get selected():Boolean { return Boolean(_selected); }
        public function set selected(n:Boolean):void{ 
            if (n != _selected){
                click(null);
            }
        }
        
        protected var _canInstantiate:Boolean = false;
        protected var _selected      :int     = 0;
        
        public function AbstractButton(){
            if (!_canInstantiate){
                new Error("AbstractButton class cannot be instantiated!", 0);
            } else {
                buttonMode = true;
                
                this.addEventListener(Event.ENTER_FRAME,        step);
                this.addEventListener(Event.REMOVED_FROM_STAGE, kill);
                this.addEventListener(MouseEvent.CLICK,         click);
                this.addEventListener(MouseEvent.ROLL_OVER,     rollOver);
                this.addEventListener(MouseEvent.ROLL_OUT,      rollOut);
            }
        }
        
        protected function kill(e:Event):void{
            this.removeEventListener(Event.ENTER_FRAME,        step);
            this.removeEventListener(Event.REMOVED_FROM_STAGE, kill);
            this.removeEventListener(MouseEvent.CLICK,         click);
            this.removeEventListener(MouseEvent.ROLL_OVER,     rollOver);
            this.removeEventListener(MouseEvent.ROLL_OUT,      rollOut);
        }
        
        protected function rollOver(e:MouseEvent):void{}
        protected function rollOut(e:MouseEvent):void{}
        protected function click(e:MouseEvent):void{}
        protected function step(e:Event):void{}
    }
}