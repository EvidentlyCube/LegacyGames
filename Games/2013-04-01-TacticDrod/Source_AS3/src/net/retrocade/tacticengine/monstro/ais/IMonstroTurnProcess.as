package net.retrocade.tacticengine.monstro.ais{
    import net.retrocade.tacticengine.core.IDestruct;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;

    public interface IMonstroTurnProcess extends IDestruct{
        function update():Boolean;

        function start():void;
        function stop():void;
        function onUndo():void;

        function set enabled(value:Boolean):void;
        function get enabled():Boolean;
        function get controllableUnits():Vector.<MonstroEntity>;
    }
}