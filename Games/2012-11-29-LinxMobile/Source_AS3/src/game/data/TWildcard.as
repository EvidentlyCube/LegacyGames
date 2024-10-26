package game.data{
    import game.global.Game;
    import game.global.Level;
    import game.objects.TConnector;

    import net.retrocade.camel.global.rGfx;

    public class TWildcard extends TConnector{
        [Embed(source="/../assets/gfx/by_cage/tiles/tile_wildcard.png")] public static var _wildcard_:Class;
        public function TWildcard(x:uint, y:uint){
            super(Gfx.wildcardTexture, x / S().tileWidth, y / S().tileHeight);

            this.x = x;
            this.y = y;

            _gfx = rGfx.getBD(_wildcard_);

            Level.level.set(x, y, this);
            Level.groupOtherTiles.add(this);

            Game.lStarling.addChild(this);

            update();
        }

        override public function colorMatches(tileColor:uint):Boolean{
            return true;
        }

        override public function update():void{
        }
    }
}