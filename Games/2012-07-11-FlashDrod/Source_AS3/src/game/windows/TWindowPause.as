package game.windows{
    import flash.display.BlendMode;
    import flash.geom.Point;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import game.global.Game;
    import game.global.Level;
    import net.retrocade.camel.effects.rEffFadeScreen;

    import game.global.Make;
    import game.global.Sfx;
    import game.states.TStateGame;
    import game.states.TStateTitle;

    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UGraphic;

    public class TWindowPause extends rWindow{
        private static var EFFECT_DURATION:uint = 400;

        private static var _instance:TWindowPause = new TWindowPause();
        public static function show():void{
            _instance.show();
        }



        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        private var _background:Grid9;
        private var _header:Text;

        private var _buttonContinue:Button;
        private var _buttonRestart :Button;
        private var _buttonHelpRoom:Button;
        private var _buttonHelp    :Button;
        private var _buttonAchieves:Button;
        private var _buttonOptions :Button;
        private var _buttonReturn  :Button;

        // Block all input
        private var _locked:Boolean = false;

        public function set locked(to:Boolean):void{
            _locked = to;

            mouseChildren = mouseEnabled = !to;
        }


        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        public function TWindowPause(){
            const W:uint = 600;
            const H:uint = 400;

            _background     = Grid9.getGrid("window", true);
            _header         = new Text(_("pauseHeader"), C.FONT_FAMILY, 32, 0);

            _buttonContinue = Make.buttonColor(clickContinue, _("pauseContinue"));
            _buttonRestart  = Make.buttonColor(clickRestart,  _("pauseRestart"));
            _buttonHelpRoom = Make.buttonColor(clickHelpRoom, _("pauseRoomHelp"));
            _buttonHelp     = Make.buttonColor(clickHelp,     _("pauseHelp"));
            _buttonAchieves = Make.buttonColor(clickAchieves, _("pauseAchievements"));
            _buttonOptions  = Make.buttonColor(clickOptions,  _("pauseOptions"));
            _buttonReturn   = Make.buttonColor(clickReturn,   _("pauseReturn"));



            _background.width  = W;
            _background.height = H;

            _header.x = (_background.width - _header.width) / 2;


            _buttonContinue.alignCenterParent(0, W);
            _buttonRestart .alignCenterParent(0, W);
            _buttonOptions .alignCenterParent(0, W);
            _buttonHelpRoom.alignCenterParent(0, W);
            _buttonHelp    .alignCenterParent(0, W);
            _buttonAchieves.alignCenterParent(0, W);
            _buttonReturn  .alignCenterParent(0, W);

            const SPACE:uint = 10;

            _buttonContinue.y = 50;
            _buttonRestart .y = _buttonContinue.bottom + SPACE;
            _buttonOptions .y = _buttonRestart .bottom + SPACE;
            _buttonHelpRoom.y = _buttonOptions .bottom + SPACE;
            _buttonHelp    .y = _buttonHelpRoom.bottom + SPACE;
            _buttonAchieves.y = _buttonHelp    .bottom + SPACE;
            _buttonReturn  .y = _buttonAchieves.bottom + SPACE;

            addChild(_background);
            addChild(_header);
            addChild(_buttonContinue);
            addChild(_buttonRestart);
            addChild(_buttonOptions);
            addChild(_buttonHelpRoom);
            addChild(_buttonHelp);
            addChild(_buttonAchieves);
            addChild(_buttonReturn);

            rTooltip.hook(_buttonContinue, _("pauseContinueTip"), true);
            rTooltip.hook(_buttonRestart,  _("pauseRestartTip"), true);
            rTooltip.hook(_buttonOptions,  _("pauseOptionsTip"), true);
            rTooltip.hook(_buttonHelpRoom, _("pauseRoomHelpTip"), true);
            rTooltip.hook(_buttonHelp,     _("pauseHelpTip"), true);
            rTooltip.hook(_buttonAchieves, _("pauseAchievementsTip"), true);
            rTooltip.hook(_buttonReturn,   _("pauseReturnTip"), true);

            center();

            UGraphic.draw(this)
                .rectFill(-x, -y, S.SIZE_GAME_WIDTH, S.SIZE_GAME_HEIGHT, 0, 0.65);
        }

        override public function show():void{
            super.show();

            locked = true;

            new rEffFade(this, 0, 1, EFFECT_DURATION, function():void{ locked = false; });

            Sfx.buttonClick();
        }

        override public function close():void {
            super.close();

            rTooltip.hide();
        }

        override public function update():void{
            if (_locked)
                return;


            if (rInput.isKeyHit(Key.ESCAPE) || rInput.isKeyHit(Key.ENTER)){
                locked = true;
                new rEffFade(this, 1, 0, EFFECT_DURATION, close);
                Sfx.buttonClick();
            }
        }

        private function clickContinue():void{
            locked = true;
            Sfx.buttonClick();
            new rEffFade(this, 1, 0, EFFECT_DURATION, close);
        }

        private function clickRestart():void{
            TStateGame.instance.restartCommand();
            locked = true;
            Sfx.buttonClick();
            new rEffFade(this, 1, 0, EFFECT_DURATION, close);
        }

        private function clickOptions():void {
            TWindowOptions.show();
            Sfx.buttonClick();
        }

        public static function clickHelpRoom():void {
            var hold:XML = Level.getHoldTag();
            var roomPos:Point = Level.getRoomOffsetInLevel(Game.room.roomID);
            var url:String = "http://forum.caravelgames.com/gamehints.php?hc=" + hold.@GID_Created +
                "&hu=" + hold.@LastUpdated +
                "&l="  + (Level.getLevelIndex(Game.room.levelID)) +
                "&rx=" + roomPos.x +
                "&ry=" + roomPos.y;

            navigateToURL(new URLRequest(url), "_blank");

            Sfx.buttonClick();
        }

        private function clickHelp():void{
            TWindowAbout.show();
            Sfx.buttonClick();
        }

        private function clickAchieves():void{
            TWindowAchievements.show();
            Sfx.buttonClick();
        }

        private function clickReturn():void {
            new rEffFade(this, 1, 0, EFFECT_DURATION);
            new rEffFadeScreen(1, 0, 0, EFFECT_DURATION, onFadeReturnToTitle);
            locked = true;

            Sfx.buttonClick();
        }


        private function onFadeReturnToTitle():void {
            close();
            TStateTitle.show();
        }
    }
}