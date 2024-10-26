package submuncher.core.constants {
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import net.retrocade.retrocamel.display.flash.RetrocamelGrid9Starling;

    import net.retrocade.retrocamel.display.starling.RetrocamelTextureAtlas;

    import starling.textures.SubTexture;

    import starling.textures.Texture;

    public class Gfx {
        private static var _tilemapSingleTextureCache:Vector.<Texture>;
        private static var _tilemapBgSingleTextureCache:Vector.<Texture>;
        private static var _editorBaseForegroundTextureCache:Vector.<Texture>;
        private static var _editorBaseForegroundVariantTextureCache:Vector.<Texture>;

        private static var _tilesetTexture:Texture;
        private static var _tilesetBgTexture:Texture;
        private static var _editorBaseForegroundTexture:Texture;
        private static var _editorBaseForegroundVariantTexture:Texture;
        private static var _spritesTexture:Texture;
        private static var _guiTexture:Texture;
        private static var _backgroundWaterTexture:Texture;
        private static var _backgroundWaterAtlas:RetrocamelTextureAtlas;
        private static var _spritesAtlas:RetrocamelTextureAtlas;
        private static var _guiAtlas:RetrocamelTextureAtlas;
        private static var _edgeCoverGrid9:Texture;
        private static var _levelSelectionMap:Texture;

        public static function initialize():void{
            _backgroundWaterTexture = Texture.fromBitmapData(GameFile.BACKGROUND_A_PNG.getBitmapData(), false);
            _spritesTexture = Texture.fromBitmapData(GameFile.SPRITES_PNG.getBitmapData(), false);
            _guiTexture = Texture.fromBitmapData(GameFile.GUI_PNG.getBitmapData(), false);
            _editorBaseForegroundTexture = Texture.fromBitmapData(GameFile.EDITOR_BASE_FG_TILESET_PNG.getBitmapData(), false);
            _editorBaseForegroundVariantTexture = Texture.fromBitmapData(GameFile.EDITOR_BASE_FG_VAR_TILESET_PNG.getBitmapData(), false);

            _backgroundWaterAtlas = new RetrocamelTextureAtlas(_backgroundWaterTexture);
            _spritesAtlas = new RetrocamelTextureAtlas(_spritesTexture);
            _guiAtlas = new RetrocamelTextureAtlas(_guiTexture);

            _backgroundWaterAtlas.parseAtlasJson(GameFile.BACKGROUND_A_JSON.getJsonObject());
            _spritesAtlas.parseAtlasJson(GameFile.SPRITES_JSON.getJsonObject());
            _guiAtlas.parseAtlasJson(GameFile.GUI_JSON.getJsonObject());

            _tilesetTexture = Texture.fromBitmapData(GameFile.TILESET_PNG.getBitmapData(), false);
            _tilesetBgTexture = Texture.fromBitmapData(GameFile.TILESET_BACKGROUND_PNG.getBitmapData(), false);
            _edgeCoverGrid9 = Texture.fromBitmapData(GameFile.EDGE_COVER_GRID9_PNG.getBitmapData(), false);
            _levelSelectionMap = Texture.fromBitmapData(GameFile.LEVEL_SELECTION_MAP_PNG.getBitmapData(), false);

            _tilemapSingleTextureCache = new Vector.<Texture>(S.tilesetWidthInTiles * S.tilesetWidthInTiles);
            _tilemapBgSingleTextureCache = new Vector.<Texture>(S.tilesetWidthInTiles * S.tilesetWidthInTiles);
            _editorBaseForegroundTextureCache = new Vector.<Texture>(S.tilesetWidthInTiles * S.tilesetWidthInTiles);
            _editorBaseForegroundVariantTextureCache = new Vector.<Texture>(S.tilesetWidthInTiles * S.tilesetWidthInTiles);
        }

        public static function get spritesAtlas():RetrocamelTextureAtlas {
            return _spritesAtlas;
        }

        public static function get backgroundWaterTexture():Texture {
            return _backgroundWaterTexture;
        }

        public static function get edgeCoverGrid9():Texture {
            return _edgeCoverGrid9;
        }

        public static function getSingleTileTextureFg(tileIndex:uint):Texture {
            var texture:Texture = _tilemapSingleTextureCache[tileIndex];
            if (!texture){
                var textureWidthInTiles:uint = S.tilesetWidthInTiles;
                var x:uint = (tileIndex % textureWidthInTiles) * 18;
                var y:uint = (tileIndex / textureWidthInTiles | 0) * 18;

                texture = Texture.fromTexture(
                    _tilesetTexture,
                    new Rectangle(x + 1, y + 1, 16, 16)
                );
                _tilemapSingleTextureCache[tileIndex] = texture;
            }


            return texture;
        }
        public static function getSingleTileTextureBg(tileIndex:uint):Texture {
            var texture:Texture = _tilemapBgSingleTextureCache[tileIndex];
            if (!texture){
                var textureWidthInTiles:uint = S.tilesetWidthInTiles;
                var x:uint = (tileIndex % textureWidthInTiles) * 18;
                var y:uint = (tileIndex / textureWidthInTiles | 0) * 18;

                texture = Texture.fromTexture(
                    _tilesetBgTexture,
                    new Rectangle(x + 1, y + 1, 16, 16)
                );
                _tilemapBgSingleTextureCache[tileIndex] = texture;
            }


            return texture;
        }

        public static function getEditorBaseForegroundTile(tileIndex:uint):Texture {
            var texture:Texture = _editorBaseForegroundTextureCache[tileIndex];
            if (!texture){
                var textureWidthInTiles:uint = _editorBaseForegroundTexture.width / 16;
                var x:uint = (tileIndex % textureWidthInTiles) * 16;
                var y:uint = (tileIndex / textureWidthInTiles | 0) * 16;

                texture = Texture.fromTexture(
                    _editorBaseForegroundTexture,
                    new Rectangle(x, y, 16, 16)
                );
                _editorBaseForegroundTextureCache[tileIndex] = texture;
            }


            return texture;
        }
        public static function getEditorBaseForegroundVariantTile(tileIndex:uint):Texture {
            var texture:Texture = _editorBaseForegroundVariantTextureCache[tileIndex];
            if (!texture){
                var textureWidthInTiles:uint = _editorBaseForegroundVariantTexture.width / 16;
                var x:uint = (tileIndex % textureWidthInTiles) * 16;
                var y:uint = (tileIndex / textureWidthInTiles | 0) * 16;

                texture = Texture.fromTexture(
                    _editorBaseForegroundVariantTexture,
                    new Rectangle(x, y, 16, 16)
                );
                _editorBaseForegroundVariantTextureCache[tileIndex] = texture;
            }


            return texture;
        }

        public static function get guiTexture():Texture {
            return _guiTexture;
        }

        public static function get guiAtlas():RetrocamelTextureAtlas {
            return _guiAtlas;
        }

        public static function createWindowGrid9():RetrocamelGrid9Starling {
            return new RetrocamelGrid9Starling(guiAtlas.getTexture('win_grid9'), new Rectangle(9, 9, 1, 1));
        }
        public static function createButtonGrid9():RetrocamelGrid9Starling {
            return new RetrocamelGrid9Starling(guiAtlas.getTexture('button_grid9'), new Rectangle(4, 4, 1, 1));
        }

        public static function createScreenGrid9():RetrocamelGrid9Starling {
            return new RetrocamelGrid9Starling(guiAtlas.getTexture('level_selection_menu'), new Rectangle(22, 25, 4, 4));
        }

        public static function createButtonOverGrid9():RetrocamelGrid9Starling {
            return new RetrocamelGrid9Starling(guiAtlas.getTexture('button_over_grid9'), new Rectangle(4, 4, 1, 1));
        }

        public static function createButtonDisabledGrid9():RetrocamelGrid9Starling {
            return new RetrocamelGrid9Starling(guiAtlas.getTexture('button_disabled_grid9'), new Rectangle(4, 4, 1, 1));
        }

        public static function getTextureOffset(textureName:String):Point {
            var texture:SubTexture = _guiAtlas.getTexture(textureName) as SubTexture;
            return new Point(texture.clipping.x * texture.parent.nativeWidth, texture.clipping.y * texture.parent.nativeHeight);
        }

        public static function get levelSelectionMap():Texture {
            return _levelSelectionMap;
        }

        public static function getBackgroundFrameA(frame:uint):Texture {
            return _backgroundWaterAtlas.getTexture('ingame_background_A_' + frame);
        }
    }
}
