package net.retrocade.tacticengine.monstro.ingame.events
{
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;

    public class MonstroEventLoadLevel extends MonstroEvent{
		public static const NAME:String = "load_level";

        public var levelIndex:int;
        public var campaignType:EnumCampaignType;
        public var saveState:String;

		public function MonstroEventLoadLevel(levelIndex:int, campaignType:EnumCampaignType, saveState:String = null){
            this.levelIndex = levelIndex;
            this.campaignType = campaignType;
            this.saveState = saveState;

            dispatch(NAME);
		}
	}
}