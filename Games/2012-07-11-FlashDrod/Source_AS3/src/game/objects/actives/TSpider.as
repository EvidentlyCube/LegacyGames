package game.objects.actives{
    import game.global.Game;
	import game.global.Gfx;
    import game.global.Room;
    import game.objects.TActiveObject;
	import game.states.TStateGame;

    import net.retrocade.camel.core.rGfx;

    public class TSpider extends TRoach{
        override public function getType():uint{ return C.M_SPIDER; }

        override public function setGfx():void{
            gfx = T.SPIDER[animationFrame][o];
        }

        private var _isHidden:Boolean = true;
		private var _distance:uint = 0;
		
		private var _alpha:Number = 0;

        override public function process(lastCommand:uint):void {
            super.process(lastCommand);

			_distance = F.distanceInTiles(x, y, Game.player.x, Game.player.y);
            _isHidden = !(prevX != x || prevY != y || _distance < 4);
			
			if (!_isHidden) {
				if (_distance < 2)
					_alpha = 0.742;
				
				else if (_distance > 5)
					_alpha = 0.371;
					
				else
					_alpha = 0.644 - _distance * 0.042;
			}
        }

        override public function update():void {
            if (!_isHidden) {
				room.layerActive.drawTileRectPrecise(Gfx.GENERAL_TILES, gfx, 
					x * S.LEVEL_TILE_WIDTH  + (prevX - x) * TStateGame.offset * S.LEVEL_TILE_WIDTH, 
					y * S.LEVEL_TILE_HEIGHT + (prevY - y) * TStateGame.offset * S.LEVEL_TILE_HEIGHT, 
					_alpha);
			}
        }

        override public function getSnapshot():Object {
            var object:Object = super.getSnapshot();

            object.isHidden = _isHidden;

            return object;
        }
    }
}