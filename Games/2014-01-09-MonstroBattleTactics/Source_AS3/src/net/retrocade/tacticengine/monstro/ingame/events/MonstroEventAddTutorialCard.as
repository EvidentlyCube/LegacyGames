
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventAddTutorialCard extends MonstroEvent{
        public static const NAME:String = "add_tutorial_card";

        public var text:String;

        public function MonstroEventAddTutorialCard(text:String) {
            this.text = text;

            dispatch(NAME);
        }
    }
}
