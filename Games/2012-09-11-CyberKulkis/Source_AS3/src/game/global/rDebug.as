package game.global{
    import flash.display.DisplayObject;
    import flash.geom.Point;
    
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.retrocamel_int;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.utils.Key;
    
    use namespace retrocamel_int;
    
    public class rDebug extends rObject{
        
        private var dragged:DisplayObject;
        private var point:Point = new Point();
        
        private var offsetX:Number = 0;
        private var offsetY:Number = 0;
        
        public function rDebug(){
            rCore.groupBefore.add(this);
        }
        
        override public function update():void{
            if (rInput.isKeyDown(Key.BACKQUOTE)){
                if (!dragged){
                    point.x = rInput.mouseX;
                    point.y = rInput.mouseY;
                    
                    var a:Array = rDisplay._stage.getObjectsUnderPoint(point);
                    if (a.length == 0)
                        return;
                    
                    dragged = a[a.length - 1];
                    if (dragged.parent is Grid9 || dragged.parent is Button)
                        dragged = dragged.parent;
                    
                    offsetX = rInput.mouseX - dragged.x;
                    offsetY = rInput.mouseY - dragged.y;
                }
                
                dragged.x = rInput.mouseX - offsetX;
                dragged.y = rInput.mouseY - offsetY;
            } else if (dragged){
                trace('DEBUG POSITION: ' + dragged.x + ":" + dragged.y);
                dragged = null;
            }
        }
    }
}