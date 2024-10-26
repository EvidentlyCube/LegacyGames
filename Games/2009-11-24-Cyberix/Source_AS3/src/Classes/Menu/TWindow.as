package Classes.Menu{
	import Classes.Grid9Data;

	import flash.display.Sprite;
	import flash.geom.Rectangle;

	import mx.core.BitmapAsset;

	public class TWindow extends Sprite{
		[Embed("../../../assets/gfx/ui/Menu_00.png")] public static var gfx_menu:Class;
		[Embed("../../../assets/gfx/ui/Menu_01.png")] public static var gfx_textfield:Class;
		[Embed("../../../assets/gfx/ui/Menu_02.png")] public static var gfx_button:Class;
		[Embed("../../../assets/gfx/ui/Menu_04.png")] public static var gfx_rect:Class;
		public static const CLOSED:String = "closed"
		public static const CANCEL:String = "cancel"
		public static const OK:String = "ok"
		public static const CHOICE1:String = "choice1"
		public static const CHOICE2:String = "choice2"
		public static const CHOICE3:String = "choice3"
		public static const CHOICE4:String = "choice4"
		public static const CHOICE5:String = "choice5"
		public static var Grid9DataMenu:Grid9Data
		public static var Grid9DataTextfield:Grid9Data
		public static var Grid9DataButton:Grid9Data
		public function TWindow(){
			var bit:BitmapAsset = new gfx_menu
			Grid9DataMenu = new Grid9Data(bit.bitmapData,new Rectangle(10,46,520,494))
			bit = new gfx_textfield
			Grid9DataTextfield = new Grid9Data(bit.bitmapData,new Rectangle(1,1,34,27))
			bit = new gfx_button
			Grid9DataButton = new Grid9Data(bit.bitmapData,new Rectangle(13,11,92,20))
		}
		public function drawWindow(wid:uint,hei:uint):void{
			if (wid > 600){wid = 600} else if (wid < 150){wid = 150}
			if (hei > 600){hei = 600} else if (hei < 100){hei = 100}
			graphics.beginFill(0xAAAAAA)
			graphics.drawRoundRect(0,0,wid,hei,24,24)
			graphics.endFill()
		}
	}
}