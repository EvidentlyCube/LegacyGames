
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventMissionFinished extends MonstroEvent{
        public static const NAME:String = "mission_finished";

        public var isVictory:Boolean;
        public var showEndCampaignScreen:Boolean;

        public function MonstroEventMissionFinished(isVictory:Boolean, showEndCampaignScreen:Boolean = false){
            this.isVictory = isVictory;
            this.showEndCampaignScreen = showEndCampaignScreen;

            dispatch(NAME);
        }
    }
}
