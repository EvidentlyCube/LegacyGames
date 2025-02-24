
package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.signal.Signal;
	import net.retrocade.tacticengine.core.injector.injectCreate;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;
	import net.retrocade.tacticengine.monstro.ingame.achievements.AchievementManager;

	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class MonstroWindowCredits extends RetrocamelWindowStarling implements IWindowMissionFinished{
		public static var displayedCredits:Boolean = false;

		public static function showWindow():MonstroWindowCredits{
			var instance:MonstroWindowCredits = injectCreate(MonstroWindowCredits);
			displayedCredits = true;

			AchievementManager.updateGeneral();
			instance.show();

			return instance;
		}

		private var _background:MonstroPrettyWindowGrid9;
		private var _parchment:MonstroGrid9;
		private var _messageLeft:TextField;
		private var _messageRight:TextField;
		private var _startCampaignButton:MonstroTextButton;

		private var _optionsDisplayGroup:MonstroDisplayGroup;

		private var _isClosing:Boolean;
		private var _sliderCounter:WindowSliderCounter;
		private var _onClosing:Signal;

		public function init():void{
			blockUnder = false;
			pauseGame = false;

			initCreateObjects();

			_optionsDisplayGroup = new MonstroDisplayGroup();
			_optionsDisplayGroup.addElements(parchmentContents);
			_optionsDisplayGroup.alignAllCenter();

			var insidesDisplayGroup:MonstroDisplayGroup = new MonstroDisplayGroup();
			insidesDisplayGroup.addElement(_parchment);
			insidesDisplayGroup.addElements(parchmentContents);
			insidesDisplayGroup.addElement(_startCampaignButton);

			_parchment.wrapAround(_optionsDisplayGroup);
			_startCampaignButton.forcedWidth = _parchment.innerWidth * 0.8;
			_startCampaignButton.alignCenterParent(0, _parchment.width);
			_startCampaignButton.y = _parchment.bottom;

			_background.wrapAround(insidesDisplayGroup);

			_sliderCounter.speed = 0.04;

			addChild(_background);
			addChild(_parchment);
			addChildren(parchmentContents);
			addChild(_startCampaignButton);

			insidesDisplayGroup.dispose();
		}

		private function initCreateObjects():void {
			_background = new MonstroPrettyWindowGrid9();
			_parchment = MonstroGfx.getGrid9Parchment();
			_messageLeft = new TextField(800, 600, _("credits.headers"), MonstroConsts.FONT_EBORACUM_48, 26, 0x382010);
			_messageRight = new TextField(800, 600, _("credits.body"), MonstroConsts.FONT_EBORACUM_48, 26, 0x744322);
			_startCampaignButton = new MonstroTextButton("Close", closeWindowHandler);

			_sliderCounter = new WindowSliderCounter(1.2);
			_onClosing = new Signal();

			_messageLeft.leading = 14;
			_messageRight.leading = 14;

			_background.header = "Credits";
			_messageLeft.hAlign = HAlign.LEFT;
			_messageLeft.vAlign = VAlign.TOP;
			_messageRight.hAlign = HAlign.RIGHT;
			_messageRight.vAlign = VAlign.TOP;

			_messageLeft.height = _messageLeft.textHeight + 20;
			_messageRight.height = _messageRight.textHeight + 20;
		}

		override public function show():void{
			super.show();

			visible = true;
			_isClosing = false;
			touchable = false;

			_sliderCounter.position = 1.2;
			_sliderCounter.show();

			resize();
			_sliderCounter.onStartHiding.add(makeUntouchable);
			_sliderCounter.onFinishedShowing.add(makeTouchable);
		}

		override public function hide():void {
			removeChildren();

			_background.dispose();
			_messageLeft.dispose();
			_messageRight.dispose();
			_startCampaignButton.dispose();
			_optionsDisplayGroup.dispose();

			_background = null;
			_messageLeft = null;
			_messageRight = null;
			_startCampaignButton = null;
			_optionsDisplayGroup = null;

			super.hide();
		}

		override public function update():void {
			if (_sliderCounter.update()) {
				refreshPosition();
			} else {
				_sliderCounter.speed = 0.07;
			}

			if (_sliderCounter.isFullyHidden) {
				visible = false;
			}
		}

		private function startClosing():void {
			if (_isClosing) {
				return;
			}

			_isClosing = true;

			_sliderCounter.hide();
			_onClosing.call();
		}

		private function refreshPosition():void {
			var calculatedPosition:Number = _sliderCounter.positionFactor;

			center = MonstroConsts.gameWidth / 2 + calculatedPosition * (MonstroConsts.gameWidth / 2 + width);

			alignMiddle();
		}

		private function closeWindowHandler():void{
			startClosing();
		}


		override public function resize():void {
			refreshPosition();
		}

		private function get parchmentContents():Array{
			return [_messageLeft, _messageRight];
		}

		public function get onClosing():Signal {
			return _onClosing;
		}

		public function get maxTopPosition():Number {
			return MonstroConsts.gameHeight / 2 - height / 2;
		}
	}
}