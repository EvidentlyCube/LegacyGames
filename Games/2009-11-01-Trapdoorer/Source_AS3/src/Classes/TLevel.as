package Classes
{
	import Classes.Interactivers.TPlayer;
	import Classes.Items.*;
	import Classes.Menu.TAchievementsPanel;
	import Classes.Scenes.*;

	import Editor.GiveClass;
	import Editor.LoadLevel;
	import Editor.PlayLevel;
	import Editor.TopPanelMonster;

	import LoadingDir.Loading;

	import flash.utils.getTimer;

	public class TLevel{
		[Embed("../../assets/gfx/by_maurycy/ui/Panel.png")] public static var g_panel: Class;
		public static var Lev: Array
		public static var wid: uint = 25
		public static var hei: uint = 25
		public static var authorName: String=""
		public static var levelName: String=""
		public static var levelCode: String=""
		public static var levelType: uint = 0
		public static var needed: uint = 0
		public static var lastPlayed: uint = 0
		public function TLevel(){
			Lev = new Array(50)
			for (var i: uint = 0;i < 50;i++){
				Lev[i]=new Array(50)
				for (var j: uint = 0;j < 50;j++){
					Lev[i][j]=new TTile()
				}
			}
		}
		public static function loadBG(id: uint): void{
			while (TD.layerBg.numChildren > 0){
				TD.layerBg.removeChildAt(0)
			}
			TD.layerBg.addChild(new (GiveClass(id)))
		}
		public static function Restart(): void{
			Clear()

			PlayLevel(levelCode)
			UndoHandler.prune();
		}
		public static function Clear(): void{
			for (var i: int = 0;i < 50;i++){
				for (var j: uint = 0;j < 50;j++){
					var tiler: TTile = Lev[i][j]
					tiler.Remove()
				}
			}
			while(TD.layerBlocks.numChildren > 0){
				TD.layerBlocks.removeChildAt(0)
			}
			while(TD.layerEffects.numChildren > 0){
				TD.layerEffects.removeChildAt(0)
			}
			while(TD.layerAbove.numChildren > 0){
				TD.layerAbove.removeChildAt(0)
			}
			while(TD.layerPanel.numChildren > 0){
				TD.layerPanel.removeChildAt(0)
			}
			TLevelScene.breakUpdate = true
		}
		public static function CanLand(x: int, y: int): Boolean{
			x = x/25
			y = y/25
			if (x < 0 || x > 49 || y < 0 || y > 49){return false}
			var tiler: TTile = Lev[x][y]
			return tiler.CanLand()
		}
		public static function JumpOff(x: int, y: int): void{
			x = Math.floor(x/25)
			y = Math.floor(y/25)
			if (x < 0 || x > 49 || y < 0 || y > 49){return}
			var tiler: TTile = Lev[x][y]
			tiler.JumpOff()
		}
		public static function Set(x: uint, y: uint, item: TItem, rem: Boolean = true): void{
			var tile: TTile = Lev[x/25][y/25]
			if (tile) {
				tile.Set(item, rem)
			}
		}
		public static function Remove(x: uint, y: uint): void{
			var tiler: TTile = Lev[x/25][y/25]
			tiler.Remove();
		}
		public static function Land(x: uint, y: uint): void{
			var tiler: TTile = Lev[x/25][y/25]
			tiler.Land();
		}
		public static function checkAt(x: int, y: int): TItem{
			x = Math.floor(x/25)
			y = Math.floor(y/25)
			if (x < 0 || x > 49 || y < 0 || y > 49){return null}
			var tiler: TTile = Lev[x][y]
			return tiler.At();
		}
		public static function Strip(x: uint, y: uint): void{
			x = Math.floor(x/25)
			y = Math.floor(y/25)
			if (x < 0 || x > 49 || y < 0 || y > 49){return}
			var tiler: TTile = Lev[x][y]
			tiler.Strip()
		}
		public static function Boom(x: uint, y: uint): void{
			x = Math.floor(x/25)
			y = Math.floor(y/25)
			if (x < 0 || x > 49 || y < 0 || y > 49){return}
			var tiler: TTile = Lev[x][y]
			tiler.Boom()
		}
		public static function playLevel(code: String, type: uint = 0): void{
			//Type = 0 - Testplay
			//Type = 1 - Campaign
			//Type = 2 - Custom
			TD.setScene(TLevelScene)
			levelType = type
			levelCode = code
			needed = 0
			if (TLevData.lastSelected){
				switch(lastPlayed){
					case(8):
						if (TLevData.lastSelected.id == "16"){
							lastPlayed = 16;
						} else if (TLevData.lastSelected.id != "8"){
							lastPlayed = 0}
						break;
					case(16):
						if (TLevData.lastSelected.id == "25"){
							lastPlayed = 25
						} else {
							lastPlayed = 0
						}
						break;
					case(25):
						if (TLevData.lastSelected.id == "34"){
							lastPlayed = 34
						} else {
							lastPlayed = 0
						}
						break;
					case(34):
						if (TLevData.lastSelected.id == "45"){
							lastPlayed = 45
						} else {
							lastPlayed = 0
						}
						break;
					case(45):
						if (TLevData.lastSelected.id == "56"){
							lastPlayed = 56
						} else {
							lastPlayed = 0
						}
						break;
					case(56):
						if (TLevData.lastSelected.id == "66"){
							TAchievementsPanel.awardAchievement(3);
							lastPlayed = 0
						} else {
							lastPlayed = 0
						}
						break;
					default:
						if (TLevData.lastSelected.id == "8"){
							lastPlayed = 8
						}
						break;
				}
			}
			PlayLevel(levelCode)
		}
		public static function endLevel(finished: Boolean = false): void{
			switch(levelType){
				case(0):
					TD.setScene(TEditorScene)
					TPlayer.kill()
					LoadLevel(levelCode)
					if (finished){
						TopPanelMonster.levFinished = true
					}
					return;
				case(1):
					if (finished){
						TAchievementsPanel.levelCompleted(TLevData.lastSelected.id)
						TLevData.lastSelected.completed()
						if (
							TAchievementsPanel.allCompleted()
							&& SimpleSave.read('has-completed-game', 0) === 0
						){
							SimpleSave.writeFlush('has-completed-game', 1);
							TD.setScene(TEndingScene)
							TPlayer.kill()
							TAchievementsPanel.awardAchievement(4)
							return;
						}
					}
					TD.setScene(TCampaignScene)
					TPlayer.kill()
					return;
					break;
				case(2):
					if (finished){
						TAchievementsPanel.levelCompleted(TLevData.lastSelected.id)
					}
					TD.setScene(TCustomScene)
					TPlayer.kill()
					return;
					break;
			}
		}
	}
}