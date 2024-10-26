package submuncher.ingame.vfx {
    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;

    public interface IEffect extends IRetrocamelUpdatable {
        function get objectClass():Class;

        function get isFinished():Boolean;

        function get isDisplayEffect():Boolean;

        function get isPersistent():Boolean;

        function get isOnGameObjectLayer():Boolean;

        function get blocksGameplay():Boolean;

        function get blocksOtherEffects():Boolean;

        function dispose():void;
    }
}
