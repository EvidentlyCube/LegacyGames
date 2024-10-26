/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 24.02.13
 * Time: 12:21
 * To change this template use File | Settings | File Templates.
 */
package submuncher.core.display {
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;

    import net.retrocade.retrocamel.display.flash.RetrocamelGrid9Starling;
    import net.retrocade.retrocamel.display.starling.RetrocamelButtonStarling;

    import starling.events.TouchEvent;

    import submuncher.core.constants.Gfx;

    public class SubmuncherButton extends RetrocamelButtonStarling{
        public var backgroundNormal:RetrocamelGrid9Starling;
        public var backgroundOver:RetrocamelGrid9Starling;
        public var backgroundDisabled:RetrocamelGrid9Starling;

        protected var _isDuringHover:Boolean = false;

        override protected function onTouch(e:TouchEvent):void {
            super.onTouch(e);

            e.stopImmediatePropagation();
        }

        protected var _isDuringClick:Boolean = false;

        public function SubmuncherButton(onClick:Function) {
            super(onClick);


            backgroundNormal = Gfx.createButtonGrid9();
            backgroundOver = Gfx.createButtonOverGrid9();
            backgroundDisabled = Gfx.createButtonDisabledGrid9();

            addChild(backgroundNormal);
            addChild(backgroundOver);
            addChild(backgroundDisabled);

            backgroundOver.visible = false;
            backgroundDisabled.visible = false;
        }

        protected function set backgroundWidth(value:Number):void{
            backgroundDisabled.width = value | 0;
            backgroundOver.width = value | 0;
            backgroundNormal.width = value | 0;
        }

        protected function set backgroundHeight(value:Number):void{
            backgroundDisabled.height = value | 0;
            backgroundOver.height = value | 0;
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
            backgroundOver.visible = false;
            backgroundDisabled.visible = true;
        }

        override protected function effectEnabled():void{
            backgroundNormal.visible = true;
            backgroundOver.visible = false;
            backgroundDisabled.visible = false;
        }

        override protected function rollOverEffect():void{
            if (!enabled){
                return;
            }

            _isDuringHover = true;

            backgroundNormal.visible = false;
            backgroundOver.visible = true;
            backgroundDisabled.visible = false;

            Mouse.cursor = MouseCursor.BUTTON;
        }

        override protected function rollOutEffect():void{
            _isDuringHover = false;

            Mouse.cursor = MouseCursor.AUTO;

            if (_isDuringClick || !enabled){
                return;
            }

            backgroundNormal.visible = true;
            backgroundOver.visible = false;
            backgroundDisabled.visible = false;

        }

        override protected function clickEffect():void{
            rollOutEffect();
            _isDuringClick = true;
            _isDuringHover = false;

            if (!enabled){
                return;
            }

            Mouse.cursor = MouseCursor.AUTO;

            backgroundNormal.visible = false;
            backgroundOver.visible = true;
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
            backgroundOver.visible = false;
            backgroundDisabled.visible = false;
        }
    }
}
