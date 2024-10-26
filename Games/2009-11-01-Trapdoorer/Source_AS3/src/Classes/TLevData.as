	package Classes{
	import Classes.Menu.TAchievementsPanel;
	import Classes.Scenes.TCampaignScene;
	import Classes.Scenes.TCustomScene;
	import Classes.Scenes.TSelfmadeScene;
	import Classes.Scenes.TScene;

	import Editor.MakeText;
	import Editor.MakeText3;
	import Editor.MakeThumbnail;

	import flash.utils.getTimer;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	public class TLevData extends Sprite{
		public static var campaign: Array = new Array()
		public static var lastSelected: TLevData
		public var levelName: String;
		public var author: String;
		public var code: String;
		public var id: String;

		public var image:*

		public var user: TLevUser

		public var tfName: TextField

		public var isSelected: Boolean = false
		public var scribbler: Shape = new Shape

		private var lastClickTime: uint = 0
		public function TLevData(
			_id: String,
			_name: String,
			_author: String,
			_code: String
		): void {
			id = _id;
			levelName = _name
			author = _author
			code = _code

			user = new TLevUser(author)
			tfName = MakeText(levelName, 12)
			addChild(scribbler)
			addChild(user)
			addChild(tfName)

			if (code) {
				image = new Bitmap(MakeThumbnail(code, true))
				addChild(image)
			}

			tfName.x = 82;
			tfName.y = 2;
			tfName.height = 1;

			if (TAchievementsPanel.isLevelCompleted(id)){
				scribbler.graphics.beginFill(0x00FF00, 0.2)
				scribbler.graphics.drawRect(0, 0,499, 76)
			}

			scribbler.graphics.beginFill(0)
			scribbler.graphics.drawRect(0, 0,76, 76)
			scribbler.graphics.endFill()

			graphics.beginFill(0, 0)
			graphics.drawRect(0, 0,499, 76)
			graphics.endFill()

			addEventListener(MouseEvent.CLICK, onClick, false, 0, true)
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0,true)
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0,true)
		}

		private function onClick(e: MouseEvent): void{
			if (lastSelected){
				lastSelected.unselect();
			}

			select();

			if (getTimer() - lastClickTime < 300){
				if (TD.curScene as TCustomScene){
					(TD.curScene as TCustomScene).clickPlay(null)
				} else if (TD.curScene as TCampaignScene){
					(TD.curScene as TCampaignScene).clickPlay(null)
				} else if (TD.curScene as TSelfmadeScene){
					(TD.curScene as TSelfmadeScene).clickEditLevel(null)
				}
				return;
			}

			lastClickTime = getTimer()
		}
		private function onMouseOver(e: MouseEvent): void{
			if (!isSelected){
				graphics.clear()
				graphics.beginFill(0, 0)
				graphics.drawRect(0, 0,499, 76)
				graphics.endFill()
				graphics.lineStyle(3, 0xFFFFFF)
				graphics.drawRect(-3, -3, 504, 81)
				graphics.endFill()
			}
		}
		private function onMouseOut(e: MouseEvent): void{
			if (!isSelected){
				graphics.clear()
				graphics.beginFill(0, 0)
				graphics.drawRect(0, 0,499, 76)
				graphics.endFill()
			}
		}
		public function select(): void{
			isSelected = true
			lastSelected = this
			graphics.clear()
			graphics.beginFill(0xFFFFFF, 0.3)
			graphics.drawRect(0, 0,499, 76)
			graphics.endFill()
		}
		public function unselect(): void{
			isSelected = false
			graphics.clear()
			graphics.beginFill(0, 0)
			graphics.drawRect(0, 0,499, 76)
			graphics.endFill()
		}

		public function completed(): void{
			scribbler.graphics.clear()
			scribbler.graphics.beginFill(0x00FF00, 0.2)
			scribbler.graphics.drawRect(0, 0,499, 76)
			scribbler.graphics.beginFill(0)
			scribbler.graphics.drawRect(0, 0,76, 76)
			scribbler.graphics.endFill()
		}
	}
}