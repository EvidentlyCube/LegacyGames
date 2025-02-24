package net.retrocade.tacticengine.monstro.ingame.events
{
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;

    public class MonstroEventPrepareLoadLevel extends MonstroEvent{
		public static const NAME:String = "MonstroEventPrepareLoadLevel";

        public var levelIndex:int;
        public var campaignType:EnumCampaignType;

		public function MonstroEventPrepareLoadLevel(levelIndex:int, campaignType:EnumCampaignType){
            this.levelIndex = levelIndex;
            this.campaignType = campaignType;

            dispatch(NAME);
		}
	}
}