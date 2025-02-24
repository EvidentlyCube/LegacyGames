
package net.retrocade.tacticengine.monstro.ingame.events {
    import net.retrocade.tacticengine.monstro.ingame.condition.IMonstroCondition;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

    public class MonstroEventChangeConditions extends MonstroEvent{
        public static const NAME:String = "change_conditions";

        public var victoryCondition:IMonstroCondition;
        public var lossCondition:IMonstroCondition;

        public function MonstroEventChangeConditions(victoryCondition:IMonstroCondition, lossCondition:IMonstroCondition){
            this.victoryCondition = victoryCondition;
            this.lossCondition = lossCondition;

            dispatch(NAME);
        }
    }
}
