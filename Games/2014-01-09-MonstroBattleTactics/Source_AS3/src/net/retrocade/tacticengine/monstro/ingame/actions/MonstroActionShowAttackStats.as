
package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.retrocamel.core.RetrocamelInputManager;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDisplayAttackStats;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTap;

    public class MonstroActionShowAttackStats extends MonstroAction{
        private static const CHAR_CODE_SPACE:uint = 32;
        private static const CHAR_CODE_TILDE:uint = 126;

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
            _waitForTap = waitForTap && MonstroConsts.hasToConfirmEnemyAttack;
            _attacker = attacker;
            _defender = defender;
        }

        override public function update():Boolean{
            if (!_isInitialized){
                init();
            }

            if (RetrocamelInputManager.isAnyKeyDown(CHAR_CODE_SPACE, CHAR_CODE_TILDE) || SmartTouch.isSingleTouchDown || SmartTouch.isRightButtonDown){
                _hasTapped = true;
            }

            return !_waitForTap || _hasTapped;
        }

        private function init():void{
            _isInitialized = true;

            Eventer.listen(MonstroEventTap.NAME, onTap, this);

            new MonstroEventDisplayAttackStats(_show, _waitForTap, _attacker, _defender);
        }

		override public function dispose():void{
			Eventer.releaseContext(this);

			super.dispose();
		}

        private function onTap():void{
            if (_isInitialized){
                _hasTapped = true;
            }
        }
    }
}
