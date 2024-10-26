package Classes{
	import Editor.MakeText3;

	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	import flash.ui.Keyboard;

	import mx.core.BitmapAsset;

	public dynamic class Loading extends MovieClip{
		[Embed("../../assets/sfx/menu_click_1.mp3")] public static var menu_click_1:Class;
		[Embed("../../assets/sfx/menu_hover_1.mp3")] public static var menu_hover_1:Class;
		[Embed(source = "../../assets/fonts/centurygothic/centurygothic.ttf",fontFamily = "fonter",embedAsCFF = "false")] private var fonter:Class;
		[Embed("../../assets/gfx/ui/load.jpg")]		private var g_load:Class;
		[Embed("../../assets/gfx/ui/load_bar.png")]	private var g_loadbar:Class;
		public static var barGrid9:Grid9Data
		public static var self:Loading
		private var back:BitmapAsset
		private var back_bar:Grid9
		private var txt:TextField
		private var app:Object
		public function Loading(){
			self = this
			back = new g_load
			var b:BitmapAsset = new g_loadbar
			barGrid9 = new Grid9Data(b.bitmapData,new Rectangle(9,1,1,5))
			back_bar = new Grid9(barGrid9)

			txt = Editor.MakeText3("Loading...",24,"center",600)
			txt.y = 280

			addChild(back)
			addChild(back_bar)
			addChild(txt)

			back_bar.x = 60
			back_bar.y = 319

			back_bar.width = 490

			SimpleSave.setStorage('cyberix-1');
			SFX.sfx = SimpleSave.read('option-sfx', 1) !== 0;
			SFX.mus = SimpleSave.read('option-music', 1) !== 0;

			//stage.showDefaultContextMenu = false
			addEventListener(Event.ENTER_FRAME,step)

			ModernDisplay.Init(this, stage, 600, 600);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:*): void {
				if (e.keyCode === Keyboard.S) {
					if (SFX.sfx){
						SFX.sfx = false
					} else {
						SFX.sfx = true
					}

					SimpleSave.writeFlush('option-sfx', SFX.mus ? 1 : 0);
				}
				if (e.keyCode === Keyboard.M) {
					if (SFX.mus){
						SFX.mus = false
					} else {
						SFX.mus = true
					}

					SimpleSave.writeFlush('option-music', SFX.mus ? 1 : 0);
				}
			});
		}
		public function step(e:Event):void{
			var p:Number = stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal
			back_bar.width = Math.max(10,Math.round(490 * p))

			if (p >= 0.995){
				removeEventListener(Event.ENTER_FRAME,step)
				removeChild(txt)
				txt = Editor.MakeText3("Click to play",42,"center",600)
				txt.y = 305
				txt.mouseEnabled = false
				addChild(txt)
				back_bar.addEventListener(MouseEvent.ROLL_OVER,function():void{
					if (SFX.sfx) {
						(new menu_hover_1).play()
					}
				})
				back_bar.addEventListener(MouseEvent.CLICK,click)
				back_bar.buttonMode = true
			}
		}
		public function click(e:MouseEvent):void{
			if (SFX.sfx) {
				(new menu_click_1).play()
			}
			removeChild(txt)
			removeChild(back)
			removeChild(back_bar)
			buttonMode = false
			back_bar.removeEventListener(MouseEvent.CLICK,click)
			nextFrame();
			var mainClass:Class = Class(getDefinitionByName("Game"));
			if(mainClass){
				app = new mainClass();
				addChild(app as DisplayObject)
			}
		}
	}
}