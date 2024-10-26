package game.managers{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
	import flash.events.MouseEvent;
    import flash.filters.DropShadowFilter;
	import game.windows.TGrowlAchievement;

    import game.achievements.Achievement;

    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.standalone.Colorizer;

    public class VOAchievementBitmap extends Sprite{
        public var achievement:Achievement;
        public var colorizer  :Colorizer;

        private var bitmap:Bitmap;

        public function VOAchievementBitmap(achievement:Achievement){
            super();

            var bitmapData:BitmapData = new BitmapData(44, 44, false, 0);

            this.achievement = achievement;
            colorizer        = new Colorizer(this);
            bitmap           = new Bitmap(bitmapData);

            addChild           (bitmap);
            achievement.drawTo (bitmapData, 0, 0);

            filters = [ new DropShadowFilter(2, 45, 0, 0.5) ];

            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(MouseEvent.CLICK, onClick);
        }
		
		private function onClick(e:*):void {
			new TGrowlAchievement(achievement);
		}

        public function updateCompletion():void {
            colorizer.saturation = (achievement.acquired ? 1 : 0);
            colorizer.luminosity = (achievement.acquired ? 1 : 0.75);
        }

        private function onAddedToStage(e:Event):void {
            var desc:String = (achievement.desc is Function ? achievement.desc() : achievement.desc);
            rTooltip.hook(this, "== " + achievement.name + " ==\n" + desc, true);
        }
    }
}