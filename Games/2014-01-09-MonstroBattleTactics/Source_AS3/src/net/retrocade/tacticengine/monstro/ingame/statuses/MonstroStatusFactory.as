
package net.retrocade.tacticengine.monstro.ingame.statuses {
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

    public class MonstroStatusFactory {
        public static const STUN:String = "stun";

        public static function getFromDescriptor(descriptor:Object, unit:MonstroEntity):IMonstroStatus{
            var status:IMonstroStatus;

            switch(descriptor.name){
                case(STUN):
                    status = new MonstroStatusStun();
                    break;
            }

            status.unit = unit;
            status.loadFromDump(descriptor);

            return status;
        }
    }
}
