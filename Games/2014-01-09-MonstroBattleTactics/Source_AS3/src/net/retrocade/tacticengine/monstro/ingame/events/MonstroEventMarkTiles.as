package net.retrocade.tacticengine.monstro.ingame.events{
    import net.retrocade.tacticengine.core.Tile;

	public class MonstroEventMarkTiles extends MonstroEvent{
		public static const NAME:String = "mark_tiles";
		
		public var tiles:Vector.<Tile>;
        public var color:uint;
		
		public function MonstroEventMarkTiles(tiles:*, color:uint){
			if (tiles is Tile){
                this.tiles = new <Tile>[tiles];
            } else if (tiles is Vector.<Tile>){
                this.tiles = tiles;
            } else {
                throw new ArgumentError("Tiles must be an instance of class Tile or be a Vector.<Tile>");
            }

            this.color = color;

            dispatch(NAME);
		}
		
		override public function dispose():void{
			tiles.length = 0;
            tiles = null;
		}
	}
}