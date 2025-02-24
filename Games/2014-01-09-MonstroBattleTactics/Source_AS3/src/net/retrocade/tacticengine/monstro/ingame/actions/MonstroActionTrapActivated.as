package net.retrocade.tacticengine.monstro.ingame.actions{
    import flash.utils.getTimer;

    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.global.enum.EnumTrapType;

    import net.retrocade.tacticengine.monstro.ingame.traps.MonstroTrapFactory;

    public class MonstroActionTrapActivated extends MonstroAction{
        private var _trapType:EnumTrapType;
        
        public function MonstroActionTrapActivated(trapType:EnumTrapType){
            super(null);

            _trapType = trapType;
        }

        final override public function update():Boolean{
            switch(_trapType){
                case(EnumTrapType.WEB):
                    MonstroSfx.playTrapWeb();
                    break;

                case(EnumTrapType.SPIKES_BIG):
                case(EnumTrapType.SPIKES_MEDIUM):
                case(EnumTrapType.SPIKES_SMALL):
                    MonstroSfx.playTrapSpike();
                    break;
            }

            return true;
        }
    }
}