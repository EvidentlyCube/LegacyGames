package net.retrocade.tacticengine.core {
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
	import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;

	public class MonstroField implements IDisposable {
		private var _tiles:Vector.<Vector.<Tile>>;
		private var _entities:Vector.<MonstroEntity>;

		private var _width:int;
		private var _height:int;

		public var currentTurn:uint = 1;
		public var isLoadedFromContinue:Boolean = false;

		public function get width():int {
			return _width;
		}

		public function get height():int {
			return _height;
		}

		public function MonstroField() {
		}

		public function init(width:int, height:int):void {
			_width = width;
			_height = height;

			_tiles = new Vector.<Vector.<Tile>>(width, true);
			_entities = new Vector.<MonstroEntity>();

			for (var i:int = 0; i < width; i++) {
				_tiles[i] = new Vector.<Tile>(height, true);

				for (var j:int = 0; j < height; j++) {
					_tiles[i][j] = new Tile(i, j, this);
				}
			}
		}

		public function setEntityList(entities:Vector.<MonstroEntity>):void{
			_entities = entities;
		}

		public function refreshEntityList():void {
			_entities.length = 0;

			for each(var column:Vector.<Tile> in _tiles) {
				for each(var tile:Tile in column) {
					if (tile.entity) {
						_entities.push(tile.entity);
					}
				}
			}
		}

		public function getTileAt(x:int, y:int):Tile {
			if (x < 0 || y < 0 || x >= _width || y >= _height) {
				return null;
			}

			return _tiles[x][y];
		}

		public function getEntityById(id:uint):MonstroEntity {
			for each(var entity:MonstroEntity in _entities) {
				if (entity && entity.id === id) {
					return entity;
				}
			}

			return null;
		}

		public function getAllEntities():Vector.<MonstroEntity> {
			return _entities.concat();
		}

		public function getLivingEntities():Vector.<MonstroEntity> {
			var entities:Vector.<MonstroEntity> = new Vector.<MonstroEntity>();

			for each(var entity:MonstroEntity in getAllEntities()){
				if (entity.isAlive){
					entities.push(entity);
				}
			}

			return entities;
		}

		public function getAllTraps():Vector.<IMonstroTrap> {
			var traps:Vector.<IMonstroTrap> = new Vector.<IMonstroTrap>();

			for each(var column:Vector.<Tile> in _tiles) {
				for each(var tile:Tile in column) {
					if (tile.floor.trap) {
						traps.push(tile.floor.trap);
					}
				}
			}

			return traps;
		}

		public function dispose():void {
			for (var i:int = 0; i < width; i++) {
				for (var j:int = 0; j < height; j++) {
					_tiles[i][j].dispose();
				}

				_tiles[i] = null;
			}
			_tiles = null;
		}
	}
}