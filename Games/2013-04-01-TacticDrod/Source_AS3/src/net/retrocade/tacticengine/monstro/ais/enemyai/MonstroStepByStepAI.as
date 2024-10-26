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

    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.actions.MonstroUnitStepData;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroConst;
    import net.retrocade.tacticengine.monstro.core.MonstroFunctions;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;
    import net.retrocade.utils.UNumber;

    public class MonstroStepByStepAI implements IMonstroEnemyAI{
        private static var _directionScore:Vector.<uint>;

        {
            _directionScore = new Vector.<uint>(MonstroConst.ORIENTATION_COUNT, true);
            _directionScore[MonstroConst.N] = 1;
            _directionScore[MonstroConst.W] = 2;
            _directionScore[MonstroConst.E] = 3;
            _directionScore[MonstroConst.S] = 4;
            _directionScore[MonstroConst.NW] = 5;
            _directionScore[MonstroConst.NE] = 6;
            _directionScore[MonstroConst.SW] = 7;
            _directionScore[MonstroConst.SE] = 8;
            _directionScore[MonstroConst.NO_ORIENTATION] = 9;
        }
        protected var _unit :MonstroEntity;
        protected var _tiles:Vector.<Tile>;

        protected var _field:Field;
        protected var _fieldRenderer:MonstroFieldRenderer;

        protected var _isFinished:Boolean;

        protected var _approachableTiles:Vector.<Tile>;
        protected var _attackableTiles:Vector.<Tile>;

        protected var _forcedWait:int = 0;

        private var _friendlyUnits:Vector.<MonstroEntity>;
        private var _hostileUnits:Vector.<MonstroEntity>;

        protected var _stepsData:Vector.<MonstroUnitStepData>;

        public function MonstroStepByStepAI(field:Field, fieldRenderer:MonstroFieldRenderer){
            _field     = field;
            _fieldRenderer = fieldRenderer;
            _stepsData = new Vector.<MonstroUnitStepData>();
        }

        public function startForUnit(unit:MonstroEntity):void {
            _unit = unit;

            _isFinished = false;
            _tiles = null;

            _stepsData.length = 0;

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
            return null;
        }


        protected function updateStep():void{}

        protected function canStep(x:int, y:int, dx:int, dy:int, entity:MonstroEntity):Boolean{
            var tileStart:Tile = _field.getTileAt(x, y);
            var tileEnd:Tile = _field.getTileAt(x + dx, y + dy);

            return !tileEnd || (tileStart.canStep(dx, dy, entity) && tileEnd.canStandOn(entity));
        }

        public function get movementPath():Vector.<MonstroUnitStepData>{
            return _stepsData;
        }

        public function get isRunning():Boolean{
            return _unit !== null && !_isFinished;
        }

        public function get unit():MonstroEntity{
            return _unit;
        }

        public function getClosestHostile(x:int, y:int):MonstroEntity{
            var closestScore:int = int.MAX_VALUE;
            var closestUnit:MonstroEntity = null;

            for each(var entity:MonstroEntity in _hostileUnits){
                var unitScore:int = UNumber.distanceGrid(x, y, entity.x, entity.y) * MonstroConst.ORIENTATION_COUNT;

                unitScore += _directionScore[MonstroFunctions.getOrientationTowards(x, y,  entity.x, entity.y)];

                if (unitScore < closestScore){
                    closestScore = unitScore;
                    closestUnit = entity;
                }
            }

            return closestUnit;
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
            var closestHostile:MonstroEntity = getClosestHostile(_unit.x, _unit.y);
            
            if (closestHostile &&_unit.canAttack(closestHostile)){
                return closestHostile;
            } else {
                return null;
            }
        }
    }
}
