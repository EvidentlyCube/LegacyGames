package net.retrocade.tacticengine.monstro.gui.render {
    import flash.geom.Point;
    import flash.utils.Dictionary;

    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.tacticengine.core.Entity;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.FieldObject;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.core.Tile;
    import net.retrocade.tacticengine.core.injector.injectCreate;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroData;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGameplayDefinition;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.global.enum.EnumTileset;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
	import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionChangeUnitEnabled;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionDelay;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionDestroyFakeWall;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionDestroyTrap;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionHitUnit;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionKillUnit;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionMarkTiles;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionMoveUnit;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionScrollTo;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionStatusChanged;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionTrapActivated;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionTrapWebActivated;
    import net.retrocade.tacticengine.monstro.ingame.actions.MonstroActionTurnPhase;
    import net.retrocade.tacticengine.monstro.ingame.ais.classic.MonstroPlayerTurnProcess;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.global.enum.EnumTrapType;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitFaction;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventCenterOnUnit;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDefenseRestored;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventDelayEffect;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLightingChanged;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventMarkTiles;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventNewAction;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventResize;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventSortUnitDisplay;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventStatusChanged;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTrapActivated;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTurnProcessIsChanging;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndidTrap;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndidUnit;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUndoFinished;
	import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitDisable;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitEnable;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitHit;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitKilled;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitMoved;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventUnitStatsChanged;
    import net.retrocade.tacticengine.monstro.ingame.floors.MonstroTileFloor;
    import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;
    import net.retrocade.utils.UtilsArray;

    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
	import starling.display.Sprite;
	import starling.extensions.lighting.core.LightLayer;
	import starling.filters.ColorMatrixFilter;
    import starling.textures.Texture;

    public class MonstroFieldRenderer implements IDisposable {

		public static function get factorX():Number{
			return 1920 / S().gameWidth;
		}

		public static function get factorY():Number{
			return 1080 / S().gameHeight;
		}

        [Inject]
        public var field:MonstroField;
        [Inject]
        public var gameplayDefinition:MonstroGameplayDefinition;
        public var layerFloor:RetrocamelLayerStarling;
        public var layerAnimatedFloor:RetrocamelLayerStarling;
        public var layerRects:RetrocamelLayerStarling;
        public var layerSprites:RetrocamelLayerStarling;
		public var layerLight:RetrocamelLayerStarling;
        public var playerControls:EnumUnitFaction;
		public var tileset:EnumTileset;

		private var _lightLayerImpl:LightLayer;
        private var _map:Dictionary;
        private var _animatedObjects:Vector.<IRetrocamelUpdatable>;
        private var _hasDisplayedFirstPhase:Boolean = false;

        public function MonstroFieldRenderer() {
		}

        public function init():void {
            _animatedObjects = new Vector.<IRetrocamelUpdatable>();

            layerAnimatedFloor = new RetrocamelLayerStarling();
            layerFloor = new RetrocamelLayerStarling();
            layerRects = new RetrocamelLayerStarling();
			layerLight = new RetrocamelLayerStarling();
            layerSprites = new RetrocamelLayerStarling();

			Eventer.listen(MonstroEventCenterOnUnit.NAME, onCenterOnUnit, this);
            Eventer.listen(MonstroEventUnitMoved.NAME, onEntityMoved, this);
            Eventer.listen(MonstroEventUnitHit.NAME, onEntityHit, this);
            Eventer.listen(MonstroEventUnitKilled.NAME, onEntityKilled, this);
            Eventer.listen(MonstroEventUnitDisable.NAME, onUnitDisabled, this);
            Eventer.listen(MonstroEventUnitEnable.NAME, onUnitEnabled, this);
            Eventer.listen(MonstroEventDelayEffect.NAME, onDelayEffect, this);
            Eventer.listen(MonstroEventTurnProcessIsChanging.NAME, onTurnProcessChanged, this);
            Eventer.listen(MonstroEventSortUnitDisplay.NAME, sortUnits, this);
            Eventer.listen(MonstroEventMarkTiles.NAME, onMarkTiles, this);
            Eventer.listen(MonstroEventStatusChanged.NAME, onStatusChanged, this);
            Eventer.listen(MonstroEventTrapActivated.NAME, onTrapActivated, this);
            Eventer.listen(MonstroEventResize.NAME, onResize, this);
            Eventer.listen(MonstroEventDefenseRestored.NAME, onDefenseRestored, this);
            Eventer.listen(MonstroEventLightingChanged.NAME, onLightingToggled, this);
            Eventer.listen(MonstroEventUndidUnit.NAME, onUndidUnit, this);
            Eventer.listen(MonstroEventUndidTrap.NAME, onUndidTrap, this);
            Eventer.listen(MonstroEventUndoFinished.NAME, sortUnits, this);
			Eventer.listen(MonstroEventUnitStatsChanged.NAME, onUnitStatsChanged, this);

            layerAnimatedFloor.layer.touchable = false;
            layerFloor.layer.touchable = false;
            layerRects.layer.touchable = false;
            layerSprites.layer.touchable = false;

        }

		public function dispose():void {
			Eventer.releaseContext(this);

			field = null;

			if (_lightLayerImpl){
				_lightLayerImpl.dispose();
				_lightLayerImpl = null;
			}

			_animatedObjects.length = 0;
			_animatedObjects = null;

			layerAnimatedFloor.clear();
			layerFloor.clear();
			layerRects.clear();
			layerSprites.clear();
			layerLight.clear();

			layerAnimatedFloor.removeLayer();
			layerFloor.removeLayer();
			layerRects.removeLayer();
			layerSprites.removeLayer();
			layerLight.removeLayer();

			layerAnimatedFloor = null;
			layerFloor = null;
			layerRects = null;
			layerSprites = null;
			layerLight = null;

			_map = null;
		}

        public function renderAll():void {
            _map = new Dictionary();

			MonstroMarkTile.resetCache();

            var image:DisplayObject;
            var tile:Tile;
            var floor:MonstroTileFloor;
            var entity:MonstroEntity;
			var unitClip:MonstroUnitClip;

            for (var i:int = 0; i < field.width; i++) {
                for (var j:int = 0; j < field.height; j++) {
                    tile = field.getTileAt(i, j);
                    floor = tile.floor as MonstroTileFloor;
                    if (floor) {
                        for each(var tilePoint:Point in floor.layers) {
                            image = getTileImage(tilePoint.x, tilePoint.y);
                            image.x = i * MonstroConsts.tileWidth;
                            image.y = j * MonstroConsts.tileHeight;

                            if (image is MonstroTileClip) {
                                layerAnimatedFloor.add(image);
                                _animatedObjects.push(image as MonstroTileClip);
                            } else {
                                layerFloor.add(image);
                            }
                        }

                        if (floor.trap){
							var trap:IMonstroTrap = floor.trap;
                            image = getTrapImage(trap);

                            if (image) {
                                image.x = i * MonstroConsts.tileWidth;
                                image.y = j * MonstroConsts.tileHeight;

                                image.visible = trap.isEnabled;

                                layerRects.add(image);
                                _map[trap] = image;
                            }
                        }
                    }

					image = new MonstroMarkTile();
					layerRects.add(image);

					image.x = i * MonstroConsts.tileWidth;
					image.y = j * MonstroConsts.tileHeight;

					_map[tile] = image;

					markTile(tile, MonstroConsts.MARK_TYPE_RESET);

                    entity = tile.entity;
                    if (entity) {
                        unitClip = createImageFrom(entity);

                        if (unitClip) {
                            _animatedObjects.push(unitClip);
                            layerSprites.add(unitClip);

							unitClip.x = i * MonstroConsts.tileWidth;
							unitClip.y = j * MonstroConsts.tileHeight;

							unitClip.visible = entity.isAlive || unitClip.hasDeadTexture;

                            _map[entity] = unitClip;
                        }
                    }
                }
            }

			for each(entity in field.getAllEntities()){
				if (!getUnitClipForEntity(entity)){
					unitClip = createImageFrom(entity);

					if (unitClip) {
						_animatedObjects.push(unitClip);
						layerSprites.add(unitClip);

						unitClip.x = entity.x * MonstroConsts.tileWidth;
						unitClip.y = entity.y * MonstroConsts.tileHeight;

						unitClip.visible = entity.isAlive || unitClip.hasDeadTexture;

						_map[entity] = unitClip
					}
				}
			}
            Sprite(layerFloor.layer).flatten();

			regenerateLightLayer();
        }

        public function globalToLocal(point:Point):void {
            layerFloor.layer.globalToLocal(point, point);
        }

        public function update():void {
            for each(var movieClip:IRetrocamelUpdatable in _animatedObjects) {
                movieClip.update();
            }

			updateLightOffsets();
        }

        public function onEntityMoved(event:MonstroEventUnitMoved):void {
            var image:MonstroUnitClip = _map[event.unit];

            if (image) {
                new MonstroEventNewAction(
                    injectCreate(
                        MonstroActionMoveUnit,
                        image,
                        event.unit,
                        event.movementPath,
                        event.onFinished
                    )
                );
            }
        }

        public function onEntityHit(event:MonstroEventUnitHit):void {
            var attacker:MonstroUnitClip = _map[event.attacker];
            var attacked:MonstroUnitClip = _map[event.defender];

            if (attacker) {
                if (event.defender.x > event.attacker.x) {
                    attacker.mirror = false;

                } else if (event.defender.x < event.attacker.x) {
                    attacker.mirror = true;
                }
            }

            if (attacked) {
                new MonstroEventNewAction(
                    injectCreate(
                        MonstroActionHitUnit,
                        attacked,
                        event.attacker,
                        event.defender,
                        event.onFinished
                    )
                );
            }
        }

        public function onEntityKilled(event:MonstroEventUnitKilled):void {
            var image:MonstroUnitClip = _map[event.unit];

            if (image) {
                if (event.unit.unitType.isBreakableTile) {
                    new MonstroEventNewAction(injectCreate(MonstroActionDestroyFakeWall, image));
                } else {
                    new MonstroEventNewAction(
                        injectCreate(
                            MonstroActionKillUnit,
                            image,
                            event.unit
                        )
                    );
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

        public function markTile(tile:Tile, markType:uint):void {
            var image:MonstroMarkTile = _map[tile];

			if (image){
				image.markType = markType;
			}
        }

        public function markTiles(tiles:Vector.<Tile>, markType:uint):void {
			if (!tiles){
				return;
			}

            for each(var tile:Tile in tiles) {
                markTile(tile, markType);
            }
        }

        public function sortUnits():void {
            DisplayObjectContainer(layerSprites.layer).sortChildren(sortUnitsCompareFunction);
        }

        public function onMarkTiles(event:MonstroEventMarkTiles):void {
            new MonstroEventNewAction(new MonstroActionMarkTiles(
                event.tiles, event.color, this
            ));
        }

        public function onStatusChanged(event:MonstroEventStatusChanged):void {
            var image:MonstroUnitClip = _map[event.target];

            if (image) {
                new MonstroEventNewAction(new MonstroActionStatusChanged(
                    event.status,
                    event.target,
                    image,
                    event.wasAdded
                ));
            }
        }

        public function onTrapActivated(event:MonstroEventTrapActivated):void {
            new MonstroEventNewAction(new MonstroActionTrapActivated(event.trap.type));

            switch (event.trap.type) {
                case(EnumTrapType.WEB):
                    var trapImage:DisplayObject = _map[event.trap];
                    var entityImage:DisplayObject = _map[event.target];

                    if (trapImage) {
                        new MonstroEventNewAction(
                            injectCreate(
                                MonstroActionTrapWebActivated,
                                entityImage
                            )
                        );
                        new MonstroEventNewAction(
                            injectCreate(
                                MonstroActionDestroyTrap,
                                trapImage,
                                event.trap
                            )
                        );
                    }
                    break;
            }
        }

        public function onUnitStatsChanged(event:MonstroEventUnitStatsChanged):void{
			if (_map) {
				var image:MonstroUnitClip = _map[event.unit];

				if (image) {
					image.setStats(event.unit);
				}
			}
        }

        public function getUnitClipForEntity(entity:MonstroEntity):MonstroUnitClip {
            if (_map){
                return _map[entity] as MonstroUnitClip;
            } else {
                return null;
            }
        }

        public function getGraphicForObject(object:Object):DisplayObject{
            if (_map){
                return _map[object];
            } else {
                return null;
            }
        }

        public function getTileImageForTile(tile:Tile):Image{
            return _map[tile] as Image;
        }

        public function makeUnitGhost(unit:MonstroEntity):MonstroUnitClip {
            var colorFilter:ColorMatrixFilter = new ColorMatrixFilter();
            colorFilter.adjustSaturation(-1);

            var ghost:MonstroUnitClip = getUnitClipForEntity(unit).clone();
            ghost.alpha = 0.5;
            ghost.filter = colorFilter;
            ghost.isGhost = true;

            layerSprites.add(ghost);

            return ghost;
        }

        public function removeGhost(ghost:MonstroUnitClip):void {
            layerSprites.remove(ghost);
        }

        protected function onDelayEffect(event:MonstroEventDelayEffect):void {
            new MonstroEventNewAction(
                new MonstroActionDelay(event.delay)
            );
        }

        protected function onTurnProcessChanged(event:MonstroEventTurnProcessIsChanging):void {
            var unit:MonstroEntity;
            var image:MonstroUnitClip;

            if (event.currentProcess) {
                for each(unit in event.currentProcess.controllableUnits) {
                    image = _map[unit];

                    if (image) {
                        image.stop();
                    }
                }
            }

            for each(unit in event.newProcess.controllableUnits) {
                image = _map[unit];

                if (image) {
                    image.play();
                }
            }

            if (gameplayDefinition.displayPhaseImages){
                new MonstroEventNewAction(
                    new MonstroActionTurnPhase(
                        (event.newProcess is MonstroPlayerTurnProcess) ? playerControls : playerControls.getInverted(),
                        !_hasDisplayedFirstPhase
                    )
                );
				new MonstroEventNewAction(
                    new MonstroActionDelay(
						250
                    )
                );
            }

            _hasDisplayedFirstPhase = true;
        }

        protected function createImageFrom(fieldObject:FieldObject):MonstroUnitClip {
            if (fieldObject is MonstroEntity) {
                var monstroEntity:MonstroEntity = fieldObject as MonstroEntity;
                var unitClip:MonstroUnitClip = MonstroGfx.getUnit(monstroEntity.unitType);

                unitClip.isDestroyed = !monstroEntity.isAlive;
                unitClip.disabled = monstroEntity.hasMoved;
                unitClip.setStats(monstroEntity);

                for (var i:int = 0, l:int = monstroEntity.getSpecializationsCount(); i < l; i++) {
                    unitClip.addSpecialtyIcon(monstroEntity.getSpecialization(i).getSmallIconTexture());
                }

                return unitClip;
            }

            return null;
        }

        protected function getTileImage(x:int, y:int):Image {
            var tileX:int = x / MonstroConsts.tileWidth;
            var tileY:int = y / MonstroConsts.tileHeight;

            if (tileY >= 12) {
                if ((tileY - 12) % 3 != 0) {
                    throw new ArgumentError("Invalid animated tile: " + tileX + ":" + tileY);
                } else {
                    return getAnimatedTile(x, y);
                }
            } else {
                return MonstroGfx.getTile(x, y);
            }
        }

        protected function getAnimatedTile(x:int, y:int):MonstroTileClip {
            var tile:Vector.<Texture> = new Vector.<Texture>(4, true);
            tile[0] = MonstroGfx.getTileTexture(x, y);
            tile[1] = MonstroGfx.getTileTexture(x, y + MonstroConsts.tileHeight);
            tile[2] = MonstroGfx.getTileTexture(x, y + MonstroConsts.tileHeight * 2);
            tile[3] = tile[1];

            return new MonstroTileClip(tile)
        }

        protected function getTrapImage(trap:IMonstroTrap):Image {
            return MonstroGfx.getTrap(trap.type);
        }

        private function onCenterOnUnit(event:MonstroEventCenterOnUnit):void {
            var image:MonstroUnitClip = _map[event.unit];

            if (MonstroData.getCenterBeforeUnitMove()) {
                new MonstroEventNewAction(new MonstroActionScrollTo(
                    image.x + MonstroConsts.tileWidth / 2,
                    image.y + MonstroConsts.tileHeight / 2
                ));
            }
        }

        private static function sortUnitsCompareFunction(itemLeft:DisplayObject, itemRight:DisplayObject):int {
            var isLeftAlwaysUnder:Boolean = (itemLeft is MonstroUnitClip && MonstroUnitClip(itemLeft).isAlwaysHiddenUnder);
            var isRightAlwaysUnder:Boolean = (itemRight is MonstroUnitClip && MonstroUnitClip(itemRight).isAlwaysHiddenUnder);

            if (isLeftAlwaysUnder && isRightAlwaysUnder){
                return UtilsArray.SORT_RESULT_LEFT_EQUALS_RIGHT;
            } else if (isLeftAlwaysUnder){
                return UtilsArray.SORT_RESULT_LEFT_BEFORE_RIGHT;
            } else if (isRightAlwaysUnder){
                return UtilsArray.SORT_RESULT_LEFT_AFTER_RIGHT;
            } else {
                return itemLeft.y - itemRight.y;
            }
        }

		private function onResize(event:MonstroEventResize):void{
			regenerateLightLayer();
		}

		private function onDefenseRestored(event:MonstroEventDefenseRestored):void{
			var unitClip:MonstroUnitClip = _map[event.unit] as MonstroUnitClip;

			if (unitClip){
				unitClip.addDefenseRestoreEffect();
			}
		}

		private function onLightingToggled(event:MonstroEventLightingChanged):void{
			regenerateLightLayer();
		}

		private function onUndidUnit(event:MonstroEventUndidUnit):void{
			refreshUnitClip(event);
		}

		private function refreshUnitClip(event:MonstroEventUndidUnit):void {
			var clip:MonstroUnitClip = getUnitClipForEntity(event.entity);
			clip.x = event.entity.x * MonstroConsts.tileWidth;
			clip.y = event.entity.y * MonstroConsts.tileHeight;
			clip.isStunned = event.entity.statusIsStunned;
			clip.disabled = event.entity.hasMoved;
			clip.isDestroyed = !event.entity.isAlive;
			clip.visible = !clip.isDestroyed;
			clip.alpha = clip.isDestroyed ? 0 : 1;
			if (event.entity.controlledBy === MonstroStateIngame.instance.currentFaction && !clip.isDestroyed) {
				clip.play();
			} else {
				clip.stop();
			}
			clip.setStats(event.entity);
		}

		private function onUndidTrap(event:MonstroEventUndidTrap):void{
			var trapImage:DisplayObject = getGraphicForObject(event.trap);
			trapImage.visible = event.trap.isEnabled;
			trapImage.alpha = 1;
		}

		private function regenerateLightLayer():void{
			destroyLights();

			if (MonstroData.getShowLights() && MonstroData.getDarknessLevel() < 1){
				if (!layerLight){
					layerLight = new RetrocamelLayerStarling();
				}
				_lightLayerImpl = new LightLayer(S().gameWidth, S().gameHeight, 0xC0C0FF, MonstroData.getDarknessLevel(), 3);
				_lightLayerImpl.shadowsEnabled = MonstroData.getShowShadows();
				layerLight.add(_lightLayerImpl);

				addLights();
				addShadowGeometry();
			}
		}

		private function destroyLights():void{
			if (_lightLayerImpl) {
				_lightLayerImpl.dispose();
				layerLight.remove(_lightLayerImpl);
			}
		}

		private function addLights():void{
			if (_lightLayerImpl){
				_lightLayerImpl.clearLights();

				for each(var renderer:* in _map){
					var unitClip:MonstroUnitClip = renderer as MonstroUnitClip;
					if (unitClip && unitClip.emitsLight){
						_lightLayerImpl.addLight(unitClip.light);
					}
				}

				updateLightOffsets();
			}
		}

		private function addShadowGeometry():void{
			if (_lightLayerImpl) {
				for (var i:int = 0; i < field.width; i++) {
					for (var j:int = 0; j < field.height; j++) {
						var tile:Tile = field.getTileAt(i, j);

						var floor:MonstroTileFloor = tile.floor as MonstroTileFloor;
						if (floor && floor.isObstacle) {
							for each(var tilePoint:Point in floor.layers) {
								if (!MonstroTileShadowGeometry.isSkippableSetOfTiles(tilePoint, floor.layers)) {
									MonstroTileShadowGeometry.addGeometryForTile(_lightLayerImpl, tileset, tilePoint, i, j)
								}
							}
						}
					}
				}
			}
		}

		private function updateLightOffsets():void{
			if (_lightLayerImpl){
				_lightLayerImpl.offsetX = layerFloor.layer.x;
				_lightLayerImpl.offsetY = layerFloor.layer.y;
				_lightLayerImpl.scale = layerFloor.layer.scaleX;
				_lightLayerImpl.shadowSoftness = 3 * layerFloor.layer.scaleX;

				_lightLayerImpl.scissorRectangle.setTo(
						layerFloor.layer.x + (32 - 8)* layerFloor.layer.scaleX,
						layerFloor.layer.y + (32 - 2)* layerFloor.layer.scaleX,
						field.width * MonstroConsts.tileWidth * layerFloor.layer.scaleX - (32 + 16)* layerFloor.layer.scaleX,
						field.height * MonstroConsts.tileHeight * layerFloor.layer.scaleX - (64 + 4)* layerFloor.layer.scaleX
				);
			}
		}
    }
}