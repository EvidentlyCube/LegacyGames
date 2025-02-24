package net.retrocade.tacticengine.monstro.gui.components {
	import net.retrocade.retrocamel.locale.RetrocamelLocale;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
	import net.retrocade.tacticengine.monstro.global.enum.EnumUnitFaction;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroGrid9;
	import net.retrocade.tacticengine.monstro.ingame.condition.IMonstroCondition;
	import net.retrocade.tacticengine.monstro.ingame.condition.MonstroConditionFactory;
	import net.retrocade.tacticengine.monstro.ingame.condition.MonstroLossConditionStallTurns;
	import net.retrocade.tacticengine.monstro.ingame.condition.MonstroVictoryConditionSurviveTurns;

	import starling.display.DisplayObjectContainer;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;

	public class MissionObjectives extends DisplayObjectContainer{
		private var _parchment:MonstroGrid9;

		private var _levelNameHeader:TextField;
		private var _levelDescription:TextField;
		private var _victoryConditionHeader:TextField;
		private var _victoryConditionBody:TextField;
		private var _loseConditionHeader:TextField;
		private var _loseConditionBody:TextField;

		public function MissionObjectives() {
			createObjects();

			var metaElementsGroup:MonstroDisplayGroup = new MonstroDisplayGroup();
			metaElementsGroup.addElements(elementsArray);
			metaElementsGroup.alignAllCenter();
			metaElementsGroup.verticalizePrecise(MonstroConsts.hudSpacer, 0, [_victoryConditionHeader, _loseConditionHeader]);

			_parchment.wrapAround(metaElementsGroup);

			metaElementsGroup.addElement(_parchment);

			addChild(_parchment);
			addChildren(elementsArray);

			metaElementsGroup.dispose();
		}

		override public function dispose():void {
			removeChildren();

			_levelNameHeader.dispose();
			_levelDescription.dispose();
			_victoryConditionHeader.dispose();
			_victoryConditionBody.dispose();
			_loseConditionHeader.dispose();
			_loseConditionBody.dispose();
			_parchment.dispose();

			_levelNameHeader = null;
			_levelDescription = null;
			_victoryConditionBody = null;
			_loseConditionHeader = null;
			_loseConditionBody = null;
			_parchment = null;
		}

		private function createObjects():void {
			_parchment = MonstroGfx.getGrid9Parchment();

			var levelNameText:String = campaignName + " #" + levelIndex + ": " + levelName;

			_levelNameHeader = new TextField(2000, 50, levelNameText, MonstroConsts.FONT_EBORACUM_48, 48, 0x382010);
			_levelDescription = new TextField(600, 500, levelDescription ? levelDescription : "<mission description missing>", MonstroConsts.FONT_EBORACUM_48, 24, 0x382010);
			_victoryConditionHeader = new TextField(600, 45, _("pause.victory.header"), MonstroConsts.FONT_EBORACUM_48, 38, 0x144715);
			_victoryConditionBody = new TextField(600, 35, victoryConditionText, MonstroConsts.FONT_EBORACUM_48, 24, 0x382010);
			_loseConditionHeader = new TextField(600, 45, _("pause.failure.header"), MonstroConsts.FONT_EBORACUM_48, 38, 0x471414);
			_loseConditionBody = new TextField(600, 35, loseConditionText, MonstroConsts.FONT_EBORACUM_48, 24, 0x382010);

			_levelNameHeader.autoSize = TextFieldAutoSize.HORIZONTAL;
			_levelNameHeader.width = _levelNameHeader.textWidth;
			_levelNameHeader.autoSize = TextFieldAutoSize.NONE;
			_levelNameHeader.hAlign = HAlign.CENTER;

			_levelDescription.width = Math.max(800, _levelNameHeader.width);
			_levelDescription.autoSize = TextFieldAutoSize.VERTICAL;
			_levelDescription.height = _levelDescription.textHeight + 50;
			_levelDescription.autoSize = TextFieldAutoSize.NONE;
		}

		private function get elementsArray():Array{
			return [_levelNameHeader, _levelDescription, _victoryConditionHeader, _victoryConditionBody, _loseConditionHeader, _loseConditionBody];
		}

		private static function get victoryCondition():IMonstroCondition {
			return MonstroStateIngame.instance.victoryCondition;
		}

		private static function get loseCondition():IMonstroCondition {
			return MonstroStateIngame.instance.lossCondition;
		}

		private static function get levelIndex():int {
			return MonstroStateIngame.instance.currentLevelIndex + 1;
		}

		private static function get levelName():String {
			return MonstroStateIngame.instance.levelStats.levelName;
		}

		private static function get levelDescription():String {
			var name:String = "description." +MonstroStateIngame.instance.currentCampaignType.name + "_" + MonstroStateIngame.instance.currentLevelIndex;
			if (RetrocamelLocale.has("en", name) && _(name) !== ""){
				return _(name);
			} else {
				return "<description missing>";
			}
		}

		private static function get campaignName():String{
			switch (MonstroStateIngame.instance.currentCampaignType){
				case(EnumCampaignType.INTRODUCTION): return _("campaign.tutorial");
				case(EnumCampaignType.HUMAN): return _("campaign.human");
				case(EnumCampaignType.HUMAN_HARD): return _("campaign.human++");
				case(EnumCampaignType.MONSTER): return _("campaign.monster");
				case(EnumCampaignType.MONSTER_HARD): return _("campaign.monster++");
				default: throw new Error("Invalid campaign type");
			}
		}

		private static function get controlledType():EnumUnitFaction{
			return MonstroStateIngame.instance.playerControls;
		}

		private function get victoryConditionText():String {
			switch (victoryCondition.type) {
				case(MonstroConditionFactory.DESTROY_ALL):
					return _(controlledType.isHuman() ? "victory.destroyAllMonsters" : "victory.destroyAllHumans");

				case(MonstroConditionFactory.DESTROY_FLAG):
					return _(controlledType.isHuman() ? "victory.destroyBrain" : "victory.destroyKing");

				case(MonstroConditionFactory.SURVIVE_TURNS):
					return _("victory.surviveTurns", MonstroVictoryConditionSurviveTurns(victoryCondition).turnCount);

				default:
					throw new Error("Invalid victory condition type");
			}
		}

		private function get loseConditionText():String {
			switch (loseCondition.type) {
				case(MonstroConditionFactory.LOSE_ALL):
					return _("failure.loseAll");

				case(MonstroConditionFactory.LOSE_ANY):
					return _("failure.loseAny");

				case(MonstroConditionFactory.LOSE_FLAG):
					return _(controlledType.isHuman() ? "failure.loseKing" : "failure.loseBrain");

				case(MonstroConditionFactory.STALL_TURNS):
					return _("failure.stall", MonstroLossConditionStallTurns(loseCondition).turnCount);

				default:
					throw new Error("Invalid lose condition type");
			}
		}
	}
}
