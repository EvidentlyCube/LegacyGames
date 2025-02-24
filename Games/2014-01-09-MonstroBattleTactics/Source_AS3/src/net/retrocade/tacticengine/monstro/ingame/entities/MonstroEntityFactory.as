
package net.retrocade.tacticengine.monstro.ingame.entities {
    import net.retrocade.retrocamel.locale._;
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitController;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitFaction;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;

    public class MonstroEntityFactory {
        public static function getUnit(unitType:EnumUnitType, field:MonstroField, playerFaction:EnumUnitFaction):MonstroEntity {
            var stats:MonstroEntityStatistics = new MonstroEntityStatistics();
            var prettyName:String = _("unitName_" + unitType.name);
            var faction:EnumUnitController;
            var movementOrder:int;
            var canBeDamaged:Boolean = true;
            var canBePushed:Boolean = false;
            var canBeAttacked:Boolean = true;
            var hasToBeKilled:Boolean = true;
            var scoreMultiplier:Number = 1.0;
			var isAlwaysUnder:Boolean = false;

            switch (unitType) {
                case(EnumUnitType.GRUNT):
                    stats.hpMax = 1;
                    stats.attack = 1;
                    stats.defenseMax = 0;
                    stats.movesMax = 4;
                    faction = (playerFaction.isHuman() ? EnumUnitController.PLAYER : EnumUnitController.ENEMY);
                    movementOrder = 6;
                    break;

                case(EnumUnitType.SOLDIER):
                    stats.hpMax = 2;
                    stats.attack = 2;
                    stats.defenseMax = 1;
                    stats.movesMax = 4;
                    faction = (playerFaction.isHuman() ? EnumUnitController.PLAYER : EnumUnitController.ENEMY);
                    movementOrder = 5;
                    break;

                case(EnumUnitType.PIKEMAN):
                    stats.hpMax = 4;
                    stats.attack = 3;
                    stats.defenseMax = 0;
                    stats.movesMax = 5;
                    stats.attackRangeMin = 1;
                    stats.attackRangeMax = 2;
                    faction = (playerFaction.isHuman() ? EnumUnitController.PLAYER : EnumUnitController.ENEMY);
                    movementOrder = 4;
                    break;

                case(EnumUnitType.ARCHER):
                    stats.hpMax = 3;
                    stats.attack = 3;
                    stats.defenseMax = 0;
                    stats.movesMax = 4;
                    stats.attackRangeMin = 2;
                    stats.attackRangeMax = 3;
                    faction = (playerFaction.isHuman() ? EnumUnitController.PLAYER : EnumUnitController.ENEMY);
                    movementOrder = 3;
                    break;

                case(EnumUnitType.KNIGHT):
                    stats.hpMax = 3;
                    stats.attack = 4;
                    stats.defenseMax = 5;
                    stats.movesMax = 3;
                    faction = (playerFaction.isHuman() ? EnumUnitController.PLAYER : EnumUnitController.ENEMY);
                    movementOrder = 2;
                    break;

                case(EnumUnitType.CAVALRY):
                    stats.hpMax = 5;
                    stats.attack = 5;
                    stats.defenseMax = 2;
                    stats.movesMax = 6;
                    faction = (playerFaction.isHuman() ? EnumUnitController.PLAYER : EnumUnitController.ENEMY);
                    movementOrder = 1;
                    break;

                case(EnumUnitType.GOO):
                    stats.hpMax = 1;
                    stats.attack = 1;
                    stats.defenseMax = 0;
                    stats.movesMax = 4;
                    faction = (playerFaction.isHuman() ? EnumUnitController.ENEMY : EnumUnitController.PLAYER);
                    movementOrder = 6;
                    break;

                case(EnumUnitType.SLIME):
                    stats.hpMax = 1;
                    stats.attack = 1;
                    stats.defenseMax = 2;
                    stats.movesMax = 3;
                    faction = (playerFaction.isHuman() ? EnumUnitController.ENEMY : EnumUnitController.PLAYER);
                    movementOrder = 5;
                    break;

                case(EnumUnitType.SHROOM):
                    stats.hpMax = 5;
                    stats.attack = 3;
                    stats.defenseMax = 0;
                    stats.movesMax = 3;
                    faction = (playerFaction.isHuman() ? EnumUnitController.ENEMY : EnumUnitController.PLAYER);
                    movementOrder = 4;
                    break;

                case(EnumUnitType.GARGOYLE):
                    stats.hpMax = 3;
                    stats.attack = 2;
                    stats.defenseMax = 1;
                    stats.movesMax = 7;
                    stats.canFly = true;
                    faction = (playerFaction.isHuman() ? EnumUnitController.ENEMY : EnumUnitController.PLAYER);
                    movementOrder = 3;
                    break;

                case(EnumUnitType.MINOTAUR):
                    stats.hpMax = 3;
                    stats.attack = 6;
                    stats.defenseMax = 2;
                    stats.movesMax = 4;
                    faction = (playerFaction.isHuman() ? EnumUnitController.ENEMY : EnumUnitController.PLAYER);
                    movementOrder = 2;
                    break;

                case(EnumUnitType.MANTICORE):
                    stats.hpMax = 5;
                    stats.attack = 4;
                    stats.defenseMax = 5;
                    stats.movesMax = 5;
                    faction = (playerFaction.isHuman() ? EnumUnitController.ENEMY : EnumUnitController.PLAYER);
                    movementOrder = 1;
                    break;

                case(EnumUnitType.MOBILE_WALL):
                    stats.hpMax = 99;
                    stats.attack = 0;
                    stats.defenseMax = 0;
                    stats.movesMax = 2;
                    stats.attackRangeMin = 0;
                    stats.attackRangeMax = 0;
                    faction = EnumUnitController.PLAYER;
                    movementOrder = 0;
                    canBeAttacked = false;
                    hasToBeKilled = false;
                    break;

                case(EnumUnitType.FAKE_WALL):
                    stats.hpMax = 1;
                    stats.attack = 0;
                    stats.defenseMax = 0;
                    stats.movesMax = 0;
                    stats.attackRangeMin = 0;
                    stats.attackRangeMax = 0;
                    faction = EnumUnitController.MISC;
                    movementOrder = 0;
                    canBeAttacked = true;
                    hasToBeKilled = false;
					isAlwaysUnder = true;
                    break;

                case(EnumUnitType.FLAG_KING):
                    stats.hpMax = 1;
                    stats.attack = 0;
                    stats.defenseMax = 0;
                    stats.movesMax = 0;
                    stats.attackRangeMin = 0;
                    stats.attackRangeMax = 0;
                    faction = (playerFaction.isHuman() ? EnumUnitController.PLAYER : EnumUnitController.ENEMY);
                    movementOrder = 0;
                    scoreMultiplier = 10.0;
                    break;

                case(EnumUnitType.FLAG_BRAIN):
                    stats.hpMax = 1;
                    stats.attack = 0;
                    stats.defenseMax = 0;
                    stats.movesMax = 0;
                    stats.attackRangeMin = 0;
                    stats.attackRangeMax = 0;
                    faction = (playerFaction.isHuman() ? EnumUnitController.ENEMY : EnumUnitController.PLAYER);
                    movementOrder = 0;
                    scoreMultiplier = 10.0;
                    break;

                case(EnumUnitType.BONFIRE):
                case(EnumUnitType.LANTERN):
                case(EnumUnitType.TORCH):
					stats.hpMax = 1;
					stats.attack = 0;
					stats.defenseMax = 15;
					stats.movesMax = 0;
					stats.attackRangeMin = 0;
					stats.attackRangeMax = 0;
					faction = EnumUnitController.MISC;
					movementOrder = 0;
					canBeAttacked = false;
					hasToBeKilled = false;
					isAlwaysUnder = false;
                    break;

				case(EnumUnitType.TIKI_BLOCK):
					stats.hpMax = 1;
					stats.attack = 0;
					stats.defenseMax = 0;
					stats.movesMax = 0;
					stats.attackRangeMin = 0;
					stats.attackRangeMax = 0;
					faction = EnumUnitController.MISC;
					movementOrder = 0;
					canBeAttacked = true;
					canBeDamaged = false;
					canBePushed = true;
					hasToBeKilled = false;
					isAlwaysUnder = false;
                    break;

                default:
                    return null;
            }

			stats.defense = stats.defenseMax;
			stats.hp = stats.hpMax;
            stats.movesLeft = stats.movesMax;

            var unit:MonstroEntity = new MonstroEntity(stats, field);
            unit.unitType = unitType;
            unit.controlledBy = faction;
            unit.movementOrder = movementOrder;
			unit.isPushable = canBePushed;
			unit.canBeDamaged = canBeDamaged;
            unit.prettyName = prettyName;
            unit.attackable = canBeAttacked;
            unit.hasToBeKilled = hasToBeKilled;
            unit.scoreMultiplier = scoreMultiplier;

            return unit;
        }

        public static function loadDump(descriptor:Object, field:MonstroField):MonstroEntity{
            var entity:MonstroEntity = new MonstroEntity(new MonstroEntityStatistics(), field);
            entity.loadFromDump(descriptor);

            return entity;
        }
    }
}
