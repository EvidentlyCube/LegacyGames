package game.windows{
    import flash.display.Bitmap;
    import flash.display.Shape;
    import flash.display.Sprite;
	import flash.utils.getTimer;
    import game.states.TStateGame;
	import net.retrocade.utils.Key;

    import game.global.Gfx;
    import game.global.Level;
    import game.global.Make;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffScreenshot;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UGraphic;

    public class TWindowLevelStart extends rWindow{
        private static var _instance:TWindowLevelStart = new TWindowLevelStart();

        private static var _screenshot:rEffScreenshot;

        public static function show(entranceID:uint, fadeIn:Boolean, skipEntranceWindow:Boolean = false):void{
            _screenshot = new rEffScreenshot();

            TStateGame.updateMusicState();

            if (skipEntranceWindow){
                return;
            }

            _instance.show();
            _instance.setEntrance(entranceID);

            if (fadeIn)
                new rEffFade(_instance, 0, 1, 850, _instance.onFadedIn);
            else
                _instance.alpha = 1;
        }

        public static function doCrossFade():void {
            new rEffFade(_screenshot.layer.displayObject, 1, 0, 800, function():void{
                _screenshot.stop();
                _screenshot = null;
            });
        }

        public static const MARGIN:uint = 20;
        public static const SCREEN:uint = S.SIZE_GAME_WIDTH - MARGIN * 2;

        public static const OFFSET_HOLD_NAME :uint = 70;
        public static const OFFSET_LEVEL_NAME:uint = 70;
        public static const OFFSET_DIVIDER   :uint = 15;
        public static const OFFSET_CREATED   :uint = 40;



        private var wrapper      :Sprite;

        private var background   :Bitmap;
        private var holdTitle    :Text;
        private var levelTitle   :Text;
        private var creationDate :Text;
        private var topDivider   :Shape;
        private var entranceBody :Text
        private var bottomDivider:Shape;

        private var fading       :Boolean = false;
		private var appearTime   :Number  = 0;

        private var keyReleased:Boolean = false;

        public function TWindowLevelStart(){
            wrapper       = new Sprite();
            background    = rGfx.getB(Gfx.CLASS_LEVEL_START_BACKGROUND);
            holdTitle     = Make.text(51,0xFFFF00);
            levelTitle    = Make.text(51);
            creationDate  = Make.text(26);
            topDivider    = new Shape;
            entranceBody  = Make.text(22);
            bottomDivider = new Shape;

            holdTitle   .color = 0xFFFF00;
            levelTitle  .color = 0xFFFF00;
            creationDate.color = 0xE3AB04;
            entranceBody.color = 0xFFFFFF;

            levelTitle  .y = OFFSET_HOLD_NAME;
            creationDate.y = OFFSET_HOLD_NAME + OFFSET_LEVEL_NAME;
            topDivider  .y = OFFSET_HOLD_NAME + OFFSET_LEVEL_NAME + OFFSET_CREATED + OFFSET_DIVIDER;
            entranceBody.y = OFFSET_HOLD_NAME + OFFSET_LEVEL_NAME + OFFSET_CREATED + OFFSET_DIVIDER * 2;

            holdTitle   .wordWrap = false;
            levelTitle  .wordWrap = false;
            creationDate.wordWrap = false;
            entranceBody.wordWrap = true;

            entranceBody.multiline = true;

            entranceBody.lineSpacing = -1;

            entranceBody.alignCenter();
            entranceBody.x = MARGIN;

            UGraphic.draw(topDivider)   .rectFill(20, 0, S.SIZE_GAME_WIDTH - 40, 1, 0x666666);
            UGraphic.draw(bottomDivider).rectFill(20, 0, S.SIZE_GAME_WIDTH - 40, 1, 0x666666);


            addChild(background);
            addChild(wrapper);

            wrapper.addChild(holdTitle);
            wrapper.addChild(levelTitle);
            wrapper.addChild(creationDate);
            wrapper.addChild(topDivider);
            wrapper.addChild(entranceBody);
            wrapper.addChild(bottomDivider);
        }
		
        override public function show():void{
            super.show();

            fading      = true;
            visible     = true;
			appearTime  = getTimer();
            keyReleased = false;
        }

        override public function close():void {
            super.close();

            TStateGame.instance.addFlashEvents();
        }

        override public function update():void {
            if (!keyReleased && rInput.isAnyKeyDown(32) && appearTime + 2000 < getTimer())
                return;

            keyReleased = true;

            if (!fading && (rInput.isMouseHit() || rInput.isAnyKeyHit())){
                fading = true;

				rInput.flushAll();
				
                new rEffFade(this, 1, 0, 500, function():void {
                    close();
                    TStateGame.updateMusicState();
                });

                _screenshot.stop();
                _screenshot = null;
            }
        }

        private function setEntrance(entranceID:uint):void{
            var date:Date = new Date(Level.getHoldTimestamp() * 1000);

            holdTitle   .text = Level.getHoldName();
            levelTitle  .text = _(Level.getLevelName(Level.getLevelIDByRoom(Level.getEntrance(entranceID).@RoomID)));
            creationDate.text = _("levelCreatedDate", date.date, date.month, date.fullYear);
            entranceBody.text = _(Level.getEntranceDescription(entranceID));

            entranceBody.width = SCREEN;

            while (entranceBody.height > 300)
                entranceBody.size--;

            holdTitle   .alignCenter();
            levelTitle  .alignCenter();
            creationDate.alignCenter();
            entranceBody.textAlignCenter();
            entranceBody.alignCenter();

            holdTitle   .height = holdTitle   .textHeight;
            levelTitle  .height = levelTitle  .textHeight;
            creationDate.height = creationDate.textHeight;
            entranceBody.height = entranceBody.textHeight;

            bottomDivider.y = entranceBody.y + entranceBody.textHeight + OFFSET_DIVIDER;

            wrapper.y = (S.SIZE_GAME_HEIGHT - wrapper.height) / 3;
        }
		
		private function onFadedIn():void {
			fading = false;
		}
    }
}