

package net.retrocade.tacticengine.monstro.ingame.achievements {
    import net.retrocade.tacticengine.core.MonstroField;
    import net.retrocade.tacticengine.monstro.global.core.MonstroData;
    import net.retrocade.tacticengine.monstro.global.data.levels.MonstroMainGameLevels;
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
	import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
	import net.retrocade.tacticengine.monstro.gui.windows.MonstroWindowCredits;
	import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;

	public class AchievementManager {
        private static var _achievements:Vector.<Achievement>;

        public static function clearAchievements(): void {
            for each(var achievement:Achievement in _achievements) {
                achievement.isAcquired = false;
                MonstroData.setAchievementCompleted(achievement.id, false);

                CF::steam{
                    SteamInterface.clearAchievement(achievement.id);
                }
            }
        }

        public static function updateGeneral():void {
            for each(var achievement:Achievement in _achievements){
                if (achievement.isAcquired){
                    continue;
                }

                if (achievement.onGeneralUpdate !== null && achievement.onGeneralUpdate()){
                    achievement.isAcquired = true;

					MonstroData.setAchievementCompleted(achievement.id);
					CF::steam{
						SteamInterface.awardAchievement(achievement.id);
					}
					CF::drmFree{
						AchievementGrowl.showGrowl(achievement);
					}
                    CF::flash {
						AchievementGrowl.showGrowl(achievement);
                    }
                }
            }
        }

        public static function updateInGame(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame):void {
            for each(var achievement:Achievement in _achievements){
                if (achievement.isAcquired){
                    continue;
                }

                if (achievement.onIngameUpdate !== null && achievement.onIngameUpdate(field, levelIndex, campaignType, state)){
                    achievement.isAcquired = true;

					MonstroData.setAchievementCompleted(achievement.id);
					CF::steam{
						SteamInterface.awardAchievement(achievement.id);
					}
					CF::drmFree{
						AchievementGrowl.showGrowl(achievement);
					}
					CF::flash{
						AchievementGrowl.showGrowl(achievement);
					}
                }
            }
        }

		private static function loadAchievements():void {
			for each(var achievement:Achievement in _achievements){
				if (MonstroData.getAchievementCompleted(achievement.id)){
					achievement.isAcquired = true;

					MonstroData.setAchievementCompleted(achievement.id);
					CF::steam{
						SteamInterface.awardAchievement(achievement.id);
					}
				}
			}
		}

        public static function init():void{
            _achievements = new <Achievement>[
                // Conquer all levels in Introduction Campaign
                new Achievement('ach_tutorial', null,
                    function(...args):Boolean{
                        return MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.INTRODUCTION)
                            === MonstroMainGameLevels.getLevelCountInCampaign(EnumCampaignType.INTRODUCTION);
                    }
                ),

				// Conquer all levels in Human Campaign
                new Achievement('ach_humans', null,
                    function(...args):Boolean{
                        return MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.HUMAN)
                            === MonstroMainGameLevels.getLevelCountInCampaign(EnumCampaignType.HUMAN);
                    }
                ),

                // Conquer all levels in Human++ Campaign
                new Achievement('ach_humans_hard', null,
                    function(...args):Boolean{
                        return MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.HUMAN_HARD)
                            === MonstroMainGameLevels.getLevelCountInCampaign(EnumCampaignType.HUMAN_HARD);
                    }
                ),

                // Conquer all levels in Monster Campaign
                new Achievement('ach_monsters', null,
                    function(...args):Boolean{
                        return MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.MONSTER)
                            === MonstroMainGameLevels.getLevelCountInCampaign(EnumCampaignType.MONSTER);
                    }
                ),

                // Conquer all levels in Monster Campaign
                new Achievement('ach_monsters_hard', null,
                    function(...args):Boolean{
                        return MonstroData.countCompletedLevelsInCampaign(EnumCampaignType.MONSTER_HARD)
                            === MonstroMainGameLevels.getLevelCountInCampaign(EnumCampaignType.MONSTER_HARD);
                    }
                ),

                // Opened credits
                new Achievement('ach_credits', null,
                    function(...args):Boolean{
						return MonstroWindowCredits.displayedCredits;
                    }
                ),


                // Introduction #3 - Make the gargoyle step on each web trap and complete the mission
                new Achievement('ach_intro_3',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.INTRODUCTION || levelIndex !== 2){
                            return false;
                        }

                        var enemyUnits:uint = countAliveEnemies(field);
                        var webTraps:uint = countWebTraps(field);

                        return enemyUnits === 0 && webTraps === 0;
                    },
                    null
                ),

                // Introduction #6 - Kill the minotaur with the spike trap
                new Achievement('ach_intro_6',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.INTRODUCTION || levelIndex !== 5){
                            return false;
                        }

						var minotaur:MonstroEntity = findUnit(field, EnumUnitType.MINOTAUR);

                        return minotaur.x === 10 && minotaur.y === 10;
                    },
                    null
                ),

                // Introduction #8 - Kill all the goos
                new Achievement('ach_intro_8',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.INTRODUCTION || levelIndex !== 7){
                            return false;
                        }


						var enemyUnits:uint = countAliveEnemies(field);
						return enemyUnits === 0;
                    },
                    null
                ),

                // Human #3 - Finish the mission without moving the mobile walls
                new Achievement('ach_human_3',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.HUMAN || levelIndex !== 2){
                            return false;
                        }

						for each (var entity:MonstroEntity in findUnits(field, EnumUnitType.MOBILE_WALL)) {
							if (entity.tilesMoved > 0){
								return false;
							}
						}

						var enemyUnits:uint = countAliveEnemies(field);

						return enemyUnits === 0;
					},
                    null
                ),

                // Human #13 - Finish the mission without losing HP
				new Achievement('ach_human_13',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.HUMAN || levelIndex !== 12){
                            return false;
                        }

						if (isWon(state) && countAlivePlayerUnits(field) === countPlayerUnits(field)){
							for each (var entity:MonstroEntity in field.getAllEntities()) {
								if (entity.controlledBy.isPlayer() && entity.getStatistics().hp !== entity.getStatistics().hpMax){
									return false
								}
							}
							return true;

						} else {
							return false;
						}
					},
                    null
                ),

                // Human #20 - Kill the slime and win the mission
				new Achievement('ach_human_20',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.HUMAN || levelIndex !== 19){
                            return false;
                        }

						return isWon(state) && findUnit(field, EnumUnitType.SLIME).isDead;
					},
                    null
                ),

                // Monster #7 -  Finish the mission without losing a single unit
				new Achievement('ach_monster_7',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.MONSTER || levelIndex !== 6){
                            return false;
                        }

						return isWon(state) && countPlayerUnits(field) === countAlivePlayerUnits(field);
					},
                    null
                ),

                // Monster #19 - Finish the mission without losing a single unit
				new Achievement('ach_monster_19',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.MONSTER || levelIndex !== 18){
                            return false;
                        }

						return isWon(state) && countPlayerUnits(field) === countAlivePlayerUnits(field);
					},
                    null
                ),

                // Monster #20 - Complete the mission without losing a single unit
				new Achievement('ach_monster_20',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.MONSTER || levelIndex !== 19){
                            return false;
                        }

						return isWon(state) && countPlayerUnits(field) === countAlivePlayerUnits(field);
					},
                    null
                ),

                // Human++ #8 - Complete the mission without losing a single unit
				new Achievement('ach_human_hard_8',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.HUMAN_HARD || levelIndex !== 7){
                            return false;
                        }

						return isWon(state) && countPlayerUnits(field) === countAlivePlayerUnits(field);
					},
                    null
                ),

                // Human++ #12 - Complete the mission without losing a single unit
				new Achievement('ach_human_hard_12',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.HUMAN_HARD || levelIndex !== 11){
                            return false;
                        }

						return isWon(state) && countPlayerUnits(field) === countAlivePlayerUnits(field);
					},
                    null
                ),

                // HUman++ #15 - Kill a manticore and complete the mission
				new Achievement('ach_human_hard_15',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.HUMAN_HARD || levelIndex !== 14){
                            return false;
                        }

						var killedManticores:uint = 0;
						for each (var entity:MonstroEntity in findUnits(field, EnumUnitType.MANTICORE)) {
							killedManticores += entity.isDead ? 1 : 0;
						}

						return isWon(state) && killedManticores > 0;
					},
                    null
                ),

                // Human++ #19 - Complete without getting hit
				new Achievement('ach_human_hard_19',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.HUMAN_HARD || levelIndex !== 18){
                            return false;
                        }

						return isWon(state) && findUnit(field, EnumUnitType.CAVALRY).damageReceived === 0;
					},
                    null
                ),

                // Monster++ #4 - Finish the mission without losing a single unit
				new Achievement('ach_monster_hard_4',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.MONSTER_HARD || levelIndex !== 3){
                            return false;
                        }

						if (isWon(state) && countPlayerUnits(field) === countAlivePlayerUnits(field)) {
                            _l("Achievement awarding ach_monster_hard_4");
                            _l("Count player units = " + countPlayerUnits(field));
                            _l("Count alive player units = " + countAlivePlayerUnits(field));
                            _l("Campaign type = " + campaignType.id + "/" + campaignType.name);
                            _l("State.isMissionWon = " + state.isMissionWon());
                            _l("State.isMissionFailed = " + state.isMissionFailed());
                            return true;
                        }

                        return false;
					},
                    null
                ),

                // Monster++ #5 - Complete the mission without the shroom attacking
				new Achievement('ach_monster_hard_5',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.MONSTER_HARD || levelIndex !== 4){
                            return false;
                        }

						return isWon(state) && findUnit(field, EnumUnitType.SHROOM).damageDealt === 0;
					},
                    null
                ),

                // Monster++ #16 - Kill all enemies and complete the mission
				new Achievement('ach_monster_hard_16',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.MONSTER_HARD || levelIndex !== 15){
                            return false;
                        }

						return isWon(state) && countAliveEnemies(field) === 0;
					},
                    null
                ),

                // Monster++ #19 - Complete the mission with 5 shrooms alive
				new Achievement('ach_monster_hard_19',
                    function(field:MonstroField, levelIndex:int, campaignType:EnumCampaignType, state:MonstroStateIngame, ...args):Boolean{
                        if (campaignType !== EnumCampaignType.MONSTER_HARD || levelIndex !== 18){
                            return false;
                        }

						return isWon(state) && countAliveUnits(field, EnumUnitType.SHROOM) >= 5;
					},
                    null
                )
            ];
			loadAchievements();
        }

		public static function get achievements():Vector.<Achievement> {
			return _achievements;
		}
	}
}

import net.retrocade.tacticengine.core.MonstroField;
import net.retrocade.tacticengine.monstro.global.enum.EnumUnitType;
import net.retrocade.tacticengine.monstro.global.states.MonstroStateIngame;
import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
import net.retrocade.tacticengine.monstro.ingame.traps.IMonstroTrap;
import net.retrocade.tacticengine.monstro.ingame.traps.MonstroTrapWeb;

function countAliveEnemies(field:MonstroField):uint{
    var count:uint = 0;

    for each(var entity:MonstroEntity in field.getAllEntities()){
        if (entity.controlledBy.isEnemy() && entity.isAlive){
            count++;
        }
    }

    return count;
}
function countWebTraps(field:MonstroField):uint{
    var count:uint = 0;

	for each (var trap:IMonstroTrap in field.getAllTraps()) {
		if (trap is MonstroTrapWeb && trap.isEnabled){
			count++;
		}
	}

	return count;
}
function countPlayerUnits(field:MonstroField):uint{
    var count:uint = 0;

    for each(var entity:MonstroEntity in field.getAllEntities()){
        if (entity.controlledBy.isPlayer()){
            count++;
        }
    }

    return count;
}
function countAlivePlayerUnits(field:MonstroField):uint{
    var count:uint = 0;

    for each(var entity:MonstroEntity in field.getAllEntities()){
        if (entity.controlledBy.isPlayer() && entity.isAlive){
            count++;
        }
    }

    return count;
}

function findUnit(field:MonstroField, unitType:EnumUnitType):MonstroEntity{
    for each(var entity:MonstroEntity in field.getAllEntities()){
        if (entity.unitType === unitType){
            return entity;
        }
    }

    return null;
}
function findUnits(field:MonstroField, unitType:EnumUnitType):Vector.<MonstroEntity>{
	var units:Vector.<MonstroEntity> = new Vector.<MonstroEntity>();

    for each(var entity:MonstroEntity in field.getAllEntities()){
        if (entity.unitType === unitType){
            units.push(entity);
        }
    }

    return units;
}
function countAliveUnits(field:MonstroField, unitType:EnumUnitType):int{
	var count:int = 0;

    for each(var entity:MonstroEntity in field.getAllEntities()){
        if (entity.unitType === unitType && entity.isAlive){
            count++;
        }
    }

    return count;
}

function isWon(state:MonstroStateIngame):Boolean{
	return state.isMissionWon() && !state.isMissionFailed();
}