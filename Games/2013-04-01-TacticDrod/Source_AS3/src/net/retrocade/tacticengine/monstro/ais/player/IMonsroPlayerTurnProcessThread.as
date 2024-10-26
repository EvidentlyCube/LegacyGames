package net.retrocade.tacticengine.monstro.ais.player{
	import net.retrocade.tacticengine.core.Field;
	import net.retrocade.tacticengine.core.IDestruct;
	import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;

    public interface IMonsroPlayerTurnProcessThread extends IDestruct{
        /**
         * Returns true if the action is finished
         */
        function click(tileX:int, tileY:int):Boolean;
		
		function set field(value:Field):void;
		
		function set fieldRenderer(value:MonstroFieldRenderer):void;

        function update():Boolean;
    }
}