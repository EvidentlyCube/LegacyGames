package game.objects.effects{
    import flash.display.BitmapData;
    
    import game.global.Game;
    import game.global.Room;
    
    import net.retrocade.camel.objects.rObject;
    
    public class TEffect extends rObject{
        protected var gfx:BitmapData;
        
        protected var room:Room;
        
        public function TEffect(){
            room = Game.room;
        }
    }
}