package net.retrocade.tacticengine.monstro.render {
    import flash.geom.Point;
    import flash.utils.Dictionary;

    import net.retrocade.camel.interfaces.rIUpdatable;

    import net.retrocade.camel.layers.rLayerStarling;

    import net.retrocade.tacticengine.core.Entity;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.Field;
    import net.retrocade.tacticengine.core.FieldObject;
    import net.retrocade.tacticengine.core.IDestruct;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionKillBeethro;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionMarkTiles;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionChangeUnitEnabled;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionDelay;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionHitUnit;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionKillUnit;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionMoveUnit;
    import net.retrocade.tacticengine.monstro.actions.MonstroActionTurnPhase;
    import net.retrocade.tacticengine.monstro.ais.MonstroEnemyTurnProcess;
    import net.retrocade.tacticengine.monstro.ais.MonstroPlayerTurnProcess;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroData;
    import net.retrocade.tacticengine.monstro.core.MonstroFunctions;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.events.MonstroEventDelayEffect;
    import net.retrocade.tacticengine.monstro.events.MonstroEventDisplayUnitStats;
    import net.retrocade.tacticengine.monstro.events.MonstroEventMarkTiles;
    import net.retrocade.tacticengine.monstro.events.MonstroEventNewAction;
    import net.retrocade.tacticengine.monstro.events.MonstroEventSortUnitDisplay;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTurnProcessChange;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitDisable;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitEnable;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitHit;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitKilled;
    import net.retrocade.tacticengine.monstro.events.MonstroEventUnitMoved;
    import net.retrocade.tacticengine.monstro.floors.MonstroTileFloor;
    import net.retrocade.tacticengine.monstro.undo.UndoBitUnitClip;
    import net.retrocade.tacticengine.monstro.undo.UndoManager;

    import starling.display.DisplayObject;

    import starling.display.DisplayObjectContainer;

    import starling.display.Image;
    import starling.display.Sprite;

    public class MonstroFieldRenderer implements IDestruct {
        private var _field:Field;
        private var _map:Dictionary;

        public var layerFloor:rLayerStarling;
        public var layerAnimatedFloor:rLayerStarling;
        public var layerRects:rLayerStarling;
        public var layerSprites:rLayerStarling;

        public var isPlayerHuman:Boolean;

        private var _animatedObjects:Vector.<MonstroUnitClip>;

        public function MonstroFieldRenderer(field:Field) {
            _field = field;

            _animatedObjects = new Vector.<MonstroUnitClip>();

            layerAnimatedFloor = new rLayerStarling();
            layerFloor = new rLayerStarling();
            layerRects = new rLayerStarling();
            layerSprites = new rLayerStarling();

            Eventer.listen(MonstroEventUnitMoved.NAME, onEntityMoved);
            Eventer.listen(MonstroEventUnitHit.NAME, onEntityHit);
            Eventer.listen(MonstroEventUnitKilled.NAME, onEntityKilled);
            Eventer.listen(MonstroEventUnitDisable.NAME, onUnitDisabled);
            Eventer.listen(MonstroEventUnitEnable.NAME, onUnitEnabled);
            Eventer.listen(MonstroEventDelayEffect.NAME, onDelayEffect);
            Eventer.listen(MonstroEventTurnProcessChange.NAME, onTurnProcessChanged);
            Eventer.listen(MonstroEventSortUnitDisplay.NAME, sortUnits);
            Eventer.listen(MonstroEventMarkTiles.NAME, onMarkTiles);

            layerAnimatedFloor.layer.touchable = false;
            layerFloor.layer.touchable = false;
            layerRects.layer.touchable = false;
            layerSprites.layer.touchable = false;
        }

        public function rerenderAll():void {
            layerFloor.clear();
            layerAnimatedFloor.clear();
            layerSprites.clear();

            _map = new Dictionary();

            var image:Image;
            var tile:Tile;
            var floor:MonstroTileFloor;
            var entity:MonstroEntity;

            for (var i:int = 0; i < _field.width; i++) {
                for (var j:int = 0; j < _field.height; j++) {
                    tile = _field.getTileAt(i, j);
                    image = MonstroGfx.getRect();
                    layerRects.addAt(image, 0);

                    image.x = i * Monstro.tileWidth;
                    image.y = j * Monstro.tileHeight;

                    _map[tile] = image;

                    markTile(tile, Monstro.MARK_RESET);

                    floor = tile.floor as MonstroTileFloor;
                    if (floor) {
                        for each(var tilePoint:Point in floor.layers) {
                            image = getTileImage(tilePoint.x, tilePoint.y);

                            image.x = i * Monstro.tileWidth;
                            image.y = j * Monstro.tileHeight;

                            if (image is MonstroTileClip){
                                layerAnimatedFloor.add(image);
                                _animatedObjects.push(image as MonstroTileClip);
                            } else {
                                layerFloor.add(image);
                            }
                        }
                    }

                    entity = tile.entity as MonstroEntity;
                    if (entity) {
                        var unitClip:MonstroUnitClip = createImageFrom(entity);

                        if (unitClip) {
                            layerSprites.add(unitClip);

                            unitClip.x = i * Monstro.tileWidth;
                            unitClip.y = j * Monstro.tileHeight;

                            if (entity.isPlayer){
                                _animatedObjects.push(unitClip);
                            }

                            _map[entity] = unitClip
                        }
                    }
                }
            }

            Sprite(layerFloor.layer).flatten();
        }

        public function globalToLocal(point:Point):void{
            layerFloor.layer.globalToLocal(point, point);
        }

        public function update():void {
            for each(var updatable:MonstroUnitClip in _animatedObjects){
                updatable.update();
            }
        }

        public function onEntityMoved(event:MonstroEventUnitMoved):void {
            var image:MonstroUnitClip = _map[event.unit];

            new MonstroEventDisplayUnitStats(null);

            if (image) {
                UndoManager.instance.addBit(new UndoBitUnitClip(image));

                new MonstroEventNewAction(new MonstroActionMoveUnit(
                        image,
                        event.unit,
                        event.movementPath,
                        event.onFinished
                ));
            }
        }

        public function onEntityHit(event:MonstroEventUnitHit):void {
            var attacker:MonstroUnitClip = _map[event.attacker];
            var attacked:MonstroUnitClip = _map[event.attacked];

            if (attacker){
                attacker.direction = MonstroFunctions.getOrientationTowards(
                        attacker.x, attacker.y, attacked.x, attacked.y
                );
            }

            if (attacked) {
                new MonstroEventNewAction(new MonstroActionHitUnit(
                        attacked,
                        event.attacked,
                        event.onFinished
                ));
            }
        }

        public function onEntityKilled(event:MonstroEventUnitKilled):void {
            var image:MonstroUnitClip = _map[event.unit];

            if (image) {
                UndoManager.instance.addBit(new UndoBitUnitClip(image));

                if (event.unit.name == MonstroEntityFactory.NAME_BEETHRO){
                    new MonstroEventNewAction(new MonstroActionKillBeethro(
                            image,
                            event.unit
                    ));
                } else {
                    new MonstroEventNewAction(new MonstroActionKillUnit(
                            image,
                            event.unit,
                            event.onFinished
                    ));
                }
            }
        }

        public function onUnitDisabled(event:MonstroEventUnitDisable):void {
            var image:MonstroUnitClip = _map[event.unit];

            if (image) {
                new MonstroEventNewAction(new MonstroActionChangeUnitEnabled(
                        image, false, null
                ));
            }
        }

        public function onUnitEnabled(event:MonstroEventUnitEnable):void {
            var image:MonstroUnitClip = _map[event.unit];

            if (image) {
                new MonstroEventNewAction(new MonstroActionChangeUnitEnabled(
                        image, true, null
                ));
            }
        }

        protected function onDelayEffect(event:MonstroEventDelayEffect):void {
            new MonstroEventNewAction(
                    new MonstroActionDelay(event.delay)
            );
        }

        protected function onTurnProcessChanged(event:MonstroEventTurnProcessChange):void {
            var unit:MonstroEntity;
            var image:MonstroUnitClip;

            if (event.currentProcess){
                for each(unit in event.currentProcess.controllableUnits) {
                    image = _map[unit];
                }
            }

            for each(unit in event.newProcess.controllableUnits) {
                image = _map[unit];
            }

            if (event.newProcess is MonstroEnemyTurnProcess){
                MonstroData.turnsTaken.add(1);
            }

            for each(var unitClip:MonstroUnitClip in _animatedObjects){
                unitClip.showUnitRect = (event.newProcess is MonstroPlayerTurnProcess);
            }

            new MonstroEventNewAction(
                    new MonstroActionTurnPhase((event.newProcess is MonstroPlayerTurnProcess) == isPlayerHuman)
            );
        }

        protected function createImageFrom(fieldObject:FieldObject):MonstroUnitClip {
            if (fieldObject is MonstroEntity){
                return MonstroGfx.getUnit(MonstroEntity(fieldObject).name);
            }

            return null;
        }

        protected function getTileImage(x:int, y:int):Image{
            return MonstroGfx.getTileDrod(x, y);
        }

        public function markTile(tile:Tile, color:uint):void {
            var image:Image = _map[tile];

            image.color = color;
            image.alpha = 0.65;
            image.visible = (color != Monstro.MARK_RESET);
        }

        public function markTiles(tiles:Vector.<Tile>, color:uint):void {
            for each(var tile:Tile in tiles) {
                markTile(tile, color);
            }
        }

        public function destruct():void {
            _field = null;

            _animatedObjects.length = 0;
            _animatedObjects = null

            layerAnimatedFloor.clear();
            layerFloor.clear();
            layerRects.clear();
            layerSprites.clear();
            layerAnimatedFloor.removeLayer();
            layerFloor.removeLayer();
            layerRects.removeLayer();
            layerSprites.removeLayer();
            layerAnimatedFloor = null;
            layerFloor = null;
            layerRects = null;
            layerSprites = null;

            Eventer.release(MonstroEventUnitMoved.NAME, onEntityMoved);
            Eventer.release(MonstroEventUnitHit.NAME, onEntityHit);
            Eventer.release(MonstroEventUnitKilled.NAME, onEntityKilled);
            Eventer.release(MonstroEventUnitDisable.NAME, onUnitDisabled);
            Eventer.release(MonstroEventUnitEnable.NAME, onUnitEnabled);
            Eventer.release(MonstroEventDelayEffect.NAME, onDelayEffect);
            Eventer.release(MonstroEventTurnProcessChange.NAME, onTurnProcessChanged);
            Eventer.release(MonstroEventSortUnitDisplay.NAME, sortUnits);
            Eventer.release(MonstroEventMarkTiles.NAME, onMarkTiles);

            _map = null;
        }

        public function sortUnits():void{
            DisplayObjectContainer(layerSprites.layer).sortChildren(sortUnitsCompareFunction);
        }

        public function onMarkTiles(event:MonstroEventMarkTiles):void{
            new MonstroEventNewAction(new MonstroActionMarkTiles(
                event.tiles, event.color, this
            ));
        }

        private function sortUnitsCompareFunction(itemA:DisplayObject, itemB:DisplayObject):int{
            return itemA.y - itemB.y;
        }
    }
}