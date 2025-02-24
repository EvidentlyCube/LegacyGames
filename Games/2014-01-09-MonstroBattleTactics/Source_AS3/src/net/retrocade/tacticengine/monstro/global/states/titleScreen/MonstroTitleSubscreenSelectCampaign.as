
package net.retrocade.tacticengine.monstro.global.states.titleScreen {
    import net.retrocade.retrocamel.locale._;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroPrettyWindowGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventPrepareLoadLevel;
	import net.retrocade.tacticengine.monstro.levelSelector.LevelSelectionWindow;

    public class MonstroTitleSubscreenSelectCampaign extends MonstroTitleSubscreenRoot {
        public static const CONTINUE_SAVE:String = "continue_save";
        public static const TUTORIAL_CAMPAIGN:String = "tutorial_campaign";
        public static const HUMAN_CAMPAIGN:String = "human_campaign";
        public static const HUMAN_CAMPAIGN_HARD:String = "human_campaign_hard";
        public static const MONSTER_CAMPAIGN:String = "monster_campaign";
        public static const MONSTER_CAMPAIGN_HARD:String = "monster_campaign_hard";
        public static const BACK_TO_MAIN_MENU:String = "back_to_main_menu";

		private var _background:MonstroPrettyWindowGrid9;
        private var _buttonContinue:MonstroTextButton;
        private var _buttonTutorial:MonstroTextButton;
        private var _buttonHuman:MonstroTextButton;
        private var _buttonHumanHard:MonstroTextButton;
        private var _buttonMonster:MonstroTextButton;
        private var _buttonMonsterHard:MonstroTextButton;
        private var _buttonReturn:MonstroTextButton;

		private var _hidingInverted:Boolean = false;

        public function MonstroTitleSubscreenSelectCampaign() {
            super();

			initCreateObjects();
			initSetProperties();

			var displayGroup:MonstroDisplayGroup = new MonstroDisplayGroup();

			addChild(_background);
			addChildren(buttons);

			displayGroup.addElements(buttons);
			displayGroup.verticalizePrecise(MonstroConsts.hudSpacer, 0, [_buttonTutorial, _buttonHuman, _buttonHumanHard, _buttonReturn], 5);

			_background.wrapAround(displayGroup);
        }

		private function initSetProperties():void {
			_buttonContinue.data.type = CONTINUE_SAVE;
			_buttonTutorial.data.type = TUTORIAL_CAMPAIGN;
			_buttonHuman.data.type = HUMAN_CAMPAIGN;
			_buttonHumanHard.data.type = HUMAN_CAMPAIGN_HARD;
			_buttonMonster.data.type = MONSTER_CAMPAIGN;
			_buttonMonsterHard.data.type = MONSTER_CAMPAIGN_HARD;
			_buttonReturn.data.type = BACK_TO_MAIN_MENU;

			_buttonContinue.enabled = MonstroData.hasSaveState();

			_buttonHuman.enabled = MonstroData.getCampaignCompleted(EnumCampaignType.INTRODUCTION);
			_buttonMonster.enabled = MonstroData.getCampaignCompleted(EnumCampaignType.INTRODUCTION);

			_buttonHumanHard.enabled = (MonstroData.getCampaignCompleted(EnumCampaignType.HUMAN) || MonstroData.getCampaignCompleted(EnumCampaignType.MONSTER));
			_buttonMonsterHard.enabled = (MonstroData.getCampaignCompleted(EnumCampaignType.HUMAN) && MonstroData.getCampaignCompleted(EnumCampaignType.MONSTER) && MonstroData.getCampaignCompleted(EnumCampaignType.HUMAN_HARD));

			if (CF::enableCheats){
				_buttonHuman.enabled = true;
				_buttonMonster.enabled = true;
				_buttonHumanHard.enabled = true;
				_buttonMonsterHard.enabled = true;
			}
			_background.header = "Select campaign";

			_sliderCounter.onFinishedShowing.add(finishedShowingHandler);
		}

		private function initCreateObjects():void {
			_background = new MonstroPrettyWindowGrid9();
			_buttonContinue = new MonstroTextButton(getContinueText(), onClick, 400);
			_buttonTutorial = new MonstroTextButton(_("title_campaign_tutorial"), campaignSelectedHandler, 400);
			_buttonHuman = new MonstroTextButton(_("title_human"), campaignSelectedHandler, 400);
			_buttonMonster = new MonstroTextButton(_("title_monster"), campaignSelectedHandler, 400);
			_buttonHumanHard = new MonstroTextButton(_("title_human++"), campaignSelectedHandler, 400);
			_buttonMonsterHard = new MonstroTextButton(_("title_monster++"), campaignSelectedHandler, 400);
			_buttonReturn = new MonstroTextButton(_("title_return"), onClick, 400);
		}

		override protected function refreshPosition():void {
			var calculatedPosition:Number = _sliderCounter.positionFactor;
			if (_hidingInverted){
				x = MonstroConsts.gameWidth / 2 - calculatedPosition * (MonstroConsts.gameWidth / 2 + _background.width) - _background.width / 2;
			} else {
				x = MonstroConsts.gameWidth / 2 + calculatedPosition * (MonstroConsts.gameWidth / 2 + _background.width) - _background.width / 2;
			}

			y = MonstroConsts.gameHeight / 2 - _background.height / 2;
		}
		private function getContinueText():String {
            if (MonstroData.hasSaveState()) {
                return _(
                    "title_continueCombo",
                    getCampaignTypeName(MonstroData.getSaveStateLevelType()),
                    MonstroData.getSaveStateLevelIndex() + 1
                );
            } else {
                return _("title_continueNo")
            }
        }

		private function campaignSelectedHandler(button:MonstroTextButton):void{
			var levelSelectionWindow:LevelSelectionWindow;

			switch(button.data.type){
				case(TUTORIAL_CAMPAIGN):
					levelSelectionWindow = LevelSelectionWindow.show(EnumCampaignType.INTRODUCTION, false);
					break;
				case(HUMAN_CAMPAIGN):
					levelSelectionWindow = LevelSelectionWindow.show(EnumCampaignType.HUMAN, false);
					break;
				case(HUMAN_CAMPAIGN_HARD):
					levelSelectionWindow = LevelSelectionWindow.show(EnumCampaignType.HUMAN_HARD, false);
					break;
				case(MONSTER_CAMPAIGN):
					levelSelectionWindow = LevelSelectionWindow.show(EnumCampaignType.MONSTER, false);
					break;
				case(MONSTER_CAMPAIGN_HARD):
					levelSelectionWindow = LevelSelectionWindow.show(EnumCampaignType.MONSTER_HARD, false);
					break;
			}

			levelSelectionWindow.onClosing.add(show);
			levelSelectionWindow.onLevelSelected.add(onLevelSelected);

			_sliderCounter.hide();
			_hidingInverted = true;
		}

		private function onLevelSelected(levelIndex:int, campaignType:EnumCampaignType):void{
			new MonstroEventPrepareLoadLevel(levelIndex, campaignType);
		}

        private function getCampaignTypeName(campaignType:EnumCampaignType):String {
            switch (campaignType) {
                case(EnumCampaignType.INTRODUCTION):
                    return _("title_campaign_tutorial");
                case(EnumCampaignType.HUMAN):
                    return _("title_human");
                case(EnumCampaignType.MONSTER):
                    return _("title_monster");
                case(EnumCampaignType.HUMAN_HARD):
                    return _("title_human++");
                case(EnumCampaignType.MONSTER_HARD):
                    return _("title_monster++");
                default:
                    return _("title_invalid");
            }
        }

        override public function dispose():void {
            super.dispose();

            _buttonContinue.dispose();
            _buttonTutorial.dispose();
            _buttonHuman.dispose();
            _buttonHumanHard.dispose();
            _buttonMonster.dispose();
            _buttonMonsterHard.dispose();
            _buttonReturn.dispose();

            _buttonContinue = null;
            _buttonTutorial = null;
            _buttonHuman = null;
            _buttonHumanHard = null;
            _buttonMonster = null;
            _buttonMonsterHard = null;
            _buttonReturn = null;
        }

		private function finishedShowingHandler():void{
			_hidingInverted = false;
		}

		private function get buttons():Array {
		  	return [_buttonContinue, _buttonTutorial, _buttonHuman, _buttonMonster, _buttonHumanHard, _buttonMonsterHard, _buttonReturn];
		}

    }
}
