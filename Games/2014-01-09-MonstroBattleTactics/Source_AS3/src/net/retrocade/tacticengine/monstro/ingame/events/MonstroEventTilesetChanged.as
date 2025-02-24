
package net.retrocade.tacticengine.monstro.ingame.events {
    import net.retrocade.tacticengine.monstro.global.enum.EnumTileset;

    public class MonstroEventTilesetChanged extends MonstroEvent{
        public static const NAME:String = "tileset_changed";

        public var tileset:EnumTileset;

        public function MonstroEventTilesetChanged(tileset:EnumTileset){
            this.tileset = tileset;

            dispatch(NAME);
        }
    }
}
