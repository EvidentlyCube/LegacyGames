package net.retrocade.tacticengine.monstro.ingame.events
{
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;

    public class MonstroEventLevelLoaded extends MonstroEvent{
		public static const NAME:String = "level_loaded";

        public var levelIndex:int;
        public var levelType:EnumCampaignType;
        public var saveState:String;

		public function MonstroEventLevelLoaded(levelIndex:int, campaignType:EnumCampaignType, saveState:String = null){
            this.levelIndex = levelIndex;
            this.levelType = campaignType;
            this.saveState = saveState;

            dispatch(NAME);
		}
	}
}