
package net.retrocade.tacticengine.monstro.ingame.traps {
    import net.retrocade.tacticengine.monstro.global.enum.EnumTrapType;

    public class MonstroTrapFactory {
        public static function getTrap(trapType:EnumTrapType):IMonstroTrap{
            switch(trapType){
                case(EnumTrapType.WEB):
                    return new MonstroTrapWeb();
                case(EnumTrapType.SPIKES_SMALL):
                    return new MonstroTrapSpike(trapType, 3);
                case(EnumTrapType.SPIKES_MEDIUM):
                    return new MonstroTrapSpike(trapType, 8);
                case(EnumTrapType.SPIKES_BIG):
                    return new MonstroTrapSpike(trapType, 20);
                default:
                    return null;
            }
        }

        public static function getFromDump(descriptor:Object):IMonstroTrap{
            var trap:IMonstroTrap = getTrap(EnumTrapType.byName(descriptor.name));
            trap.loadFromDump(descriptor);

            return trap;
        }
    }
}
