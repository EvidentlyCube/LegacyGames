package game.data{
    import flash.display.BitmapData;

    import game.global.Game;
    import game.global.Level;
    import game.global.Pre;
    import game.objects.TConnector;

    import net.retrocade.camel.core.rGfx;

    public class TBase extends TConnector{
        [Embed(source="/../assets/gfx/by_cage/tiles/base_white.png")]  public static var _base_0:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_red.png")]    public static var _base_1:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_orange.png")] public static var _base_2:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_yellow.png")] public static var _base_3:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_green.png")]  public static var _base_4:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_cyan.png")]   public static var _base_5:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_blue.png")]   public static var _base_6:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_violet.png")] public static var _base_7:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_black.png")]  public static var _base_8:Class;

        [Embed(source="/../assets/gfx/by_cage/tiles/base_white_1.png")]  public static var _basec_0:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_red_1.png")]    public static var _basec_1:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_orange_1.png")] public static var _basec_2:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_yellow_1.png")] public static var _basec_3:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_green_1.png")]  public static var _basec_4:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_cyan_1.png")]   public static var _basec_5:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_blue_1.png")]   public static var _basec_6:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_violet_1.png")] public static var _basec_7:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/base_black_1.png")]  public static var _basec_8:Class;

        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_white.png")]  public static var _base_cb0:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_red.png")]    public static var _base_cb1:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_orange.png")] public static var _base_cb2:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_yellow.png")] public static var _base_cb3:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_green.png")]  public static var _base_cb4:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_cyan.png")]   public static var _base_cb5:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_blue.png")]   public static var _base_cb6:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_violet.png")] public static var _base_cb7:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_black.png")]  public static var _base_cb8:Class;

        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_white_1.png")]  public static var _basec_cb0:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_red_1.png")]    public static var _basec_cb1:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_orange_1.png")] public static var _basec_cb2:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_yellow_1.png")] public static var _basec_cb3:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_green_1.png")]  public static var _basec_cb4:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_cyan_1.png")]   public static var _basec_cb5:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_blue_1.png")]   public static var _basec_cb6:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_violet_1.png")] public static var _basec_cb7:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/cb/base_black_1.png")]  public static var _basec_cb8:Class;

        private var _gfxCompleted:BitmapData;

        public function TBase(x:uint, y:uint, color:uint){
            _x     = x;
            _y     = y;
            _color = color;

            Level.bases.add(this);
            Level.level.set(_x, _y, this);

            _gfx          = rGfx.getBD(TBase["_base_" + (Pre.colorBlind ? "cb" : "") + color]);
            _gfxCompleted = rGfx.getBD(TBase["_basec_" + (Pre.colorBlind ? "cb" : "") + color]);
        }

        override public function resetGfx():void{
            _gfx          = rGfx.getBD(TBase["_base_" + (Pre.colorBlind ? "cb" : "") + color]);
            _gfxCompleted = rGfx.getBD(TBase["_basec_" + (Pre.colorBlind ? "cb" : "") + color]);
        }

        override public function update():void{
            if (this.allConnected)
                Game.lGame.draw(_gfxCompleted, x + S().playfieldOffsetX, y + S().playfieldOffsetY);
            else
                Game.lGame.draw(_gfx, x + S().playfieldOffsetX, y + S().playfieldOffsetY);
        }
    }
}