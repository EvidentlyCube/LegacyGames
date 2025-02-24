package net.retrocade.tacticengine.monstro.global.oldProgressImporter {
	import flash.utils.Dictionary;

	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.global.core.MonstroLevelDatabase;

	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;

	public class OldProgressImporter {
		public static function hasProgress():Boolean{
			CF::desktop {
				return OldProgressImporterImpl.hasProgress();
			}

			CF::flash {
				return false;
			}
		}

		public static function importProgress():Boolean{
			CF::desktop {
				return OldProgressImporterImpl.importProgress();
			}

			CF::flash {
				return true;
			}
		}
	}
}

CF::desktop {
	import flash.utils.Dictionary;

	import net.retrocade.tacticengine.monstro.global.core.MonstroData;
	import net.retrocade.tacticengine.monstro.global.core.MonstroLevelDatabase;

	import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
	import net.retrocade.tacticengine.monstro.global.oldProgressImporter.OldProgressStorageIo;
	import net.retrocade.tacticengine.monstro.global.oldProgressImporter.OldProgressStorageWrapper;

	class OldProgressImporterImpl {
		public static function hasProgress():Boolean{
			return OldProgressStorageIo.init();
		}

		public static function importProgress():Boolean{
			try {
				if (OldProgressStorageIo.init()){
					var save:Object = OldProgressStorageIo.read();
					var storage:OldProgressStorageWrapper = new OldProgressStorageWrapper(save);

					for (var i:uint = 0; i < 20; i++){
						mapProgress(storage, EnumCampaignType.HUMAN, i);
						mapProgress(storage, EnumCampaignType.HUMAN_HARD, i);
						mapProgress(storage, EnumCampaignType.MONSTER, i);
						mapProgress(storage, EnumCampaignType.MONSTER_HARD, i);
					}

					MonstroData.setSawIntro(true);
					MonstroData.commitData();

					return true;
				}

				return false;
			} catch (e:Error){
				return false;
			}

			return false;
		}

		private static function mapProgress(storage:OldProgressStorageWrapper, campaignType:EnumCampaignType, levelIndex:uint):void{
			var originalCampaign:EnumCampaignType = MonstroLevelDatabase.getLevelOriginalCampaign(campaignType, levelIndex);
			var originalLevel:int = MonstroLevelDatabase.getLevelOriginalLevel(campaignType, levelIndex);

			if (originalLevel > -1 && storage.isLevelCompleted(originalLevel, originalCampaign)){
				MonstroData.setLevelCompleted(levelIndex, campaignType, false);
			}
		}

		private static function humanCampaignMapping():Dictionary{
			var dict:Dictionary = new Dictionary();
			dict[1] = 1; // a fair clash
			dict[2] = 2; //block'em
			dict[3] = 3; //Tiny conflicts
			dict[4] = -1; //Hot path
			dict[5] = 4; //Forward Maze
			dict[6] = 5; //eye of the gargoyle
			dict[7] = 6; //waiting for reinforcments
			dict[8] = 7; //Circumvallating Assault
			dict[9] = 8; //The Power of One
			dict[10] = 9; //Quatro Fromaggi
			dict[11] = 11; //Sticky Business
			dict[12] = 12; //Tic-tac-toe
			dict[13] = 13; //Brainiac
			dict[14] = 14; //Aim Well
			dict[15] = 15; //An Unfair Clash
			dict[16] = 16; //The Showdown
			dict[17] = 17; //Icelands
			dict[18] = 18; //The Riddle
			dict[19] = 10; //Icy Plains
			dict[20] = 20; //Flight of the Gargoyle
			dict[21] = -1; //Accident on the Bridge
			dict[22] = 22; //9-Grid
			dict[23] = 23; //Of Walls and Men

			return dict;
		}

		private static function humanHardCampaignMapping():Dictionary{
			var dict:Dictionary = new Dictionary();
			dict[0] = 0; //It's a Trap!
			dict[1] = 1; //Shroomy Path
			dict[2] = -1; //Golden Run
			dict[3] = 2; //Polar Outpost
			dict[4] = 3; //The Crosssnows
			dict[5] = 4; //Blue Corridors
			dict[6] = 5; //Sharp Decisions
			dict[7] = 6; //Small Armies
			dict[8] = 7; //Islandmania
			dict[9] = 8; //Don't Waste No Time
			dict[10] = 9; //Surrender
			dict[11] = 10; //Castlemania
			dict[12] = 11; //The Siege
			dict[13] = 12; //Spirashell
			dict[14] = 13; //Don't get too cold
			dict[15] = 14; //Kingslayers
			dict[16] = -1; //David and Goliath
			dict[17] = 16; //Waves
			dict[18] = 18; //Adventure Island
			dict[19] = 19; //Outnumbered
			dict[20] = 20; //Last Men Standing
			dict[21] = 21; //Hot Escape
			dict[22] = 22; //Diagonals
			dict[23] = 23; //The Day We Died

			return dict;
		}

		private static function monsterCampaignMapping():Dictionary{
			var dict:Dictionary = new Dictionary();
			dict[0] = 0; //Overpower
			dict[1] = 1; //Minus
			dict[2] = 2; //Gargoyles Ensemble
			dict[3] = 3; //Webster
			dict[4] = 4; //Slimes vs. Soldiers
			dict[5] = 5; //Three by Three
			dict[6] = 6; //Meadows of  Flora
			dict[7] = 7; //Advanced Tactics
			dict[8] = 8; //The Islander
			dict[9] = 9; //Stay Divided
			dict[10] = 10; //Stinging Edges
			dict[11] = -1; //Ambush on the Bridge
			dict[12] = 12; //Raw Power
			dict[13] = 13; //Sticky Armors
			dict[14] = 14; //Path of The Fungi
			dict[15] = -1; //Clash of Minions
			dict[16] = 16; //Jesters
			dict[17] = 17; //Strong Opinions
			dict[18] = 18; //Drylands
			dict[19] = 19; //Power of the Growth
			dict[20] = 20; //Small Unfairness
			dict[21] = 21; //Keep Me Safe
			dict[22] = 22; //Unequality
			dict[23] = 23; //Absolute Concentration

			return dict;
		}

		private static function monsterHardCampaignMapping():Dictionary{
			var dict:Dictionary = new Dictionary();
			dict[0] = 0; //Like a Flag
			dict[1] = 1; //Surrounded
			dict[2] = 2; //The Fungi
			dict[3] = 3; //Your Siege
			dict[4] = 4; //A Big Battle
			dict[5] = 5; //King's Bounty
			dict[6] = 6; //Zig Zag
			dict[7] = 7; //Snail Mail
			dict[8] = 8; //Environmentally Aware
			dict[9] = 10; //Taking The Colossus Down
			dict[10] = 11; //Learn to Swim
			dict[11] = 12; //Northern Outpost
			dict[12] = -1; //The Runaway
			dict[13] = 13; //Kinda Fair
			dict[14] = 14; //A Lone Ranger
			dict[15] = 15; //Rotten Labyrinth
			dict[16] = -1; //The Crossgrasses
			dict[17] = 16; //Defend the King
			dict[18] = 17; //Like a Flame
			dict[19] = 18; //Last Men Standing
			dict[20] = 20; //Defend the Brain
			dict[21] = 21; //Never Give Up
			dict[22] = 22; //Deadly Mazes of Death
			dict[23] = 23; //The Battle of the Four Islands

			return dict;
		}
	}
}