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
    import net.retrocade.tacticengine.monstro.core.MonstroConst;
    import net.retrocade.tacticengine.monstro.core.MonstroFunctions;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;
import net.retrocade.tacticengine.monstro.utils.MonstroPathmapper;
    import net.retrocade.utils.UNumber;

    public class MonstroGoblinAI extends MonstroStepByStepAI {
        private static var QUERY_PATH_X:Vector.<int> = new Vector.<int>(9, true);
        private static var QUERY_PATH_Y:Vector.<int> = new Vector.<int>(9, true);

        { init(); }

        private static function init():void{
            QUERY_PATH_X[0] = 0;
            QUERY_PATH_X[1] = 0;
            QUERY_PATH_X[2] = 1;
            QUERY_PATH_X[3] = -1;
            QUERY_PATH_X[4] = 1;
            QUERY_PATH_X[5] = 1;
            QUERY_PATH_X[6] = -1;
            QUERY_PATH_X[7] = -1;
            QUERY_PATH_X[8] = 0;

            QUERY_PATH_Y[0] = -1;
            QUERY_PATH_Y[1] = 1;
            QUERY_PATH_Y[2] = 0;
            QUERY_PATH_Y[3] = 0;
            QUERY_PATH_Y[4] = -1;
            QUERY_PATH_Y[5] = 1;
            QUERY_PATH_Y[6] = 1;
            QUERY_PATH_Y[7] = -1;
            QUERY_PATH_Y[8] = 0;
        }

        protected var _currentX:int;
        protected var _currentY:int;
        protected var _movesLeft:int;

        public function MonstroGoblinAI(field:Field, fieldRenderer:MonstroFieldRenderer){
            super(field, fieldRenderer);
        }


        override public function startForUnit(unit:MonstroEntity):void {
            super.startForUnit(unit);

            _currentX = unit.x;
            _currentY = unit.y;
            _movesLeft = unit.movesLeft;
        }

        override protected function updateStep():void{
            var closestUnit:MonstroEntity;
            var direction:int;
            var dx:int;
            var dy:int;
            var moveScore:int;

            _stepsData.push(new MonstroUnitStepData(_currentX, _currentY, MonstroConst.NO_ORIENTATION));

            while (_movesLeft > 0){
                closestUnit = getClosestHostile(_currentX, _currentY);
                var bestMoveDirection:int = MonstroConst.NO_ORIENTATION;
                var bestMoveScore    :int = int.MAX_VALUE

                closestUnit = getClosestHostile(_currentX, _currentY);

                moveScore = UNumber.distanceGrid(_currentX, _currentY, closestUnit.x, closestUnit.y);

                if (moveScore > 1){
                    for (var i:int = 0; i < 9; i++){
                        dx = QUERY_PATH_X[i];
                        dy = QUERY_PATH_Y[i];
                        direction = MonstroFunctions.getOrientation(dx, dy);

                        if (canStep(_currentX, _currentY, dx, dy, _unit)){
                            closestUnit = getClosestHostile(_currentX + dx, _currentY + dy);

                            moveScore = UNumber.distance(_currentX + dx, _currentY + dy,
                                    closestUnit.x,  closestUnit.y);

                            if (direction == MonstroConst.NO_ORIENTATION){
                                moveScore++;
                            }

                            if (moveScore < bestMoveScore){
                                bestMoveScore = moveScore;
                                bestMoveDirection = direction;
                            }
                        }
                    }
                } else {
                    bestMoveDirection = MonstroConst.NO_ORIENTATION;
                }

                _currentX += MonstroFunctions.getDeltaXFromOrientation(bestMoveDirection);
                _currentY += MonstroFunctions.getDeltaYFromOrientation(bestMoveDirection);

                _stepsData.push(new MonstroUnitStepData(_currentX, _currentY, bestMoveDirection));

                _movesLeft--;
            }

            _isFinished = true;
        }

        override public function getTargetTile():Tile {
            return _field.getTileAt(_currentX, _currentY);
        }
    }
}
