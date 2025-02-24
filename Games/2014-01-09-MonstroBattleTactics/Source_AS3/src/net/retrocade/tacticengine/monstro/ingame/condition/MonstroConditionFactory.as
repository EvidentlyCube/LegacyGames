
package net.retrocade.tacticengine.monstro.ingame.condition {
    import net.retrocade.tacticengine.core.MonstroField;

    public class MonstroConditionFactory {
        public static const DESTROY_ALL  :String = "destroyAll";
        public static const DESTROY_FLAG :String = "destroyFlag";
        public static const SURVIVE_TURNS:String = "surviveTurns";

        public static const LOSE_ALL   :String = "loseAll";
        public static const LOSE_ANY   :String = "lossAny";
        public static const LOSE_FLAG  :String = "loseFlag";
        public static const STALL_TURNS:String = "stallTurns";

        public static function getCondition(type:String, field:MonstroField, turns:int = 0):IMonstroCondition{
            switch(type){
                case(DESTROY_ALL):
                    return new MonstroVictoryConditionDefeatAll(field);
                case(DESTROY_FLAG):
                    return new MonstroVictoryConditionDestroyFlag(field);
                case(SURVIVE_TURNS):
                    return new MonstroVictoryConditionSurviveTurns(field, turns);
                case(LOSE_ALL):
                    return new MonstroLossConditionLoseAll(field);
                case(LOSE_ANY):
                    return new MonstroLossConditionLoseAny(field);
                case(LOSE_FLAG):
                    return new MonstroLossConditionLoseFlag(field);
                case(STALL_TURNS):
                    return new MonstroLossConditionStallTurns(field, turns);
                default:
                    return null;
            }
        }

        public static function getFromDump(descriptor:Object, field:MonstroField):IMonstroCondition{
            var condition:IMonstroCondition = getCondition(descriptor.type, field, 1);
            condition.loadFromDump(descriptor);

            return condition;
        }
    }
}
