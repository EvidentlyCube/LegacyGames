package game.objects {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import game.global.Level;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.effects.rEffectScreen;
    import net.retrocade.utils.UBitmapData;
	
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TEffectRoomSlide extends rEffectScreen {

        public static var instance:TEffectRoomSlide;

        private var _bitmapDataOld:BitmapData;
        private var _bitmapDataNew:BitmapData;

        private var _bitmapData:BitmapData;
        private var _bitmap:Bitmap;

        private var _direction:uint = uint.MAX_VALUE;

        public function TEffectRoomSlide() {
            super(0, onFinish);

            instance = this;
            setOld();

            _bitmapData = new BitmapData(S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS, true, 0x00000000);
            _bitmap     = new Bitmap(_bitmapData);

            _bitmap.x = S.LEVEL_OFFSET_X;
            _bitmap.y = S.LEVEL_OFFSET_Y;

            layer.add2(_bitmap);
        }

        override public function update():void {
            if (_direction == uint.MAX_VALUE) {
				finish();
                return;
			}

            super.update();

            switch(_direction) {
                case(C.N):
                    UBitmapData.blitPart(_bitmapDataOld, _bitmapData,
                        0, -interval * S.LEVEL_HEIGHT_PIXELS,
                        0, 0,
                        S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS);

                    UBitmapData.blitPart(_bitmapDataNew, _bitmapData,
                        0, S.LEVEL_HEIGHT_PIXELS - interval * S.LEVEL_HEIGHT_PIXELS,
                        0, 0,
                        S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS);
                    break;

                case(C.S):
                    UBitmapData.blitPart(_bitmapDataOld, _bitmapData,
                        0, interval * S.LEVEL_HEIGHT_PIXELS,
                        0, 0,
                        S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS);

                    UBitmapData.blitPart(_bitmapDataNew, _bitmapData,
                        0, interval * S.LEVEL_HEIGHT_PIXELS - S.LEVEL_HEIGHT_PIXELS,
                        0, 0,
                        S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS);
                    break;

                case(C.W):
                    UBitmapData.blitPart(_bitmapDataOld, _bitmapData,
                        -interval * S.LEVEL_WIDTH_PIXELS, 0,
                        0, 0,
                        S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS);

                    UBitmapData.blitPart(_bitmapDataNew, _bitmapData,
                        S.LEVEL_WIDTH_PIXELS - interval * S.LEVEL_WIDTH_PIXELS, 0,
                        0, 0,
                        S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS);
                    break;

                case(C.E):
                    UBitmapData.blitPart(_bitmapDataOld, _bitmapData,
                        interval * S.LEVEL_WIDTH_PIXELS, 0,
                        0, 0,
                        S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS);

                    UBitmapData.blitPart(_bitmapDataNew, _bitmapData,
                        interval * S.LEVEL_WIDTH_PIXELS - S.LEVEL_WIDTH_PIXELS, 0,
                        0, 0,
                        S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS);
                    break;
            }

        }

        private function onFinish():void {
            instance = null;
        }

        private function setOld():void {
            var bd:BitmapData = new BitmapData(S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS, false, 0xFF000000);

            UBitmapData.drawPart(rDisplay.application, bd,
                0, 0,
                S.LEVEL_OFFSET_X, S.LEVEL_OFFSET_Y,
                S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS);

            _bitmapDataOld = bd;
        }

        public function setNew():void {
            var bd:BitmapData = new BitmapData(S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS, false, 0xFF000000);

            UBitmapData.drawPart(rDisplay.application, bd,
                0, 0,
                S.LEVEL_OFFSET_X, S.LEVEL_OFFSET_Y,
                S.LEVEL_WIDTH_PIXELS, S.LEVEL_HEIGHT_PIXELS);

            _bitmapDataNew = bd;
        }

        public function start(prevRoom:uint, newRoom:uint):void {
            var oldRoomPos:Point = Level.getRoomOffsetInLevel(prevRoom);
            var newRoomPos:Point = Level.getRoomOffsetInLevel(newRoom);

            var offset:Point = newRoomPos.subtract(oldRoomPos);

            resetDuration(500);

            if (offset.x == 1)
                _direction = C.W;
            else if (offset.x == -1)
                _direction = C.E;
            else if (offset.y == 1)
                _direction = C.N;
            else if (offset.y == -1)
                _direction = C.S;

            update();
        }
    }
}