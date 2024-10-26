package game.windows {
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import game.global.Game;
    import game.global.Make;
    import game.global.Progress;
    import game.states.TStateTitle;
	import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
	
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TWindowGameCompleted extends rWindow {

        private static var _instance:TWindowGameCompleted = new TWindowGameCompleted();

        public static function show():void {
            _instance.show();
        }




        private var _bg:Grid9;

        private var _header:Text;

        private var _nextGameDesc  :Text;
        private var _nextGameButton:Button;

        private var _learnMoreDesc  :Text;
        private var _learnMoreButton:Button;

        private var _continueDesc  :Text;
        private var _continueButton:Button;



        public function TWindowGameCompleted() {
            const PADDING:uint = 10;
            const WIDTH  :uint = 300;

            const SPACE_SMALL:uint = 5;
            const SPACE_BIG  :uint = 15;


            // Creation

            _bg     = Grid9.getGrid("window");
            _header = Make.text(24);

            _nextGameDesc  = Make.text(14);
            _learnMoreDesc = Make.text(14);
            _continueDesc  = Make.text(14);

            _nextGameButton  = Make.buttonColor(onNextGame,  _('complButtNextGame'));
            _learnMoreButton = Make.buttonColor(onLearnMore, _('complButtLearnMore'));
            _continueButton  = Make.buttonColor(onContinue,  _('complButtContinue'));


            // Properties

            _header       .text = _('complHeader');
            _nextGameDesc .text = _('complNextGame');
            _learnMoreDesc.text = _('complLearnMore');
            _continueDesc .text = _('complContinue');

            _header       .multiline = _header       .wordWrap = true;
            _nextGameDesc .multiline = _nextGameDesc .wordWrap = true;
            _learnMoreDesc.multiline = _learnMoreDesc.wordWrap = true;
            _continueDesc .multiline = _continueDesc .wordWrap = true;

            _header         .width = WIDTH;
            _nextGameButton .width = WIDTH;
            _nextGameDesc   .width = WIDTH;
            _learnMoreButton.width = WIDTH;
            _learnMoreDesc  .width = WIDTH;
            _continueButton .width = WIDTH;
            _continueDesc   .width = WIDTH;

            _header       .textAlignCenter();
            _nextGameDesc .textAlignCenter();
            _learnMoreDesc.textAlignCenter();
            _continueDesc .textAlignCenter();

            _header       .apply();
            _nextGameDesc .apply();
            _learnMoreDesc.apply();
            _continueDesc .apply();

            // Positioning

            _header.y = PADDING;
            _header.height = _header.textHeight;

            _nextGameDesc   .y      = _header.bottom + SPACE_BIG;
            _nextGameDesc   .height = _nextGameDesc.textHeight;
            _nextGameButton .y      = _nextGameDesc.bottom + SPACE_SMALL;

            _learnMoreDesc  .y      = _nextGameButton.bottom + SPACE_BIG;
            _learnMoreDesc  .height = _learnMoreDesc.textHeight;
            _learnMoreButton.y      = _learnMoreDesc.bottom + SPACE_SMALL;

            _continueDesc  .y      = _learnMoreButton.bottom + SPACE_BIG;
            _continueDesc  .height = _continueDesc.textHeight;
            _continueButton.y      = _continueDesc.bottom + SPACE_SMALL;

            _header         .x = PADDING;
            _nextGameDesc   .x = PADDING;
            _nextGameButton .x = PADDING;
            _learnMoreDesc  .x = PADDING;
            _learnMoreButton.x = PADDING;
            _continueDesc   .x = PADDING;
            _continueButton .x = PADDING;


            _bg.setSizePosition( 0, 0, WIDTH + PADDING * 2, _continueButton.bottom + PADDING);



            // Adding

            addChild(_bg);
            addChild(_header);
            addChild(_nextGameButton);
            addChild(_nextGameDesc);
            addChild(_learnMoreButton);
            addChild(_learnMoreDesc);
            addChild(_continueButton);
            addChild(_continueDesc);

            center();
			
			graphics.beginFill(0, 0.6);
			graphics.drawRect( -x, -y, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT);
        }

        override public function show():void {
            Progress.isGameCompleted = true;
			
			var wasMastered:Boolean = Progress.isGameMastered;
			
			if (!wasMastered && Progress.checkHoldMastery()) {
                Progress.isGameMastered = true;
            }

            super.show();

            mouseChildren = false;

            new rEffFade(this, 0, 1, 500, onFadedIn);
        }

        override public function close():void {
            super.close();
        }

        private function onFadedIn():void {
            mouseChildren = true;
        }

        private function onFadedOut():void {
            close();

            TStateTitle.show();
        }

        private function onNextGame():void {
            TWindowMessage.show("Not Yet Implemented!", 150, false);
        }

        private function onLearnMore():void {
            navigateToURL(new URLRequest("http://forum.caravelgames.com/viewsitepage.php?id=275971"), "_blank");
        }

        private function onContinue():void {
            mouseChildren = false;

            new rEffFadeScreen(1, 0, 0, 1000);
            new rEffFade(this, 1, 0, 1000, onFadedOut)

			if (Game.room)
				Game.room.clear();
				
            Game.room = null;
        }
    }
}