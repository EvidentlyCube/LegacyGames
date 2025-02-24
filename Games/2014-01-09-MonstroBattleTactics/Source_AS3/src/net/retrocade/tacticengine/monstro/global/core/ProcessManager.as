
package net.retrocade.tacticengine.monstro.global.core {
	import net.retrocade.retrocamel.global.RetrocamelEventsQueue;
	import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.ingame.ais.common.IMonstroTurnProcess;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventEndTurn;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTurnProcessHasChanged;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTurnProcessIsChanging;

    public class ProcessManager implements IDisposable{
		[Inject]
		public var gameplayDefinition:MonstroGameplayDefinition;

        private var _processes:Vector.<IMonstroTurnProcess>;
        private var _currentProcess:IMonstroTurnProcess;
        private var _currentProcessIndex:int;

        public function ProcessManager() {
            _processes = new Vector.<IMonstroTurnProcess>();
        }

		public function dispose():void{
			for each(var process:IMonstroTurnProcess in _processes){
				process.dispose();
			}

			_processes = null;
			_currentProcess = null;
			gameplayDefinition = null;
		}

        public function addProcess(process:IMonstroTurnProcess):void{
            _processes.push(process);
        }

        public function set enabled(value:Boolean):void{
            if (_currentProcess){
                _currentProcess.enabled = value;
            }
        }

        public function update():void{
            if (_currentProcess && _currentProcess.enabled && _currentProcess.update()){
 				RetrocamelEventsQueue.add(MonstroConsts.EVENT_TURN_ENDED);

                var newProcess:IMonstroTurnProcess;

                _currentProcessIndex = (_currentProcessIndex + 1) % _processes.length;
                newProcess = _processes[_currentProcessIndex];

                new MonstroEventTurnProcessIsChanging(_currentProcess, newProcess);

                _currentProcess.stop();
                _currentProcess = newProcess;
                _currentProcess.start();

                new MonstroEventTurnProcessHasChanged(newProcess);

            } else if (!_currentProcess){
                _currentProcess = _processes[_currentProcessIndex];
                _currentProcess.start();

                new MonstroEventTurnProcessIsChanging(null, _currentProcess);
            }
        }

		public function silentlySwitchTo(switchToClass:Class):void{
			for each (var process:IMonstroTurnProcess in _processes) {
				if (process is switchToClass){
					if (_currentProcess === process){
						return
					}
					gameplayDefinition.displayPhaseImages = false;
					new MonstroEventTurnProcessIsChanging(_currentProcess, process);

					_currentProcess.stop();
					_currentProcess = process;
					_currentProcessIndex = _processes.indexOf(_currentProcess);
					_currentProcess.start();

					new MonstroEventTurnProcessHasChanged(process);
					gameplayDefinition.displayPhaseImages = true;
				}
			}
		}

        public function onUndo():void{
            if (_currentProcess){
                _currentProcess.onUndo();
            }
        }


        public function get currentProcess():IMonstroTurnProcess{
            return _currentProcess;
        }
    }
}
