package net.retrocade.tacticengine.core{
	public interface IEvent extends IDestruct{
        function get isPropagationStopped():Boolean;
        function get isDefaultPrevented():Boolean;
		function preventDefault():void;
        function stopPropagation():void;
	}
}