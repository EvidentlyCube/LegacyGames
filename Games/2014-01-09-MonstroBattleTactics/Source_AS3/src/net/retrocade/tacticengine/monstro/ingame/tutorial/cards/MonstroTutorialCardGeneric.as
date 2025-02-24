
package net.retrocade.tacticengine.monstro.ingame.tutorial.cards {
    import flash.utils.getTimer;

    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroData;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroGrid9;

    import starling.display.Image;

    import starling.text.TextField;

    public class MonstroTutorialCardGeneric extends MonstroTutorialCardBase {
        private static const EDGE:int = MonstroConsts.hudSpacer | 0;

        public var funcCheckIfAppear:Function;
        public var funcCheckIfHide:Function;
        public var funcOnAppear:Function;
        public var funcOnHide:Function;
        public var funcUpdate:Function;
        public var data:Object;
        private var _id:int;
        private var _requiresConstantUpdate:Boolean;

        private var _background:MonstroGrid9;
        private var _text:TextField;
        private var _iconQuestion:Image;
        private var _iconArrow:Image;

        private var _image:Image;

        public function MonstroTutorialCardGeneric(){}

        public function initCard(id:int, constantUpdate:Boolean):void {
            _id = id;
            _requiresConstantUpdate = constantUpdate;

            data = MonstroData.getTutorialData(_id);


            _background = MonstroGfx.getGrid9Window();
            _background.width = 350;
            _background.height = 80;

            _iconQuestion = MonstroGfx.getQuestionMark();
            _iconArrow = MonstroGfx.getArrowRight();

            _text = new TextField(
                _background.width - 10 - _iconArrow.width / 2 - _iconQuestion.width * 2,
                _background.height - EDGE * 2,
                "",
                MonstroConsts.FONT_EBORACUM_48,
                16,
                0xFFFFFF
            );

            addChild(_background);
            addChild(_iconQuestion);
            addChild(_iconArrow);
            addChild(_text);

            _iconQuestion.x = 8;
            _iconArrow.right = width - 8;

            _iconQuestion.alignMiddleParent();
            _iconArrow.alignMiddleParent();

            _text.alignCenterParent();
            _text.alignMiddleParent();

            useHandCursor = true;

            visible = false;
            alpha = 0;
        }

        override public function dispose():void {
            _background.dispose();
            _text.dispose();
            _iconQuestion.dispose();
            _iconArrow.dispose();

            _background = null;
            _text = null;
            _iconQuestion = null;
            _iconArrow = null;

            MonstroData.setTutorialData(_id, data);
            funcCheckIfAppear = null;
            funcCheckIfHide = null;
            funcOnAppear = null;
            funcOnHide = null;
            data = null;

            super.dispose();
        }

        override public function checkIfAppear():Boolean {
            return funcCheckIfAppear.call(this);
        }

        override public function onAppear():void {
            if (funcOnAppear != null) {
                funcOnAppear.call(this);
            }
        }

        override public function checkIfHide():Boolean {
            return funcCheckIfHide.call(this);
        }

        override public function onHide():void {
            if (funcOnHide != null) {
                funcOnHide.call(this);
            }
        }

        override public function get id():int {
            return _id
        }

        override public function get requiresConstantUpdate():Boolean {
            return _requiresConstantUpdate;
        }

        override public function update():Boolean {
            x = MonstroConsts.gameWidth - _background.width - MonstroConsts.hudSpacer * 2 | 0;
            _iconArrow.right = _background.width + Math.cos(getTimer() / 350) * 12;

            bottom = MonstroConsts.gameHeight - MonstroConsts.bottomBarHeight - MonstroConsts.hudSpacer;

            if (funcUpdate != null){
                return funcUpdate.call(this);
            } else {
                return false;
            }
        }

        public function set valGetText(value:*):void {
            if (value is Function){
                _text.text = value();
            } else {
                _text.text = value.toString();
            }
        }

        public function set image(value:Image):void{
            _image = value;

            addChild(_image);
            _image.middle = _background.middle;
            //noinspection JSSuspiciousNameCombination
            _image.x = _image.y;

            _text.x = _image.right + _image.x;
            _text.width = _background.width - EDGE - _text.x;

            _iconQuestion.visible = false;
        }
    }
}
