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

    public class MonstroRoachAI extends MonstroStepByStepAI {
        protected var _currentX:int;
        protected var _currentY:int;
        protected var _movesLeft:int;

        public function MonstroRoachAI(field:Field, fieldRenderer:MonstroFieldRenderer){
            super(field, fieldRenderer);
        }


        override public function startForUnit(unit:MonstroEntity):void {
            super.startForUnit(unit);

            _currentX = unit.x;
            _currentY = unit.y;
            _movesLeft = unit.movesLeft;
        }

        override protected function updateStep():void{
            var closestUnit:MonstroEntity

            _stepsData.push(new MonstroUnitStepData(_currentX, _currentY, MonstroConst.NO_ORIENTATION));

            while (_movesLeft > 0){
                closestUnit = getClosestHostile(_currentX, _currentY);

                if (UNumber.distanceGrid(_currentX, _currentY, closestUnit.x, closestUnit.y) == 1){
                    break;
                }

                var direction:int = MonstroFunctions.getOrientationTowards(_currentX, _currentY, closestUnit.x, closestUnit.y);
                var dx:int = MonstroFunctions.getDeltaXFromOrientation(direction);
                var dy:int = MonstroFunctions.getDeltaYFromOrientation(direction);

                if (canStep(_currentX, _currentY, dx, dy, _unit)){
                    _currentX += dx;
                    _currentY += dy;
                } else if (canStep(_currentX, _currentY, 0, dy, _unit)){
                    _currentY += dy;
                } else if (canStep(_currentX, _currentY, dx, 0, _unit)){
                    _currentX += dx;
                }

                _stepsData.push(new MonstroUnitStepData(_currentX, _currentY, direction));

                _movesLeft--;
            }

            _isFinished = true;
        }

        override public function getTargetTile():Tile {
            return _field.getTileAt(_currentX, _currentY);
        }
    }
}
