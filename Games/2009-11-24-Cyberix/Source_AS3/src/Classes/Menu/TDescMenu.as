package Classes.Menu{
	import Classes.Grid9;
	import Classes.MenuButton;
	import Classes.Scenes.TMenuScene;

	import Editor.MakeText;

	import flash.events.MouseEvent;
	import flash.text.TextField;
	public class TDescMenu extends TMenu{
		public var textLogin:TextField
		public var animate:int
		public var bg:Grid9
		public function TDescMenu(){
			bg = new Grid9(TWindow.Grid9DataMenu)
			bg.width = 270
			bg.height = 270
			addChild(bg)

			x = 315
			y = 150
			textLogin = MakeText("More games by Mauft.com:",19)
			textLogin.x = width / 2-textLogin.width / 2

			addChild(textLogin)
			alpha = 0
			animate = 1
			visible = false

		}
		public function update():void{
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