package net.retrocade.tacticengine.monstro.levelSelector {
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import net.retrocade.random.Random;
	import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;
	import net.retrocade.signal.Signal;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
	import net.retrocade.tacticengine.monstro.gui.helpers.MonstroCursorManager;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextField;
	import starling.textures.TextureSmoothing;

	public class LevelSelectionIsland implements IRetrocamelUpdatable{
		private static const FADED_OUT_ALPHA:Number = 0.5;
		private static var _filter:ColorMatrixFilter;
		private static var _filter2:ColorMatrixFilter;

		private var _x:Number = 0;
		private var _y:Number = 0;

		private var _islandImage:Image;
		private var _shadowImage:Image;
		private var _ribbonImage:Image;
		private var _levelNumber:TextField;
		private var _lockImage:Image;
		private var _victoryImage:Image;

		private var _animationPeriod:Number;
		private var _animationSpeed:Number;

		private var _islandRange:Number;
		private var _levelIndex:uint;

		private var _islandsContainer:Sprite;
		private var _isLevelCompleted:Boolean;

		public var onLevelSelected:Signal;
		public var onHover:Signal;
		public var onUnhover:Signal;

		public function LevelSelectionIsland(imageIndex:uint, levelIndex:uint, campaign:EnumCampaignType, islandsContainer:Sprite) {
			if (!_filter){
				_filter = new ColorMatrixFilter();
				_filter.reset();
				_filter.adjustBrightness(0.1);


				_filter2 = new ColorMatrixFilter();
				_filter2.reset();
				_filter2.colorFill(0xdfc97c, 0.4);
			}

			_islandsContainer = islandsContainer;
			_levelIndex = levelIndex;
			onLevelSelected = new Signal();
			onHover = new Signal();
			onUnhover = new Signal();

			_islandImage = new Image(MonstroGfx.getMapIsland(imageIndex));
			_shadowImage = new Image(MonstroGfx.getMapShadow(imageIndex));
			_ribbonImage = new Image(MonstroGfx.getMapRibbon());
			_victoryImage = new Image(MonstroGfx.getMapVictory());
			_levelNumber = new TextField(_ribbonImage.width, _ribbonImage.height, (levelIndex + 1).toString(), MonstroConsts.FONT_EBORACUM_64, 40, 0x382010);
			_lockImage = new Image(MonstroGfx.getMapLock());
			_islandImage.smoothing = TextureSmoothing.TRILINEAR;
			_ribbonImage.smoothing = TextureSmoothing.TRILINEAR;
			_levelNumber.smoothing = TextureSmoothing.TRILINEAR;
			_lockImage.smoothing = TextureSmoothing.TRILINEAR;
			_victoryImage.smoothing = TextureSmoothing.TRILINEAR;

			_animationPeriod = Random.defaultEngine.getNumberRange(0, Math.PI);
			_animationSpeed = Random.defaultEngine.getNumberRange(0.8, 1.2) * 2;
			_islandRange = Random.defaultEngine.getNumberRange(8, 16);

			_ribbonImage.center = _islandImage.center;

			_shadowImage.touchable = false;
			_ribbonImage.touchable = false;
			_levelNumber.touchable = false;
			_lockImage  .touchable = false;

			islandsContainer.addChild(_shadowImage);
			islandsContainer.addChild(_islandImage);
			islandsContainer.addChild(_ribbonImage);
			islandsContainer.addChild(_levelNumber);
			islandsContainer.addChild(_lockImage);
			islandsContainer.addChild(_victoryImage);

			_isLevelCompleted = MonstroData.isLevelCompleted(levelIndex, campaign);
			_lockImage.visible = false;
			_victoryImage.visible = false;

			_islandImage.filter =_isLevelCompleted ? null : _filter2;
			_ribbonImage.filter =_isLevelCompleted ? null : _filter2;
			_levelNumber.filter =_isLevelCompleted ? null : _filter2;
			_shadowImage.filter =_isLevelCompleted ? null : _filter2;
			_islandImage.addEventListener(TouchEvent.TOUCH, touchHandler);
		}

		public function dispose():void {
			_islandImage.removeEventListener(TouchEvent.TOUCH, touchHandler);

			_islandImage.filter = null;
			_shadowImage.filter = null;
			_ribbonImage.filter = null;
			_levelNumber.filter = null;

			_shadowImage.dispose();
			_islandImage.dispose();
			_ribbonImage.dispose();
			_levelNumber.dispose();
			_victoryImage.dispose();

			_shadowImage = null;
			_islandImage = null;
			_ribbonImage = null;
			_levelNumber = null;
			_victoryImage = null;

			onLevelSelected.clear();
			onHover.clear();
			onUnhover.clear();
		}

		public function update():void{
			_animationPeriod += _animationSpeed * Math.PI * 0.01;

			_islandImage.y = _shadowImage.middle - Math.cos(_animationPeriod) * _islandRange + _islandRange - _islandImage.height * 1.1;
			_ribbonImage.y = _islandImage.y - _ribbonImage.height - 10;
			_levelNumber.x = _ribbonImage.x;
			_levelNumber.y = _ribbonImage.y - 6;
			_shadowImage.alpha = 0.75 - Math.cos(_animationPeriod) * 0.25;

			_lockImage.x = _islandImage.x + _islandImage.width / 2 - _lockImage.width / 2;
			_lockImage.y = _islandImage.y + _islandImage.height / 2 - _lockImage.height / 2;

			_victoryImage.x = _islandImage.x + _islandImage.width / 2 - _victoryImage.width / 2;
			_victoryImage.y = _islandImage.y + _islandImage.height - _victoryImage.height * 0.5;
		}

		private function touchHandler(event:TouchEvent):void {
			var touch:Touch = event.getTouch(_islandImage);

			if (touch){
				var bounds:Rectangle = _islandImage.getBounds(_islandsContainer.stage);
				if (!bounds.containsPoint(new Point(touch.globalX, touch.globalY))) {
					unhover();
					return;
				} else {
					hoverEffect();
				}

				if (touch.phase === TouchPhase.ENDED){
					if (bounds.containsPoint(new Point(touch.globalX, touch.globalY))){
						trace("TOCHED");
						onLevelSelected.call(_levelIndex);
					} else {
						unhover();
					}
				}

			} else {
				unhover();
			}
		}

		public function get x():Number {
			return _x;
		}

		public function set x(value:Number):void {
			if (_x !== value){
				var deltaX:Number = value - _x;

				_islandImage.x += deltaX;
				_shadowImage.x += deltaX;
				_ribbonImage.x += deltaX;
				_levelNumber.x += deltaX;
				_lockImage.x += deltaX;
				_victoryImage.x += deltaX;

				_x = value;
			}
		}

		public function get y():Number {
			return _y;
		}

		public function set y(value:Number):void {
			if (_y !== value){
				var deltaY:Number = value - _y;

				_islandImage.y += deltaY;
				_shadowImage.y += deltaY;
				_ribbonImage.y += deltaY;
				_levelNumber.y += deltaY;
				_lockImage.y += deltaY;
				_victoryImage.y += deltaY;

				_y = value;
			}
		}

		public function hoverEffect():void{
			_islandImage.filter = _filter;
			_ribbonImage.filter = _filter;
			_levelNumber.filter = _filter;
			onHover.call(_levelIndex);

		}
		public function unhover():void {
			_islandImage.filter = null;
			onUnhover.call();

			_islandImage.filter =_isLevelCompleted ? null : _filter2;
			_ribbonImage.filter =_isLevelCompleted ? null : _filter2;
			_levelNumber.filter =_isLevelCompleted ? null : _filter2;
		}
	}
}
