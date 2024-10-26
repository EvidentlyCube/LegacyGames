package src.Objects{
    import flash.display.MovieClip;
    
    import src.PlatformerEngine.Gfx;

    public class MessageField extends MovieClip{
        private static var headersList:Object = {
            controls_1: "CONTROLS 1:",
            controls_2: "CONTROLS 2:"
                                                }
                                                
        private static var contentList:Object = {
            controls_1: "Unlike usual platformer, in Scribbland you move using only ONE key!\n\nThe Acrion Key can be either left-mouse button or right arrow key.\n\nTo move forward please hold the Action Key and release it to Stop."
                                                }
        public var show:Boolean = false;
        
        public function MessageField(_name:String){
            this.name  = _name;
            this.alpha = 0;
            
            
            x = 50;
            y = 100;
            
            Gfx.windowAdd(this);
        }
        
        public function update():void{
            if (show && alpha < 1){
                alpha += 0.05;
            } else if (!show && alpha > 0){
                alpha -= 0.05;
            }
        }
        
    }
}