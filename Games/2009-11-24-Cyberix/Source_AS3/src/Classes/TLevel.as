package Classes
{
	import Classes.Interactivers.TObject;
	import Classes.Items.*;
	import Classes.Menu.TAchievementsPanel;
	import Classes.Scenes.*;

	import Editor.GiveClass;
	import Editor.LoadLevel;
	import Editor.PlayLevel;
	import Editor.TopPanelMonster;

	import Functions.Loop;


	import mx.core.BitmapAsset;

	public class TLevel{
		public static var Lev:Array
		public static var wid:uint = 25
		public static var hei:uint = 25
		public static var authorName:String = ""
		public static var levelName:String = ""
		public static var levelCode:String = ""
		public static var levelType:uint = 0
		public static var fruits:uint = 0
		public function TLevel(){
			Lev = new Array(25)
			for (var i:uint = 0;i < 25;i++){
				Lev[i]=new Array(25)
				for (var j:uint = 0;j < 25;j++){
					Lev[i][j]=new TTile()
				}
			}
		}
		public static function Restart(faded:Boolean = false):void{
			if (TLevelScene.command == 0 && !faded){
				TLevelScene.command = 1
				return
			}
			if (!faded){
				return;
			}
			Clear()
			PlayLevel(levelCode)
			if (levelType == 1){
				new TutorialHandler()
			}
			TLevelScene.reset()
		}
		public static function FixSize():void{
			Game.layerPlayer.graphics.clear()
			Game.layerEffects.x = Game.layerObjects.x = Game.layerItems.x = Game.layerFloor.x = Game.layerBg.x = (25 - wid) * 12
			Game.layerEffects.y = Game.layerObjects.y = Game.layerItems.y = Game.layerFloor.y = Game.layerBg.y = (25 - hei) * 12
			Game.layerPlayer.graphics.beginFill(0)
			Game.layerPlayer.graphics.drawRect(0,0,600,(25 - hei) * 12)
			Game.layerPlayer.graphics.beginFill(0)
			Game.layerPlayer.graphics.drawRect(0,0,(25 - wid) * 12,600)
			Game.layerPlayer.graphics.beginFill(0)
			Game.layerPlayer.graphics.drawRect(0,600 - (25 - hei) * 12,600,(25 - hei) * 12)
			Game.layerPlayer.graphics.beginFill(0)
			Game.layerPlayer.graphics.drawRect(600 - (25 - wid) * 12,0,(25 - wid) * 12,600)
			for (var i:uint = 0;i < 25;i++){
				for (var j:uint = 0;j < 25;j++){
					if (i >= wid || j >= hei){
						Remove(i * 24,j * 24)
					}
				}
			}
		}
		public static function addFloor(x:uint,y:uint,gfx:uint):void{
			var spr:BitmapAsset = new (GiveClass(gfx))
			spr.x = x*24
			spr.y = y*24
			Game.layerFloor.addChild(spr)
		}
		public static function generateRandom():void{
			for (var i:uint = 0;i < 25;i++){
				for (var j:uint = 0;j < 25;j++){
					var tiler:TTile = Lev[i][j]
					if (Math.random() < 0.3){
						tiler.Set(new TWall(i * 24,j * 24,60))
					} else if (Math.random() < 0.2){
						if (i > 0){
							//tiler.Set(new TButtonItem(i * 24,j * 24,i * 24 - 24,j * 24,"M","5"))
						}
					} else {
						//tiler.Set(new TStopper(i * 24,j * 24))
					}
				}
			}
		}
		public static function Clear():void{
			var chd:TObject
			for (var i:int = 0;i < 25;i++){
				for (var j:uint = 0;j < 25;j++){
					var tiler:TTile = Lev[i][j]
					tiler.Remove()
				}
			}
			for (i = Game.layerObjects.numChildren - 1;i >= 0;i--){
				chd = Game.layerObjects.getChildAt(i) as TObject
				if (chd == null){Game.layerObjects.removeChildAt(i);continue}
				chd.Remove()
			}
			for (i = Game.layerEffects.numChildren - 1;i >= 0;i--){
				chd = Game.layerEffects.getChildAt(i) as TObject
				if (chd == null){Game.layerEffects.removeChildAt(i);continue}
				chd.Remove()
			}
			while(Game.layerPlayer.numChildren > 0){
				Game.layerPlayer.removeChildAt(0)
			}
			TLevelScene.breakUpdate = true
			Game.clearLayer(Game.layerItems)
			Game.clearLayer(Game.layerFloor)
		}
		public static function checkHit(who:TObject,x:int,y:int):void{
			x = Loop(Math.floor(x / 24),TLevel.wid)
			y = Loop(Math.floor(y / 24),TLevel.hei)
			var tiler:TTile = Lev[x][y]
			tiler.Hit(who)
		}
		public static function checkBullet(who:TObject,x:int,y:int):void{
			x = Math.floor(x / 24)
			y = Math.floor(y / 24)
			if (x < 0 || x > 24 || y < 0 || y > 24){return}
			var tiler:TTile = Lev[x][y]
			tiler.Bullet(who)
		}
		public static function checkStomp(who:TObject,x:int,y:int):void{
			x = Math.floor(x / 24)
			y = Math.floor(y / 24)
			if (x < 0 || x > 24 || y < 0 || y > 24){return}
			var tiler:TTile = Lev[x][y]
			tiler.Stomp(who)
		}
		public static function Set(x:uint,y:uint,item:TItem,rem:Boolean = true):void{
			var tile:TTile = Lev[x / 24][y / 24]
			if (tile) {
				tile.Set(item,rem)
			}
		}
		public static function Remove(x:uint,y:uint):void{
			var tiler:TTile = Lev[x / 24][y / 24]
			tiler.Remove();
		}
		public static function checkAt(x:int,y:int):TItem{
			x = Loop(Math.floor(x / 24),TLevel.wid)
			y = Loop(Math.floor(y / 24),TLevel.hei)
			var tiler:TTile = Lev[x][y]
			return tiler.At();
		}
		public static function playLevel(code:String, type:uint = 0):void{
			//Type = 0 - Testplay
			//Type = 1 - Campaign
			//Type = 2 - Custom
			Game.setScene(TLevelScene)
			levelType = type
			levelCode = code
			fruits = 0
			PlayLevel(levelCode)
			new TutorialHandler()
		}
		public static function endLevel(finished:Boolean = false,faded:Boolean = false):void{
			switch(levelType){
				case(0):
					Game.setScene(TEditorScene)
					LoadLevel(levelCode)
					if (finished){
						TopPanelMonster.levFinished = true
					}
					return;
				case(1):
					if (finished){
						if (TLevData.lastSelected.id === "140") {
							TAchievementsPanel.awardAchievement(2)
						}
						TAchievementsPanel.levelCompleted(TLevData.lastSelected.id)
						if (
							TAchievementsPanel.allCompleted()
							&& SimpleSave.read('game-completed', 0) !== 1
						){
							SimpleSave.writeFlush('game-completed', 1);
							TAchievementsPanel.awardAchievement(1)
							Game.setScene(TCreditsScene)
							return;
						}

					}
					Game.setScene(TCampaignScene)
					return;
				case(2):
					if (finished){
						TAchievementsPanel.levelCompleted(TLevData.lastSelected.id)
					}
					Game.setScene(TCustomScene)
					return;
			}
		}
	}
}