
package net.retrocade.tacticengine.monstro.ingame.undo {
    import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.core.MonstroField;

	public interface IUndoBit extends IDisposable{
        function undo(field:MonstroField):void;
		function makeDump():Object;
		function loadFromDump(dump:Object):void;
    }
}
