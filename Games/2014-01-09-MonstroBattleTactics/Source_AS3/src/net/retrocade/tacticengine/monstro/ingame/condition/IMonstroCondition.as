
package net.retrocade.tacticengine.monstro.ingame.condition {
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.core.IDumpable;

    public interface IMonstroCondition extends IDisposable, IDumpable{
        function check():Boolean;

        function get type():String;
    }
}
