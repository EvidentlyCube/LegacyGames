/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 24.02.13
 * Time: 12:21
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.render {
    import net.retrocade.standalone.MobileButton;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;

    public class MonstroButton extends MobileButton{
        public var backgroundNormal:MonstroGrid9;
        public var backgroundLit:MonstroGrid9;
        public var backgroundDisabled:MonstroGrid9;

        protected var _isDuringHover:Boolean = false;
        protected var _isDuringClick:Boolean = false;

        public function MonstroButton(onClick:Function) {
            super(onClick);

            backgroundNormal = MonstroGfx.getGrid9Button();
            backgroundLit = MonstroGfx.getGrid9ButtonHilite();
            backgroundDisabled = MonstroGfx.getGrid9ButtonDisabled();

            addChild(backgroundNormal);
            addChild(backgroundLit);
            addChild(backgroundDisabled);

            backgroundLit.visible = false;
            backgroundDisabled.visible = false;
        }

        protected function set backgroundWidth(value:Number):void{
            backgroundDisabled.width = value | 0;
            backgroundLit.width = value | 0;
            backgroundNormal.width = value | 0;
        }

        protected function set backgroundHeight(value:Number):void{
            backgroundDisabled.height = value | 0;
            backgroundLit.height = value | 0;
            backgroundNormal.height = value | 0;
        }

        protected function get backgroundWidth():Number{
            return backgroundNormal.width;
        }

        protected function get backgroundHeight():Number{
            return backgroundNormal.height;
        }

        override public function set x(value:Number):void{
            super.x = value | 0;
        }

        override public function set y(value:Number):void{
            super.y = value | 0;
        }

        override protected function effectDisabled():void{
            if (_isDuringClick){
                return;
            }

            _isDuringHover = false;

            backgroundNormal.visible = false;
            backgroundLit.visible = false;
            backgroundDisabled.visible = true;
        }

        override protected function effectEnabled():void{
            backgroundNormal.visible = true;
            backgroundLit.visible = false;
            backgroundDisabled.visible = false;
        }

        override protected function rollOverEffect():void{
            if (!enabled){
                return;
            }

            _isDuringHover = true;

            backgroundNormal.visible = false;
            backgroundLit.visible = true;
            backgroundDisabled.visible = false;
        }

        override protected function rollOutEffect():void{
            _isDuringHover = false;

            if (_isDuringClick || !enabled){
                return;
            }

            backgroundNormal.visible = true;
            backgroundLit.visible = false;
            backgroundDisabled.visible = false;
        }

        override protected function clickEffect():void{
            _isDuringClick = true;
            _isDuringHover = false;

            if (!enabled){
                return;
            }

            backgroundNormal.visible = false;
            backgroundLit.visible = true;
            backgroundDisabled.visible = false;
        }

        override protected function unclickEffect():void{
            _isDuringClick = false;

            if (!enabled){
                effectDisabled();
                return;
            }

            if (_isDuringHover){
                return;
            }

            backgroundNormal.visible = true;
            backgroundLit.visible = false;
            backgroundDisabled.visible = false;
        }
    }
}
