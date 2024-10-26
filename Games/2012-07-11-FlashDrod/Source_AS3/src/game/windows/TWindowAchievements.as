package game.windows{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import game.global.Sfx;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;

    import game.achievements.Achievement;
    import game.achievements.Achievements;
    import game.global.Make;
    import game.managers.VOAchievementBitmap;

    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;

    public class TWindowAchievements extends rWindow{
        private static var _instance:TWindowAchievements = new TWindowAchievements();

        public static function show():void{
            _instance.show();
        }

        CF::holdKdd1
        private static const ITEMS_IN_ROW:uint = 8;

        CF::holdKdd2
        private static const ITEMS_IN_ROW:uint = 6;

        CF::holdKdd3
        private static const ITEMS_IN_ROW:uint = 8;

        CF::lib
        private static const ITEMS_IN_ROW:uint = 0;

        private var _header      :Text;

        private var _achievements:Array = [];
        private var _background  :Grid9;
        private var _close       :Button;

        public function TWindowAchievements(){
            super();

            _header     = Make.text(24);
            _background = Grid9.getGrid("window");
            _close      = Make.buttonColor(closeClicked, _("close"));

            _header.text = _("achlistHeader");
            _header.y    = 8;

            _blockUnder = true;
            _pauseGame  = true;

            addChild(_background);
            addChild(_header);

            var achievements:Array               = Achievements.getAll();
            var previous    :VOAchievementBitmap;

            var spacerIndex:uint = 0;
            for each(var achievement:Achievement in achievements){
                var achievementBitmap:VOAchievementBitmap = new VOAchievementBitmap(achievement);

                _achievements.push(achievementBitmap);
                addChild          (achievementBitmap);

                if (previous){
                    achievementBitmap.x = previous.x + 50 * 1;
                    achievementBitmap.y = previous.y;
                } else {
                    achievementBitmap.x = 20;
                    achievementBitmap.y = 50;
                }

                while (achievementBitmap.x > ITEMS_IN_ROW * 50){
                    achievementBitmap.x -= ITEMS_IN_ROW * 50;
                    achievementBitmap.y += 50;
                }

                previous = achievementBitmap;
            }

            addChild(_close);

            _header.alignCenterParent(10);

            _background.width = width + 20;
            _background.height = height + 70;

            _close.alignCenterParent(0, width);
            _close.y = height - _close.height - 20;
        }

        override public function show():void {
			graphics.clear();

            for each(var achievement:VOAchievementBitmap in _achievements){
                achievement.updateCompletion();
            }

            center();

			graphics.beginFill(0, 0.6);
			graphics.drawRect( -x, -y, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT);

            super.show();

            mouseChildren = false;
            new rEffFade(this, 0, 1, 400, shown);
        }

        override public function update():void {
            if ((rInput.isKeyHit(Key.ESCAPE) || rInput.isKeyHit(Key.TAB) || rInput.isKeyHit(Key.ENTER)) && mouseChildren)
                closeClicked();
        }

        private function shown():void{
            mouseChildren = true;
        }

        private function closeClicked():void{
            if (!mouseChildren)
                return;

            mouseChildren = false;

            new rEffFade(this, 1, 0, 400, close);

            Sfx.buttonClick();
        }
    }
}