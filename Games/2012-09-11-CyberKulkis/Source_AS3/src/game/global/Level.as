package game.global {
    import flash.events.Event;
    import flash.net.FileFilter;
    import flash.net.FileReference;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import flash.utils.setTimeout;

    import net.retrocade.camel.core.rGroup;
    import net.retrocade.camel.engines.tilegrid.rTileGrid;

    /**
     * ...
     * @author
     */
    public class Level {
        [Embed(source = '/../assets/gfx/bg2.png')] public static var _bg_:Class;

        public static var level :rTileGrid = new rTileGrid(16, 14, 24, 24);
        public static var active:rGroup    = new rGroup();
        public static var effects:rGroup   = new rGroup();

        public static var widthTiles :uint;
        public static var heightTiles:uint;

        public static var widthPixels :uint;
        public static var heightPixels:uint;

        public static var levelDrawOffsetX:uint;
        public static var levelDrawOffsetY:uint;

        public static var heartCollected:Boolean = false;
    }
}