package Classes.Menu{
	import Classes.MenuButton;

	import Editor.MakeText;

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
	import Classes.Grid9;
	import Editor.MakeText3;
	import flash.net.navigateToURL;
	import flash.filters.DropShadowFilter;
	import Classes.SFX;
	import LoadingDir.Loading;
	public class TAchievementsPanel extends Sprite{
		[Embed("../../../assets/gfx/by_maurycy/achievements/ac1.png")] public static var gfx_ac1: Class;
		[Embed("../../../assets/gfx/by_maurycy/achievements/ac2.png")] public static var gfx_ac2: Class;
		[Embed("../../../assets/gfx/by_maurycy/achievements/ac3.png")] public static var gfx_ac3: Class;
		[Embed("../../../assets/gfx/by_maurycy/achievements/ac4.png")] public static var gfx_ac4: Class;
		[Embed("../../../assets/gfx/by_maurycy/achievements/ac5.png")] public static var gfx_ac5: Class;
		[Embed("../../../assets/gfx/by_maurycy/achievements/ac6.png")] public static var gfx_ac6: Class;
		[Embed("../../../assets/gfx/by_maurycy/achievements/ac7.png")] public static var gfx_ac7: Class;
		[Embed("../../../assets/gfx/by_maurycy/achievements/ac8.png")] public static var gfx_ac8: Class;
		[Embed("../../../assets/gfx/by_maurycy/achievements/ac9.png")] public static var gfx_ac9: Class;
		[Embed("../../../assets/gfx/by_maurycy/achievements/ac10.png")] public static var gfx_ac10: Class;
		public static var self: TAchievementsPanel
		private static var achievements: Array = new Array

		public static var BUILTIN_LEVELS: Number=75;
		public static var USER_LEVELS: Array = [];
		public static var CUSTOM_LEVELS: Array = [];

		private var title: BitmapAsset

		private var logged: Boolean

		private var loginDesc: TextField
		public function TAchievementsPanel(){
			var bg:* = new Grid9(TWindow.Grid9DataMenu);
			bg.width = 301;
			bg.height = 101;
			bg.y = 105;
			addChild(bg)
			self = this

			var ld12345: String="Here were online services,\nnow there are only achievements."
			loginDesc = Editor.MakeText3(ld12345, 12, "center", 260)
			loginDesc.x = 16
			loginDesc.y = 120
			loginDesc.height = 80
			addChild(loginDesc);

			achievements.push(new gfx_ac1)
			achievements.push(new gfx_ac2)
			achievements.push(new gfx_ac3)
			achievements.push(new gfx_ac4)
			achievements.push(new gfx_ac5)
			achievements.push(new gfx_ac6)
			achievements.push(new gfx_ac7)
			achievements.push(new gfx_ac8)
			achievements.push(new gfx_ac9)
			achievements.push(new gfx_ac10)

			for(var i: uint = 0;i < 10;i++){
				var achievement: BitmapAsset = achievements[i]
				achievement.width = 26
				achievement.height = 26
				achievement.x = 19+i*26
				achievement.y = 164
				achievement.alpha = 0.2
				achievement.smoothing = true
				addChild(achievement)
			}

			updateAchievements()
			logged = true

		}
		public static function killLogin(): void{
			// @FIXME - Remove this somedays
		}
		private function updateAchievements(): void{
			if (SimpleSave.read("achievement_dead-speak-not", 0) === 1){achievements[0].alpha = 1}
			if (SimpleSave.read("achievement_the-nth-architect", 0) === 1){achievements[1].alpha = 1}
			if (SimpleSave.read("achievement_i-can-read", 0) === 1){achievements[2].alpha = 1}
			if (SimpleSave.read("achievement_guru-meditation", 0) === 1){achievements[3].alpha = 1}
			if (SimpleSave.read("achievement_end-of-the-endless", 0) === 1){achievements[4].alpha = 1}
			if (SimpleSave.read("achievement_respect-your-elders", 0) === 1){achievements[5].alpha = 1}
			if (SimpleSave.read("achievement_i-know-whats-going-on", 0) === 1){achievements[6].alpha = 1}
			if (SimpleSave.read("achievement_the-beautiful-view", 0) === 1){achievements[7].alpha = 1}
			if (SimpleSave.read("achievement_strong-see-their-mistakes", 0) === 1){achievements[8].alpha = 1}
			if (SimpleSave.read("achievement_mommy-i-am-lost", 0) === 1){achievements[9].alpha = 1}
		}
		public static function isLevelCompleted(id: String): Boolean{
			return SimpleSave.read('lvl-completed-' + id, 0) == 1;
		}
		public static function levelCompleted(id: String): void{
			SimpleSave.writeFlush('lvl-completed-' + id, 1);
		}
		public static function allCompleted(): Boolean{
			for (var i: Number = 0; i < BUILTIN_LEVELS; i++) {
				if (!isLevelCompleted(i.toString())) {
					return false;
				}
			}
			return true;
		}
		public static function awardAchievement(id: uint): void{
			trace("Award: " + id);
			switch(id){
				case(0):
					if (SimpleSave.read("achievement_dead-speak-not", 0) !== 1) {
						new TNote("Achievement!", "Dead speak not", new gfx_ac1);
						SimpleSave.writeFlush("achievement_dead-speak-not", 1);
						self.updateAchievements()
					}
					break
				case(1):
					// GOAL - Create a level in the editor, complete it and then save
					// before making any changes
					if (SimpleSave.read("achievement_the-nth-architect", 0) !== 1) {
						new TNote("Achievement!", "The N-th Architect", new gfx_ac2);
						SimpleSave.writeFlush("achievement_the-nth-architect", 1);
						self.updateAchievements()
					}
					break
				case(2):
					// GOAL: Click on ingame help
					if (SimpleSave.read("achievement_i-can-read", 0) !== 1) {
						new TNote("Achievement!", "I Can Read!", new gfx_ac3);
						SimpleSave.writeFlush("achievement_i-can-read", 1);
						self.updateAchievements()
					}
					break
				case(3):
					// GOAL: Play every meditation level in order
					if (SimpleSave.read("achievement_guru-meditation", 0) !== 1) {
						new TNote("Achievement!", "Guru Meditation", new gfx_ac4);
						SimpleSave.writeFlush("achievement_guru-meditation", 1);
						self.updateAchievements()
					}
					break
				case(4):
					// GOAL: Complete the campaign
					if (SimpleSave.read("achievement_end-of-the-endless", 0) !== 1) {
						new TNote("Achievement!", "End of the Endless", new gfx_ac5);
						SimpleSave.writeFlush("achievement_end-of-the-endless", 1);
						self.updateAchievements()
					}
					break
				case(5):
					// GOAL: Watch credits
					if (SimpleSave.read("achievement_respect-your-elders", 0) !== 1) {
						new TNote("Achievement!", "Respect your Elders", new gfx_ac6);
						SimpleSave.writeFlush("achievement_respect-your-elders", 1);
						self.updateAchievements()
					}
					break
				case(6):
					// GOAL: Watch entire intro without skipping (can fast forward)
					if (SimpleSave.read("achievement_i-know-whats-going-on", 0) !== 1) {
						new TNote("Achievement!", "I know what's going on", new gfx_ac7);
						SimpleSave.writeFlush("achievement_i-know-whats-going-on", 1);
						self.updateAchievements()
					}
					break
				case(7):
					// GOAL: Scroll the game screen far far away
					if (SimpleSave.read("achievement_the-beautiful-view", 0) !== 1) {
						new TNote("Achievement!", "The beautiful view", new gfx_ac8);
						SimpleSave.writeFlush("achievement_the-beautiful-view", 1);
						self.updateAchievements()
					}
					break
				case(8):
					if (SimpleSave.read("achievement_strong-see-their-mistakes", 0) !== 1) {
						new TNote("Achievement!", "Strong see their mistakes", new gfx_ac9);
						SimpleSave.writeFlush("achievement_strong-see-their-mistakes", 1);
						self.updateAchievements()
					}
					break
				case(9):
					// GOAL: Reach certain spot in the last meditation stage
					if (SimpleSave.read("achievement_mommy-i-am-lost", 0) !== 1) {
						new TNote("Achievement!", "Mommy, I am lost!", new gfx_ac10);
						SimpleSave.writeFlush("achievement_mommy-i-am-lost", 1);
						self.updateAchievements()
					}
					break
			}
		}
	}
}