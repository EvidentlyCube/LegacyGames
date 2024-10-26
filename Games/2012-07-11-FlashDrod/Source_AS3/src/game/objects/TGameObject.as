package game.objects{
    import flash.display.BitmapData;
    
    import game.global.Core;
    import game.global.Gfx;
    import game.global.Level;
    import game.global.Room;
    import game.states.TStateGame;
    
    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.camel.objects.rObjectDisplay;
    
    public class TGameObject extends rObject {
        public var x    :uint;
        public var y    :uint;
        public var o    :uint;
        
        public var prevX:uint;
        public var prevY:uint;
        public var prevO:uint;
        
        public var gfx  :uint;
        
        public var room :Room;
        
        override public function update():void {
            room.layerActive.blitTileRectPrecise(Gfx.GENERAL_TILES, gfx, 
                x * S.LEVEL_TILE_WIDTH  + (prevX - x) * TStateGame.offset * S.LEVEL_TILE_WIDTH, 
                y * S.LEVEL_TILE_HEIGHT + (prevY - y) * TStateGame.offset * S.LEVEL_TILE_HEIGHT);
        }
    }
}