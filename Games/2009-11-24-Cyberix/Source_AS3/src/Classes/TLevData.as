	package Classes{
	import Classes.Menu.TAchievementsPanel;
	import Classes.Scenes.*;

	import Editor.MakeText;
	import Editor.MakeText3;
	import Editor.MakeThumbnail;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.utils.getTimer;

	public class TLevData extends Sprite{
		public static var tooltip:TextField
		public static var lastSelected:TLevData
		public var nam:String
		public var author:String
		public var code:String
		public var id:String

		public var thumbnail:*

		public var nameTextField:TextField
		public var authorTextField:TextField

		public var isSelected:Boolean = false
		public var scribbler:Shape = new Shape

		public var isFauxLevel: Boolean = false;

		private var tim:uint = 0
		public function TLevData(_id: String, _name:String, _author:String, _code:String):void{
			id = _id;
			nam = _name
			author = _author
			code = _code

			nameTextField = MakeText(_name, 12)
			authorTextField = MakeText(_author ? "by " + _author : '', 12)
			addChild(scribbler)
			addChild(nameTextField)
			addChild(authorTextField)

			thumbnail = new Bitmap(MakeThumbnail(_code,true))
			addChild(thumbnail)

			nameTextField.x = 82
			nameTextField.y = 2
			authorTextField.x = 82
			authorTextField.y = 50
			if (TAchievementsPanel.isLevelCompleted(id)){
				scribbler.graphics.beginFill(0x00FF00,0.2)
				scribbler.graphics.drawRect(0,0,499,76)
			}
			scribbler.graphics.beginFill(0)
			scribbler.graphics.drawRect(0,0,76,76)
			scribbler.graphics.endFill()

			graphics.beginFill(0,0)
			graphics.drawRect(0,0,499,76)
			graphics.endFill()

			addEventListener(MouseEvent.CLICK,mClick,false,0,true)
			addEventListener(MouseEvent.ROLL_OVER,mOver,false,0,true)
			addEventListener(MouseEvent.ROLL_OUT,mOut,false,0,true)
		}
		private function thumbLoaded(e:Event):void{
			var m:Shape = new Shape
			m.graphics.beginFill(0)
			m.graphics.drawRect(1,1,74,74)
			m.graphics.endFill()
			addChild(m)
			thumbnail.width = 99
			thumbnail.height = 74
			thumbnail.mask = m
			thumbnail.x=-11.
			thumbnail.y = 1
			addChild(thumbnail)
		}
		private function mClick(e:MouseEvent):void{
			SFX.Play("menu click 2")
			if (lastSelected){lastSelected.unselect()}
			select()
			if (getTimer() - tim < 300){
				var s:TScene = Game.curScene
				if (s as TCustomScene){
					(s as TCustomScene).onClickPlay(null)
				} else if (s as TCampaignScene){
					(s as TCampaignScene).onClickPlay(null)
				}else if (s as TSelfmadeScene){
					(s as TSelfmadeScene).onClickPlay(null)
				}
				return;
			}
			tim = getTimer()

		}
		private function mOver(e:MouseEvent):void{
			if (!isSelected){
				SFX.Play("menu hover 2")
				graphics.clear()
				graphics.beginFill(0,0)
				graphics.drawRect(0,0,499,76)
				graphics.endFill()
				graphics.lineStyle(3,0xFFFFFF)
				graphics.drawRect(-3,-3,504,81)
				graphics.endFill()
			}
		}
		private function mOut(e:MouseEvent):void{
			if (!isSelected){
				graphics.clear()
				graphics.beginFill(0,0)
				graphics.drawRect(0,0,499,76)
				graphics.endFill()
			}
		}
		public function select():void{
			isSelected = true
			lastSelected = this
			graphics.clear()
			graphics.beginFill(0xFFFFFF,0.3)
			graphics.drawRect(0,0,499,76)
			graphics.endFill()
		}
		public function unselect():void{
			isSelected = false
			graphics.clear()
			graphics.beginFill(0,0)
			graphics.drawRect(0,0,499,76)
			graphics.endFill()
		}
	}
}