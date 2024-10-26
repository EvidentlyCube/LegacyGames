package net.retrocade.tacticengine.monstro.ais.player{
    import net.retrocade.tacticengine.core.Field;
	import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.events.MonstroEventDisplayUnitStats;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;

	public class MonstroPlayerThreadInactivatePlayerUnit implements IMonsroPlayerTurnProcessThread{
		private var _field:Field;
		private var _renderer:MonstroFieldRenderer;
		
		private var _approachableTiles:Vector.<Tile>;
        private var _attackableTiles  :Vector.<Tile>;
		
		public function set field(value:Field):void{
			_field = value;
		}
		
		public function set fieldRenderer(value:MonstroFieldRenderer):void{
			_renderer = value;
		}

        public function MonstroPlayerThreadInactivatePlayerUnit(){}

        public function update():Boolean{
            return false;
        }

		public function click(tileX:int, tileY:int):Boolean{
			var tile:Tile = _field.getTileAt(tileX, tileY);

            if (!tile || _approachableTiles){
                return true;
            }

            var unit:MonstroEntity = tile.entity as MonstroEntity;

            new MonstroEventDisplayUnitStats(unit);

            _approachableTiles = unit.getMovableTiles();
            _renderer.markTiles(_approachableTiles, Monstro.MARK_MOVABLE_MOVED);

            return false;
		}

		public function destruct():void{
            new MonstroEventDisplayUnitStats(null);

            if (_approachableTiles){
			    _renderer.markTiles(_approachableTiles, Monstro.MARK_RESET);
                _approachableTiles.length = 0;
            }

            if (_attackableTiles){
                _renderer.markTiles(_attackableTiles, Monstro.MARK_RESET);
                _attackableTiles.length = 0;
            }

			_field = null;
			_renderer = null;
		}
	}
}