
package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroFieldRenderer;

    public class MonstroActionMarkTiles extends MonstroAction{
        private var _tiles:Vector.<Tile>;
        private var _fieldRenderer:MonstroFieldRenderer;
        private var _color:uint;

        public function MonstroActionMarkTiles(tiles:Vector.<Tile>, color:uint, fieldRenderer:MonstroFieldRenderer) {
            super(null);

            _tiles = tiles.concat();
            _color = color;

            _fieldRenderer = fieldRenderer;
        }

        override public function update():Boolean{
            _fieldRenderer.markTiles(_tiles, _color);

            return true;
        }

        override public function dispose():void{
            _tiles.length == 0;
            _tiles = null;

            super.dispose();
        }

        override public function get shouldSkipFrameAfterFinished():Boolean{
            return false;
        }
    }
}
