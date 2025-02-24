package net.retrocade.tacticengine.monstro.ingame.actions{
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.IDisposable;

	public interface IMonstroAction extends IDisposable{
		function update():Boolean;
		function resize():void;
        function set field(value:MonstroField):void;

		function get isProcessManagerBlocked():Boolean;
        function get shouldSkipFrameAfterFinished():Boolean;

        function get canHaveMultipleInstances():Boolean;
		function get isBlockingOtherActions():Boolean;

		function get callback():Function;
	}
}