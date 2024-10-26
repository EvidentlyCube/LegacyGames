package game.mobiles{
    import flash.events.Event;
    
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rState;
    
    public class rMobileState extends rState{
        override public function create():void{
            super.create();
            
            rDisplay.stage.addEventListener(Event.RESIZE, resized);
            
            resized(null);
        }
        
        override public function destroy():void{
            super.destroy();
            
            rDisplay.stage.removeEventListener(Event.RESIZE, resized);
        }
        
        protected function resized(e:Event):void{}
    }
}