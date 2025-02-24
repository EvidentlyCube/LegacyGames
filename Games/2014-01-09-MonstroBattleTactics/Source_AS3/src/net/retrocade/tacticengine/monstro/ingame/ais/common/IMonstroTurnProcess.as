package net.retrocade.tacticengine.monstro.ingame.ais.common{
    import net.retrocade.tacticengine.core.IDisposable;
	import net.retrocade.tacticengine.monstro.global.enum.EnumUnitController;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

    public interface IMonstroTurnProcess extends IDisposable{
        function update():Boolean;
		function get controlledBy():EnumUnitController;

        function start():void;
        function stop():void;

        function onUndo():void;

        function set enabled(value:Boolean):void;
        function get enabled():Boolean;

        function get controllableUnits():Vector.<MonstroEntity>;
    }
}