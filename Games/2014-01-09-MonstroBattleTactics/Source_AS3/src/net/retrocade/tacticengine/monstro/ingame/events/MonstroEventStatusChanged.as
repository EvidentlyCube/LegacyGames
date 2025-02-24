package net.retrocade.tacticengine.monstro.ingame.events {
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.statuses.IMonstroStatus;

    public class MonstroEventStatusChanged extends MonstroEvent {
        public static const NAME:String = "status_changed";
        public var status:IMonstroStatus;
        public var target:MonstroEntity;
        public var wasAdded:Boolean;

        public function MonstroEventStatusChanged(status:IMonstroStatus, target:MonstroEntity, wasAdded:Boolean) {
            this.status = status;
            this.target = target;
            this.wasAdded = wasAdded;

            dispatch(NAME);
        }

        override public function dispose():void {
            super.dispose();

            status = null;
            target = null;
        }
    }
}