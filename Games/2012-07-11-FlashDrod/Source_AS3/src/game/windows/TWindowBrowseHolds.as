package game.windows {
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import game.global.CaravelConnect;
    import game.global.Make;
    import game.interfaces.THoldEntry;
    import net.retrocade.camel.core.rInput;
	import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
	
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TWindowBrowseHolds extends rWindow {

        private static var _instance:TWindowBrowseHolds = new TWindowBrowseHolds();

        public static function show():void {
            _instance.show();
        }




        private var header           :Text;
        private var background       :Grid9;
        private var holdsBackground  :Grid9;

        private var holds            :Sprite;

        private var holdsRect        :Rectangle = new Rectangle();

        private var holdTitle        :Text;
        private var holdTimestamp    :Text;
        private var holdDescription  :Text;

        private var buttonClose:Button;
        private var buttonPlay :Button;

        private var holdsArray:Array = [];
        private var selected:Object;

        public function TWindowBrowseHolds() {
            background      = Grid9.getGrid('window', true);
            holdsBackground = Grid9.getGrid("textInput", true);
            header          = Make.text(36);
            holds           = new Sprite();
            holdTitle       = Make.text(24);
            holdTimestamp   = Make.text(14);
            holdDescription = Make.text(16);
            buttonClose     = Make.buttonColor(onClose,     _("close"));
            buttonPlay      = Make.buttonColor(onClickOpen, _("browseOpen"));

            // Misc Data

            header.text = _("browseHeader");

            holdTitle.width     = 296;
            holdTitle.wordWrap  = true;
            holdTitle.multiline = true;
            holdTitle.textAlignCenter();

            holdTimestamp.width     = 296;
            holdTimestamp.wordWrap  = true;
            holdTimestamp.multiline = true;
            holdTimestamp.textAlignCenter();

            holdDescription.width     = 296;
            holdDescription.wordWrap  = true;
            holdDescription.multiline = true;
            holdDescription.textAlignJustify();




            // Positioning and sizing

            background     .setSizePosition(0, 0, 600, 500);
            holdsBackground.setSizePosition(10, 68, 280, 420);

            holds.x = holdsBackground.x;
            holds.y = holdsBackground.y;

            holdsRect.width  = holdsBackground.width;
            holdsRect.height = holdsBackground.height;

            holds.scrollRect = holdsRect;

            header.y = 5;
            header.alignCenterParent(0, background.width);

            buttonPlay .alignCenterParent(292, 296);
            buttonClose.alignCenterParent(292, 296);

            buttonClose.bottom = 500           - 14;
            buttonPlay .bottom = buttonClose.y - 8;

            addChild(background);
            addChild(holdsBackground);
            addChild(header);
            addChild(holds);
            addChild(holdTitle);
            addChild(holdTimestamp);
            addChild(holdDescription);
            addChild(buttonPlay);
            addChild(buttonClose);

            center();
			
			graphics.beginFill(0, 0.6);
			graphics.drawRect( -x, -y, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT);

            createHolds();
        }

        override public function show():void {
            super.show();

            mouseChildren = false;
            new rEffFade(this, 0, 1, 400, onFadedIn);

            buttonPlay.alpha = 0.5;
            buttonPlay.disable();
            holdTimestamp  .text = "";
            holdTitle      .text = "";
            holdDescription.text = "";

            holdClicked(null);
        }

        override public function update():void {
            if (holdsBackground.mouseX < 0 || holdsBackground.mouseX > holdsBackground.width || holds.numChildren * 30 <= holdsRect.height)
                return;

            var mouseY:Number = Math.max(0, Math.min(1, (holdsBackground.mouseY - 15) / (holdsBackground.height - 30)));

            holdsRect.y = (holds.numChildren * 30 - holdsRect.height) * mouseY;

            holds.scrollRect = holdsRect;

            if (mouseChildren && rInput.isKeyHit(Key.ESCAPE))
                onClose();
        }

        private function onClickOpen():void {
            if (selected)
                navigateToURL(new URLRequest(selected.url), "_blank");
        }

        private function onClose():void {
            new rEffFade(this, 1, 0, 400, close);
            mouseChildren = false;
        }

        private function onFadedIn():void {
            mouseChildren = true;
        }

        private function holdClicked(holdClicked:Button):void {
            for each(var hold:THoldEntry in holdsArray) {
                hold.unset();
            }

            if (!holdClicked)
                return;

            var timeDate :Date   = new Date(holdClicked.data.timestamp * 1000);
            var timestamp:String =

            holdTitle      .text = holdClicked.data.title;
            holdTimestamp  .text = timestamp;
            holdDescription.text = holdClicked.data.description;

            holdTitle      .width = 296;
            holdTimestamp  .width = 296;
            holdDescription.width = 296;

            holdTitle.x = holdsBackground.right + 8;
            holdTitle.y = holdsBackground.y;

            holdTimestamp.x = holdTitle.x;
            holdTimestamp.y = holdTitle.y + holdTitle.textHeight + 10;

            holdDescription.x = holdTitle.x;
            holdDescription.y = holdTimestamp.y + holdTimestamp.textHeight + 10;

            selected = holdClicked.data;
            buttonPlay.enable();
            buttonPlay.alpha = 1;
        }

        private function createHolds():void {
            var index:uint = 0;

            for each(var i:Object in CaravelConnect.games){
                var hold:THoldEntry = new THoldEntry(holdClicked, i);
                hold.y = index++ * 30;

                holds     .addChild(hold);
                holdsArray.push    (hold);
            }
        }
    }
}