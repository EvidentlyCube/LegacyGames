/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 26.01.13
 * Time: 17:10
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.render {
    import starling.display.Image;

    public class MonstroHudButton extends MonstroButton{
        private var _enabledIcon:Image;
        private var _disabledIcon:Image;

        public function MonstroHudButton(enabledIcon:Image, disabledIcon:Image, callback:Function){
            super(callback);

            _enabledIcon = enabledIcon;
            _disabledIcon = disabledIcon;

            addChild(_enabledIcon);

            if (_disabledIcon){
                _disabledIcon.visible = false;
                addChild(_disabledIcon);

            }

            width = 50;
            height = 50;

            clickEffectDuration = 50;
        }

        override protected function effectDisabled():void{
            if (_isDuringClick){
                return;
            }

            if (_disabledIcon){
                _enabledIcon.visible = false;
                _disabledIcon.visible = true;
            }

            super.effectDisabled();
        }

        override protected function effectEnabled():void{

            if (_disabledIcon){
                _enabledIcon.visible = true;
                _disabledIcon.visible = false;
            }

            super.effectEnabled();
        }

        override public function set width(value:Number):void{
            backgroundDisabled.width = value;
            backgroundLit.width = value;
            backgroundNormal.width = value;

            var iconRealWidth:Number;

            iconRealWidth = _enabledIcon.width / _enabledIcon.scaleX;
            _enabledIcon.scaleX = backgroundNormal.width / iconRealWidth;
            _enabledIcon.x = (backgroundNormal.width - _enabledIcon.width) / 2;

            if (_disabledIcon){
                iconRealWidth = _disabledIcon.width / _disabledIcon.scaleX;
                _disabledIcon.scaleX = backgroundNormal.width / iconRealWidth;
                _disabledIcon.x = (backgroundNormal.width - _enabledIcon.width) / 2;
            }
        }

        override public function set height(value:Number):void{
            backgroundDisabled.height = value;
            backgroundLit.height = value;
            backgroundNormal.height = value;

            var iconRealHeight:Number;

            iconRealHeight = _enabledIcon.height / _enabledIcon.scaleY;
            _enabledIcon.scaleY = backgroundNormal.height / iconRealHeight;
            _enabledIcon.y = (backgroundNormal.height - _enabledIcon.height) / 2;

            if (_disabledIcon){
                iconRealHeight = _disabledIcon.height / _disabledIcon.scaleY;
                _disabledIcon.scaleY = backgroundNormal.height / iconRealHeight;
                _disabledIcon.y = (backgroundNormal.height - _disabledIcon.height) / 2;
            }
        }

        override public function get width():Number{
            return backgroundNormal.width;
        }

        override public function get height():Number{
            return backgroundNormal.height;
        }
    }
}
