package net.retrocade.tacticengine.monstro.ais.player{
	import net.retrocade.tacticengine.core.Field;
	import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.events.MonstroEventDisplayUnitStats;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;

	public class MonstroPlayerThreadEnemyUnit implements IMonsroPlayerTurnProcessThread{
		private var _unit:MonstroEntity;
		private var _field:Field;
		private var _renderer:MonstroFieldRenderer;
		
		private var _approachableTiles:Vector.<Tile>;
        private var _attackableTiles:Vector.<Tile>;

		public function set field(value:Field):void{
			_field = value;
		}
		
		public function set fieldRenderer(value:MonstroFieldRenderer):void{
			_renderer = value;
		}

        public function MonstroPlayerThreadEnemyUnit(){}

        public function update():Boolean{
            return false;
        }
		
		public function click(tileX:int, tileY:int):Boolean{
			var tile:Tile = _field.getTileAt(tileX, tileY);

            if (!_unit){
                _unit = tile.entity as MonstroEntity;

                _approachableTiles = _unit.getMovableTiles();
                _attackableTiles = _unit.getExpandedAttackableTiles(_approachableTiles);

                _renderer.markTiles(_attackableTiles, Monstro.MARK_ATTACKABLE);
                _renderer.markTiles(_approachableTiles, Monstro.MARK_MOVABLE);
                _renderer.markTile(_unit.tile, Monstro.MARK_MOVE_TO);

                new MonstroEventDisplayUnitStats(_unit);
                return false;
            } else {
                return true;
            }
		}

		public function destruct():void{
            if (_approachableTiles){
			    _renderer.markTiles(_approachableTiles, Monstro.MARK_RESET);
                _approachableTiles.length = 0;
            }

            if (_attackableTiles){
			    _renderer.markTiles(_attackableTiles, Monstro.MARK_RESET);
                _attackableTiles.length = 0;
            }

            new MonstroEventDisplayUnitStats(null);

			_unit = null;
			_field = null;
			_renderer = null;
		}
	}
}