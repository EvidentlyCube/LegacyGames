package submuncher.editor.core {
    public class EditorAutoTiler {
        private static const Y:uint = 112;

        private static var _autoTileOffset:Vector.<uint>;
        private static var _8wayOffsetCalculated:Vector.<uint>;

        {
            init();
        }

        private static function init():void {
            _8wayOffsetCalculated = new <uint>[
                0, 0, 4, 4, 0, 0, 4, 4, 3, 3, 11, 12, 3, 3, 11, 12,
                1, 1, 13, 13, 1, 1, 14, 14, 5, 5, 23, 24, 5, 5, 25, 26,
                0, 0, 4, 4, 0, 0, 4, 4, 3, 3, 11, 12, 3, 3, 11, 12,
                1, 1, 13, 13, 1, 1, 14, 14, 5, 5, 23, 24, 5, 5, 25, 26,
                2, 2, 6, 6, 2, 2, 6, 6, 9, 9, 19, 21, 9, 9, 19, 21,
                7, 7, 27, 27, 7, 7, 28, 28, 15, 15, 31, 39, 15, 15, 35, 43,
                2, 2, 6, 6, 2, 2, 6, 6, 10, 10, 20, 22, 10, 10, 20, 22,
                7, 7, 27, 27, 7, 7, 28, 28, 17, 17, 33, 41, 17, 17, 37, 45,
                0, 0, 4, 4, 0, 0, 4, 4, 3, 3, 11, 12, 3, 3, 11, 12,
                1, 1, 13, 13, 1, 1, 14, 14, 5, 5, 23, 24, 5, 5, 25, 26,
                0, 0, 4, 4, 0, 0, 4, 4, 3, 3, 11, 12, 3, 3, 11, 12,
                1, 1, 13, 13, 1, 1, 14, 14, 5, 5, 23, 24, 5, 5, 25, 26,
                2, 2, 6, 6, 2, 2, 6, 6, 9, 9, 19, 21, 9, 9, 19, 21,
                8, 8, 29, 29, 8, 8, 30, 30, 16, 16, 32, 40, 16, 16, 36, 44,
                2, 2, 6, 6, 2, 2, 6, 6, 10, 10, 20, 22, 10, 10, 20, 22,
                8, 8, 29, 29, 8, 8, 30, 30, 18, 18, 34, 42, 18, 18, 38, 46
            ];


            _autoTileOffset = new Vector.<uint>(16 * 16);

            _autoTileOffset[1] = Y * 1;
            _autoTileOffset[2] = Y * 2;
            _autoTileOffset[3] = Y * 3;
            _autoTileOffset[4] = Y * 4;
            _autoTileOffset[5] = Y * 5;
            _autoTileOffset[6] = Y * 6;
            _autoTileOffset[7] = Y * 7;
            _autoTileOffset[8] = Y * 8;
            _autoTileOffset[9] = Y * 9;
            _autoTileOffset[10] = Y * 10;
            _autoTileOffset[11] = Y * 11;
            _autoTileOffset[12] = Y * 12;
            _autoTileOffset[13] = Y * 13;
            _autoTileOffset[14] = Y * 14;
            _autoTileOffset[15] = Y * 15;
            _autoTileOffset[16] = Y * 16;
            _autoTileOffset[17] = Y * 17;
            _autoTileOffset[18] = Y * 18;
        }

        public static function calculateTile(baseTile:uint, sides:Vector.<Boolean>, isVariation:Boolean):uint {
            if (baseTile >= 1 && baseTile <= 18) {
                var index:int = (sides[0] ? 0x01 : 0) +
                        (sides[1] ? 0x02 : 0) +
                        (sides[2] ? 0x04 : 0) +
                        (sides[3] ? 0x08 : 0) +
                        (sides[4] ? 0x10 : 0) +
                        (sides[5] ? 0x20 : 0) +
                        (sides[6] ? 0x40 : 0) +
                        (sides[7] ? 0x80 : 0);

                return _autoTileOffset[baseTile] + _8wayOffsetCalculated[index] + (isVariation ? 57 : 0);
            } else {
                return 0;
            }
        }
    }
}
