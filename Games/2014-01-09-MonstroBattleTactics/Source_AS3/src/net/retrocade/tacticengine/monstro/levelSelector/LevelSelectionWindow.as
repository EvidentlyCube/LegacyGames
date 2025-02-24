package net.retrocade.tacticengine.monstro.levelSelector {
	import flash.geom.Point;

	import net.retrocade.constants.KeyConst;
	import net.retrocade.retrocamel.components.RetrocamelUpdatableGroup;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.signal.Signal;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroEscapeBlocker;
	import net.retrocade.tacticengine.monstro.global.core.MonstroLevelDatabase;
	import net.retrocade.tacticengine.monstro.global.core.MonstroLoadedGfx;
	import net.retrocade.tacticengine.monstro.global.data.levels.MonstroMainGameLevels;
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
	import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.text.TextField;

	public class LevelSelectionWindow extends RetrocamelWindowStarling{

		public static function show(campaign:EnumCampaignType, isVerticalHiding:Boolean, currentlyPlayerLevel:int = -1):LevelSelectionWindow{
			var instance:LevelSelectionWindow = new LevelSelectionWindow(currentlyPlayerLevel, campaign);

			instance.isVerticalHiding = isVerticalHiding;
			instance.show();

			return instance;
		}

		private static const VERTICAL_SPACE_BELOW_MAP:uint = 50;

		private var _window:MonstroPrettyWindowGrid9;
		private var _mapParchment:Image;
		private var _mapParchmentContent:LevelSelectionBackground;
		private var _mapParchmentContentFadedTo:LevelSelectionBackground;
		private var _islandsList:RetrocamelUpdatableGroup;
		private var _islandsContainer:Sprite;
		private var _campaignType:EnumCampaignType;
		private var _missionTitle:TextField;
		private var _closeButton:MonstroTextButton;
		private var _nextButton:MonstroTextButton;
		private var _prevButton:MonstroTextButton;

		private var _screens:Vector.<LevelSelectionScreenDefinition>;

		private var _currentScreen:uint;

		private var _isHiding:Boolean;
		private var _sliderCounter:WindowSliderCounter;


		public var isVerticalHiding:Boolean;
		public var isInvertedHiding:Boolean;
		public var onClosing:Signal;
		public var onClosed:Signal;
		public var onLevelSelected:Signal;

		public function LevelSelectionWindow(currentlyPlayedLevel:int, campaignType:EnumCampaignType) {
			if (currentlyPlayedLevel === -1){
				currentlyPlayedLevel = MonstroMainGameLevels.getFirstUncompletedLevel(campaignType);
			}

			if (campaignType === EnumCampaignType.INTRODUCTION){
				_currentScreen = currentlyPlayedLevel / 4 | 0;
			} else {
				_currentScreen = currentlyPlayedLevel / 5 | 0;
			}

			_pauseGame = false;
			_blockUnder = false;

			_campaignType = campaignType;

			initCreateObjects();
			initAddChildren();
			initSetProperties();
			refreshIslands();

			resize();

			touchable = false;
		}

		override public function dispose():void{
			_islandsContainer.removeChildren();

			var island:LevelSelectionIsland;
			for each(island in _islandsList.getAllOriginal()){
				island.dispose();
			}

			_islandsList.clear();

			_window.dispose();
			_mapParchment.dispose();
			_islandsContainer.dispose();
			_closeButton.dispose();
			_nextButton.dispose();
			_prevButton.dispose();
			_missionTitle.dispose();
			_sliderCounter.dispose();
			onClosing.clear();
			onClosed.clear();
			onLevelSelected.clear();
		}

		override public function hide():void {
			onClosed.call();

			super.hide();

			dispose();
		}

		override public function update():void {
			CF::enableCheats{
				if (RetrocamelInputManager.isRightMouseDown) {
					var p:Point = new Point(RetrocamelInputManager.mouseX, RetrocamelInputManager.mouseY);
					p = _mapParchment.globalToLocal(p);

					getCurrentScreen().islands[_currentlyEditedIsland].x = p.x;
					getCurrentScreen().islands[_currentlyEditedIsland].y = p.y;

					LevelSelectionIsland(_islandsList.getAt(_currentlyEditedIsland)).x = p.x;
					LevelSelectionIsland(_islandsList.getAt(_currentlyEditedIsland)).y = p.y;
				}

				if (RetrocamelInputManager.isKeyHit(KeyConst.NUMPAD_PLUS)) {
					_currentlyEditedIsland++;
					if (_currentlyEditedIsland >= getCurrentScreen().islands.length){
						_currentlyEditedIsland = 0;
					}
				}
				if (RetrocamelInputManager.isKeyHit(KeyConst.NUMPAD_MINUS)) {
					_currentlyEditedIsland--;
					if (_currentlyEditedIsland < 0){
						_currentlyEditedIsland = getCurrentScreen().islands.length - 1;
					}
				}
				if (RetrocamelInputManager.isKeyHit(KeyConst.SPACE)) {
					for each(var i:LevelSelectionIslandDefinition in getCurrentScreen().islands){
						trace(i.x.toFixed(0) + ", " + i.y.toFixed());
					}
				}
			}

			if (_mapParchmentContentFadedTo){
				_mapParchmentContentFadedTo.alpha += 0.1;
				_islandsContainer.alpha -= 0.1;

				if (_mapParchmentContentFadedTo.alpha >= 1){
					removeChild(_mapParchmentContent);
					_mapParchmentContent.dispose();

					_mapParchmentContent = _mapParchmentContentFadedTo;
					_mapParchmentContentFadedTo = null;
					refreshIslands();
					touchable = true;
				}
				return;
			}

			if (_islandsContainer.alpha < 1){
				_islandsContainer.alpha += 0.1;
			}

			_islandsList.update();

			if (MonstroEscapeBlocker.isEscapeDown) {
				MonstroEscapeBlocker.flush();
				startHiding();
			}

			if (_sliderCounter.update()){
				refreshPosition();
			}

			if (_sliderCounter.isFullyHidden){
				hide();
			}
		}

		private function initCreateObjects():void {
			_screens = LevelSelectionScreenDefinition.generate(_campaignType);

			_window = new MonstroPrettyWindowGrid9();
			_mapParchment = new Image(MonstroLoadedGfx.mapParchment);
			_mapParchmentContent = new LevelSelectionBackground(getCurrentScreen().backgroundId);
			_islandsContainer = new Sprite();
			_islandsList = new RetrocamelUpdatableGroup();
			_closeButton = new MonstroTextButton("Close", closeHandler);
			_nextButton = new MonstroTextButton("Next page >>", nextScreenHandler);
			_prevButton = new MonstroTextButton("<< Prev page", prevScreenHandler);
			_missionTitle = new TextField(100, 50, "...", MonstroConsts.FONT_EBORACUM_48, 50, 0x382010);


			_sliderCounter = new WindowSliderCounter(1.2);
			onClosing = new Signal();
			onClosed = new Signal();
			onLevelSelected = new Signal();
		}

		private function initAddChildren():void {
			addChild(_window);
			addChild(_mapParchment);
			addChild(_mapParchmentContent);
			addChild(_islandsContainer);
			addChild(_closeButton);
			addChild(_nextButton);
			addChild(_prevButton);
			addChild(_missionTitle);
		}

		private function initSetProperties():void {
			touchable = false;
			_sliderCounter.onStartHiding.add(makeUntouchable);
			_sliderCounter.onFinishedShowing.add(makeTouchable);

			_window.header = _("campaign_" + _campaignType.name) + " Campaign";
			_missionTitle.text = "Please select a mission";
			_isHiding = false;
		}

		private function refreshIslands():void{
			_prevButton.enabled = !isFirstScreen;
			_nextButton.enabled = !isLastScreen;

			_islandsContainer.removeChildren();

			var island:LevelSelectionIsland;
			for each(island in _islandsList.getAllOriginal()){
				island.dispose();
			}

			_islandsList.clear();

			for each(var islandDefinition:LevelSelectionIslandDefinition in getCurrentScreen().islands){
				island = new LevelSelectionIsland(islandDefinition.islandImage, islandDefinition.levelIndex, _campaignType, _islandsContainer);
				island.onLevelSelected.add(levelSelectedHandler);
				island.onHover.add(onIslandHovered);
				island.onUnhover.add(onIslandUnhovered);

				island.x = islandDefinition.x;
				island.y = islandDefinition.y;

				_islandsList.add(island);

				island.update();
			}
		}

		private function startCrossfade():void{
			ASSERT(_mapParchmentContentFadedTo === null);

			_mapParchmentContentFadedTo = new LevelSelectionBackground(getCurrentScreen().backgroundId);
			_mapParchmentContentFadedTo.alpha = 0;

			addChildAt(_mapParchmentContentFadedTo, getChildIndex(_mapParchmentContent) + 1);

			resize();

			touchable = false;
		}

		private function refreshPosition():void {
			var calculatedPosition:Number = _sliderCounter.positionFactor;

			if (isVerticalHiding){
				middle = MonstroConsts.gameHeight / 2 + calculatedPosition * (MonstroConsts.gameHeight/ 2 + height);
				alignCenter();

				if (isInvertedHiding){
					x = MonstroConsts.gameWidth / 2 - _window.width / 2;
					y = MonstroConsts.gameHeight / 2 - calculatedPosition * (MonstroConsts.gameHeight / 2 + _window.height) - _window.height / 2;
				} else {
					x = MonstroConsts.gameWidth / 2 - _window.width / 2;
					y = MonstroConsts.gameHeight / 2 + calculatedPosition * (MonstroConsts.gameHeight / 2 + _window.height) - _window.height / 2;
				}
			} else {
				x = MonstroConsts.gameWidth / 2 + calculatedPosition * (MonstroConsts.gameWidth / 2 + _window.width) - _window.width / 2;
				y = MonstroConsts.gameHeight / 2 - _window.height / 2;
			}
		}

		override public function resize():void {
			super.resize();

			var availableWidth:Number = MonstroConsts.gameWidth * 0.9 - MonstroPrettyWindowGrid9.LEFT_EDGE - MonstroPrettyWindowGrid9.RIGHT_EDGE;
			var availableHeight:Number = MonstroConsts.gameHeight * 0.9 - MonstroPrettyWindowGrid9.TOP_EDGE - MonstroPrettyWindowGrid9.BOTTOM_EDGE - VERTICAL_SPACE_BELOW_MAP;

			if (availableWidth / availableHeight < _mapParchment.texture.width / _mapParchment.texture.height){
				_mapParchment.width = Math.min(_mapParchment.texture.width, availableWidth);
				//noinspection JSSuspiciousNameCombination
				_mapParchment.scaleY = _mapParchment.scaleX;
			} else {
				_mapParchment.height = Math.min(_mapParchment.texture.height, availableHeight);
				//noinspection JSSuspiciousNameCombination
				_mapParchment.scaleX = _mapParchment.scaleY;
			}

			_window.innerWidth = _mapParchment.width;
			_window.innerHeight = _mapParchment.height + VERTICAL_SPACE_BELOW_MAP;
			_mapParchment.x = _window.x + MonstroPrettyWindowGrid9.LEFT_EDGE;
			_mapParchment.y = _window.y + MonstroPrettyWindowGrid9.TOP_EDGE;

			_mapParchmentContent.fitToParchment(_mapParchment);
			if (_mapParchmentContentFadedTo){
				_mapParchmentContentFadedTo.fitToParchment(_mapParchment);
			}

			_islandsContainer.x = _mapParchment.x;
			_islandsContainer.y = _mapParchment.y;

			//noinspection JSSuspiciousNameCombination
			_islandsContainer.scaleX =_islandsContainer.scaleY =_mapParchment.scaleX;

			_prevButton.forcedWidth = _nextButton.forcedWidth = _closeButton.forcedWidth = _mapParchment.width * 0.8 / 3;
			_prevButton.y = _nextButton.y = _closeButton.y = _mapParchment.bottom + 10;

			_prevButton.x = _mapParchment.x;
			_nextButton.right = _mapParchment.right;
			_closeButton.center = _mapParchment.center;

			_missionTitle.fontSize = 50 * _mapParchment.scaleX;
			_missionTitle.width = _mapParchment.width;
			_missionTitle.height = 72 * _mapParchment.scaleX;
			_missionTitle.x = _mapParchment.x;
			_missionTitle.y = _mapParchment.y + 6 * _mapParchment.scaleX;

			refreshPosition();
		}

		private var _currentlyEditedIsland:int = 0;

		private function levelSelectedHandler(levelIndex:uint):void{
			touchable = false;
			onLevelSelected.call(levelIndex, _campaignType);
			isInvertedHiding = true;
		}

		public function startHiding():void {
			if (_isHiding){
				return;
			}

			_isHiding = true;

			touchable = false;
			_sliderCounter.hide();
			onClosing.call();
		}

		private function onIslandHovered(levelIndex:uint):void{
			_missionTitle.text = MonstroLevelDatabase.getLevelTitle(_campaignType, levelIndex);
		}

		private function onIslandUnhovered():void{
			_missionTitle.text = "Please select a mission";
		}

		private function closeHandler():void{
			startHiding();
		}

		private function nextScreenHandler():void{
			_currentScreen++;

			startCrossfade();
//			refreshIslands();
		}

		private function prevScreenHandler():void{
			_currentScreen--;

			startCrossfade();
//			refreshIslands();
		}

		private function get isFirstScreen():Boolean{
			return _currentScreen === 0;
		}

		private function get isLastScreen():Boolean{
			return _currentScreen === _screens.length - 1;
		}

		private function getCurrentScreen():LevelSelectionScreenDefinition{
			return _screens[_currentScreen];
		}
	}
}
