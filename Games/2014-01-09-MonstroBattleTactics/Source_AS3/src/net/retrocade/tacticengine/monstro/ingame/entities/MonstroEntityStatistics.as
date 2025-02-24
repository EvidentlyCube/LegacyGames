
package net.retrocade.tacticengine.monstro.ingame.entities {
    import net.retrocade.tacticengine.core.IDisposable;

    public class MonstroEntityStatistics implements IDisposable {
        private var _hp:int = 0;
        private var _hpMax:int = 0;
        private var _attack:int = 0;
        private var _defense:int = 0;
        private var _defenseMax:int = 0;
        private var _attackRangeMin:int = 1;
        private var _attackRangeMax:int = 1;
        private var _canFly:Boolean = false;
        private var _movesLeft:int = 0;
        private var _movesMax:int = 0;


        public function MonstroEntityStatistics() {}

        public function clone():MonstroEntityStatistics {
            var cloneInstance:MonstroEntityStatistics = new MonstroEntityStatistics();
            cloneInstance._attack = _attack;
            cloneInstance._attackRangeMax = _attackRangeMax;
            cloneInstance._attackRangeMin = _attackRangeMin;
            cloneInstance._canFly = _canFly;
            cloneInstance._defense = _defense;
            cloneInstance._defenseMax = _defenseMax;
            cloneInstance._hp = _hp;
            cloneInstance._hpMax = _hpMax;
            cloneInstance._movesLeft = _movesLeft;
            cloneInstance._movesMax = _movesMax;
            cloneInstance._attackRangeMin = _attackRangeMin;

            return cloneInstance;
        }

        public function dispose():void {
        }

        public function get hp():int {
            return _hp;
        }

        public function set hp(value:int):void {
            _hp = value;
        }

		public function get hpMax():int{
			return _hpMax;
		}

		public function set hpMax(value:int):void{
			_hpMax = value;
		}

		public function get attack():int {
            return _attack;
        }

        public function set attack(value:int):void {
            _attack = value;
        }

        public function get defense():int {
            return _defense;
        }

        public function set defense(value:int):void {
            _defense = value;
        }

        public function get defenseMax():int {
            return _defenseMax;
        }

        public function set defenseMax(value:int):void {
            _defenseMax = value;
        }

        public function get attackRangeMin():int {
            return _attackRangeMin;
        }

        public function set attackRangeMin(value:int):void {
            _attackRangeMin = value;
        }

        public function get attackRangeMax():int {
            return _attackRangeMax;
        }

        public function set attackRangeMax(value:int):void {
            _attackRangeMax = value;
        }

        public function get canFly():Boolean {
            return _canFly;
        }

        public function set canFly(value:Boolean):void {
            _canFly = value;
        }

        public function get movesLeft():int {
            return _movesLeft;
        }

        public function set movesLeft(value:int):void {
            _movesLeft = value;
        }

        public function get movesMax():int {
            return _movesMax;
        }

        public function set movesMax(value:int):void {
            _movesMax = value;
        }

        public function makeDump():Object{
            var dump:Object = {};
            dump.hp = _hp;
            dump.hpMax = _hpMax;
            dump.attack = _attack;
            dump.defense = _defense;
            dump.defenseMax = _defenseMax;
            dump.attackRangeMin = _attackRangeMin;
            dump.attackRangeMax = _attackRangeMax;
            dump.canFly = _canFly;
            dump.movesLeft = _movesLeft;
            dump.movesMax = _movesMax;

            return dump;
        }

        public function loadFromDump(dump:Object):void{
            _hp = dump.hp;
            _hpMax = dump.hpMax;
            _attack = dump.attack;
            _defense = dump.defense;
            _defenseMax = dump.defenseMax;
            _attackRangeMin = dump.attackRangeMin;
            _attackRangeMax = dump.attackRangeMax;
            _canFly = dump.canFly;
            _movesLeft = dump.movesLeft;
            _movesMax = dump.movesMax;
        }

        final public function equals(statistics:MonstroEntityStatistics):Boolean{
            return _hp == statistics._hp &&
				_hpMax == statistics._hpMax &&
                _attack == statistics._attack &&
                _defense == statistics._defense &&
                _defenseMax == statistics.defenseMax &&
                _attackRangeMin == statistics.attackRangeMin &&
                _attackRangeMax == statistics.attackRangeMax &&
                _canFly == statistics._canFly &&
                _movesLeft == statistics._movesLeft &&
                _movesMax == statistics._movesMax;
        }

		final public function isDamaged():Boolean{
			return _hp !== _hpMax ||
				_defense !== _defenseMax;
		}
    }
}
