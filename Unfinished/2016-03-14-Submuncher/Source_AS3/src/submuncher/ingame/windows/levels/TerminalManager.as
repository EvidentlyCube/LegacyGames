package submuncher.ingame.windows.levels {
    import net.retrocade.retrocamel.core.RetrocamelWindowsManager;
    import net.retrocade.retrocamel.interfaces.IRetrocamelWindow;

    public class TerminalManager {
        public static function isActive(terminal:ITerminal):Boolean {
            for (var i:int = windows.length - 1; i >= 0; i--){
                if (!(windows[i] is ITerminal)){
                    return false;
                }

                var checkTerminal:ITerminal = windows[i] as ITerminal;
                if (checkTerminal === terminal){
                    return true;
                } else if (!checkTerminal.isDisabled){
                    return false;
                }
            }

            return false;
        }

        private static function get windows():Vector.<IRetrocamelWindow> {
            return RetrocamelWindowsManager.allOriginal;
        }
    }
}
