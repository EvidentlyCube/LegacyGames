package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.retrocamel.interfaces.IRetrocamelWindow;
	import net.retrocade.signal.Signal;

    public interface IWindowMissionFinished extends IRetrocamelWindow{
        function get onClosing():Signal;
        function get maxTopPosition():Number;
    }
}
