package net.retrocade.tacticengine.monstro.ais{
    import net.retrocade.tacticengine.core.Entity;
    import net.retrocade.tacticengine.core.Eventer;

    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionMissionEnded;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionShowAttackStats;
    import net.retrocade.tacticengine.monstro.actions.MonstroUnitStepData;
    import net.retrocade.tacticengine.monstro.ais.enemyai.IMonstroEnemyAI;
    import net.retrocade.tacticengine.monstro.ais.enemyai.MonstroGoblinAI;
    import net.retrocade.tacticengine.monstro.ais.enemyai.MonstroRoachAI;
    import net.retrocade.tacticengine.monstro.ais.enemyai.MonstroSlayerAI;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.events.MonstroEventDisplayAttackStats;
    import net.retrocade.tacticengine.monstro.events.MonstroEventMarkTiles;
    import net.retrocade.tacticengine.monstro.events.MonstroEventMissionFinished;
    import net.retrocade.tacticengine.monstro.events.MonstroEventNewAction;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitHit;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitKilled;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitMoved;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;
    import net.retrocade.tacticengine.monstro.undo.UndoManager;
    import net.retrocade.tacticengine.monstro.utils.MonstroPathmapper;

    public class MonstroEnemyTurnProcess implements IMonstroTurnProcess{
        private var _fieldRenderer:MonstroFieldRenderer;
        private var _field:Field;

		private var _enabled:Boolean = true;

        private var _monsterUnits:Vector.<MonstroEntity>;
        private var _hostileUnits:Vector.<MonstroEntity>;

        private var _aiSlayer:MonstroSlayerAI;
        private var _aiRoach:MonstroRoachAI;
        private var _aiGoblin:MonstroGoblinAI;

        private var _currentAI:IMonstroEnemyAI;

        public function MonstroEnemyTurnProcess(field:Field, fieldRenderer:MonstroFieldRenderer){
            _field = field;
            _fieldRenderer = fieldRenderer;

            Eventer.listen(MonstroEventUnitKilled.NAME, resetUnitsList);

            resetUnitsList();

            _aiSlayer = new MonstroSlayerAI(_field, _fieldRenderer);
            _aiRoach  = new MonstroRoachAI(_field, _fieldRenderer);
            _aiGoblin  = new MonstroGoblinAI(_field, _fieldRenderer);
        }

        public function start():void{
            UndoManager.instance.startNewStep();
        }

        public function stop():void{
            UndoManager.instance.commitStep();

            MonstroPathmapper.stopCache();

            enabled = false;
            for each(var unit:MonstroEntity in _monsterUnits){
                unit.hasMoved = false;
            }
        }

		public function update():Boolean{
            if (_currentAI && _currentAI.isRunning){
                _currentAI.friendlyUnits = controllableUnits;
                _currentAI.hostileUnits = hostileUnits;

                if (_currentAI.update()){
                    MonstroPathmapper.stopCache();
                    _fieldRenderer.markTile(_currentAI.unit.tile, Monstro.MARK_RESET);
                    performMove();
                }
            } else {
                var unit:MonstroEntity = getNextUnit();

                if (unit){
                    if (unit.name == MonstroEntityFactory.NAME_SLAYER){
                        _currentAI = _aiSlayer;

                    } else if (unit.name == MonstroEntityFactory.NAME_GOBLIN){
                        _currentAI = _aiGoblin;
                    } else {
                        _currentAI = _aiRoach;
                    }

                    _currentAI.startForUnit(unit);
                    _fieldRenderer.markTile(unit.tile, Monstro.MARK_MOVABLE);
                } else {
                    return true;
                }
            }

			return false;
		}


        public function destruct():void{

        }

        private function getNextUnit():MonstroEntity{
            for each(var unit:MonstroEntity in _monsterUnits){
                if (!unit.hasMoved){
                    return unit;
                }
            }

            return null;
        }

        private function performMove():void{
            var targetTile:Tile = _currentAI.getTargetTile();
            var unit:MonstroEntity = _currentAI.unit;

            var path:Vector.<MonstroUnitStepData> = _currentAI.movementPath;

            if (targetTile == unit.tile || unit.move(targetTile.x,  targetTile.y)){
                new MonstroEventUnitMoved(unit, path);
            }

            _unitAttacker = unit;
            _unitDefender = _currentAI.attackTarget;

            if (_unitDefender){
                new MonstroEventMarkTiles(_unitAttacker.tile, Monstro.MARK_ATTACKER);
                new MonstroEventMarkTiles(_unitDefender.tile, Monstro.MARK_ATTACKABLE);

                new MonstroEventNewAction(new MonstroActionShowAttackStats(
                        true, true, _unitAttacker, _unitDefender
                ));

                new MonstroEventUnitHit(
                        _unitAttacker,
                        _unitDefender,
                        onAttackFinished
                );

                if (_unitAttacker.name == MonstroEntityFactory.NAME_SLAYER){
                    MonstroSfx.playSlayerAttack();
                }

                new MonstroEventNewAction(new MonstroActionShowAttackStats(
                        false
                ));

                new MonstroEventMarkTiles(_unitAttacker.tile, Monstro.MARK_RESET);
                new MonstroEventMarkTiles(_unitDefender.tile, Monstro.MARK_RESET);

            } else {
                unit.hasMoved = true;
            }
        }

        private var _unitAttacker:MonstroEntity;
        private var _unitDefender:MonstroEntity;

        private function onAttackFinished():void{
            _unitAttacker.attackOtherUnit(_unitDefender);
            new MonstroEventDisplayAttackStats(false);

            _unitAttacker.hasMoved = true;
        }

        private function resetUnitsList():void{
            _monsterUnits = new Vector.<MonstroEntity>();
            _hostileUnits = new Vector.<MonstroEntity>();

            var entities:Vector.<Entity> = _field.getAllEntities();
            for each(var entity:Entity in entities){
                if (entity.get(Monstro.PROP_isPlayerControlled)){
                    _hostileUnits.push(entity as MonstroEntity);
                } else {
                    _monsterUnits.push(entity as MonstroEntity);
                }
            }

            _monsterUnits = _monsterUnits.sort(function(entityA:MonstroEntity, entityB:MonstroEntity):Number{
                if (entityA.movementOrder != entityB.movementOrder){
                    return entityA.movementOrder - entityB.movementOrder;

                } else if (entityA.hp != entityB.hp){
                    return entityB.hp - entityA.hp;

                } else  if (entityA.y != entityB.y){
                    return entityA.y - entityB.y;

                } else {
                    return entityA.x - entityB.x;
                }
            });
        }

        public function onUndo():void {}

        public function set enabled(value:Boolean):void{
            _enabled = value;
        }

        public function get enabled():Boolean{
            return _enabled;
        }

        public function get controllableUnits():Vector.<MonstroEntity>{
            return _monsterUnits;
        }

        public function get hostileUnits():Vector.<MonstroEntity>{
            return _hostileUnits;
        }

    }
}