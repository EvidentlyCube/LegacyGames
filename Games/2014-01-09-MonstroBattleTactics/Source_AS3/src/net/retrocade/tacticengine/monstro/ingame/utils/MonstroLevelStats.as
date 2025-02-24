
package net.retrocade.tacticengine.monstro.ingame.utils {
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.monstro.global.enum.EnumTileset;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.MonstroEnemyTurnProcess;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitController;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTurnProcessIsChanging;

    public class MonstroLevelStats implements IDisposable{
        [Inject]
        public var field:MonstroField;
        private var _turnsPassed:int;
        private var _startingUnits:Vector.<int>;

        public var levelName:String;
        public var levelDescription:String;
		public var levelTileset:EnumTileset;

        public function MonstroLevelStats() {}

        public function start():void{
            _turnsPassed = 0;
            _startingUnits = new <int>[0, 0, 0];

            for each(var unit:MonstroEntity in field.getAllEntities()){
                _startingUnits[unit.controlledBy.id]++;
            }

            Eventer.listen(MonstroEventTurnProcessIsChanging.NAME, onTurnProcessChanged, this);
        }

		public function dispose():void {
			Eventer.releaseContext(this);

			field = null;
			_startingUnits = null;
		}


        private function onTurnProcessChanged(e:MonstroEventTurnProcessIsChanging):void {
            if (e.currentProcess is MonstroEnemyTurnProcess) {
                _turnsPassed++;
            }
        }
    }
}
