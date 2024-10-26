package Classes.Menu{
	import Classes.Grid9;
	import Classes.MenuButton;
	import Editor.MakeText
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.events.Event
	public class TSelectWindow extends TWindow{
		private var title:TextField
		private var content:TextField
		private var o1:MenuButton
		private var o2:MenuButton
		private var o3:MenuButton
		private var o4:MenuButton
		private var o5:MenuButton
		private var bg:Grid9
		public function TSelectWindow(mess:String,opt1:String = "",opt2:String = "",opt3:String = "",opt4:String = "",opt5:String = ""){
			title = MakeText("<p align='center'>Attention!</p>",22)

			content = MakeText("<p align='center'>"+mess + "</p>",18)
			content.y = 40

			var opts:uint = 0
			if (opt1){opts++}
			if (opt2){opts++}
			if (opt3){opts++}
			if (opt4){opts++}
			if (opt5){opts++}

			bg = new Grid9(TWindow.Grid9DataMenu)
			bg.width = Math.max(150,content.width + 20)
			bg.height = Math.max(100,content.height + 60 + 40 * opts)

			addChild(bg)

			if (opt1){
				o1 = new MenuButton(opt1,18)
				o1.x = width / 2-o1.width / 2+6
				o1.y = 60 + content.height
				addChild(o1)
				o1.addEventListener(MouseEvent.CLICK,o1Click)
			}
			if (opt2){
				o2 = new MenuButton(opt2,18)
				o2.x = width / 2-o2.width / 2+6
				o2.y = 100 + content.height
				addChild(o2)
				o2.addEventListener(MouseEvent.CLICK,o2Click)
			}
			if (opt3){
				o3 = new MenuButton(opt3,18)
				o3.x = width / 2-o3.width / 2+6
				o3.y = 140 + content.height
				addChild(o3)
				o3.addEventListener(MouseEvent.CLICK,o3Click)
			}
			if (opt4){
				o4 = new MenuButton(opt4,18)
				o4.x = width / 2-o4.width / 2+6
				o4.y = 180 + content.height
				addChild(o4)
				o4.addEventListener(MouseEvent.CLICK,o4Click)
			}
			if (opt5){
				o5 = new MenuButton(opt5,18)
				o5.x = width / 2-o5.width / 2+6
				o5.y = 220 + content.height
				addChild(o5)
				o5.addEventListener(MouseEvent.CLICK,o5Click)
			}

			x = 300 - width / 2
			y = 300 - height / 2
			title.x = width / 2-title.width / 2
			content.x = width / 2-content.width / 2

			addChild(title)
			addChild(content)
			WindowHandler.newWindow(this)
		}
		public function o1Click(e:MouseEvent):void{
			this.dispatchEvent(new Event(TWindow.CHOICE1))
			kill()
		}
		public function o2Click(e:MouseEvent):void{
			this.dispatchEvent(new Event(TWindow.CHOICE2))
			kill()
		}
		public function o3Click(e:MouseEvent):void{
			this.dispatchEvent(new Event(TWindow.CHOICE3))
			kill()
		}
		public function o4Click(e:MouseEvent):void{
			this.dispatchEvent(new Event(TWindow.CHOICE4))
			kill()
		}
		public function o5Click(e:MouseEvent):void{
			this.dispatchEvent(new Event(TWindow.CHOICE5))
			kill()
		}
		public function kill():void{
			if (o1){o1.removeEventListener(MouseEvent.CLICK,o1Click)}
			if (o2){o2.removeEventListener(MouseEvent.CLICK,o2Click)}
			if (o3){o3.removeEventListener(MouseEvent.CLICK,o3Click)}
			if (o4){o4.removeEventListener(MouseEvent.CLICK,o4Click)}
			if (o5){o5.removeEventListener(MouseEvent.CLICK,o5Click)}
			WindowHandler.popWindow()
		}
	}
}
