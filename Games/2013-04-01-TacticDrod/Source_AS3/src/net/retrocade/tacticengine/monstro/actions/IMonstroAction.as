package net.retrocade.tacticengine.monstro.actions{
    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.IDestruct;

	public interface IMonstroAction extends IDestruct{
		function update():Boolean;
        function set field(value:Field):void;

        function get isStoppingAction():Boolean;
	}
}