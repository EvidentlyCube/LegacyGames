


package net.retrocade.tacticengine.monstro.gui.windows {
	import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
	import net.retrocade.retrocamel.display.starling.RetrocamelWindowStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.tacticengine.core.injector.injectCreate;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroGrid9;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;

	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.VAlign;

	public class MonstroWindowChromeIssue extends RetrocamelWindowStarling{
        public static function show():void{
            var instance:MonstroWindowChromeIssue = injectCreate(MonstroWindowChromeIssue);

            instance.show();
        }

        public static var framerate:uint = 60;

        private var _modal:Image;
        private var _background:MonstroGrid9;
        private var _header:TextField;
        private var _text:TextField;
        private var _button30:MonstroTextButton;
        private var _button60:MonstroTextButton;

        private var _displayGroup:MonstroDisplayGroup;

        override public function show():void{
            super.show();

            const WINDOW_WIDTH:uint = 600;

            _modal = MonstroGfx.getBlackColor();
            _background = MonstroGfx.getGrid9WindowHeader();
            _header = new TextField(WINDOW_WIDTH, 34, _("chrome_issue.header"), MonstroConsts.FONT_EBORACUM_48, 24, 0xFFFFFF);
            _text = new TextField(WINDOW_WIDTH, 500, _("chrome_issue.body"), MonstroConsts.FONT, 18, 0xFFFFFF);
            _text.htmlText = true;
            _text.autoSize = TextFieldAutoSize.VERTICAL;
            _text.vAlign = VAlign.TOP;
            _button30 = new MonstroTextButton("30 FPS", on30FPS);
            _button60 = new MonstroTextButton("60 FPS", on60FPS);

            _displayGroup = new MonstroDisplayGroup();

            _displayGroup.addElement(_background);
            _displayGroup.addElement(_header);
            _displayGroup.addElement(_text);
            _displayGroup.addElement(_button30);
            _displayGroup.addElement(_button60);


            _header.y -= 1;
            _text.y = _header.bottom + MonstroConsts.hudSpacer * 2;

            addChild(_modal);
            addChild(_background);
            addChild(_header);
            addChild(_text);
            addChild(_button30);
            addChild(_button60);

            _button60.y = _text.textHeight + _text.y + MonstroConsts.hudSpacer * 3;
            _button30.y = _text.textHeight + _text.y + MonstroConsts.hudSpacer * 3;

            _header.center = WINDOW_WIDTH / 2;
            _text.alignCenterParent();
            _button60.center = WINDOW_WIDTH / 4;
            _button30.center = WINDOW_WIDTH * 3 / 4;
            _background.x -= MonstroConsts.hudSpacer * 2;
            _background.width = WINDOW_WIDTH + MonstroConsts.hudSpacer * 4;
            _background.height = height + MonstroConsts.hudSpacer * 2;

            _modal.alpha = 0.6;

            resize();
        }

        override public function hide():void {
            removeChildren();

            _modal.dispose();
            _background.dispose();
            _header.dispose();
            _text.dispose();
            _button30.dispose();
            _displayGroup.dispose();

            _modal = null;
            _background = null;
            _header = null;
            _text = null;
            _button30 = null;
            _displayGroup = null;

            super.hide();
        }

        private function on30FPS():void{
            framerate = 30;
            RetrocamelDisplayManager.flashStage.frameRate = framerate;
            hide();
        }

        private function on60FPS():void{
            framerate = 60;
            RetrocamelDisplayManager.flashStage.frameRate = framerate;
            hide();
        }


        override public function resize():void {
            super.resize();

            _modal.width = MonstroConsts.gameWidth;
            _modal.height = MonstroConsts.gameHeight;

            _displayGroup.alignCenter();
            _displayGroup.alignMiddle();
        }
    }
}