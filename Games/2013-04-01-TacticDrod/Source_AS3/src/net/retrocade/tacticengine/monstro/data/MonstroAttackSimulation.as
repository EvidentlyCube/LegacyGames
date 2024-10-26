/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 12.01.13
 * Time: 15:43
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.data {
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;

    public class MonstroAttackSimulation {
        private var _initialHP:int;

        private var _resultHP:int;

        public function get hpDamage():int{
            return _initialHP - _resultHP;
        }


        public function get resultHP():int {
            return _resultHP;
        }

        public function get isDead():Boolean{
            return _resultHP == 0;
        }

        public function get score():int{
            return (isDead ? 1000 : hpDamage * 100 - resultHP * 10);
        }

        public function MonstroAttackSimulation(attacker:MonstroEntity, defender:MonstroEntity){
            var attack:int = attacker.attack;
            _initialHP = defender.hp;
            _resultHP = _initialHP;

            _resultHP = Math.max(0, _resultHP - attack);
        }
    }
}
