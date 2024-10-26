package submuncher.ingame.gameObjects.helpers {
    import net.retrocade.enums.Direction4;

    import submuncher.ingame.gameObjects.EnemyEel;
    import submuncher.ingame.gameObjects.EnemyJellyfish;

    public interface IJellyfishSegment {
        function get x():Number;
        function get y():Number;
        function get direction():Direction4;
    }
}
