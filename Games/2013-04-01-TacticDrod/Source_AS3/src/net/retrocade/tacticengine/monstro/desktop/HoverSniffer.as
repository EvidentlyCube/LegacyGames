/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 15.02.13
 * Time: 15:34
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.desktop {
    import flash.geom.Point;

    import net.retrocade.camel.interfaces.rIUpdatable;

    import net.retrocade.tacticengine.core.Eventer;

    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.IDestruct;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.SmartTouch;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.events.MonstroEventDisplayAttackStats;
    import net.retrocade.tacticengine.monstro.events.MonstroEventDisplayUnitStats;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitSelected;
    import net.retrocade.tacticengine.monstro.render.MonstroFieldRenderer;

    public class HoverSniffer implements rIUpdatable, IDestruct{
        private var _field:Field;
        private var _fieldRenderer:MonstroFieldRenderer;

        private var _lastTile:Tile = null;
        private var _movingUnit:MonstroEntity;

        private var _showingAttackWindow:Boolean = false;
        private var _showingStatsWindow:Boolean = false;

        public function HoverSniffer(field:Field, renderer:MonstroFieldRenderer){
            _field = field;
            _fieldRenderer = renderer;

            Eventer.listen(MonstroEventUnitSelected.NAME, onUnitSelected);
        }

        public function update():void{
            var position:Point = new Point(SmartTouch.hoverX, SmartTouch.hoverY);
            _fieldRenderer.globalToLocal(position);

            var x:int = position.x / Monstro.tileWidth | 0;
            var y:int = position.y / Monstro.tileHeight | 0;

            var tile:Tile = _field.getTileAt(x, y);
            if (tile == _lastTile){
                return;
            }

            onMovedAwayFromTile();

            if (tile && tile.entity){
                onMovedOnEntity(tile.entity as MonstroEntity);
            }

            _lastTile = tile;
        }

        private function onMovedAwayFromTile():void{
            if (_showingAttackWindow){
                new MonstroEventDisplayAttackStats(false);
                _showingAttackWindow = false;
            }

            if (_showingStatsWindow){
                if (_movingUnit){
                    new MonstroEventDisplayUnitStats(_movingUnit);
                } else {
                    new MonstroEventDisplayUnitStats(null);
                }
                _showingStatsWindow = false;
            }
        }

        private function onMovedOnEntity(entity:MonstroEntity):void{
            if (_movingUnit == entity){
                return;
            }

            if (_movingUnit){
                if (entity && !entity.isPlayer){
                    new MonstroEventDisplayAttackStats(true, false, _movingUnit, entity);
                    _showingAttackWindow = true;
                }
            } else if (entity){
                new MonstroEventDisplayUnitStats(entity);
                _showingStatsWindow = true;
            }
        }

        private function onUnitSelected(e:MonstroEventUnitSelected):void{
            _movingUnit = e.unit;

            if (!_movingUnit){
                new MonstroEventDisplayAttackStats(false);
            }
        }


        public function destruct():void {
            _field = null;
            _fieldRenderer = null;
            _movingUnit = null;

            Eventer.release(MonstroEventUnitSelected.NAME, onUnitSelected);
        }
    }
}
