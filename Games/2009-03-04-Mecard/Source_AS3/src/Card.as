package{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import mx.core.BitmapAsset;

	public class Card extends Sprite{
		[Embed("/../assets/gfx/card_back.png")] private var gb:Class;
		[Embed("/../assets/gfx/card_00.png")] private var g00:Class;
		[Embed("/../assets/gfx/card_01.png")] private var g01:Class;
		[Embed("/../assets/gfx/card_02.png")] private var g02:Class;
		[Embed("/../assets/gfx/card_03.png")] private var g03:Class;
		[Embed("/../assets/gfx/card_04.png")] private var g04:Class;
		[Embed("/../assets/gfx/card_05.png")] private var g05:Class;
		[Embed("/../assets/gfx/card_06.png")] private var g06:Class;
		[Embed("/../assets/gfx/card_07.png")] private var g07:Class;
		[Embed("/../assets/gfx/card_08.png")] private var g08:Class;
		[Embed("/../assets/gfx/card_09.png")] private var g09:Class;
		[Embed("/../assets/gfx/card_10.png")] private var g10:Class;
		[Embed("/../assets/gfx/card_11.png")] private var g11:Class;
		[Embed("/../assets/gfx/card_12.png")] private var g12:Class;
		[Embed("/../assets/gfx/card_13.png")] private var g13:Class;
		[Embed("/../assets/gfx/card_14.png")] private var g14:Class;
		[Embed("/../assets/gfx/card_15.png")] private var g15:Class;
		[Embed("/../assets/gfx/card_16.png")] private var g16:Class;
		[Embed("/../assets/gfx/card_17.png")] private var g17:Class;
		[Embed("/../assets/gfx/card_18.png")] private var g18:Class;
		[Embed("/../assets/gfx/card_19.png")] private var g19:Class;
		public var type:uint
		public var back:BitmapAsset
		public var fore:BitmapAsset
		public var state:uint=0
		public function Card(_x:uint,_y:uint,_t:uint){
			x=_x*54+27
			y=_y*86+56
			type=_t
			fore=Cls(_t)
			fore.x=-27
			fore.smoothing=true
			back=new gb;
			back.x=-27
			back.smoothing=true
			addChild(fore)
			addChild(back)
			fore.visible=false
			this.addEventListener(MouseEvent.CLICK,click)
			buttonMode=true
			Mecard.layer.addChild(this)
		}
		private function click(e:MouseEvent):void{
			CardHandler.Flip(this)
		}
		public function Kill():void{
			this.removeEventListener(MouseEvent.CLICK,click)
			Mecard.layer.removeChild(this)
		}
		private function Cls(_t:uint):BitmapAsset{
			switch(_t){
				case(0):return new g00;
				case(1):return new g01;
				case(2):return new g02;
				case(3):return new g03;
				case(4):return new g04;
				case(5):return new g05;
				case(6):return new g06;
				case(7):return new g07;
				case(8):return new g08;
				case(9):return new g09;
				case(10):return new g10;
				case(11):return new g11;
				case(12):return new g12;
				case(13):return new g13;
				case(14):return new g14;
				case(15):return new g15;
				case(16):return new g16;
				case(17):return new g17;
				case(18):return new g18;
				case(19):return new g19;
			}
			return new g00;
		}
	}
}