package net.retrocade.tacticengine.monstro.global.core {
	import flash.display.Sprite;

	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;

	public class CoreSaveCrafter extends Sprite {

		public function CoreSaveCrafter() {
			MonstroData.init();

			MonstroData.setCampaignCompleted(EnumCampaignType.INTRODUCTION, true);

			for (var i:uint = 1; i < 20; i++){
				MonstroData.setLevelCompleted(i, EnumCampaignType.HUMAN, false);
				MonstroData.setLevelCompleted(i, EnumCampaignType.HUMAN_HARD, false);
				MonstroData.setLevelCompleted(i, EnumCampaignType.MONSTER, false);
				MonstroData.setLevelCompleted(i, EnumCampaignType.MONSTER_HARD, false);
			}

			MonstroData.commitData();
		}
	}
}
