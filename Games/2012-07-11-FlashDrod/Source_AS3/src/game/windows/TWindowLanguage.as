package game.windows {
    import flash.filters.DropShadowFilter;
    import flash.filters.GlowFilter;
	import net.retrocade.camel.core.rSave;
	import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.rLang;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Text;
	
	/**
     * ...
     * @author ...
     */
    public class TWindowLanguage extends rWindow {
        private var buttons:Array = [];

        public function TWindowLanguage() {
            var txt:Text;
            var but:Button;

            var lastY:uint = 0;

            for (var i:uint = 0, l:uint = S.LANGUAGES.length; i < l; i++ ) {
                txt = new Text("", C.FONT_FAMILY, 48, 0xFFFFFF)
                txt.text = S.LANGUAGES_NAMES[i];
                txt.color = 0xFFFFFF;
                txt.filters = [ new GlowFilter(0, 1, 3, 3, 4), new DropShadowFilter(4, 45, 0, 1, 2, 2, 0.5) ];

                but = new Button(onSelectLanguage);
                but.addChild(txt);
                but.data = S.LANGUAGES[i];

                buttons.push(but);

                addChild(but);

                but.y = lastY;

                lastY += but.height;
            }

            for each(but in buttons) {
                but.alignCenterParent(0, width);
            }

            center();

            graphics.beginFill(0, 0.75);
            graphics.drawRect( -x, -y, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT);

            show();
        }

        private function onSelectLanguage(data:Button):void {
            rLang.selected = data.data.toString();
			
			rSave.setStorage(S.SAVE_OPTIONS_STORAGE);
			rSave.write("lang", rLang.selected);
			rSave.setStorage(S.SAVE_STORAGE_NAME);
			
            close();
        }
    }
}