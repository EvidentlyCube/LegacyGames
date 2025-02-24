
package net.retrocade.tacticengine.monstro.ingame.utils {

    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityStatistics;

    public class MonstroAttackSimulation {
        private var _initialDefense:int;
        private var _initialHP:int;
        private var _resultDefense:int;
        private var _resultHP:int;
        private var _defenderAttack:int;
        private var _scoreMultiplier:Number;

        public function MonstroAttackSimulation(attacker:MonstroEntity, defender:MonstroEntity) {
            var attackerStats:MonstroEntityStatistics = attacker.getStatistics();
            var defenderStats:MonstroEntityStatistics = defender.getStatistics();

            var attack:int = attackerStats.attack;
            _initialDefense = defenderStats.defense;
            _initialHP = defenderStats.hp;
            _resultDefense = _initialDefense;
            _resultHP = _initialHP;

            _defenderAttack = defenderStats.attack;

            _scoreMultiplier = defender.scoreMultiplier;

            if (attack > _initialDefense) {
                attack -= _resultDefense;
                _resultDefense = 0;
                _resultHP = Math.max(0, _resultHP - attack);
            } else {
                _resultDefense -= attack;
            }
        }

        public function get defenseDamage():int {
            return _initialDefense - _resultDefense;
        }

        public function get hpDamage():int {
            return _initialHP - _resultHP;
        }

        public function get resultDefense():int {
            return _resultDefense;
        }

        public function get resultHP():int {
            return _resultHP;
        }

        public function get isDead():Boolean {
            return _resultHP == 0;
        }

        public function get score():int {
            return _scoreMultiplier * (
                    (isDead ? 10000 : 0) + hpDamage * 1000 - resultHP * 100 - resultDefense * 10 + _defenderAttack
                    );
        }
    }
}
