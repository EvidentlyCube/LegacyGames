
package net.retrocade.tacticengine.monstro.gui.render {
    import net.retrocade.retrocamel.display.starling.RetrocamelButtonStarling;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;

    import starling.events.TouchEvent;

    public class MonstroButton extends RetrocamelButtonStarling{
		public static const COLOR_BLUE:uint = 0;
		public static const COLOR_RED:uint = 1;
		public static const COLOR_GREEN:uint = 2;

        public var backgroundNormal:MonstroGrid9;
        public var backgroundLit:MonstroGrid9;
        public var backgroundDisabled:MonstroGrid9;

        protected var _isDuringHover:Boolean = false;

        override protected function onTouch(e:TouchEvent):void {
            super.onTouch(e);

            e.stopImmediatePropagation();
        }

        protected var _isDuringClick:Boolean = false;

        public function MonstroButton(onClick:Function, color:uint = COLOR_BLUE) {
            super(onClick);


			if (color === COLOR_RED){
				backgroundNormal = MonstroGfx.getGrid9ButtonRed();
				backgroundLit = MonstroGfx.getGrid9ButtonRedHilite();
			} else if (color === COLOR_GREEN){
				backgroundNormal = MonstroGfx.getGrid9ButtonGreen();
				backgroundLit = MonstroGfx.getGrid9ButtonGreenHilite();
			} else {
				backgroundNormal = MonstroGfx.getGrid9Button();
				backgroundLit = MonstroGfx.getGrid9ButtonHilite();

			}
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

            MonstroSfx.playButtonClick();
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
