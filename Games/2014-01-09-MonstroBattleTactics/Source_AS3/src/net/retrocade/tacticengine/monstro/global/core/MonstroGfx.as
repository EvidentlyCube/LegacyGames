package net.retrocade.tacticengine.monstro.global.core{
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

    import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.display.starling.RetrocamelMovieClipStarling;
    import net.retrocade.retrocamel.display.starling.RetrocamelTextureAtlas;
    import net.retrocade.tacticengine.core.log;
	import net.retrocade.tacticengine.monstro.global.enum.EnumFxType;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroCloudImage;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroGrid9;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroBackground;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroTileClip;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroUnitClip;
    import net.retrocade.tacticengine.monstro.global.enum.EnumTrapType;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
    import net.retrocade.functions.printf;
	import net.retrocade.tacticengine.monstro.ingame.achievements.Achievement;
	import net.retrocade.tacticengine.monstro.ingame.achievements.AchievementImage;
	import net.retrocade.utils.UtilsString;

	import starling.display.Image;
	import starling.textures.Texture;
    import starling.textures.TextureSmoothing;

    public class MonstroGfx{
        [Embed(source="/../assets/gfx/sheets/tileset_greenland.png")] private static var _tile_set_greenland_class:Class;
        [Embed(source="/../assets/gfx/sheets/tileset_lava.png")] private static var _tile_set_lava_class:Class;
        [Embed(source="/../assets/gfx/sheets/tileset_ice.png")] private static var _tile_set_ice_class:Class;
        [Embed(source="/../assets/gfx/sheets/spritesheet.png")] private static var _sprite_sheet_class:Class;
        [Embed(source="/../assets/gfx/sheets/phaseSheet.png")] private static var _phases_sheet_class:Class;
        [Embed(source="/../assets/gfx/sheets/fx_animations.png")] private static var _fx_sheet_class:Class;
        [Embed(source="/../assets/gfx/sheets/defense_up_frames.png")] private static var _defense_sheet_class:Class;
        [Embed(source="/../assets/gfx/sheets/menu_box_frame_ribbon.png")] private static var _window_pretty_frame_class:Class;
        [Embed(source="/../assets/gfx/sheets/menu_box_bg.png")] private static var _window_pretty_background_class:Class;
        [Embed(source="/../assets/gfx/sheets/menu_text_bg.png")] private static var _parchment_bg_class:Class;
        [Embed(source="/../assets/gfx/sheets/achievements.png")] private static var _achievements_class:Class;
        [Embed(source="/../assets/gfx/sheets/achievements.json",mimeType="application/octet-stream")] private static var _achievements_json_class:Class;

        [Embed(source="/../assets/gfx/bg/gameplayBg1.png")] private static var _gameplaybg1_class:Class;
        [Embed(source="/../assets/gfx/bg/gameplayBg2.png")] private static var _gameplaybg2_class:Class;
        [Embed(source="/../assets/gfx/bg/gameplayBg3.png")] private static var _gameplaybg3_class:Class;

        [Embed(source="/../assets/gfx/bg/titleBg.png")]private static var _title_screen_background_class:Class;
        [Embed(source="/../assets/gfx/bg/titleLogo.png")]private static var _title_screen_logo_class:Class;

		[Embed(source="/../assets/gfx/sheets/map.png")] public static var _map_set_class:Class;
		[Embed(source="/../assets/gfx/sheets/map.json",mimeType="application/octet-stream")] public static var _map_json_class:Class;
		[Embed(source="/../assets/fonts/eboracum/Eboracum.ttf", fontName = "eboracum_embed", embedAsCFF="false")] private static var _font:Class;

        private static var _currentTileset:Class;

        private static var _tileSpriteAtlas:RetrocamelTextureAtlas;
        private static var _tileSheetAtlas:RetrocamelTextureAtlas;
        private static var _fxSheetAtlas:RetrocamelTextureAtlas;
        private static var _defenseSheetAtlas:RetrocamelTextureAtlas;
        private static var _phaseSheet:Texture;
        private static var _windowUiBackground:Texture;

        private static var _iconSpecializationSmallAttack:Texture;
        private static var _iconSpecializationSmallDefense:Texture;
        private static var _iconSpecializationSmallBerserker:Texture;
        private static var _iconSpecializationSmallRange:Texture;
        private static var _iconSpecializationSmallHp:Texture;
        private static var _iconSpecializationSmallSpeed:Texture;
        private static var _iconSpecializationSmallStop:Texture;
        private static var _iconSpecializationSmallCustomStats:Texture;

        private static var _gameplayBg1:Texture;
        private static var _gameplayBg2:Texture;
        //noinspection JSFieldCanBeLocal
        private static var _gameplayBgCloudsTexture:Texture;
        private static var _gameplayBgClouds:Vector.<Texture>;

        private static var _phaseHumanTurn:Texture;
        private static var _phaseMonsterTurn:Texture;
        private static var _phaseMonstersVictory:Texture;
        private static var _phaseHumansVictory:Texture;
        private static var _phaseMonstersLose:Texture;
        private static var _phaseHumansLose:Texture;

		private static var _mapTexture:Texture;
		private static var _mapAtlas:RetrocamelTextureAtlas;

		private static var _achievementsTexture:Texture;
		private static var _achievementsAtlas:RetrocamelTextureAtlas;

        private static var _isInitialized:Boolean = false;

        public static function init():void{
            if (_isInitialized){
                throw new Error("Already initialized");
            }

            _isInitialized = true;

            _tileSpriteAtlas = new RetrocamelTextureAtlas(Texture.fromEmbeddedAsset(_sprite_sheet_class, false));
			_fxSheetAtlas = new RetrocamelTextureAtlas(Texture.fromEmbeddedAsset(_fx_sheet_class, false));
			_defenseSheetAtlas = new RetrocamelTextureAtlas(Texture.fromEmbeddedAsset(_defense_sheet_class, false));
            _phaseSheet = Texture.fromEmbeddedAsset(_phases_sheet_class, false);
			_windowUiBackground = Texture.fromEmbeddedAsset(_window_pretty_background_class, false, false, 1, "bgra", true);

            setUnitsAtlas();
            setFxAtlas();
            setDefenseAtlas();


			_l("Registering specialization icons");
			_iconSpecializationSmallRange = Texture.fromTexture(_tileSpriteAtlas.texture, new Rectangle(597, 63, 10, 10));
			_iconSpecializationSmallSpeed = Texture.fromTexture(_tileSpriteAtlas.texture, new Rectangle(578, 63, 8, 10));
			_iconSpecializationSmallHp = Texture.fromTexture(_tileSpriteAtlas.texture, new Rectangle(556, 63, 11, 10));
			_iconSpecializationSmallDefense = Texture.fromTexture(_tileSpriteAtlas.texture, new Rectangle(536, 131, 10, 10));
			_iconSpecializationSmallBerserker = Texture.fromTexture(_tileSpriteAtlas.texture, new Rectangle(525, 131, 10, 10));
			_iconSpecializationSmallAttack = Texture.fromTexture(_tileSpriteAtlas.texture, new Rectangle(568, 63, 9, 10));
			_iconSpecializationSmallStop = Texture.fromTexture(_tileSpriteAtlas.texture, new Rectangle(587, 63, 9, 10));
			_iconSpecializationSmallCustomStats = Texture.fromTexture(_tileSpriteAtlas.texture, new Rectangle(513, 131, 11, 10));

            _gameplayBg1 = Texture.fromEmbeddedAsset(_gameplaybg1_class, false, false, 1, "bgra", true);
            _gameplayBg2 = Texture.fromEmbeddedAsset(_gameplaybg2_class, false, false, 1, "bgra", true);
            _gameplayBgCloudsTexture = Texture.fromEmbeddedAsset(_gameplaybg3_class, false);
            _gameplayBgClouds = new <Texture>[
                Texture.fromTexture(_gameplayBgCloudsTexture, new Rectangle(0, 0, 275, 146)),
                Texture.fromTexture(_gameplayBgCloudsTexture, new Rectangle(286, 0, 226, 123)),
                Texture.fromTexture(_gameplayBgCloudsTexture, new Rectangle(0, 166, 284, 132)),
                Texture.fromTexture(_gameplayBgCloudsTexture, new Rectangle(344, 153, 168, 83)),
                Texture.fromTexture(_gameplayBgCloudsTexture, new Rectangle(10, 312, 248, 100))
            ];

            _l("Registering phase images");
            _phaseHumanTurn = Texture.fromTexture(_phaseSheet, new Rectangle(0, 8, 512, 71));
            _phaseMonsterTurn = Texture.fromTexture(_phaseSheet, new Rectangle(0, 92, 512, 131));
            _phaseHumansLose = Texture.fromTexture(_phaseSheet, new Rectangle(0, 390, 510, 122));
            _phaseHumansVictory = Texture.fromTexture(_phaseSheet, new Rectangle(0, 232, 511, 151));
            _phaseMonstersLose = Texture.fromTexture(_phaseSheet, new Rectangle(512, 198, 512, 186));
            _phaseMonstersVictory = Texture.fromTexture(_phaseSheet, new Rectangle(512, 0, 512, 185));

            //_solidColor = Texture.fromColor(32, 32, 0xFFFFFFFF, false, 1);

			initMapTextureAtlas();
			initAchievementTextureAtlas();
        }

		private static function initMapTextureAtlas():void{
			if (_mapTexture){
				return;
			}

			_mapTexture = Texture.fromBitmap(new _map_set_class, false);
			_mapAtlas = new RetrocamelTextureAtlas(_mapTexture);

			var jsonByteArray:ByteArray = new _map_json_class;
			var jsonString:String = jsonByteArray.readUTFBytes(jsonByteArray.length);
			_mapAtlas.parseAtlasJson(JSON.parse(jsonString));
		}

		private static function initAchievementTextureAtlas():void{
			if (_achievementsTexture){
				return;
			}

			_achievementsTexture = Texture.fromBitmap(new _achievements_class, false);
			_achievementsAtlas = new RetrocamelTextureAtlas(_achievementsTexture);

			var jsonByteArray:ByteArray = new _achievements_json_class;
			var jsonString:String = jsonByteArray.readUTFBytes(jsonByteArray.length);
			_achievementsAtlas.parseAtlasJson(JSON.parse(jsonString));
		}

		public static function getTitleScreenLogoImage():Image{
            return new Image(Texture.fromEmbeddedAsset(_title_screen_logo_class));
        }

        public static function getTitleScreenBackgroundTexture():Texture{
            return Texture.fromEmbeddedAsset(_title_screen_background_class, false, false, 1, "bgra", true);
        }

        public static function getGrid9Window():MonstroGrid9{
            return new MonstroGrid9(CoreInit.guiTexture, new Rectangle(6, 6, 20, 20), CoreInit.guiTextureAtlas.getTexture('window_grid9_shadow').region);
        }


        public static function getTutorialIcon1():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('TutorialIcon'));
        }

        public static function setTilesetToGrassland():void{
            if (_currentTileset !== _tile_set_greenland_class){
                _l("Changing tileset to Greenland");
                if (_tileSheetAtlas){
                    _tileSheetAtlas.dispose();
                }

                _currentTileset = _tile_set_greenland_class;

                _tileSheetAtlas = new RetrocamelTextureAtlas(Texture.fromEmbeddedAsset(_tile_set_greenland_class, false));
                RetrocamelBitmapManager.dispose(_tile_set_greenland_class);
            }
        }

        public static function setTilesetToLava():void{
            if (_currentTileset !== _tile_set_lava_class){
                _l("Changing tileset to Lava");
                if (_tileSheetAtlas){
                    _tileSheetAtlas.dispose();
                }

                _currentTileset = _tile_set_lava_class;

                _tileSheetAtlas = new RetrocamelTextureAtlas(Texture.fromEmbeddedAsset(_tile_set_lava_class, false));
                RetrocamelBitmapManager.dispose(_tile_set_lava_class);
            }
        }

        public static function setTilesetToIce():void{
            if (_currentTileset !== _tile_set_ice_class){
                _l("Changing tileset to Ice");
                if (_tileSheetAtlas){
                    _tileSheetAtlas.dispose();
                }

                _currentTileset = _tile_set_ice_class;

                _tileSheetAtlas = new RetrocamelTextureAtlas(Texture.fromEmbeddedAsset(_tile_set_ice_class, false));
                RetrocamelBitmapManager.dispose(_tile_set_ice_class);
            }
        }

        public static function getGrid9WindowHeader():MonstroGrid9{
            return new MonstroGrid9(CoreInit.guiTexture, new Rectangle(6, 37, 121, 65), CoreInit.guiTextureAtlas.getTexture('window_grid9_header_shadow').region);
        }

        public static function getGrid9Button():MonstroGrid9{
            return new MonstroGrid9(CoreInit.guiTexture, new Rectangle(18, 18, 215, 24), CoreInit.guiTextureAtlas.getTexture('button_grid9').region);
        }

        public static function getGrid9ButtonHilite():MonstroGrid9{
            return new MonstroGrid9(CoreInit.guiTexture, new Rectangle(18, 18, 215, 24), CoreInit.guiTextureAtlas.getTexture('button_grid9_over').region);
        }

        public static function getGrid9ButtonGreen():MonstroGrid9{
            return new MonstroGrid9(CoreInit.guiTexture, new Rectangle(18, 18, 215, 24), CoreInit.guiTextureAtlas.getTexture('button_grid9_green').region);
        }

        public static function getGrid9ButtonGreenHilite():MonstroGrid9{
            return new MonstroGrid9(CoreInit.guiTexture, new Rectangle(18, 18, 215, 24), CoreInit.guiTextureAtlas.getTexture('button_grid9_green_over').region);
        }

        public static function getGrid9ButtonRed():MonstroGrid9{
            return new MonstroGrid9(CoreInit.guiTexture, new Rectangle(18, 18, 215, 24), CoreInit.guiTextureAtlas.getTexture('button_grid9_red').region);
        }

        public static function getGrid9ButtonRedHilite():MonstroGrid9{
            return new MonstroGrid9(CoreInit.guiTexture, new Rectangle(18, 18, 215, 24), CoreInit.guiTextureAtlas.getTexture('button_grid9_red_over').region);
        }

		public static function getGrid9ButtonDisabled():MonstroGrid9{
			return new MonstroGrid9(CoreInit.guiTexture, new Rectangle(18, 18, 215, 24), CoreInit.guiTextureAtlas.getTexture('button_grid9_disabled').region);
		}

        public static function getGrid9Parchment():MonstroGrid9{
            return new MonstroGrid9(CoreInit.guiTexture, new Rectangle(27, 26, 196, 57), CoreInit.guiTextureAtlas.getTexture('menu_text_bg').region);
        }

        public static function getIconMenu():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_menu'));
        }

        public static function getIconMenuDisabled():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_menu_disabled'));
        }

        public static function getIconUndo():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_undo'));
        }

        public static function getIconUndoDisabled():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_undo_disabled'));
        }

        public static function getIconEndTurn():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_turn'));
        }

        public static function getIconEndTurnDisabled():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_turn_disabled'));
        }

        public static function getIconAttack():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('stat_atk_red'));
        }

        public static function getIconDefense():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('stat_def_red'));
        }

        public static function getIconHealth():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('stat_hp_red'));
        }

        public static function getIconMovement():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('stat_mov_red'));
        }

        public static function getIconRange():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('stat_rng_red'));
        }

        public static function getIconZoomIn():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_zoom_in'));
        }

        public static function getIconZoomInDisabled():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_zoom_in_disabled'));
        }

        public static function getIconZoomOut():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_zoom_out'));
        }

        public static function getIconZoomOutDisabled():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_zoom_out_disabled'));
        }

        public static function getIconHelp():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_help'));
        }

        public static function getIconHelpDisabled():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_help_disabled'));
        }

        public static function getIconObjective():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_objective'));
        }

        public static function getIconObjectiveDisabled():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('icon_big_objective_disabled'));
        }

        public static function getQuestionMark():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('question_mark'));
        }

        public static function getArrowRight():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('arrow_next'));
        }

        public static function getArrowDown():Image{
		 	return new Image(CoreInit.guiTextureAtlas.getTexture('arrow_down'));
        }

        public static function getCursorDefault():Texture{
		 	return CoreInit.guiTextureAtlas.getTexture('cursor_point2');
        }

        public static function getCursorAttack():Texture{
		 	return CoreInit.guiTextureAtlas.getTexture('cursor_attack3');
        }

        public static function getCursorCannotAttack():Texture{
		 	return CoreInit.guiTextureAtlas.getTexture('cursor_attack3_block');
        }

        public static function getCursorCannotDrop():Texture{
		 	return CoreInit.guiTextureAtlas.getTexture('cursor_hold_block');
        }

        public static function getCursorDraggingUnit():Texture{
		 	return CoreInit.guiTextureAtlas.getTexture('cursor_hold');
        }

        public static function getCursorGrabUnit():Texture{
		 	return CoreInit.guiTextureAtlas.getTexture('cursor_hover');
        }

        public static function getCursorStopUnit():Texture{
		 	return CoreInit.guiTextureAtlas.getTexture('cursor_turn');
        }

        public static function getCheckboxEmpty():Texture{
		 	return CoreInit.guiTextureAtlas.getTexture('checkbox1');
        }

        public static function getCheckboxSelected():Texture{
		 	return CoreInit.guiTextureAtlas.getTexture('checkbox2');
        }

        public static function getGameplayBgBottom():MonstroBackground{
            return new MonstroBackground(_gameplayBg1, 0.0007);
        }

        public static function getBackgroundCloud(index:int):MonstroCloudImage{
            return new MonstroCloudImage(_gameplayBgClouds[index]);
        }

        public static function getBlackColor():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('blackRectangle'));
        }

        public static function getHumanTurn():Image{
            return new Image(_phaseHumanTurn);
        }

        public static function getMonsterTurn():Image{
            return new Image(_phaseMonsterTurn);
        }

        public static function getHumansVictory():Image{
            return new Image(_phaseHumansVictory);
        }

        public static function getHumansLose():Image{
            return new Image(_phaseHumansLose);
        }

        public static function getMonstersVictory():Image{
            return new Image(_phaseMonstersVictory);
        }

        public static function getMonstersLose():Image{
            return new Image(_phaseMonstersLose);
        }

        public static function getPhaseBackground():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('shadow'));
        }

        public static function getSliderBackground():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('dragBackground'));
        }

        public static function getSliderThumb():Image{
            return new Image(CoreInit.guiTextureAtlas.getTexture('dragThumb'));
        }

        public static function getSpecialtySmallIconArrowTexture():Texture{
            return _iconSpecializationSmallRange;
        }

        public static function getSpecialtySmallIconFootTexture():Texture{
            return _iconSpecializationSmallSpeed;
        }

        public static function getSpecialtySmallIconHeartTexture():Texture{
            return _iconSpecializationSmallHp;
        }

        public static function getSpecialtySmallIconShieldTexture():Texture{
            return _iconSpecializationSmallDefense;
        }

        public static function getSpecialtySmallIconSkullTexture():Texture{
            return _iconSpecializationSmallBerserker;
        }

        public static function getSpecialtySmallIconSwordTexture():Texture{
            return _iconSpecializationSmallAttack;
        }

        public static function getSpecialtySmallIconStarTexture():Texture{
            return _iconSpecializationSmallCustomStats;
        }

        public static function getSpecialtySmallIconStopTexture():Texture{
            return _iconSpecializationSmallStop;
        }

        public static function getSpecialtyLargeIconArrowTexture():Texture{
			return CoreInit.guiTextureAtlas.getTexture('stat_rng_blue');
        }

        public static function getSpecialtyLargeIconFootTexture():Texture{
			return CoreInit.guiTextureAtlas.getTexture('stat_mov_blue');
        }

        public static function getSpecialtyLargeIconHeartTexture():Texture{
			return CoreInit.guiTextureAtlas.getTexture('stat_hp_blue');
        }

        public static function getSpecialtyLargeIconShieldTexture():Texture{
			return CoreInit.guiTextureAtlas.getTexture('stat_def_blue');
        }

        public static function getSpecialtyLargeIconSkullTexture():Texture{
			return CoreInit.guiTextureAtlas.getTexture('stat_bsrk_blue');
        }

        public static function getSpecialtyLargeIconSwordTexture():Texture{
			return CoreInit.guiTextureAtlas.getTexture('stat_atk_blue');
        }

        public static function getSpecialtyLargeIconStarTexture():Texture{
			return CoreInit.guiTextureAtlas.getTexture('stat_str_blue');
        }

        public static function getSpecialtyLargeIconStopTexture():Texture{
			return CoreInit.guiTextureAtlas.getTexture('stat_stp_blue');
        }

        public static function getHealthBar(hp:int):Image{
            hp = Math.min(hp, 6);

            var textureName:String = printf('healthbar_%%', hp);

            return new Image(_tileSpriteAtlas.getTexture(textureName));
        }

        public static function getDefenseBar(defense:int):Image{
            defense = Math.min(defense, 6);

            var textureName:String = printf('defensebar_%%', defense);

            return new Image(_tileSpriteAtlas.getTexture(textureName));
        }

        public static function getTile(tx:int, ty:int):Image{
            var image:Image = new Image(getTileTexture(tx, ty));
            image.smoothing = TextureSmoothing.NONE;

            return image;
        }

        public static function getTileTexture(tx:int, ty:int):Texture{
            var name:String = tx + ":" + ty;

            if (!_tileSheetAtlas.hasTexture(name)){
                var x:int = tx / MonstroConsts.tileWidth;
                var y:int = ty / MonstroConsts.tileHeight;

                _tileSheetAtlas.addRegion(name, new Rectangle(
                        x * (MonstroConsts.tileWidth + 2) + 1,
                        y * (MonstroConsts.tileHeight + 2) + 1,
                        MonstroConsts.tileWidth, MonstroConsts.tileHeight
                ));
            }

            return _tileSheetAtlas.getTexture(name);
        }

        public static function getTrap(trapType:EnumTrapType):Image{
            switch(trapType){
                case(EnumTrapType.WEB):
                    return getTile(896, 0);
                case(EnumTrapType.SPIKES_SMALL):
                    return getTile(928, 0);
                case(EnumTrapType.SPIKES_MEDIUM):
                    return getTile(928, 32);
                case(EnumTrapType.SPIKES_BIG):
                    return getTile(928, 64);
                default:
                    return null;
            }
        }

        public static function getUnit(unitType:EnumUnitType):MonstroUnitClip{
            var unitTypeName:String = unitType.name;

            var movieClip:MonstroUnitClip = new MonstroUnitClip(
                    _tileSpriteAtlas.getTextures(unitTypeName + "_"),
                    _tileSpriteAtlas.getTexture(unitTypeName + "static"),
                    _tileSpriteAtlas.getTexture(unitTypeName + "disabled"),
                    _tileSpriteAtlas.getTexture(unitTypeName + "destroyed"),
					getUnitFps(unitType),
                    getUnitOffsetX(unitType), getUnitOffsetY(unitType)
            );

            movieClip.isAlwaysAnimated = getUnitIsAlwaysAnimated(unitType);
            movieClip.isAlwaysHiddenUnder = getUnitIsAlwaysHiddenUnder(unitType);
            movieClip.emitsLight = getUnitEmitsLight(unitType);

            return movieClip;
        }

		public static function getWalkingUnitAnimation(unitType:EnumUnitType):Vector.<Texture>{
			return _tileSpriteAtlas.getTextures(unitType.name + "_");
		}

        public static function getStunClip():RetrocamelMovieClipStarling{
            var movieClip:RetrocamelMovieClipStarling = new MonstroTileClip(_tileSpriteAtlas.getTextures('stun_'));
            movieClip.fps = 8;

            return movieClip;
        }

        public static function getPoofClip():RetrocamelMovieClipStarling{
            var movieClip:RetrocamelMovieClipStarling = new RetrocamelMovieClipStarling(_tileSpriteAtlas.getTextures('poof_'));
            movieClip.fps = 10;

            return movieClip;
        }

		private static function setFxAtlas():void{
			var typeName:String;

			for (var i:int = 0; i < EnumFxType.TOTAL; i++){
				typeName = EnumFxType.byId(i).name;

				for (var j:int = 0; j < 6; j++){
					_fxSheetAtlas.addRegion(typeName + '_' + j, new Rectangle(1 + j * 49, 1 + i * 49, 48, 48));
				}
			}
		}

		private static function setDefenseAtlas():void{
			for (var i:int = 0; i < 24; i++){
				var frameName:String = "frame_"  + UtilsString.padLeft(i, 3);
				_defenseSheetAtlas.addRegion(frameName, new Rectangle(1 + i * 73, 1, 72, 72));
			}
		}

		public static function getFxClip(fxType:EnumFxType):RetrocamelMovieClipStarling{
			var movieClip:RetrocamelMovieClipStarling = new RetrocamelMovieClipStarling(_fxSheetAtlas.getTextures(fxType.name + "_"));
			movieClip.fps = 10;

			return movieClip;
		}

		public static function getDefenseRecoveryFrames():Vector.<Texture>{
			return _defenseSheetAtlas.getTextures();
		}

        private static function setUnitsAtlas():void{
            var typeName:String;

            typeName = EnumUnitType.GRUNT.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(166, 1, 32, 44));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(166, 1, 32, 44));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(199, 1, 32, 44));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(232, 1, 32, 44));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(265, 1, 32, 44));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(298, 1, 32, 44));

            typeName = EnumUnitType.SOLDIER.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(622, 214, 32, 35));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(655, 214, 32, 35));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(688, 214, 32, 35));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(721, 214, 32, 35));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(754, 214, 32, 35));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(787, 214, 32, 35));

            typeName = EnumUnitType.PIKEMAN.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(820, 69, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(853, 69, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(886, 69, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(919, 69, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(952, 69, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(985, 69, 32, 37));

            typeName = EnumUnitType.ARCHER.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(820, 114, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(853, 114, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(886, 114, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(919, 114, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(952, 114, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(985, 114, 32, 37));

            typeName = EnumUnitType.KNIGHT.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(820, 207, 32, 42));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(853, 207, 32, 42));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(886, 207, 32, 42));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(919, 207, 32, 42));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(952, 207, 32, 42));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(985, 207, 32, 42));

            typeName = EnumUnitType.CAVALRY.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(1, 130, 48, 56));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(50, 130, 48, 56));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(99, 130, 48, 56));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(148, 130, 48, 56));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(197, 130, 48, 56));
            _tileSpriteAtlas.addRegion(typeName + '_4', new Rectangle(246, 130, 48, 56));
            _tileSpriteAtlas.addRegion(typeName + '_5', new Rectangle(295, 130, 48, 56));
            _tileSpriteAtlas.addRegion(typeName + '_6', new Rectangle(344, 130, 48, 56));
            _tileSpriteAtlas.addRegion(typeName + '_7', new Rectangle(393, 130, 48, 56));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(442, 130, 48, 56));

            typeName = EnumUnitType.GOO.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(1, 1, 32, 32));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(1, 1, 32, 32));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(34, 1, 32, 32));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(67, 1, 32, 32));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(100, 1, 32, 32));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(133, 1, 32, 32));

            typeName = EnumUnitType.SLIME.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(622, 182, 32, 23));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(655, 182, 32, 23));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(688, 182, 32, 23));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(721, 182, 32, 23));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(754, 182, 32, 23));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(787, 182, 32, 23));

            typeName = EnumUnitType.SHROOM.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(820, 164, 32, 38));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(853, 164, 32, 38));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(886, 164, 32, 38));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(919, 164, 32, 38));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(952, 164, 32, 38));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(985, 164, 32, 38));

            typeName = EnumUnitType.GARGOYLE.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(622, 135, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(655, 135, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(688, 135, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(721, 135, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(754, 135, 32, 37));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(787, 135, 32, 37));

            typeName = EnumUnitType.MINOTAUR.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(295, 77, 48, 44));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(344, 77, 48, 44));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(393, 77, 48, 44));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(442, 77, 48, 44));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(491, 77, 48, 44));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(540, 77, 48, 44));

            typeName = EnumUnitType.MANTICORE.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(1, 77, 48, 46));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(50, 77, 48, 46));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(99, 77, 48, 46));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(148, 77, 48, 46));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(197, 77, 48, 46));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(246, 77, 48, 46));

            typeName = EnumUnitType.MOBILE_WALL.name;
            _tileSpriteAtlas.addRegion(typeName + 'static', new Rectangle(622, 96, 32, 32));
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(655, 96, 32, 32));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(688, 96, 32, 32));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(721, 96, 32, 32));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(688, 96, 32, 32));
            _tileSpriteAtlas.addRegion(typeName + 'disabled', new Rectangle(754, 96, 32, 32));

            typeName = EnumUnitType.FAKE_WALL.name;
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(589, 76, 32, 32));
            _tileSpriteAtlas.addRegion(typeName + 'destroyed', new Rectangle(589, 109, 32, 32));

            typeName = EnumUnitType.FLAG_KING.name;
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(491, 145, 32, 36));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(522, 145, 32, 36));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(553, 145, 32, 36));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(584, 145, 32, 36));

            typeName = EnumUnitType.FLAG_BRAIN.name;
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(659, 53, 36, 42));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(696, 53, 36, 42));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(733, 53, 36, 42));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(770, 53, 36, 42));

            typeName = EnumUnitType.TORCH.name;
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(1, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(34, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(67, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(100, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_4', new Rectangle(133, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_5', new Rectangle(166, 267, 32, 53));
			_tileSpriteAtlas.addRegion(typeName + 'destroyed', new Rectangle(589, 109, 32, 32));

            typeName = EnumUnitType.LANTERN.name;
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(199, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(232, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(265, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(298, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_4', new Rectangle(331, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_5', new Rectangle(364, 267, 32, 53));
			_tileSpriteAtlas.addRegion(typeName + 'destroyed', new Rectangle(589, 109, 32, 32));

            typeName = EnumUnitType.BONFIRE.name;
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(397, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_1', new Rectangle(430, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_2', new Rectangle(463, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_3', new Rectangle(496, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_4', new Rectangle(529, 267, 32, 53));
            _tileSpriteAtlas.addRegion(typeName + '_5', new Rectangle(562, 267, 32, 53));
			_tileSpriteAtlas.addRegion(typeName + 'destroyed', new Rectangle(589, 109, 32, 32));

            typeName = EnumUnitType.TIKI_BLOCK.name;
            _tileSpriteAtlas.addRegion(typeName + '_0', new Rectangle(7, 327, 18, 42));

            _tileSpriteAtlas.addRegion('stun_0', new Rectangle(570, 126, 17, 17));

            _tileSpriteAtlas.addRegion('poof_0', new Rectangle(1, 187, 68, 68));
            _tileSpriteAtlas.addRegion('poof_1', new Rectangle(70, 187, 68, 68));
            _tileSpriteAtlas.addRegion('poof_2', new Rectangle(139, 187, 68, 68));
            _tileSpriteAtlas.addRegion('poof_3', new Rectangle(208, 187, 68, 68));
            _tileSpriteAtlas.addRegion('poof_4', new Rectangle(277, 187, 68, 68));
            _tileSpriteAtlas.addRegion('poof_5', new Rectangle(346, 187, 68, 68));
            _tileSpriteAtlas.addRegion('poof_6', new Rectangle(415, 187, 68, 68));
            _tileSpriteAtlas.addRegion('poof_7', new Rectangle(484, 187, 68, 68));
            _tileSpriteAtlas.addRegion('poof_8', new Rectangle(553, 187, 68, 68));

            _tileSpriteAtlas.addRegion('healthbar_1', new Rectangle(922, 54, 16, 4));
            _tileSpriteAtlas.addRegion('healthbar_2', new Rectangle(939, 54, 16, 4));
            _tileSpriteAtlas.addRegion('healthbar_3', new Rectangle(956, 54, 16, 4));
            _tileSpriteAtlas.addRegion('healthbar_4', new Rectangle(973, 54, 16, 4));
            _tileSpriteAtlas.addRegion('healthbar_5', new Rectangle(990, 54, 16, 4));
            _tileSpriteAtlas.addRegion('healthbar_6', new Rectangle(1007, 54, 16, 4));
            _tileSpriteAtlas.addRegion('defensebar_1', new Rectangle(922, 59, 16, 4));
            _tileSpriteAtlas.addRegion('defensebar_2', new Rectangle(939, 59, 16, 4));
            _tileSpriteAtlas.addRegion('defensebar_3', new Rectangle(956, 59, 16, 4));
            _tileSpriteAtlas.addRegion('defensebar_4', new Rectangle(973, 59, 16, 4));
            _tileSpriteAtlas.addRegion('defensebar_5', new Rectangle(990, 59, 16, 4));
            _tileSpriteAtlas.addRegion('defensebar_6', new Rectangle(1007, 59, 16, 4));


            _tileSpriteAtlas.addRegion('icon_specialization_small_arrow', new Rectangle(559, 131, 11, 10));
            _tileSpriteAtlas.addRegion('icon_specialization_small_foot', new Rectangle(491, 131, 10, 10));
            _tileSpriteAtlas.addRegion('icon_specialization_small_heart', new Rectangle(548, 131, 11, 10));
            _tileSpriteAtlas.addRegion('icon_specialization_small_shield', new Rectangle(536, 131, 10, 10));
            _tileSpriteAtlas.addRegion('icon_specialization_small_skull', new Rectangle(525, 131, 10, 10));
            _tileSpriteAtlas.addRegion('icon_specialization_small_sword', new Rectangle(502, 131, 10, 10));
            _tileSpriteAtlas.addRegion('icon_specialization_small_stop', new Rectangle(608, 63, 10, 10));
            _tileSpriteAtlas.addRegion('icon_specialization_small_star', new Rectangle(513, 131, 11, 10));
        }

        private static function getUnitOffsetX(unitType:EnumUnitType):Number{
            switch(unitType){
                case(EnumUnitType.GRUNT): return 0;
                case(EnumUnitType.SOLDIER): return 0;
                case(EnumUnitType.PIKEMAN): return 0;
                case(EnumUnitType.ARCHER): return 0;
                case(EnumUnitType.KNIGHT): return 0;
                case(EnumUnitType.CAVALRY): return -8;
                case(EnumUnitType.GOO): return 0;
                case(EnumUnitType.SLIME): return 0;
                case(EnumUnitType.SHROOM): return 0;
                case(EnumUnitType.GARGOYLE): return 0;
                case(EnumUnitType.MINOTAUR): return -8;
                case(EnumUnitType.MANTICORE): return -8;
                case(EnumUnitType.FLAG_KING): return 0;
                case(EnumUnitType.FLAG_BRAIN): return -2;
                case(EnumUnitType.BONFIRE): return 0;
                case(EnumUnitType.TORCH): return 0;
                case(EnumUnitType.LANTERN): return 0;
                default: return 0;
            }
        }

        private static function getUnitOffsetY(unitType:EnumUnitType):Number{
            switch(unitType){
                case(EnumUnitType.GRUNT): return -9;
                case(EnumUnitType.SOLDIER): return -5;
                case(EnumUnitType.PIKEMAN): return -7;
                case(EnumUnitType.ARCHER): return -7;
                case(EnumUnitType.KNIGHT): return -12;
                case(EnumUnitType.CAVALRY): return -26;
                case(EnumUnitType.GOO): return 0;
                case(EnumUnitType.SLIME): return 7;
                case(EnumUnitType.SHROOM): return -8;
                case(EnumUnitType.GARGOYLE): return -8;
                case(EnumUnitType.MINOTAUR): return -14;
                case(EnumUnitType.MANTICORE): return -16;
                case(EnumUnitType.FLAG_KING): return -6;
                case(EnumUnitType.FLAG_BRAIN): return -10;
				case(EnumUnitType.BONFIRE): return -21;
				case(EnumUnitType.TORCH): return -21;
				case(EnumUnitType.LANTERN): return -21;
                default: return 0;
            }
        }

        private static function getUnitIsAlwaysAnimated(unitType:EnumUnitType):Boolean{
            switch(unitType){
                case(EnumUnitType.FLAG_BRAIN):
                case(EnumUnitType.FLAG_KING):
                case(EnumUnitType.BONFIRE):
                case(EnumUnitType.TORCH):
                case(EnumUnitType.LANTERN):
                case(EnumUnitType.TIKI_BLOCK):
                    return true;

                default:
                    return false;
            }
        }

        private static function getUnitIsAlwaysHiddenUnder(unitType:EnumUnitType):Boolean{
            switch(unitType){
                case(EnumUnitType.FAKE_WALL):
                    return true;

                default:
                    return false;
            }
        }

        private static function getUnitEmitsLight(unitType:EnumUnitType):Boolean{
            switch(unitType){
                case(EnumUnitType.FAKE_WALL):
                    return false;

                default:
                    return true;
            }
        }
        private static function getUnitFps(unitType:EnumUnitType):Number{
            switch(unitType){
                case(EnumUnitType.BONFIRE): return 8;
                case(EnumUnitType.LANTERN): return 8;
                case(EnumUnitType.TORCH): return 8;

                default: return 2;
            }
        }


		public static function get windowUiFrameTexture():Texture{
			return CoreInit.guiTextureAtlas.getTexture('menu_box_frame_ribbon');
		}

		public static function get windowUiHudFrameTexture():Texture{
			return CoreInit.guiTextureAtlas.getTexture('menu_box_frames4');
		}

		public static function get windowUiBackgroundTexture():Texture{
			return _windowUiBackground;
		}

		public static function getMapIsland(index:uint):Texture{
			index %= 18;
			return _mapAtlas.getTexture("map_island_" + index);
		}

		public static function getMapShadow(index:uint):Texture{
			switch(index % 18){
				case(0):
				case(1):
				case(6):
				case(7):
				case(12):
				case(13):
					return _mapAtlas.getTexture("map_shadow_2x2");

				case(2):
				case(3):
				case(8):
				case(9):
				case(14):
				case(15):
					return _mapAtlas.getTexture("map_shadow_3x3");

				case(4):
				case(10):
				case(17):
					return _mapAtlas.getTexture("map_shadow_4x3");

				case(5):
				case(11):
				case(16):
					return _mapAtlas.getTexture("map_shadow_3x4");
			}

			throw new Error("Invalid island index");
		}

		public static function getMapRibbon():Texture{
			return _mapAtlas.getTexture("map_ribbon");
		}

		public static function getMapLock():Texture{
			return _mapAtlas.getTexture("map_lock");
		}

		public static function getMapVictory():Texture{
			return _mapAtlas.getTexture("map_ribbon_victory2");
		}

		public static function createAchievementImage(achievement:Achievement):AchievementImage {
			var textureName:String = achievement.isAcquired ? "achievement_" + achievement.index : "locked_achievement_" + achievement.index;

			return new AchievementImage(achievement, _achievementsAtlas.getTexture(textureName));
		}
	}
}