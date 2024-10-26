package game.global {
    import flash.events.MouseEvent;
    import flash.filters.DropShadowFilter;
    import game.interfaces.TDrodButton;

    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UGraphic;

	/**
     * @author ...
     */
    public class Make {
        public static function buttonColor(onClick:Function, text:String):Button {
            return new TDrodButton(onClick, text);
        }

        public static function text(fontSize:uint = 14, color:uint = 0):Text{
            return new Text("", C.FONT_FAMILY, fontSize, color);
        }
    }
}