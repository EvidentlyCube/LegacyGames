
package net.retrocade.tacticengine.monstro.ingame.specializations {
    public class MonstroSpecializationFactory {
        public static const TYPE_ARROW:String = "arrow";
        public static const TYPE_FOOT:String = "foot";
        public static const TYPE_HEART:String = "heart";
        public static const TYPE_SHIELD:String = "shield";
        public static const TYPE_SKULL:String = "skull";
        public static const TYPE_SWORD:String = "sword";
        public static const TYPE_STAR:String = "star";
        public static const TYPE_STOP:String = "stop";

        public static function getSpecialization(specializationType:String):IMonstroSpecialization {
            switch(specializationType){
                default:
                    return new MonstroSpecializationGeneric(specializationType)
            }
        }

        public static function loadFromDump(dump:Object):IMonstroSpecialization{
            var specialization:IMonstroSpecialization = getSpecialization(dump.type);
            specialization.loadFromDump(dump);

            return specialization;
        }
    }
}
