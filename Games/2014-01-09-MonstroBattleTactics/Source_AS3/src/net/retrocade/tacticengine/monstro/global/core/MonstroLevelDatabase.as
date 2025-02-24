package net.retrocade.tacticengine.monstro.global.core{
	import net.retrocade.tacticengine.monstro.global.data.levels.MonstroMainGameLevels;
	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;

    public class MonstroLevelDatabase{
		private static var _data:Vector.<LevelData>;

		public static function traceAllData():void{
			var data:Vector.<LevelData> = new Vector.<LevelData>();

			for each(var campaign:EnumCampaignType in [EnumCampaignType.INTRODUCTION, EnumCampaignType.HUMAN, EnumCampaignType.HUMAN_HARD, EnumCampaignType.MONSTER, EnumCampaignType.MONSTER_HARD]){
				for (var i:int = 0; i < MonstroMainGameLevels.getLevelCount(); i++){
					if (MonstroMainGameLevels.hasLevel(i, campaign)){
						data.push(getLevelData(campaign, i));
					}
				}
			}

			data.sort(function(left:LevelData, right:LevelData):int{
				if (left.title > right.title){
					return 1;
				} else if (left.title < right.title){
					return -1;
				} else {
					return 0;
				}
			});

			for each (var levelData:LevelData in data) {
				trace(levelData.title + " (" + levelData.campaign.name + " #" + levelData.levelIndex + ")");
				trace(levelData.description);
			}
		}

		public static function getLevelTitle(campaign:EnumCampaignType, levelIndex:uint):String{
			var data:LevelData = getLevelData(campaign, levelIndex);

			return data.title;
		}

		public static function getLevelDescription(campaign:EnumCampaignType, levelIndex:uint):String{
			var data:LevelData = getLevelData(campaign, levelIndex);

			return data.description;
		}

		public static function getLevelOriginalCampaign(campaign:EnumCampaignType, levelIndex:uint):EnumCampaignType{
			var data:LevelData = getLevelData(campaign, levelIndex);

			return data.originalCampaign;
		}

		public static function getLevelOriginalLevel(campaign:EnumCampaignType, levelIndex:uint):int{
			var data:LevelData = getLevelData(campaign, levelIndex);

			return data.originalLevel;
		}

		private static function getLevelData(campaign:EnumCampaignType, levelIndex:uint):LevelData{
			if (!_data){
				_data = new Vector.<LevelData>();
			}

			for each(var data:LevelData in _data){
				if (data.campaign === campaign && data.levelIndex === levelIndex){
					return data;
				}
			}

			var level:XML = MonstroMainGameLevels.getLevel(levelIndex, campaign);

			data = new LevelData();
			data.campaign = campaign;
			data.levelIndex = levelIndex;
			data.title = level.@title.toString();
			data.description = level.@description.toString();
			try{
				data.originalCampaign = EnumCampaignType.byName(level.@origCampaign.toString());

			} catch (e:Error){
				data.originalCampaign = EnumCampaignType.INTRODUCTION;
			}

			data.originalLevel = parseInt(level.@origLevel);

			_data.push(data);

			return data;
		}
    }
}

import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;

class LevelData{
	public var campaign:EnumCampaignType;
	public var levelIndex:uint;

	public var title:String;
	public var description:String;

	public var originalCampaign:EnumCampaignType;
	public var originalLevel:int;
}