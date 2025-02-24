
package net.retrocade.tacticengine.monstro.ingame.traps {
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.core.IDumpable;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.global.enum.EnumTrapType;

    public interface IMonstroTrap extends IDumpable, IDisposable {
        function get x():int;
        function set x(value:int):void;

        function get y():int;
        function set y(value:int):void;

        function unitStands(unit:MonstroEntity):void;

        function get name():String;

        function get type():EnumTrapType;

        function get isEnabled():Boolean;

        function set isEnabled(value:Boolean):void;
    }
}
