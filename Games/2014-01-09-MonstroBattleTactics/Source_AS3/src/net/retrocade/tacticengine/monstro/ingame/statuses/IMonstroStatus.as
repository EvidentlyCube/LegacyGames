
package net.retrocade.tacticengine.monstro.ingame.statuses {
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.core.IDumpable;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

    public interface IMonstroStatus extends IDisposable, IDumpable{
        function attachToUnit(unit:MonstroEntity):void;
        function onTurnStart():void;
        function onTurnEnd():void;
        function onAttack():void;
        function onDefense():void;

        function set unit(value:MonstroEntity):void;
        function get unit():MonstroEntity;

        function get name():String;
    }
}
