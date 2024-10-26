/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 06.04.13
 * Time: 19:10
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.undo {
    import net.retrocade.tacticengine.core.IDestruct;

    public class UndoManager implements IDestruct{
        public static var instance:UndoManager;

        private var _undoSteps:Vector.<UndoStep>;
        private var _currentStep:UndoStep;

        public function UndoManager() {
            _undoSteps = new Vector.<UndoStep>();
        }

        public function startNewStep():void{
            if (_currentStep){
                commitStep();
            }

            _currentStep = new UndoStep();
        }

        public function addBit(bit:IUndoBit):void{
            CF::debug{ASSERT(_currentStep);}

            _currentStep.addBit(bit);
        }

        public function commitStep():void{
            CF::debug{ASSERT(_currentStep);}

            if (_currentStep.numberOfBits > 0){
                _undoSteps.push(_currentStep);
            } else {
                cancelStep();
            }

            _currentStep = null;
        }

        public function cancelStep():void{
            CF::debug{ASSERT(_currentStep);}

            _currentStep.destruct();
            _currentStep = null;
        }

        public function undo():void{
            CF::debug{ASSERT(hasAnyUndo());}

            if (isInsideStep()){
                commitStep();
            }

            var step:UndoStep = _undoSteps.pop();
            step.undo();
            step.destruct();
        }

        public function isInsideStep():Boolean{
            return _currentStep != null;
        }

        public function hasAnyUndo():Boolean{
            return _undoSteps.length > 0 || (_currentStep && _currentStep.numberOfBits > 0);
        }

        public function clear():void{
            while (_undoSteps.length){
                _undoSteps.pop().destruct();
            }

            if (isInsideStep()){
                cancelStep();
            }
        }

        public function destruct():void {
            for each(var step:UndoStep in _undoSteps){
                step.destruct();
            }

            _undoSteps = null;

            if (_currentStep){
                cancelStep();
            }
        }
    }
}
