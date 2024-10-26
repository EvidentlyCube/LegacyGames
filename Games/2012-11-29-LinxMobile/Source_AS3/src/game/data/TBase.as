package game.data{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    import game.global.Game;
    import game.global.Level;
    import game.global.Minimap;
    import game.global.Pre;
    import game.objects.TConnector;

    import net.retrocade.camel.global.rGfx;

    public class TBase extends TConnector{
        [Embed(source="/../assets/gfx/by_cage/tiles/tiles_base.png")]        public static var _tiles_:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/tiles_base_hlight.png")] public static var _tiles_hi:Class;

        [Embed(source="/../assets/gfx/by_cage/tiles/tiles_base_pattern.png")]        public static var _tiles_cb:Class;
        [Embed(source="/../assets/gfx/by_cage/tiles/tiles_base_pattern_hlight.png")] public static var _tiles_hi_cb:Class;

        private var _gfxFit:BitmapData;

        private var _gfxRect:Rectangle;

        private var _isColorBlind:Boolean;
        private var _isSmall:Boolean

        public function TBase(x:uint, y:uint, tileColor:uint){
            super(Gfx.getBase(tileColor, Pre.colorBlind, S().useSmallTileset), x, y);

            _color = tileColor;

            Level.groupBases.add(this);
            Level.level.setTile(tileX, tileY, this);

            resetGfx();

            Game.lStarling.addChild(this);

            Minimap.instance.drawBase(tileX, tileY, tileColor);

            _isColorBlind = Pre.colorBlind;
            reposition();
        }

        override public function set scaleX(value:Number):void{
            super.scaleX = (S().useSmallTileset ? value * 50 / 24 : value / 2);
        }

        override public function set scaleY(value:Number):void{
            super.scaleY = (S().useSmallTileset ? value * 50 / 24 : value / 2);
        }

        override public function resetGfx():void{
            if (_isColorBlind != Pre.colorBlind || _isSmall != S().useSmallTileset){
                _isColorBlind = Pre.colorBlind;
                _isSmall = S().useSmallTileset;

                texture = Gfx.getBase(tileColor, Pre.colorBlind, S().useSmallTileset);
                readjustSize();
            }
        }

        override public function update():void{
            resetGfx();
        }

        override public function redrawTransparent():void{
            if (!_gfxRect || !_gfx)
                return;
        }
    }
}