/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 17.01.13
 * Time: 10:11
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.actions {
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;

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

        override public function destruct():void{
            _tiles.length == 0;
            _tiles = null;

            super.destruct();
        }

        override public function get isStoppingAction():Boolean{
            return false;
        }
    }
}
