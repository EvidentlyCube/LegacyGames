/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 20.01.13
 * Time: 17:32
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.ais.enemyai {
    import flash.utils.getTimer;

    import net.retrocade.camel.global.rCore;
    import net.retrocade.tacticengine.monstro.actions.MonstroUnitStepData;

    import net.retrocade.tacticengine.monstro.ais.*;
    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;
import net.retrocade.tacticengine.monstro.utils.MonstroPathmapper;

    public class MonstroSlayerAI implements IMonstroEnemyAI{
        private var _flowsAndSteps:Vector.<Vector.<IMonstroEnemyStep>>;
        private var _currentStep:IMonstroEnemyStep;
        private var _currentFlow:Vector.<IMonstroEnemyStep>;
        private var _currentStepIndex:int = -1;
        private var _currentFlowIndex:int = -1;

        private var _unit :MonstroEntity;
        private var _startingTile:Tile;
        private var _tiles:Vector.<Tile>;

        private var _field:Field;
        private var _fieldRenderer:MonstroFieldRenderer;

        private var _isFinished:Boolean;

        private var _approachableTiles:Vector.<Tile>;
        private var _attackableTiles:Vector.<Tile>;

        private var _forcedWait:int = 0;

        private var _friendlyUnits:Vector.<MonstroEntity>;
        private var _hostileUnits:Vector.<MonstroEntity>;

        public function MonstroSlayerAI(field:Field, fieldRenderer:MonstroFieldRenderer){
            _field     = field;
            _fieldRenderer = fieldRenderer;

            //noinspection UnterminatedStatementJS
            _flowsAndSteps = new <Vector.<IMonstroEnemyStep>>[
                new <IMonstroEnemyStep>[
                    new MonstroEnemyAITargetOpponentsInRange(),
                    new MonstroEnemyAIFilterLeastAttackers()
                ],
                new <IMonstroEnemyStep>[
                    new MonstroEnemyAITargetClosestTiles(),
                    new MonstroEnemyAIFilterLeastAttackers()
                ]];
        }

        public function startForUnit(unit:MonstroEntity):void {
            _unit = unit;
            _startingTile = _unit.tile;

            MonstroSfx.playSlayerMove();

            _isFinished = false;
            _tiles = null;

            _currentFlow = null;
            _currentStep = null;
            _currentFlowIndex = -1;
            _currentStepIndex = -1;

            if (_fieldRenderer && Monstro.displayMonsterThinking){
                _approachableTiles = _unit.getMovableTiles();
                _attackableTiles = _unit.getExpandedAttackableTiles(_approachableTiles);

                _fieldRenderer.markTiles(_attackableTiles, Monstro.MARK_ATTACKABLE);
                _fieldRenderer.markTiles(_approachableTiles, Monstro.MARK_MOVABLE);
                _fieldRenderer.markTile(_unit.tile, Monstro.MARK_MOVE_TO);

                _forcedWait = Monstro.monsterThinkingDelay;
            } else {
                _forcedWait = 0;
            }
        }

        public function update():Boolean{
            _forcedWait -= rCore.deltaTime;

            if (_forcedWait > 0){
                return false;
            }

            var canThinkUntil:Number = getTimer() + Monstro.timeToThink;

            while (!_isFinished && getTimer() < canThinkUntil){
                if (_currentFlowIndex == -1){
                    setNextFlow();
                }

                updateStep();
            }

            if (_fieldRenderer && _isFinished && Monstro.displayMonsterThinking){
                _fieldRenderer.markTiles(_approachableTiles, Monstro.MARK_RESET);
                _fieldRenderer.markTiles(_attackableTiles, Monstro.MARK_RESET);
                _fieldRenderer.markTile(_unit.tile, Monstro.MARK_RESET);
            }

            return _isFinished;
        }

        public function getTargetTile():Tile{
            if (!_tiles || _tiles.length == 0){
                return _unit.tile;
            } else {
                return _tiles[0];
            }
        }

        public function get movementPath():Vector.<MonstroUnitStepData>{
            var targetTile:Tile = getTargetTile();

            return MonstroPathmapper.getPathFromTo(_startingTile.x, _startingTile.y, targetTile.x, targetTile.y, _unit, _field);
        }

        private function updateStep():void{
            if (_currentStep && _currentStep.update()){
                stepFinished();
            }
        }

        private function stepFinished():void{
            _tiles = _currentStep.getResult();

            if (_tiles){
                if (_tiles.length == 0){
                    setNextFlow()
                } else if (_tiles.length == 1){
                    _isFinished = true;
                } else {
                    setNextStep();
                }
            } else {
                setNextFlow();
            }
        }

        private function setNextFlow():void{
            _currentFlowIndex++;
            _currentStepIndex = -1;

            if (_currentFlowIndex < _flowsAndSteps.length){
                _currentFlow = _flowsAndSteps[_currentFlowIndex];

                setNextStep();
            } else {
                _currentFlow = null;
                _currentStep = null;
                _isFinished = true;
            }
        }

        private function setNextStep():void{
            _currentStepIndex++;

            if (_currentStepIndex < _currentFlow.length){
                MonstroPathmapper.stopCache();

                _currentStep = _currentFlow[_currentStepIndex];
                _currentStep.field = _field;
                _currentStep.init(_unit, _tiles, _friendlyUnits, _hostileUnits);

                MonstroPathmapper.startCache();
            } else {
                _currentFlow = null;
                _currentStep = null;
                _isFinished = true;
            }
        }


        public function get isRunning():Boolean{
            return _unit !== null && !_isFinished;
        }

        public function get unit():MonstroEntity{
            return _unit;
        }

        public function get friendlyUnits():Vector.<MonstroEntity> {
            return _friendlyUnits;
        }

        public function set friendlyUnits(value:Vector.<MonstroEntity>):void {
            _friendlyUnits = value;
        }

        public function get hostileUnits():Vector.<MonstroEntity> {
            return _hostileUnits;
        }

        public function set hostileUnits(value:Vector.<MonstroEntity>):void {
            _hostileUnits = value;
        }

        public function get attackTarget():MonstroEntity {
            var bestUnit:MonstroEntity;

            for each(var hostileUnit:MonstroEntity in _hostileUnits){
                if (_unit.canAttack(hostileUnit)){
                    if (!bestUnit){
                        bestUnit = hostileUnit;
                    } else if (hostileUnit.name == MonstroEntityFactory.NAME_BEETHRO){
                        bestUnit = hostileUnit;
                        break;
                    } else if (hostileUnit.name == MonstroEntityFactory.NAME_STALWART){
                        bestUnit = hostileUnit;
                    }
                }
            }

            return bestUnit;
        }
    }
}
