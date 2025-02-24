package net.retrocade.tacticengine.monstro.global.core{
    import net.retrocade.tacticengine.core.Entity;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.core.Tile;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
    import net.retrocade.tacticengine.monstro.ingame.condition.IMonstroCondition;
    import net.retrocade.tacticengine.monstro.ingame.condition.MonstroConditionFactory;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityFactory;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityStatistics;
    import net.retrocade.tacticengine.monstro.global.enum.EnumTileset;
    import net.retrocade.tacticengine.monstro.global.enum.EnumTrapType;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitFaction;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventChangeConditions;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTilesetChanged;
    import net.retrocade.tacticengine.monstro.ingame.floors.MonstroTileFloor;
    import net.retrocade.tacticengine.monstro.ingame.specializations.MonstroSpecializationFactory;
    import net.retrocade.tacticengine.monstro.ingame.specializations.MonstroSpecializationGeneric;
    import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;
    import net.retrocade.tacticengine.monstro.ingame.traps.MonstroTrapFactory;
    import net.retrocade.tacticengine.monstro.ingame.utils.MonstroSaveStateManager;
    import net.retrocade.tacticengine.monstro.ingame.utils.MonstroTileDefinitions;

    public class MonstroLevelLoader{
        public static function loadLevel(level:XML, field:MonstroField, playerControls:EnumUnitFaction, stateDump:String = null):void{
            var tileset:EnumTileset = EnumTileset.byName(
                level.@tileset.toString() || "greenland"
            );

            switch(tileset){
                case(EnumTileset.LAVA):
                    MonstroGfx.setTilesetToLava();
                    break;

                case(EnumTileset.GREENLAND):
                    MonstroGfx.setTilesetToGrassland();
                    break;

                case(EnumTileset.ICE):
                    MonstroGfx.setTilesetToIce();
                    break;

                default:
                    throw new ArgumentError("nvalid tileset");
            }

            new MonstroEventTilesetChanged(tileset);

            MonstroStateIngame.instance.levelStats.levelName = level.@title.toString();
            MonstroStateIngame.instance.levelStats.levelDescription = level.@description.toString();
			MonstroStateIngame.instance.levelStats.levelTileset = tileset;

            var width:int = int(level.width) / MonstroConsts.tileWidth;
            var height:int = int(level.height) / MonstroConsts.tileHeight;
            
            field.init(width, height);

            fillFieldFloors(field);

			var tile:Tile;
			var floor:MonstroTileFloor;
			var tileXML:XML;

			var tx:Number;
			var ty:Number;

			for each(tileXML in level..tile){
				tile = field.getTileAt(tileXML.@x / MonstroConsts.tileWidth, tileXML.@y / MonstroConsts.tileHeight);
				floor = tile.floor as MonstroTileFloor;

				tx = tileXML.@tx;
				ty = tileXML.@ty;

				MonstroTileDefinitions.updateFloorMeta(floor, tx, ty, tileset);
				MonstroTileFloor(tile.floor).addLayerItem(tx, ty);
			}

            for (var i:int = 0; i < width; i++){
                for (var j:int = 0; j < height; j++){
                    floor = field.getTileAt(i, j).floor as MonstroTileFloor;
                    if (floor.layers.length == 0){
                        floor.isObstacle = true;
                    }
                }
            }

            if (stateDump){
                MonstroSaveStateManager.loadFromDump(stateDump, field);

            } else {
                for each(var actorXML:XML in level.actors.children()){
                    tile = field.getTileAt(actorXML.@x / MonstroConsts.tileWidth, actorXML.@y / MonstroConsts.tileHeight);
                    floor = tile.floor as MonstroTileFloor;

                    var entity:Entity = getEntity(actorXML, field, playerControls);

					if (entity is MonstroEntity){
						MonstroEntity(entity).setId(tile.x + tile.y*1000);
					}

                    if (entity){
                        entity.tile = tile;
                    } else {
                        var trap:IMonstroTrap = MonstroTrapFactory.getTrap(
                            EnumTrapType.byName(actorXML.name().toString())
                        );

                        if (trap){
                            trap.x = tile.x;
                            trap.y = tile.y;

							floor.trap = trap;
                        }
                    }
                }

				field.refreshEntityList();
                loadConditions(level, field);
            }
        }

        private static function fillFieldFloors(field:MonstroField):void{
            for (var i:int = 0; i < field.width; i++){
                for (var j:int = 0; j < field.height; j++){
                    var tile:Tile = field.getTileAt(i, j);
                    tile.floor = new MonstroTileFloor(field);
                }
            }
        }


        private static function getEntity(entityXml:XML, field:MonstroField, playerControls:EnumUnitFaction):Entity{
            var entityName:String = entityXml.name().toString();
            if (!EnumUnitType.hasName(entityName)){
                return null;
            }

            var unitType:EnumUnitType = EnumUnitType.byName(entityName);

            var entity:MonstroEntity = MonstroEntityFactory.getUnit(unitType, field, playerControls);

            if (entity){
                extractSpecialization(entityXml, entity, "arrow", MonstroSpecializationFactory.TYPE_ARROW);
                extractSpecialization(entityXml, entity, "foot", MonstroSpecializationFactory.TYPE_FOOT);
                extractSpecialization(entityXml, entity, "heart", MonstroSpecializationFactory.TYPE_HEART);
                extractSpecialization(entityXml, entity, "shield", MonstroSpecializationFactory.TYPE_SHIELD);
                extractSpecialization(entityXml, entity, "sword", MonstroSpecializationFactory.TYPE_SWORD);
                extractSpecialization(entityXml, entity, "skull", MonstroSpecializationFactory.TYPE_SKULL);
                extractSpecialization(entityXml, entity, "stop", MonstroSpecializationFactory.TYPE_STOP);

                extractStarSpecialization(entityXml, entity);
            }

            return entity;
        }

        private static function extractSpecialization(entityXml:XML, entityInstance:MonstroEntity, specialtyType:String, internalType:String):void{
            var result:XMLList = entityXml.attribute(specialtyType);

            if (result.length() > 0){
                var count:int = parseInt(result[0].toString());
                while (count--){
                    entityInstance.addSpecialization(MonstroSpecializationFactory.getSpecialization(internalType));
                }
            }
        }

        private static function extractStarSpecialization(entityXml:XML, entityInstance:MonstroEntity):void{
            if (entityXml.@customStats == "true"){
                var stats:MonstroEntityStatistics = entityInstance.getStatistics();
                stats.hp = parseInt(entityXml.@hp);
                stats.hpMax = parseInt(entityXml.@hp);
                stats.attack = parseInt(entityXml.@attack);
                stats.defenseMax = parseInt(entityXml.@defense);
                stats.movesMax = parseInt(entityXml.@movement);
                stats.attackRangeMin = parseInt(entityXml.@attackRangeMin);
                stats.attackRangeMax = parseInt(entityXml.@attackRangeMax);

                stats.movesLeft = stats.movesMax;
                stats.defense = stats.defenseMax;

                entityInstance.setStatistics(stats);

                entityInstance.addSpecialization(new MonstroSpecializationGeneric(MonstroSpecializationFactory.TYPE_STAR));
            }
        }

        private static function loadConditions(xml:XML, field:MonstroField):void{
            var victoryCondition:IMonstroCondition = MonstroConditionFactory.getCondition(
                    xml.@victoryCondition,
                    field,
                    parseInt(xml.@surviveTurns)
            );

            var lossCondition:IMonstroCondition = MonstroConditionFactory.getCondition(
                    xml.@lossCondition,
                    field,
                    parseInt(xml.@stallTurns)
            );

            if (!victoryCondition){
                throw new Error("Invalid victory condition");
            }

            if (!lossCondition){
                throw new Error("Invalid loss condition");
            }

            new MonstroEventChangeConditions(victoryCondition, lossCondition);
        }
    }
}