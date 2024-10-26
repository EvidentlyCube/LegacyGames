package net.retrocade.tacticengine.monstro.core{
    import flash.geom.Rectangle;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.starling.rTextureAtlas;
    import net.retrocade.tacticengine.monstro.data.MonstroFont24;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.render.MonstroGrid9;
    import net.retrocade.tacticengine.monstro.render.MonstroUnitClip;

    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.textures.Texture;
    import starling.textures.TextureSmoothing;

    public class MonstroGfx{
        [Embed(source="/../assets/gfx/sheets/drodTileSet.png")] private static var _drod_tile_set_class:Class;
        [Embed(source="/../assets/gfx/sheets/phaseSheet.png")] private static var _phases_sheet_class:Class;

        [Embed(source="/../assets/gfx/bg/gameplayBg.png")] private static var _gameplaybg_class:Class;

        private static var _drodSpriteAtlas:rTextureAtlas;
        private static var _guiSheet:Texture;
        private static var _phaseSheet:Texture;

        private static var _solidColor:Texture;

        private static var _iconEndTurn:Texture;
        private static var _iconEndTurnDisabled:Texture;
        private static var _iconMenu:Texture;
        private static var _iconUndo:Texture;
        private static var _iconUndoDisabled:Texture;
        private static var _iconZoomIn:Texture;
        private static var _iconZoomInDisabled:Texture;
        private static var _iconZoomOut:Texture;
        private static var _iconZoomOutDisabled:Texture;
        private static var _iconEndUnitMove:Texture;
        private static var _iconEndUnitMoveDisabled:Texture;

        private static var _sliderBackground:Texture;
        private static var _sliderThumb:Texture;
        private static var _phaseBackground:Texture;

        private static var _blackBackground:Texture;

        private static var _gameplayBg:Texture;

        private static var _phasePlayerTurn:Texture;
        private static var _phaseEnemyTurn:Texture;
        private static var _phaseMonstersVictory:Texture;
        private static var _phaseHumansVictory:Texture;
        private static var _phaseMonstersLose:Texture;
        private static var _phaseHumansLose:Texture;

        private static var _isInitialized:Boolean = false;

        public static function init():void{
            if (_isInitialized){
                throw new Error("Alread initialized");
            }

            _isInitialized = true;

            _drodSpriteAtlas = new rTextureAtlas(Texture.fromBitmapData(rGfx.getBD(_drod_tile_set_class)));
            _guiSheet = MonstroFont24.guiSetTexture;
            _phaseSheet = Texture.fromBitmapData(rGfx.getBD(_phases_sheet_class));

            _guiSheet.name = "GUI sheet";

            _iconEndTurn = Texture.fromTexture(_guiSheet, new Rectangle(219, 262, 70, 102), new Rectangle(-29, -13, 128, 128));
            _iconEndUnitMove = Texture.fromTexture(_guiSheet, new Rectangle(209, 369, 102, 102), new Rectangle(-13, -13, 128, 128));
            _iconMenu = Texture.fromTexture(_guiSheet, new Rectangle(417, 180, 76, 96), new Rectangle(-26, -16, 128, 128));
            _iconUndo = Texture.fromTexture(_guiSheet, new Rectangle(245, 180, 100, 80), new Rectangle(-14, -24, 128, 128));
            _iconZoomIn = Texture.fromTexture(_guiSheet, new Rectangle(115, 265, 102, 102), new Rectangle(-13, -13, 128, 128));
            _iconZoomOut = Texture.fromTexture(_guiSheet, new Rectangle(11, 265, 102, 102), new Rectangle(-13, -13, 128, 128));
            _iconEndTurnDisabled = Texture.fromTexture(_guiSheet, new Rectangle(291, 262, 70, 102), new Rectangle(-29, -13, 128, 128));
            _iconEndUnitMoveDisabled = Texture.fromTexture(_guiSheet, new Rectangle(313, 365, 102, 101), new Rectangle(-13, -13.5, 128, 128));
            _iconUndoDisabled = Texture.fromTexture(_guiSheet, new Rectangle(143, 180, 100, 80), new Rectangle(-14, -24, 128, 128));
            _iconZoomInDisabled = Texture.fromTexture(_guiSheet, new Rectangle(105, 369, 102, 102), new Rectangle(-13, -13, 128, 128));
            _iconZoomOutDisabled = Texture.fromTexture(_guiSheet, new Rectangle(1, 391, 102, 102), new Rectangle(-13, -13, 128, 128));

            _sliderBackground = Texture.fromTexture(_guiSheet, new Rectangle(219, 133, 279, 45));
            _sliderThumb = Texture.fromTexture(_guiSheet, new Rectangle(105, 473, 15, 36));

            _phaseBackground = Texture.fromTexture(_guiSheet, new Rectangle(2, 133, 6, 256));

            _blackBackground = Texture.fromColor(32, 32, 0xFF000000);

            _gameplayBg = Texture.fromBitmapData(rGfx.getBD(_gameplaybg_class), false);

            _phasePlayerTurn = Texture.fromTexture(_phaseSheet, new Rectangle(0, 8, 512, 71));
            _phaseEnemyTurn = Texture.fromTexture(_phaseSheet, new Rectangle(0, 92, 512, 131));
            _phaseHumansLose = Texture.fromTexture(_phaseSheet, new Rectangle(0, 390, 510, 122));
            _phaseHumansVictory = Texture.fromTexture(_phaseSheet, new Rectangle(0, 232, 511, 151));
            _phaseMonstersLose = Texture.fromTexture(_phaseSheet, new Rectangle(512, 198, 512, 186));
            _phaseMonstersVictory = Texture.fromTexture(_phaseSheet, new Rectangle(512, 0, 512, 185));

            _phasePlayerTurn.name = "Player turn";
            _phaseEnemyTurn.name = "Enemy turn";

            _solidColor = Texture.fromColor(32, 32, 0xFFFFFFFF, false, 1);
            _solidColor.name = "Solid Color";

            initUnitGridTextures();
        }

        public static function getGrid9Window():MonstroGrid9{
            return new MonstroGrid9(_guiSheet, new Rectangle(5, 5, 120, 120), new Rectangle(11, 133, 130, 130));
        }

        public static function getGrid9WindowHeader():MonstroGrid9{
            return new MonstroGrid9(_guiSheet, new Rectangle(5, 5, 120, 120), new Rectangle(11, 133, 130, 130));
        }

        public static function getGrid9Button():MonstroGrid9{
            return new MonstroGrid9(_guiSheet, new Rectangle(3, 3, 24, 24), new Rectangle(154, 473, 30, 30));
        }

        public static function getGrid9ButtonDisabled():MonstroGrid9{
            return new MonstroGrid9(_guiSheet, new Rectangle(3, 3, 24, 24), new Rectangle(218, 473, 30, 30));
        }

        public static function getGrid9ButtonHilite():MonstroGrid9{
            return new MonstroGrid9(_guiSheet, new Rectangle(3, 3, 24, 24), new Rectangle(122, 473, 30, 30));
        }

        public static function getCheckboxEmpty():Texture{
            return Texture.fromTexture(_guiSheet, new Rectangle(272, 473, 22, 22));
        }

        public static function getCheckboxSelected():Texture{
            return Texture.fromTexture(_guiSheet, new Rectangle(249, 473, 22, 22));
        }

        public static function getIconMenu():Image{
            return new Image(_iconMenu);
        }

        public static function getIconUndo():Image{
            return new Image(_iconUndo);
        }

        public static function getIconUndoDisabled():Image{
            return new Image(_iconUndoDisabled);
        }

        public static function getIconEndTurn():Image{
            return new Image(_iconEndTurn);
        }

        public static function getIconEndTurnDisabled():Image{
            return new Image(_iconEndTurnDisabled);
        }

        public static function getIconUnitEndMove():Image{
            return new Image(_iconEndUnitMove);
        }

        public static function getIconUnitEndMoveDisabled():Image{
            return new Image(_iconEndUnitMoveDisabled);
        }


        public static function getGameplayBg():Image{
            return new Image(_gameplayBg);
        }

        public static function getRect():Image{
            return getTileDrod(20, 5);
        }

        public static function getUnitRect():MovieClip{
            return new MovieClip(_drodSpriteAtlas.getTextures("unitgrid_"));
        }

        public static function getBlackColor():Image{
            return new Image(_blackBackground);
        }

        public static function getPlayerTurn():Image{
            return new Image(_phasePlayerTurn);
        }

        public static function getEnemyTurn():Image{
            return new Image(_phaseEnemyTurn);
        }

        public static function getPhaseBackground():Image{
            return new Image(_phaseBackground);
        }

        public static function getSliderBackground():Image{
            return new Image(_sliderBackground);
        }

        public static function getSliderThumb():Image{
            return new Image(_sliderThumb);
        }

        public static function getTileDrod(tx:int, ty:int):Image{
            var image:Image = new Image(getTileTextureDrod(tx, ty));
            image.smoothing = TextureSmoothing.NONE;

            return image;
        }

        public static function getTileTextureDrod(tx:int, ty:int):Texture{
            var name:String = tx + ":" + ty;
            var texture:Texture = _drodSpriteAtlas.getTexture(name);

            if (!texture){
                var x:int = tx;
                var y:int = ty;

                _drodSpriteAtlas.addRegion(name, new Rectangle(
                        0 + x * (Monstro.tileWidth + 0),
                        0 + y * (Monstro.tileHeight + 0),
                        Monstro.tileWidth, Monstro.tileHeight
                ));
            }

            return _drodSpriteAtlas.getTexture(name);
        }

        public static function getUnit(unitName:String):MonstroUnitClip{
            var unitClip:MonstroUnitClip = new MonstroUnitClip();

            switch(unitName){
                case(MonstroEntityFactory.NAME_CITIZEN):
                    fillUnitTilesCitizen(unitClip);
                    break;

                case(MonstroEntityFactory.NAME_STALWART):
                    fillUnitTilesStalwart(unitClip);
                    break;

                case(MonstroEntityFactory.NAME_BEETHRO):
                    fillUnitTilesBeethro(unitClip);
                    break;

                case(MonstroEntityFactory.NAME_ROACH):
                    fillUnitTilesRoach(unitClip);
                    break;

                case(MonstroEntityFactory.NAME_SPIDER):
                    fillUnitTilesSpider(unitClip);
                    break;

                case(MonstroEntityFactory.NAME_TARBABY):
                    fillUnitTilesTarBaby(unitClip);
                    break;

                case(MonstroEntityFactory.NAME_GOBLIN):
                    fillUnitTilesGoblin(unitClip);
                    break;

                case(MonstroEntityFactory.NAME_SLAYER):
                    fillUnitTilesSlayer(unitClip);
                    break;
            }

            unitClip.direction = MonstroConst.S;

            return unitClip;
        }

        private static function fillUnitTilesCitizen(unitClip:MonstroUnitClip):void{
            unitClip.addTexture(MonstroConst.N, getUnitTexture(0, 7));
            unitClip.addTexture(MonstroConst.NE, getUnitTexture(1, 7));
            unitClip.addTexture(MonstroConst.E, getUnitTexture(2, 7));
            unitClip.addTexture(MonstroConst.SE, getUnitTexture(3, 7));
            unitClip.addTexture(MonstroConst.S, getUnitTexture(4, 7));
            unitClip.addTexture(MonstroConst.SW, getUnitTexture(5, 7));
            unitClip.addTexture(MonstroConst.W, getUnitTexture(6, 7));
            unitClip.addTexture(MonstroConst.NW, getUnitTexture(7, 7));

            unitClip.addDisabledTexture(MonstroConst.N, getUnitTexture(8, 13));
            unitClip.addDisabledTexture(MonstroConst.NE, getUnitTexture(9, 13));
            unitClip.addDisabledTexture(MonstroConst.E, getUnitTexture(10, 13));
            unitClip.addDisabledTexture(MonstroConst.SE, getUnitTexture(11, 13));
            unitClip.addDisabledTexture(MonstroConst.S, getUnitTexture(12, 13));
            unitClip.addDisabledTexture(MonstroConst.SW, getUnitTexture(13, 13));
            unitClip.addDisabledTexture(MonstroConst.W, getUnitTexture(14, 13));
            unitClip.addDisabledTexture(MonstroConst.NW, getUnitTexture(15, 13));
        }

        private static function fillUnitTilesStalwart(unitClip:MonstroUnitClip):void{
            unitClip.addTexture(MonstroConst.N, getUnitTexture(0, 10));
            unitClip.addTexture(MonstroConst.NE, getUnitTexture(1, 10));
            unitClip.addTexture(MonstroConst.E, getUnitTexture(2, 10));
            unitClip.addTexture(MonstroConst.SE, getUnitTexture(3, 10));
            unitClip.addTexture(MonstroConst.S, getUnitTexture(4, 10));
            unitClip.addTexture(MonstroConst.SW, getUnitTexture(5, 10));
            unitClip.addTexture(MonstroConst.W, getUnitTexture(6, 10));
            unitClip.addTexture(MonstroConst.NW, getUnitTexture(7, 10));

            unitClip.addDisabledTexture(MonstroConst.N, getUnitTexture(8, 16));
            unitClip.addDisabledTexture(MonstroConst.NE, getUnitTexture(9, 16));
            unitClip.addDisabledTexture(MonstroConst.E, getUnitTexture(10, 16));
            unitClip.addDisabledTexture(MonstroConst.SE, getUnitTexture(11, 16));
            unitClip.addDisabledTexture(MonstroConst.S, getUnitTexture(12, 16));
            unitClip.addDisabledTexture(MonstroConst.SW, getUnitTexture(13, 16));
            unitClip.addDisabledTexture(MonstroConst.W, getUnitTexture(14, 16));
            unitClip.addDisabledTexture(MonstroConst.NW, getUnitTexture(15, 16));
        }

        private static function fillUnitTilesBeethro(unitClip:MonstroUnitClip):void{
            unitClip.addTexture(MonstroConst.N, getUnitTexture(8, 5));
            unitClip.addTexture(MonstroConst.NE, getUnitTexture(9, 5));
            unitClip.addTexture(MonstroConst.E, getUnitTexture(10, 5));
            unitClip.addTexture(MonstroConst.SE, getUnitTexture(11, 5));
            unitClip.addTexture(MonstroConst.S, getUnitTexture(12, 5));
            unitClip.addTexture(MonstroConst.SW, getUnitTexture(13, 5));
            unitClip.addTexture(MonstroConst.W, getUnitTexture(14, 5));
            unitClip.addTexture(MonstroConst.NW, getUnitTexture(15, 5));

            unitClip.addDisabledTexture(MonstroConst.N, getUnitTexture(8, 17));
            unitClip.addDisabledTexture(MonstroConst.NE, getUnitTexture(9, 17));
            unitClip.addDisabledTexture(MonstroConst.E, getUnitTexture(10, 17));
            unitClip.addDisabledTexture(MonstroConst.SE, getUnitTexture(11, 17));
            unitClip.addDisabledTexture(MonstroConst.S, getUnitTexture(12, 17));
            unitClip.addDisabledTexture(MonstroConst.SW, getUnitTexture(13, 17));
            unitClip.addDisabledTexture(MonstroConst.W, getUnitTexture(14, 17));
            unitClip.addDisabledTexture(MonstroConst.NW, getUnitTexture(15, 17));
        }


        private static function fillUnitTilesRoach(unitClip:MonstroUnitClip):void{
            unitClip.addTexture(MonstroConst.N, getUnitTexture(0, 5));
            unitClip.addTexture(MonstroConst.N, getUnitTexture(0, 6));
            unitClip.addTexture(MonstroConst.NE, getUnitTexture(1, 5));
            unitClip.addTexture(MonstroConst.NE, getUnitTexture(1, 6));
            unitClip.addTexture(MonstroConst.E, getUnitTexture(2, 5));
            unitClip.addTexture(MonstroConst.E, getUnitTexture(2, 6));
            unitClip.addTexture(MonstroConst.SE, getUnitTexture(3, 5));
            unitClip.addTexture(MonstroConst.SE, getUnitTexture(3, 6));
            unitClip.addTexture(MonstroConst.S, getUnitTexture(4, 5));
            unitClip.addTexture(MonstroConst.S, getUnitTexture(4, 6));
            unitClip.addTexture(MonstroConst.SW, getUnitTexture(5, 5));
            unitClip.addTexture(MonstroConst.SW, getUnitTexture(5, 6));
            unitClip.addTexture(MonstroConst.W, getUnitTexture(6, 5));
            unitClip.addTexture(MonstroConst.W, getUnitTexture(6, 6));
            unitClip.addTexture(MonstroConst.NW, getUnitTexture(7, 5));
            unitClip.addTexture(MonstroConst.NW, getUnitTexture(7, 6));

            unitClip.addDisabledTexture(MonstroConst.N, getUnitTexture(8, 11));
            unitClip.addDisabledTexture(MonstroConst.N, getUnitTexture(8, 12));
            unitClip.addDisabledTexture(MonstroConst.NE, getUnitTexture(9, 11));
            unitClip.addDisabledTexture(MonstroConst.NE, getUnitTexture(9, 12));
            unitClip.addDisabledTexture(MonstroConst.E, getUnitTexture(10, 11));
            unitClip.addDisabledTexture(MonstroConst.E, getUnitTexture(10, 12));
            unitClip.addDisabledTexture(MonstroConst.SE, getUnitTexture(11, 11));
            unitClip.addDisabledTexture(MonstroConst.SE, getUnitTexture(11, 12));
            unitClip.addDisabledTexture(MonstroConst.S, getUnitTexture(12, 11));
            unitClip.addDisabledTexture(MonstroConst.S, getUnitTexture(12, 12));
            unitClip.addDisabledTexture(MonstroConst.SW, getUnitTexture(13, 11));
            unitClip.addDisabledTexture(MonstroConst.SW, getUnitTexture(13, 12));
            unitClip.addDisabledTexture(MonstroConst.W, getUnitTexture(14, 11));
            unitClip.addDisabledTexture(MonstroConst.W, getUnitTexture(14, 12));
            unitClip.addDisabledTexture(MonstroConst.NW, getUnitTexture(15, 11));
            unitClip.addDisabledTexture(MonstroConst.NW, getUnitTexture(15, 12));
        }

        private static function fillUnitTilesSpider(unitClip:MonstroUnitClip):void{
            unitClip.addTexture(MonstroConst.N, getUnitTexture(8, 10));
            unitClip.addTexture(MonstroConst.N, getUnitTexture(8, 9));
            unitClip.addTexture(MonstroConst.NE, getUnitTexture(9, 10));
            unitClip.addTexture(MonstroConst.NE, getUnitTexture(9, 9));
            unitClip.addTexture(MonstroConst.E, getUnitTexture(10, 10));
            unitClip.addTexture(MonstroConst.E, getUnitTexture(10, 9));
            unitClip.addTexture(MonstroConst.SE, getUnitTexture(11, 10));
            unitClip.addTexture(MonstroConst.SE, getUnitTexture(11, 9));
            unitClip.addTexture(MonstroConst.S, getUnitTexture(12, 10));
            unitClip.addTexture(MonstroConst.S, getUnitTexture(12, 9));
            unitClip.addTexture(MonstroConst.SW, getUnitTexture(13, 10));
            unitClip.addTexture(MonstroConst.SW, getUnitTexture(13, 9));
            unitClip.addTexture(MonstroConst.W, getUnitTexture(14, 10));
            unitClip.addTexture(MonstroConst.W, getUnitTexture(14, 9));
            unitClip.addTexture(MonstroConst.NW, getUnitTexture(15, 10));
            unitClip.addTexture(MonstroConst.NW, getUnitTexture(15, 9));

            unitClip.addDisabledTexture(MonstroConst.N, getUnitTexture(8, 22));
            unitClip.addDisabledTexture(MonstroConst.N, getUnitTexture(8, 21));
            unitClip.addDisabledTexture(MonstroConst.NE, getUnitTexture(9, 22));
            unitClip.addDisabledTexture(MonstroConst.NE, getUnitTexture(9, 21));
            unitClip.addDisabledTexture(MonstroConst.E, getUnitTexture(10, 22));
            unitClip.addDisabledTexture(MonstroConst.E, getUnitTexture(10, 21));
            unitClip.addDisabledTexture(MonstroConst.SE, getUnitTexture(11, 22));
            unitClip.addDisabledTexture(MonstroConst.SE, getUnitTexture(11, 21));
            unitClip.addDisabledTexture(MonstroConst.S, getUnitTexture(12, 22));
            unitClip.addDisabledTexture(MonstroConst.S, getUnitTexture(12, 21));
            unitClip.addDisabledTexture(MonstroConst.SW, getUnitTexture(13, 22));
            unitClip.addDisabledTexture(MonstroConst.SW, getUnitTexture(13, 21));
            unitClip.addDisabledTexture(MonstroConst.W, getUnitTexture(14, 22));
            unitClip.addDisabledTexture(MonstroConst.W, getUnitTexture(14, 21));
            unitClip.addDisabledTexture(MonstroConst.NW, getUnitTexture(15, 22));
            unitClip.addDisabledTexture(MonstroConst.NW, getUnitTexture(15, 21));
        }

        private static function fillUnitTilesTarBaby(unitClip:MonstroUnitClip):void{
            unitClip.addTexture(MonstroConst.N, getUnitTexture(0, 8));
            unitClip.addTexture(MonstroConst.N, getUnitTexture(0, 9));
            unitClip.addTexture(MonstroConst.NE, getUnitTexture(1, 8));
            unitClip.addTexture(MonstroConst.NE, getUnitTexture(1, 9));
            unitClip.addTexture(MonstroConst.E, getUnitTexture(2, 8));
            unitClip.addTexture(MonstroConst.E, getUnitTexture(2, 9));
            unitClip.addTexture(MonstroConst.SE, getUnitTexture(3, 8));
            unitClip.addTexture(MonstroConst.SE, getUnitTexture(3, 9));
            unitClip.addTexture(MonstroConst.S, getUnitTexture(4, 8));
            unitClip.addTexture(MonstroConst.S, getUnitTexture(4, 9));
            unitClip.addTexture(MonstroConst.SW, getUnitTexture(5, 8));
            unitClip.addTexture(MonstroConst.SW, getUnitTexture(5, 9));
            unitClip.addTexture(MonstroConst.W, getUnitTexture(6, 8));
            unitClip.addTexture(MonstroConst.W, getUnitTexture(6, 9));
            unitClip.addTexture(MonstroConst.NW, getUnitTexture(7, 8));
            unitClip.addTexture(MonstroConst.NW, getUnitTexture(7, 9));

            unitClip.addDisabledTexture(MonstroConst.N, getUnitTexture(8, 14));
            unitClip.addDisabledTexture(MonstroConst.N, getUnitTexture(8, 15));
            unitClip.addDisabledTexture(MonstroConst.NE, getUnitTexture(9, 14));
            unitClip.addDisabledTexture(MonstroConst.NE, getUnitTexture(9, 15));
            unitClip.addDisabledTexture(MonstroConst.E, getUnitTexture(10, 14));
            unitClip.addDisabledTexture(MonstroConst.E, getUnitTexture(10, 15));
            unitClip.addDisabledTexture(MonstroConst.SE, getUnitTexture(11, 14));
            unitClip.addDisabledTexture(MonstroConst.SE, getUnitTexture(11, 15));
            unitClip.addDisabledTexture(MonstroConst.S, getUnitTexture(12, 14));
            unitClip.addDisabledTexture(MonstroConst.S, getUnitTexture(12, 15));
            unitClip.addDisabledTexture(MonstroConst.SW, getUnitTexture(13, 14));
            unitClip.addDisabledTexture(MonstroConst.SW, getUnitTexture(13, 15));
            unitClip.addDisabledTexture(MonstroConst.W, getUnitTexture(14, 14));
            unitClip.addDisabledTexture(MonstroConst.W, getUnitTexture(14, 15));
            unitClip.addDisabledTexture(MonstroConst.NW, getUnitTexture(15, 14));
            unitClip.addDisabledTexture(MonstroConst.NW, getUnitTexture(15, 15));
        }

        private static function fillUnitTilesGoblin(unitClip:MonstroUnitClip):void{
            unitClip.addTexture(MonstroConst.N, getUnitTexture(8, 6));
            unitClip.addTexture(MonstroConst.N, getUnitTexture(8, 7));
            unitClip.addTexture(MonstroConst.NE, getUnitTexture(9, 6));
            unitClip.addTexture(MonstroConst.NE, getUnitTexture(9, 7));
            unitClip.addTexture(MonstroConst.E, getUnitTexture(10, 6));
            unitClip.addTexture(MonstroConst.E, getUnitTexture(10, 7));
            unitClip.addTexture(MonstroConst.SE, getUnitTexture(11, 6));
            unitClip.addTexture(MonstroConst.SE, getUnitTexture(11, 7));
            unitClip.addTexture(MonstroConst.S, getUnitTexture(12, 6));
            unitClip.addTexture(MonstroConst.S, getUnitTexture(12, 7));
            unitClip.addTexture(MonstroConst.SW, getUnitTexture(13, 6));
            unitClip.addTexture(MonstroConst.SW, getUnitTexture(13, 7));
            unitClip.addTexture(MonstroConst.W, getUnitTexture(14, 6));
            unitClip.addTexture(MonstroConst.W, getUnitTexture(14, 7));
            unitClip.addTexture(MonstroConst.NW, getUnitTexture(15, 6));
            unitClip.addTexture(MonstroConst.NW, getUnitTexture(15, 7));

            unitClip.addDisabledTexture(MonstroConst.N, getUnitTexture(8, 18));
            unitClip.addDisabledTexture(MonstroConst.N, getUnitTexture(8, 19));
            unitClip.addDisabledTexture(MonstroConst.NE, getUnitTexture(9, 18));
            unitClip.addDisabledTexture(MonstroConst.NE, getUnitTexture(9, 19));
            unitClip.addDisabledTexture(MonstroConst.E, getUnitTexture(10, 18));
            unitClip.addDisabledTexture(MonstroConst.E, getUnitTexture(10, 19));
            unitClip.addDisabledTexture(MonstroConst.SE, getUnitTexture(11, 18));
            unitClip.addDisabledTexture(MonstroConst.SE, getUnitTexture(11, 19));
            unitClip.addDisabledTexture(MonstroConst.S, getUnitTexture(12, 18));
            unitClip.addDisabledTexture(MonstroConst.S, getUnitTexture(12, 19));
            unitClip.addDisabledTexture(MonstroConst.SW, getUnitTexture(13, 18));
            unitClip.addDisabledTexture(MonstroConst.SW, getUnitTexture(13, 19));
            unitClip.addDisabledTexture(MonstroConst.W, getUnitTexture(14, 18));
            unitClip.addDisabledTexture(MonstroConst.W, getUnitTexture(14, 19));
            unitClip.addDisabledTexture(MonstroConst.NW, getUnitTexture(15, 18));
            unitClip.addDisabledTexture(MonstroConst.NW, getUnitTexture(15, 19));
        }

        private static function fillUnitTilesSlayer(unitClip:MonstroUnitClip):void{
            unitClip.addTexture(MonstroConst.N, getUnitTexture(8, 8));
            unitClip.addTexture(MonstroConst.NE, getUnitTexture(9, 8));
            unitClip.addTexture(MonstroConst.E, getUnitTexture(10, 8));
            unitClip.addTexture(MonstroConst.SE, getUnitTexture(11, 8));
            unitClip.addTexture(MonstroConst.S, getUnitTexture(12, 8));
            unitClip.addTexture(MonstroConst.SW, getUnitTexture(13, 8));
            unitClip.addTexture(MonstroConst.W, getUnitTexture(14, 8));
            unitClip.addTexture(MonstroConst.NW, getUnitTexture(15, 8));

            unitClip.addDisabledTexture(MonstroConst.N, getUnitTexture(8, 20));
            unitClip.addDisabledTexture(MonstroConst.NE, getUnitTexture(9, 20));
            unitClip.addDisabledTexture(MonstroConst.E, getUnitTexture(10, 20));
            unitClip.addDisabledTexture(MonstroConst.SE, getUnitTexture(11, 20));
            unitClip.addDisabledTexture(MonstroConst.S, getUnitTexture(12, 20));
            unitClip.addDisabledTexture(MonstroConst.SW, getUnitTexture(13, 20));
            unitClip.addDisabledTexture(MonstroConst.W, getUnitTexture(14, 20));
            unitClip.addDisabledTexture(MonstroConst.NW, getUnitTexture(15, 20));
        }

        private static function getUnitTexture(x:int, y:int):Texture{
            return Texture.fromTexture(_drodSpriteAtlas.texture,
                    new Rectangle(x * Monstro.tileWidth, y * Monstro.tileHeight, Monstro.tileWidth, Monstro.tileHeight));
        }

        private static function initUnitGridTextures():void{
            _drodSpriteAtlas.addRegion("unitgrid_1", new Rectangle(440, 154, 22, 22));
            _drodSpriteAtlas.addRegion("unitgrid_2", new Rectangle(462, 154, 22, 22));
            _drodSpriteAtlas.addRegion("unitgrid_3", new Rectangle(440, 176, 22, 22));
            _drodSpriteAtlas.addRegion("unitgrid_4", new Rectangle(462, 176, 22, 22));
            _drodSpriteAtlas.addRegion("unitgrid_5", new Rectangle(440, 198, 22, 22));
            _drodSpriteAtlas.addRegion("unitgrid_6", new Rectangle(462, 198, 22, 22));
        }
    }
}