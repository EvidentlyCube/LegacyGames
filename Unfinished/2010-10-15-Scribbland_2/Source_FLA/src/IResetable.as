package src{
    public interface IResetable{
        function stateCheckpoint():void;
        function stateDeath():void;
        function stateRestart():void;
    }
}