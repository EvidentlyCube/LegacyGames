package game.windows {
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import game.global.Make;
    import game.global.Sfx;

    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.easings.exponentialIn;
    import net.retrocade.camel.easings.exponentialOut;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffMove;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UDisplay;

    /**
     * ...
     * @author ...
     */
    public class TWinBlocker extends rWindow {
        /****************************************************************************************************************/
        /**                                                                                                     STATIC  */
        /****************************************************************************************************************/

        private static var _instance:TWinBlocker = new TWinBlocker();

        public static function show():void{
            _instance.show();
        }

        public static function close():void{
            _instance.onClose();
        }



        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        public function TWinBlocker() {
            _blockUnder = true;
            _pauseGame  = false;

            var title:Text = new Text("Please wait...", "font", 22, 0xFFFFFF);
            title.setShadow();

            addChild(title);

            center();

            graphics.beginFill(0, 0.75);
            graphics.drawRect(-x, -y, S().gameWidth, S().gameHeight);
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Overrides
        // ::::::::::::::::::::::::::::::::::::::::::::::

        override public function show():void{
            super.show();

            mouseEnabled  = false;
            mouseChildren = false;

            center();

            new rEffFade(this, 0, 1, 400, function():void{
                mouseEnabled  = true;
                mouseChildren = true;
            });
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Callbacks
        // ::::::::::::::::::::::::::::::::::::::::::::::

        private function onClose():void {
            new rEffFade(this, 1, 0, 400, onHideFinish);
            Sfx.click();
        }

        private function onHideFinish():void {
            close();
        }
    }
}