/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 31.01.13
 * Time: 13:23
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.core {
    import net.retrocade.tacticengine.core.IDestruct;
    import net.retrocade.tacticengine.monstro.ais.IMonstroTurnProcess;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTransition;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTurnProcessChange;

    public class ProcessManager implements IDestruct{
        private var _processes:Vector.<IMonstroTurnProcess>;
        private var _currentProcess:IMonstroTurnProcess;
        private var _currentProcessIndex:int;

        public function ProcessManager() {
            _processes = new Vector.<IMonstroTurnProcess>();
        }

        public function addProcess(process:IMonstroTurnProcess):void{
            _processes.push(process);
        }

        public function update():void{
            if (_currentProcess && _currentProcess.enabled && _currentProcess.update()){


                var newProcess:IMonstroTurnProcess;

                _currentProcessIndex = (_currentProcessIndex + 1) % _processes.length;
                newProcess = _processes[_currentProcessIndex];

                new MonstroEventTurnProcessChange(_currentProcess, newProcess);

                _currentProcess.stop();
                _currentProcess = newProcess;
                _currentProcess.start();
            } else if (!_currentProcess){
                _currentProcess = _processes[_currentProcessIndex];
                _currentProcess.start();

                new MonstroEventTurnProcessChange(null, _currentProcess);
            }
        }

        public function onUndo():void{
            if (_currentProcess){
                _currentProcess.onUndo();
            }
        }

        public function destruct():void{
            for each(var process:IMonstroTurnProcess in _processes){
                process.destruct();
            }

            _currentProcess = null;
        }

        public function set enabled(value:Boolean):void{
            if (_currentProcess){
                _currentProcess.enabled = value;
            }
        }

        public function get currentProcess():IMonstroTurnProcess{
            return _currentProcess;
        }
    }
}
