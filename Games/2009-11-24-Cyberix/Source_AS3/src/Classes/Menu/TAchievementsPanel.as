package Classes.Menu{
	import Classes.*;
	import Classes.Menu.*;
	import Classes.Scenes.*;
	import Classes.Items.*;
	import Classes.Interactivers.*;
	import Classes.Data.*;
	import Editor.*;

	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;

	import mx.core.BitmapAsset;
	import flash.net.navigateToURL;
	import flash.filters.DropShadowFilter;

	public class TAchievementsPanel extends Sprite{
		[Embed("../../../assets/gfx/achievements/ac1.png")] public static var gfx_ac1:Class;
		[Embed("../../../assets/gfx/achievements/ac2.png")] public static var gfx_ac2:Class;
		[Embed("../../../assets/gfx/achievements/ac3.png")] public static var gfx_ac3:Class;
		[Embed("../../../assets/gfx/achievements/ac4.png")] public static var gfx_ac4:Class;
		[Embed("../../../assets/gfx/achievements/ac5.png")] public static var gfx_ac5:Class;
		[Embed("../../../assets/gfx/achievements/ac6.png")] public static var gfx_ac6:Class;
		[Embed("../../../assets/gfx/achievements/ac7.png")] public static var gfx_ac7:Class;
		private static var self:TAchievementsPanel
		private static var achievements:Array = new Array

		private var connectInit:Boolean = false
		private var avatar:Loader

		private var compl:TextField

		private var bg:Grid9

		private var loginDesc:TextField

		private static var credits:MenuButton
		public function TAchievementsPanel(){
			self = this
			bg = new Grid9(TWindow.Grid9DataMenu)
			bg.width = 270
			bg.height = 270
			addChild(bg)

			var ld12345:String = "Online services were here but all that is left are achievements."
			loginDesc = Editor.MakeText3(ld12345,12,"justify",250)
			loginDesc.x = 10
			loginDesc.y = 40
			addChild(loginDesc);

			achievements.push(new gfx_ac1)
			achievements.push(new gfx_ac2)
			achievements.push(new gfx_ac3)
			achievements.push(new gfx_ac4)
			achievements.push(new gfx_ac5)
			achievements.push(new gfx_ac6)
			achievements.push(new gfx_ac7)

			credits = new MenuButton("Watch Credits")
			credits.x = 75
			credits.y = 224
			credits.addEventListener(MouseEvent.CLICK,function():void{Game.setScene(TCreditsScene)})
			addChild(credits);

			for(var i:uint = 0;i < 7;i++){
				var a:BitmapAsset = achievements[i]
				a.width = 35
				a.height = 35
				a.x = 14 + i*35
				a.y = 155
				a.alpha = 0.3
				a.smoothing = true
				addChild(a)
			}

			updateAchievements();
		}
		private function updateAchievements():void{
			if (SimpleSave.read("achivement-helpless", 0) === 1){ achievements[0].alpha = 1; }
			if (SimpleSave.read("achivement-mastery", 0) === 1){ achievements[1].alpha = 1; }
			if (SimpleSave.read("achivement-challenger", 0) === 1){ achievements[2].alpha = 1; }
			if (SimpleSave.read("achivement-craftmanship", 0) === 1){ achievements[3].alpha = 1; }
			if (SimpleSave.read("achivement-ignorance", 0) === 1){ achievements[4].alpha = 1; }
			if (SimpleSave.read("achivement-collector", 0) === 1){ achievements[5].alpha = 1; }
			if (SimpleSave.read("achivement-far-fetcher", 0) === 1){ achievements[6].alpha = 1; }
		}

		public static function countCompletion(): uint {
			var counter: Number = 0;
			for (var i: Number = 0; i < LevelDatabase.campaignLevels.length; i++) {
				var level:* = LevelDatabase.campaignLevels[i];

				if (isLevelCompleted(level.id)) {
					counter++;
				}
			}

			return counter;
		}
		public static function isLevelCompleted(id:String):Boolean{
			return SimpleSave.read('level-completed-' + id, 0) === 1;
		}

		public static function levelCompleted(id:String):void{
			SimpleSave.writeFlush('level-completed-' + id, 1);
			self.updateLevs();
		}
		public function updateLevs():void{
			var c:uint = countCompletion();

			compl = MakeText("Levels Completed: " + c+" out of 140",15)
			compl.y = 190
			compl.x = 135 - compl.width / 2
			addChild(compl)
		}
		public static function allCompleted(): Boolean{
			return countCompletion() === LevelDatabase.campaignLevels.length;
		}

		public static function awardAchievement(id:uint):void{
			switch(id){
				case(0):
					// GOAL: Open help
					if (SimpleSave.read("achivement-helpless", 0) === 0){
						new TNote("Achievement!","Helpless?",new gfx_ac1);
						SimpleSave.writeFlush("achivement-helpless", 1);
						self.updateAchievements()
					}
					break
				case(1):
					// GOAL: Complete all levels
					if (SimpleSave.read("achivement-mastery", 0) === 0){
						new TNote("Achievement!","Mastery",new gfx_ac2);
						SimpleSave.writeFlush("achivement-mastery", 1);
						self.updateAchievements();
					}
					break
				case(2):
					// GOAL: Complete last level
					if (SimpleSave.read("achivement-challenger", 0) === 0){
						new TNote("Achievement!","Challenger",new gfx_ac3);
						SimpleSave.writeFlush("achivement-challenger", 1);
						self.updateAchievements();
					}
					break
				case(3):
					// GOAL: Build a level, complete it in playtest and save it
					if (SimpleSave.read("achivement-craftmanship", 0) === 0){
						new TNote("Achievement!","Craftmanship",new gfx_ac4);
						SimpleSave.writeFlush("achivement-craftmanship", 1);
						self.updateAchievements();
					}
					break
				case(4):
					// GOAL: Die 100 times in total
					if (SimpleSave.read("achivement-ignorance", 0) === 0){
						new TNote("Achievement!","Ignorance",new gfx_ac5);
						SimpleSave.writeFlush("achivement-ignorance", 1);
						self.updateAchievements();
					}
					break
				case(5):
					// GOAL: Collect 1000 things
					if (SimpleSave.read("achivement-collector", 0) === 0){
						new TNote("Achievement!","Collector",new gfx_ac6);
						SimpleSave.writeFlush("achivement-collector", 1);
						self.updateAchievements();
					}
					break
				case(6):
					// GOAL: Travel 10 000 steps
					if (SimpleSave.read("achivement-far-fetcher", 0) === 0){
						new TNote("Achievement!","Far-fetcher",new gfx_ac7);
						SimpleSave.writeFlush("achivement-far-fetcher", 1);
						self.updateAchievements();
					}
					break
			}
		}

		public static function recordPlayerDeath():void {
			SimpleSave.writeFlush('total-deaths', SimpleSave.read('total-deaths', 0) + 1);
			if (SimpleSave.read('total-deaths', 0) >= 100){
				TAchievementsPanel.awardAchievement(4);
			}
		}

		public static function recordEatingItem():void {
			SimpleSave.writeFlush('total-eats', SimpleSave.read('total-eats', 0) + 1);
			if (SimpleSave.read('total-eats', 0) >= 1000){
				TAchievementsPanel.awardAchievement(5);
			}
		}

		public static function recordTileTravelled():void {
			SimpleSave.writeFlush('total-steps', SimpleSave.read('total-steps', 0) + 1);
			if (SimpleSave.read('total-steps', 0) >= 10000){
				TAchievementsPanel.awardAchievement(6);
			}
		}
	}
}