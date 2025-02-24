package net.retrocade.tacticengine.monstro.global.data.levels{
    import flash.utils.ByteArray;

    import net.retrocade.tacticengine.monstro.global.core.*;
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitFaction;
    import net.retrocade.utils.UtilsString;
    import net.retrocade.functions.printf;

    public class MonstroMainGameLevels{
        public static function get levelClass():Class{
            return LevelsCollection;
        }
        public static function getLevel(index:int, campaignType:EnumCampaignType):XML{
            var name:String = getLevelFileName(index, campaignType);

            var level:ByteArray = new (levelClass[name]);
            level.position = 0;

            return new XML(level.readUTFBytes(level.length));
        }
        public static function hasLevel(index:int, campaignType:EnumCampaignType):Boolean{
            var name:String = getLevelFileName(index, campaignType);

            return levelClass[name] !== undefined;
        }

        public static function getLevelCount():int{
            return 20;
        }

        public static function getLevelCountInCampaign(campaignType:EnumCampaignType):int{
            var count:int = 0;
            for (var i:int = 0; i < getLevelCount(); i++){
                if (hasLevel(i, campaignType)){
                    count++;
                }
            }

            return count;
        }

        public static function getCompletedLevelCount(campaignType:EnumCampaignType):int{
            var completedLevelCount:int = 0;

            for (var i:int = 0; i < getLevelCount(); i++){
                if (hasLevel(i, campaignType) && MonstroData.isLevelCompleted(i, campaignType)){
                    completedLevelCount++;
                }
            }

            return completedLevelCount;
        }

        public static function getFirstUncompletedLevel(campaignType:EnumCampaignType):int{
            for (var levelIndex:uint = 0; levelIndex < getLevelCount(); levelIndex++){
                if (hasLevel(levelIndex, campaignType) && !MonstroData.isLevelCompleted(levelIndex, campaignType)){
                    return levelIndex;
                }
            }

            return 0;
        }

        public static function getFirstUncompletedLevelAfter(levelIndex:int, campaignType:EnumCampaignType):int{
            var startedLevelIndex:int = levelIndex;

            levelIndex += 1;
            while (startedLevelIndex !== levelIndex){
                if (hasLevel(levelIndex, campaignType) && !MonstroData.isLevelCompleted(levelIndex, campaignType)){
                    return levelIndex;
                }
                levelIndex = (levelIndex + 1) % getLevelCount();
            }

            return getNextAvailableLevel(startedLevelIndex + 1, campaignType);
        }

        public static function getNextAvailableLevel(levelIndex:int, campaignType:EnumCampaignType):int{
            while (!hasLevel(levelIndex, campaignType)){
                levelIndex = (levelIndex + 1) % getLevelCount();
            }

            return levelIndex;
        }

        public static function getPlayerFactionByLevel(campaignType:EnumCampaignType):EnumUnitFaction{
            switch(campaignType){
                case(EnumCampaignType.INTRODUCTION):
                case(EnumCampaignType.HUMAN):
                case(EnumCampaignType.HUMAN_HARD):
                    return EnumUnitFaction.HUMAN;

                case(EnumCampaignType.MONSTER):
                case(EnumCampaignType.MONSTER_HARD):
                    return EnumUnitFaction.MONSTER;

                default:
                    throw new Error("Invalid campaign type");
            }
        }

        private static function getLevelFileName(index:int, campaignType:EnumCampaignType):String{
            var prefix:String;
            switch(campaignType){
                case(EnumCampaignType.INTRODUCTION):     prefix = "tu"; break;
                case(EnumCampaignType.HUMAN):        prefix = "hn"; break;
                case(EnumCampaignType.MONSTER):      prefix = "mn"; break;
                case(EnumCampaignType.HUMAN_HARD):   prefix = "hh"; break;
                case(EnumCampaignType.MONSTER_HARD): prefix = "mh"; break;
                case(EnumCampaignType.TEST):         prefix = "test"; break;
            }

            var levelNameRaw:String = "level_%%_%%";

            return printf(levelNameRaw, prefix, UtilsString.padLeft(index, 3));
        }
    }
}