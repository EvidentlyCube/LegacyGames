package game.objects.effects {
    import flash.display.BitmapData;
    import flash.utils.getTimer;
    import game.managers.VOCoord;
    import game.states.TStateGame;
    import net.retrocade.utils.UBitmapData;
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TEffectBump extends TEffect {

        private var _x:int;
        private var _y:int;
        private var _hideOn:Number;

        public function TEffectBump(coord:VOCoord) {
            var x:uint = coord.x;
            var y:uint = coord.y;
            var o:uint = coord.o;

            gfx = new BitmapData(S.LEVEL_TILE_WIDTH, S.LEVEL_TILE_HEIGHT, false, 0);

            UBitmapData.blitPart(room.layerUnder.bitmapData, gfx,
                0, 0,
                S.LEVEL_OFFSET_X + x * S.LEVEL_TILE_WIDTH, S.LEVEL_OFFSET_Y + y * S.LEVEL_TILE_HEIGHT,
                S.LEVEL_TILE_WIDTH, S.LEVEL_TILE_HEIGHT);

            _x = x * S.LEVEL_TILE_WIDTH  + F.getOX(o);
            _y = y * S.LEVEL_TILE_HEIGHT + F.getOY(o);

            _hideOn = getTimer() + 250;

            TStateGame.effectsUnder.add(this);
        }

        override public function update():void {
            if (getTimer() > _hideOn)
                TStateGame.effectsUnder.nullify(this);
            else
                room.layerActive.blitDirectly(gfx, _x, _y);
        }

    }
}