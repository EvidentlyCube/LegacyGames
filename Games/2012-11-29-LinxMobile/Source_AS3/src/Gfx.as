package{
    import flash.geom.Rectangle;

    import game.data.TBase;
    import game.data.TPath;
    import game.data.TWildcard;
    import game.tiles.TTileFloor;

    import net.retrocade.camel.global.rGfx;
    import net.retrocade.starling.rTextureAtlas;

    import starling.textures.Texture;

    public class Gfx{
        [Embed(source="/../assets/gfx/by_cage/tiles/newpath_colored_1.png")] public static var _tiles_path_big_:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/newpath_colored_1_cblind.png")] public static var _tiles_path_big_colorblind_:Class;

        [Embed(source="/../assets/gfx/by_cage/tiles/newpath_colored_small.png")] public static var _tiles_path_small_:Class;

        private static var _tilesBig:rTextureAtlas;
        private static var _tilesSmall:rTextureAtlas;

        private static var _tilesTexture:Texture;
        private static var _isColorBlind:Boolean = false;
        private static var _isSmall:Boolean = false;

        public static function get isSmall():Boolean{
            return _isSmall;
        }

        public static var floorTexture:Texture;
        public static var wildcardTexture:Texture;

        public static function init():void{

            floorTexture = Texture.fromBitmapData(rGfx.getBD(TTileFloor._floor_));
            wildcardTexture = Texture.fromBitmapData(rGfx.getBD(TWildcard._wildcard_));


        }

        private static function initTiles(colorBlind:Boolean, isSmall:Boolean):void{
            const SIDES:Array = ['0000', '1000', '0100', '0010', '0001', '1100', '0110', '0011', '1001', '1010', '0101', '1110', '0111', '1011', '1101', '1111'];
            const SIDES_COUNT:int = 16;
            const COLORS_COUNT:int = 9;

            var i:int;
            var j:int;

            if (colorBlind == _isColorBlind && isSmall == _isSmall && _tilesTexture){
                return;
            }

            if (_tilesTexture){
                _tilesTexture.dispose();
                _tilesBig.dispose();
            }

            _isColorBlind = colorBlind;
            _isSmall = isSmall;

            if (_isSmall){
                _tilesTexture = Texture.fromBitmapData(rGfx.getBD(colorBlind ? _tiles_path_big_colorblind_ : _tiles_path_small_));

                _tilesBig = new rTextureAtlas(_tilesTexture);

                for (i = 0; i < COLORS_COUNT; i++){
                    _tilesBig.addRegion("base_"+i, new Rectangle(1, 1 + i * 26, 24, 24));
                    for (j = 0; j < SIDES_COUNT; j++){
                        _tilesBig.addRegion('tile_' + i + '_' + SIDES[j], new Rectangle(27 + j * 26, 1 + i * 26, 24, 24));
                    }
                }
            } else {
                _tilesTexture = Texture.fromBitmapData(rGfx.getBD(colorBlind ? _tiles_path_big_colorblind_ : _tiles_path_big_));

                _tilesBig = new rTextureAtlas(_tilesTexture);

                for (i = 0; i < COLORS_COUNT; i++){
                    _tilesBig.addRegion("base_"+i, new Rectangle(1, 1 + i * 102, 100, 100));
                    for (j = 0; j < SIDES_COUNT; j++){
                        _tilesBig.addRegion('tile_' + i + '_' + SIDES[j], new Rectangle(103 + j * 102, 1 + i * 102, 100, 100));
                    }
                }
            }


        }

        public static function getPathBig(color:Number, sidesString:String, isColorBlind:Boolean, useSmall:Boolean):Texture{
            initTiles(isColorBlind, useSmall);

            return _tilesBig.getTexture('tile_' + color + '_' + sidesString);
        }

        public static function getBase(tileColor:int, isColorBlind:Boolean, useSmall:Boolean):Texture{
            initTiles(isColorBlind, useSmall);

            return _tilesBig.getTexture('base_' + tileColor);
        }
    }
}