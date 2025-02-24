
package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.signal.Signal;
	import net.retrocade.tacticengine.core.injector.injectCreate;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.global.core.MonstroEscapeBlocker;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGameplayDefinition;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;
	import net.retrocade.tacticengine.monstro.ingame.achievements.AchievementImage;
	import net.retrocade.tacticengine.monstro.ingame.achievements.AchievementManager;
	import net.retrocade.tacticengine.monstro.ingame.achievements.MonstroAchievementTooltip;

	public class MonstroWindowAchievements extends RetrocamelWindowStarling {
		public static function showWindow(isVerticalHiding:Boolean):MonstroWindowAchievements {
			var instance:MonstroWindowAchievements = injectCreate(MonstroWindowAchievements);

			instance.isVerticalHiding = isVerticalHiding;
			instance.show();

			return instance;
		}

		[Inject]
		public var gameplayDefinition:MonstroGameplayDefinition;

		private var _achievementImages:Vector.<AchievementImage>;
		private var _background:MonstroPrettyWindowGrid9;
		private var _close:MonstroTextButton;
		private var _tooltip:MonstroAchievementTooltip;

		private var _isHiding:Boolean;
		private var _sliderCounter:WindowSliderCounter;

		public var isVerticalHiding:Boolean;
		public var onClosing:Signal;

		public function init():void {
			CF::debug{
				ASSERT(gameplayDefinition);
			}

			initCreateObjects();
			initSettings();

			var insideGroup:MonstroDisplayGroup = createAchievements();

			_close.forcedWidth = insideGroup.width * 0.8;
			_close.alignCenterParent(0, insideGroup.width);
			_close.y = insideGroup.bottom + MonstroConsts.hudSpacer * 10;

			insideGroup.addElement(_close);

			_background.header = _("achievements.header");
			_background.wrapAround(insideGroup);

			addChild(_background);
			insideGroup.addSelfTo(this);
			addChild(_close);
			addChild(_tooltip);

			insideGroup.dispose();
		}

		override public function hide():void {
			removeChildren();

			for each (var image:AchievementImage in _achievementImages) {
				image.dispose();
			}

			_achievementImages = null;

			_background.dispose();
			_close.dispose();
			_sliderCounter.dispose();
			onClosing.clear();

			_background = null;
			_close = null;
			_sliderCounter = null;
			onClosing = null;

			super.hide();
		}

		private function createAchievements():MonstroDisplayGroup {
			var achievementsGroup:MonstroDisplayGroup = new MonstroDisplayGroup();

			for (var i:int = 0; i < AchievementManager.achievements.length; i++) {
				var achievementImage:AchievementImage = MonstroGfx.createAchievementImage(AchievementManager.achievements[i]);

				achievementImage.x = (i % 5) * (achievementImage.width + MonstroConsts.hudSpacer * 3);
				achievementImage.y = (i / 5 | 0) * (achievementImage.height + MonstroConsts.hudSpacer * 3);

				achievementImage.onMouseOut.add(onMouseOut);
				achievementImage.onMouseOver.add(onMouseOver);

				_achievementImages.push(achievementImage);
				achievementsGroup.addElement(achievementImage);
			}

			return achievementsGroup;
		}

		private function onMouseOver(achievement:AchievementImage):void {
			_tooltip.showToAchievement(achievement);
		}

		private function onMouseOut(achievement:AchievementImage):void {
			_tooltip.hide();
		}


		private function initCreateObjects():void {
			_achievementImages = new <AchievementImage>[];
			_background = new MonstroPrettyWindowGrid9();
			_close = new MonstroTextButton(_("options.close"), onClose);
			_tooltip = new MonstroAchievementTooltip();

			_sliderCounter = new WindowSliderCounter(1.2);
			onClosing = new Signal();
		}

		private function initSettings():void {
			_isHiding = false;
			_pauseGame = false;
			_blockUnder = false;

			touchable = false;
			_sliderCounter.onStartHiding.add(makeUntouchable);
			_sliderCounter.onFinishedShowing.add(makeTouchable);
		}

		override public function show():void {
			super.show();

			resize();
		}

		override public function update():void {
			if (MonstroEscapeBlocker.isEscapeDown) {
				MonstroEscapeBlocker.flush();
				startHiding();
			}

			if (_sliderCounter.update()) {
				refreshPosition();
			}

			if (_sliderCounter.isFullyHidden) {
				hide();
			}
		}

		private function refreshPosition():void {
			var calculatedPosition:Number = _sliderCounter.positionFactor;

			if (isVerticalHiding) {
				middle = MonstroConsts.gameHeight / 2 + calculatedPosition * (MonstroConsts.gameHeight / 2 + height);
				alignCenter();
			} else {
				center = MonstroConsts.gameWidth / 2 + calculatedPosition * (MonstroConsts.gameWidth / 2 + width);
				alignMiddle();
			}
		}

		private function startHiding():void {
			if (_isHiding) {
				return;
			}

			_isHiding = true;

			MonstroData.commitData();
			_sliderCounter.hide();
			onClosing.call();
		}

		private function onClose():void {
			MonstroData.commitData();
			startHiding();
		}


		override public function resize():void {
			super.resize();

			refreshPosition();
		}
	}
}