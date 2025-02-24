
package net.retrocade.tacticengine.monstro.ingame.undo {
    import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.core.MonstroField;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndoFinished;

	public class UndoManager implements IDisposable{
        public static var instance:UndoManager;

        private var _undoSteps:Vector.<UndoStep>;
        private var _currentStep:UndoStep;

        public function UndoManager() {
            _undoSteps = new Vector.<UndoStep>();
        }

        public function startNewStep(field:MonstroField):void{
            if (_currentStep){
                commitStep();
            }

            _currentStep = new UndoStep(field.currentTurn);
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

            _currentStep.dispose();
            _currentStep = null;
        }

        public function undo(field:MonstroField):void{
            CF::debug{ASSERT(hasAnyUndo());}

            if (isInsideStep()){
                commitStep();
            }

            var step:UndoStep = _undoSteps.pop();
            step.undo(field);
            step.dispose();

			new MonstroEventUndoFinished();
        }

		public function get length():uint {
			return _undoSteps.length;
		}

		public function getUndoStep(index:uint):UndoStep {
			return _undoSteps[index];
		}

        public function isInsideStep():Boolean{
            return _currentStep != null;
        }

        public function hasAnyUndo():Boolean{
            return _undoSteps.length > 0 || (_currentStep && _currentStep.numberOfBits > 0);
        }

        public function clear():void{
            while (_undoSteps.length){
                _undoSteps.pop().dispose();
            }

            if (isInsideStep()){
                cancelStep();
            }
        }

        public function dispose():void {
            for each(var step:UndoStep in _undoSteps){
                step.dispose();
            }

            _undoSteps = null;

            if (_currentStep){
                cancelStep();
            }
        }

		public function makeDump():Object{
			var steps:Array = [];
			for each(var step:UndoStep in _undoSteps){
				steps.push(step.makeDump());
			}

			return {
				steps: steps
			};
		}

		public function loadFromDump(dump:Object):void{
			for each(var stepDump:Object in dump.steps){
				var step:UndoStep = new UndoStep(0);
				step.loadFromDump(stepDump);
				_undoSteps.push(step);
			}
		}
    }
}
