/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 17.01.13
 * Time: 10:11
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.actions {
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.events.MonstroEventDisplayAttackStats;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTap;

    public class MonstroActionShowAttackStats extends MonstroAction{
        private var _hasTapped:Boolean = false;
        private var _isInitialized:Boolean = false;

        private var _show:Boolean;
        private var _waitForTap:Boolean;
        private var _attacker:MonstroEntity;
        private var _defender:MonstroEntity;

        public function MonstroActionShowAttackStats(show:Boolean,
                                                     waitForTap:Boolean = false,
                                                     attacker:MonstroEntity = null,
                                                     defender:MonstroEntity = null) {
            super(null);

            _show = show;
            _waitForTap = waitForTap && Monstro.hasToConfirmEnemyAttack;
            _attacker = attacker;
            _defender = defender;
        }

        override public function update():Boolean{
            if (!_isInitialized){
                init();
            }

            return !_waitForTap || _hasTapped;
        }

        private function init():void{
            _isInitialized = true;

            Eventer.listen(MonstroEventTap.NAME, onTap);

            new MonstroEventDisplayAttackStats(_show, _waitForTap, _attacker, _defender);
        }

        private function onTap():void{
            if (_isInitialized){
                _hasTapped = true;
            }
        }

        override public function destruct():void{
            Eventer.release(MonstroEventTap.NAME, onTap);

            super.destruct();
        }
    }
}
