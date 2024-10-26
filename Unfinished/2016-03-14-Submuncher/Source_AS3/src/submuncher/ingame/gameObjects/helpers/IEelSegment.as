package submuncher.ingame.gameObjects.helpers {
    import net.retrocade.enums.Direction4;

    import submuncher.ingame.gameObjects.EnemyEel;

    public interface IEelSegment {
        function get x():Number;
        function get y():Number;
        function get prevX():Number;
        function get prevY():Number;
        function get direction():Direction4;
        function get head():EnemyEel;
        function get isMoving():Boolean;
        function get nextSegment():IEelSegment;
        function getAngle():Number;
        function get lastAngle():Number;
        function get isTurnSegment():Boolean;
    }
}
