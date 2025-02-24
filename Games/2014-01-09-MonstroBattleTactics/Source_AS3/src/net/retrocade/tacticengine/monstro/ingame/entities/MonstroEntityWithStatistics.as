
package net.retrocade.tacticengine.monstro.ingame.entities {
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitStatsChanged;

    public class MonstroEntityWithStatistics extends MonstroEntityWithStatuses{
        private var _statistics:MonstroEntityStatistics;
        private var _movementOrder:int;

        public function MonstroEntityWithStatistics(stats:MonstroEntityStatistics, field:MonstroField) {
            super(field);

            _statistics = stats;
        }

        final public function getStatistics():MonstroEntityStatistics{
            return _statistics.clone();
        }

        final public function setStatistics(value:MonstroEntityStatistics):void{
            if (!_statistics.equals(value)){
                _statistics = value;

                new MonstroEventUnitStatsChanged(this as MonstroEntity);
            }
        }

        final public function getAttackDistanceMin():int{
            return _statistics.attackRangeMin;
        }

        final public function getAttackDistanceMax():int{
            return _statistics.attackRangeMax;
        }

        final public function onMoved(from:Tile, to:Tile, distance:int):void{
            _statistics.movesLeft -= distance;
        }

        final protected function get statistics():MonstroEntityStatistics {
            return _statistics;
        }

        final protected function set statistics(value:MonstroEntityStatistics):void {
            _statistics = value;
        }

        final public function get movementOrder():int {
            return _movementOrder;
        }

        final public function set movementOrder(value:int):void {
            _movementOrder = value;
        }

        override public function makeDump():Object {
            var dump:Object = super.makeDump();
            dump.statistics = _statistics.makeDump();
            dump.movementOrder = _movementOrder;

            return dump;
        }

        override public function loadFromDump(dump:Object):void {
            super.loadFromDump(dump);

            _statistics.loadFromDump(dump.statistics);
            _movementOrder = dump.movementOrder;
        }

        final public function get canFly():Boolean{
            return _statistics.canFly;
        }

        override public function dispose():void{
            statistics.dispose();

            super.dispose();
        }
    }
}
