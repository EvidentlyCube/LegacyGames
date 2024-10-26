package game.managers{
    import flash.display.BitmapData;
    
    import game.global.DrodLayer;
    import game.global.Gfx;
    import game.global.Room;
    
    import net.retrocade.camel.core.rGfx;

    public class VOCheckpoints{
        public var checkpoints:Array = [];
        
        public function addCheckpoint(xml:XML):void{
            checkpoints.push(parseInt(xml.@X) + parseInt(xml.@Y) * S.LEVEL_WIDTH);
        }
        
        public function contains(x:uint, y:uint):Boolean{
            return checkpoints.indexOf(x + y * S.LEVEL_WIDTH) != -1;
        }
        
        public function clear():void{
            checkpoints.length = 0;
        }
        
        public function drawIfHas(x:uint, y:uint, drawTo:DrodLayer):void{
            if (checkpoints.indexOf(x + y * S.LEVEL_WIDTH) != -1)
                drawTo.blitTileRect(Gfx.GENERAL_TILES, T.TI_CHECKPOINT, x, y);
        }
    }
}