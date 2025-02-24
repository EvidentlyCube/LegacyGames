
package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.tacticengine.monstro.gui.render.MonstroUnitClip;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.statuses.IMonstroStatus;
    import net.retrocade.tacticengine.monstro.ingame.statuses.MonstroStatusFactory;

    public class MonstroActionStatusChanged extends MonstroAction{
        private var _status:IMonstroStatus;
        private var _targetUnit:MonstroEntity;
        private var _targetImage:MonstroUnitClip;
        private var _wasAdded:Boolean;

        public function MonstroActionStatusChanged(status:IMonstroStatus, targetUnit:MonstroEntity, targetImage:MonstroUnitClip, wasAdded:Boolean) {
            super(null);

            _status = status;
            _targetUnit = targetUnit;
            _targetImage = targetImage;
            _wasAdded = wasAdded;
        }

        override public function update():Boolean{
            switch(_status.name){
                case(MonstroStatusFactory.STUN):
                    _targetImage.isStunned = _wasAdded;
                    break;
            }

            return true;
        }
    }
}
