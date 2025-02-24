package net.retrocade.tacticengine.monstro.ingame.events
{
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;

	public class MonstroEventTransition extends MonstroEvent{
		public static const NAME:String = "return_to_menu";

        public static const TRANSITION_RESTART_MISSION:int = 0;
        public static const TRANSITION_RETURN_TO_MENU:int = 1;
        public static const TRANSITION_NEXT_MISSION:int = 2;
        public static const TRANSITION_RESTART_AND_LOAD_STATE:int = 3;
        public static const TRANSITION_SHOW_END_CAMPAIGN_SCREEN:int = 4;
        public static const TRANSITION_LOAD_SPECIFIC_LEVEL:int = 5;
        public static const TRANSITION_UNDO_LAST_MOVE:int = 6;

        public var type:int;
		public var campaignToLoad:EnumCampaignType;
		public var levelIndexToLoad:uint;

		public function MonstroEventTransition(type:int, campaign:EnumCampaignType = null, levelIndex:uint = -1){
            this.type = type;
			this.campaignToLoad = campaign;
			this.levelIndexToLoad = levelIndex;

            dispatch(NAME);
		}
	}
}