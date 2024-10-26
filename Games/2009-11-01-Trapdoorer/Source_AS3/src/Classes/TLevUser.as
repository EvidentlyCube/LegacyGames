package Classes{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.LoaderContext;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class TLevUser extends Sprite{
		private var levelName: TextField

		public function TLevUser(_name: String=""){
			levelName = new TextField;
			levelName.width = 180
			levelName.mouseEnabled = false
			levelName.x = 315
			levelName.y = 53
			levelName.embedFonts = true
			levelName.selectable = false
			levelName.antiAliasType = AntiAliasType.ADVANCED
			levelName.htmlText = "<p align='right'><font face='fonter' color='#FFFFFF' size='12'>"+_name+"</font></p>";
			levelName.autoSize = TextFieldAutoSize.NONE
			levelName.filters = [ new DropShadowFilter(2, 45, 0,1, 2,2, 1) ];
			levelName.height = 20
			addChild(levelName)
		}
	}
}