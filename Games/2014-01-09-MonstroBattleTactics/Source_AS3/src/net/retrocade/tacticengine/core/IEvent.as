package net.retrocade.tacticengine.core{
	public interface IEvent extends IDisposable{
        function get isPropagationStopped():Boolean;
        function get isDefaultPrevented():Boolean;
		function preventDefault():void;
        function stopPropagation():void;
	}
}