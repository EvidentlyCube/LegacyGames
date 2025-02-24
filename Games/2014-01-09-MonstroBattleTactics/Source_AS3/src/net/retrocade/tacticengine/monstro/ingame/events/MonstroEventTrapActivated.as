package net.retrocade.tacticengine.monstro.ingame.events {
    import net.retrocade.retrocamel.global.RetrocamelEventsQueue;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;

    public class MonstroEventTrapActivated extends MonstroEvent {
        public static const NAME:String = "trap_activated";
        public var trap:IMonstroTrap;
        public var target:MonstroEntity;

        public function MonstroEventTrapActivated(trap:IMonstroTrap, target:MonstroEntity) {
            this.trap = trap;
            this.target = target;

            RetrocamelEventsQueue.add(MonstroConsts.EVENT_TRAP_ACTIVATED);

            dispatch(NAME);
        }

        override public function dispose():void {
            super.dispose();

            trap = null;
            target = null;
        }
    }
}