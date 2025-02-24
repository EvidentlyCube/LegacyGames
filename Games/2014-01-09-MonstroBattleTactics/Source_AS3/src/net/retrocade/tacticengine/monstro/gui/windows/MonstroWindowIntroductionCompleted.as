
package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.signal.Signal;
	import net.retrocade.tacticengine.core.injector.injectCreate;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGameplayDefinition;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.global.data.levels.MonstroMainGameLevels;
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
	import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroStatsWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTransition;

	import starling.text.TextField;

	public class MonstroWindowIntroductionCompleted extends RetrocamelWindowStarling implements IWindowMissionFinished{
        public static function showWindow():MonstroWindowIntroductionCompleted{
            var instance:MonstroWindowIntroductionCompleted = injectCreate(MonstroWindowIntroductionCompleted);

            instance.show();

			return instance;
        }

        [Inject]
        public var gameplayDefinition:MonstroGameplayDefinition;

		private var _background:MonstroStatsWindowGrid9;
		private var _parchment:MonstroGrid9;
        private var _message:TextField;
        private var _startCampaignButton:MonstroTextButton;
        private var _titleScreenButton:MonstroTextButton;

        private var _optionsDisplayGroup:MonstroDisplayGroup;

		private var _isClosing:Boolean;
		private var _sliderCounter:WindowSliderCounter;
		private var _onClosing:Signal;

        public function init():void{
            CF::debug{ ASSERT(gameplayDefinition); }

			blockUnder = false;
			pauseGame = false;

			initCreateObjects();

            _optionsDisplayGroup = new MonstroDisplayGroup();
			_optionsDisplayGroup.addElements(optionElements);
			_optionsDisplayGroup.alignAllCenter();

			var insidesDisplayGroup:MonstroDisplayGroup = new MonstroDisplayGroup();
			insidesDisplayGroup.addElement(_parchment);
			insidesDisplayGroup.addElements(optionElements);
			insidesDisplayGroup.addElement(_titleScreenButton);
			insidesDisplayGroup.addElement(_startCampaignButton);

			_parchment.wrapAround(_optionsDisplayGroup);
			_titleScreenButton.forcedWidth = _startCampaignButton.forcedWidth = _parchment.innerWidth * 0.8;
			_startCampaignButton.alignCenterParent(0, _parchment.width);
			_titleScreenButton.alignCenterParent(0, _parchment.width);
			_startCampaignButton.y = _parchment.bottom;
			_titleScreenButton.y = _startCampaignButton.bottom + MonstroConsts.hudSpacer;

			_background.wrapAround(insidesDisplayGroup);

			_sliderCounter.speed = 0.04;

            addChild(_background);
            addChild(_parchment);
            addChildren(optionElements);
            addChild(_titleScreenButton);
            addChild(_startCampaignButton);

			insidesDisplayGroup.dispose();
        }

		private function initCreateObjects():void {
			_background = new MonstroStatsWindowGrid9();
			_parchment = MonstroGfx.getGrid9Parchment();
			_message = new TextField(600, 600, _("introduction.completed.body"), MonstroConsts.FONT_EBORACUM_48, 26, 0x382010);
			_startCampaignButton = new MonstroTextButton(getContinueButtonText(), continuePlayingHandler);
			_titleScreenButton = new MonstroTextButton("Return to title screen", returnToTitleHandler);

			_sliderCounter = new WindowSliderCounter(1.2);
			_onClosing = new Signal();

			_message.height = _message.textHeight + 20;
		}

		private function getContinueButtonText():String {
			if (MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.HUMAN) === 0){
				return "Start Human campaign";
			} else if (!MonstroData.getCampaignCompleted(EnumCampaignType.HUMAN)){
				return "Continue Human campaign";
			} else if (MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.MONSTER) === 0){
				return "Start Monster campaign";
			} else if (!MonstroData.getCampaignCompleted(EnumCampaignType.MONSTER)){
				return "Continue Monster campaign";
			} else if (MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.HUMAN_HARD) === 0){
				return "Start Human++ campaign";
			} else if (!MonstroData.getCampaignCompleted(EnumCampaignType.HUMAN_HARD)){
				return "Continue Human++ campaign";
			} else if (MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.MONSTER_HARD) === 0){
				return "Start Monster++ campaign";
			} else if (!MonstroData.getCampaignCompleted(EnumCampaignType.MONSTER_HARD)){
				return "Continue Monster++ campaign";
			} else {
				return "Go back to first level";
			}
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
            _message.dispose();
            _startCampaignButton.dispose();
            _titleScreenButton.dispose();
            _optionsDisplayGroup.dispose();

            _background = null;
            _message = null;
			_startCampaignButton = null;
			_titleScreenButton = null;
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

			middle= MonstroConsts.gameHeight / 2 + calculatedPosition * (MonstroConsts.gameHeight / 2 + height);

			alignCenter();
		}

        private function returnToTitleHandler():void{
			new MonstroEventTransition(MonstroEventTransition.TRANSITION_RETURN_TO_MENU);
			startClosing();
        }

        private function continuePlayingHandler():void{
			var campaignToPlay:EnumCampaignType;
			var levelToPlay:uint = 0;

			if (MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.HUMAN) === 0){
				campaignToPlay = EnumCampaignType.HUMAN;

			} else if (!MonstroData.getCampaignCompleted(EnumCampaignType.HUMAN)){
				campaignToPlay = EnumCampaignType.HUMAN;
				levelToPlay = MonstroMainGameLevels.getFirstUncompletedLevel(campaignToPlay);

			} else if (MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.MONSTER) === 0){
				campaignToPlay = EnumCampaignType.MONSTER;

			} else if (!MonstroData.getCampaignCompleted(EnumCampaignType.MONSTER)){
				campaignToPlay = EnumCampaignType.MONSTER;
				levelToPlay = MonstroMainGameLevels.getFirstUncompletedLevel(campaignToPlay);

			} else if (MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.HUMAN_HARD) === 0){
				campaignToPlay = EnumCampaignType.HUMAN_HARD;

			} else if (!MonstroData.getCampaignCompleted(EnumCampaignType.HUMAN_HARD)){
				campaignToPlay = EnumCampaignType.HUMAN_HARD;
				levelToPlay = MonstroMainGameLevels.getFirstUncompletedLevel(campaignToPlay);

			} else if (MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.MONSTER_HARD) === 0){
				campaignToPlay = EnumCampaignType.MONSTER_HARD;

			} else if (!MonstroData.getCampaignCompleted(EnumCampaignType.MONSTER_HARD)){
				campaignToPlay = EnumCampaignType.MONSTER_HARD;
				levelToPlay = MonstroMainGameLevels.getFirstUncompletedLevel(campaignToPlay);

			} else {
				campaignToPlay = EnumCampaignType.INTRODUCTION;
			}

			new MonstroEventTransition(MonstroEventTransition.TRANSITION_LOAD_SPECIFIC_LEVEL, campaignToPlay, levelToPlay);
			startClosing();
        }


        override public function resize():void {
            refreshPosition();
        }

		private function get optionElements():Array{
			return [_message];
		}

		public function get onClosing():Signal {
			return _onClosing;
		}

		public function get maxTopPosition():Number {
			return MonstroConsts.gameHeight / 2 - height / 2;
		}
	}
}