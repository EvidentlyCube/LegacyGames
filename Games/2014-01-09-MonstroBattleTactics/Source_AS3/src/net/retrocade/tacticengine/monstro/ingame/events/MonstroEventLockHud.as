
package net.retrocade.tacticengine.monstro.ingame.events {
    public class MonstroEventLockHud extends MonstroEvent{
        public static const NAME:String = "lock_hud";

        public var lockHud:Boolean;

        public function MonstroEventLockHud(lockHud:Boolean){
            this.lockHud = lockHud;

            dispatch(NAME);
        }
    }
}
