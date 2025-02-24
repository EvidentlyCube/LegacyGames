
package net.retrocade.tacticengine.monstro.ingame.events {
    import net.retrocade.tacticengine.monstro.gui.windows.MonstroTutorialCard;

    public class MonstroEventRemoveTutorialCard extends MonstroEvent{
        public static const NAME:String = "remove_tutorial_card";

        public var card:MonstroTutorialCard;

        public function MonstroEventRemoveTutorialCard(card:MonstroTutorialCard) {
            this.card = card;

            dispatch(NAME);
        }
    }
}
