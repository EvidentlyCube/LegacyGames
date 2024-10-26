package Classes.Menu{
	import Classes.MenuButton;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import mx.core.BitmapAsset;

	public class THelpMenu extends TMenu{
		[Embed("../../../assets/gfx/ui/Help.png")] private var g_00:Class
		[Embed("../../../assets/gfx/ui/Help2.png")] private var g_01:Class
		public var cont:BitmapAsset
		public var button:MenuButton
		public var animate:int=-1
		public function THelpMenu(alt:Boolean = false){
			visible = false
			alpha = 0
			graphics.beginFill(0,0.9)
			graphics.drawRect(-50,-50,600,600)

			x = y=50

			if (!alt){cont = new g_00} else {cont = new g_01}

			button = new MenuButton("  Continue  ",18)
			button.x = 250 - button.width / 2+9
			button.y = 460
			button.addEventListener(MouseEvent.CLICK,clicked)

			addChild(button)
			addChild(cont)
		}
		public function clicked(e:MouseEvent):void{
			animate=-1
		}
		public function update(e:Event = null):void{
			if (animate > 0){
				if (alpha < 1){
					alpha += 0.05
					visible = true
				}
			} else if (animate < 0){
				if (alpha > 0){
					alpha -= 0.05
				} else {visible = false}
			}
		}

	}
}