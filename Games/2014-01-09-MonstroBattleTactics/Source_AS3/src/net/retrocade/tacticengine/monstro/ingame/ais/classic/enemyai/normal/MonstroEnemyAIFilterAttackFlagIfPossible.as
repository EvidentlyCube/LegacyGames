
package net.retrocade.tacticengine.monstro.ingame.ais.classic.enemyai.normal {

    import flash.utils.Dictionary;

    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
	import net.retrocade.tacticengine.monstro.ingame.ais.classic.IMonstroEnemyStep;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.utils.MonstroPathmapper;

    public class MonstroEnemyAIFilterAttackFlagIfPossible implements IMonstroEnemyStep {
        private var _tilesToTest:Vector.<Tile>;
        private var _unit:MonstroEntity;
        private var _field:MonstroField;
        private var _testedTiles:Vector.<Tile>;
		private var _originalTiles:Vector.<Tile>
		private var _tilesScores:Dictionary;

        private var _lookedForFlag:Boolean = false;
        private var _staticFlag:MonstroEntity;

		private var _canReachFlag:Boolean = false;
		private var _smallestTileScore:Number;

        public function init(entity:MonstroEntity, tiles:Vector.<Tile>, friendlyUnits:Vector.<MonstroEntity>, hostileUnits:Vector.<MonstroEntity>):void {
            _unit = entity;
            _tilesToTest = tiles;

            _testedTiles = new Vector.<Tile>();
            _tilesScores = new Dictionary(true);

            if (!_lookedForFlag){
                for each(var unit:MonstroEntity in hostileUnits) {
                    if (unit.unitType.isFlag()) {
                        _staticFlag = unit;
                        break;
                    }
                }

                _lookedForFlag = true;
            }

			_originalTiles = tiles;
			_smallestTileScore = Number.MAX_VALUE;
            if (_staticFlag && _staticFlag.isAlive){
				_canReachFlag = MonstroPathmapper.hasOpenPath(_unit.x, _unit.y, _staticFlag.x, _staticFlag.y, _unit, _field);

				if (_canReachFlag) {
					_tilesToTest.push(_field.getTileAt(_staticFlag.x - 1, _staticFlag.y));
					_tilesToTest.push(_field.getTileAt(_staticFlag.x + 1, _staticFlag.y));
					_tilesToTest.push(_field.getTileAt(_staticFlag.x, _staticFlag.y - 1));
					_tilesToTest.push(_field.getTileAt(_staticFlag.x, _staticFlag.y + 1));
				}
            }
        }

        public function update():Boolean {
            if (!_staticFlag || !_staticFlag.isAlive || _tilesToTest.length == 0 || !_canReachFlag) {
                return true;
            }

            parseTile(_tilesToTest.pop());

            return _tilesToTest.length == 0;
        }

        public function getResult():Vector.<Tile> {
            if (!_staticFlag || !_staticFlag.isAlive || !_canReachFlag || _tilesToTest.length === 0) {
                return _originalTiles;
            } else {
                var result:Vector.<Tile> = new Vector.<Tile>();

                for (var tile:Object in _tilesScores) {
                    var score:int = _tilesScores[tile];

					if (score === _smallestTileScore){
						result.push(tile as Tile);
					}
                }

                return result;
            }
        }

        public function dispose():void {

        }

        private function parseTile(tile:Tile):void {
			if (tile.canStandOn(_unit) && MonstroPathmapper.hasOpenPath(_unit.x, _unit.y, tile.x, tile.y, _unit, _field)){
				var distance:int = MonstroPathmapper.getDistance(_unit.x, _unit.y, tile.x, tile.y, _unit, _field);

				if (distance <= _unit.getStatistics().movesLeft){
					_smallestTileScore = Math.min(_smallestTileScore, distance);
					_tilesScores[tile] = distance;
				}
			}
        }

        public function set field(value:MonstroField):void {
            _field = value;
        }

        public function toString():String {
            return "Attack flag if possible";
        }
    }
}
