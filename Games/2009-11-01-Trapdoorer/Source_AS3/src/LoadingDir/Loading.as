package LoadingDir{

	import Classes.BGHandler;
	import Classes.Grid9;
	import Classes.Menu.TWindow;
	import Classes.MenuButton;
	import Classes.SFX;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.LocalConnection;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;

	import mx.core.BitmapAsset;
	public dynamic class Loading extends MovieClip{

		[Embed(source="../../assets/fonts/madame-butterfly/Madame_Butterfly.ttf", fontFamily="fonter", embedAsCFF="false")] private var fonter: Class;
		[Embed("../../assets/gfx/by_maurycy/ui/Logo.png")] public static var g_logo: Class;

		public var app: Object
		private var logo: BitmapAsset
		private var txt: TextField = new TextField
		private var g9: Grid9
		private var startGameButton: MenuButton
		private var lc: LocalConnection
		public static var lc: LocalConnection = new LocalConnection();
		private var g: Sprite = new Sprite
		public static var FAILED: Boolean = false
		public static var self: Loading
		public function Loading(){
			SimpleSave.setStorage('trapdoorer-v2');
			SFX.soundOn = SimpleSave.read('option-sfx', 1);

			new TWindow()
			new BGHandler(stage)
			new SFX(stage)
			SFX.musicOn = 0

			logo = new g_logo
			self = this
			g9 = new Grid9(TWindow.Grid9DataMenu)
			g9.width = 500
			g9.height = 100
			g9.x = 50
			g9.y = 420
			txt = new TextField
			txt.embedFonts = true
			txt.selectable = false
			txt.textColor = 0xFFFFFF
			txt.autoSize="center"
			txt.htmlText="<font face='fonter' size='22'>Loaded: 0%</font>"
			txt.x = 300-txt.width/2
			txt.y = 430
			var filArr: Array = txt.filters
			var filShad: DropShadowFilter = new DropShadowFilter(2, 45, 0,1, 2,2, 1)
			filArr.push(filShad);
			txt.filters = filArr
			addChild(BGHandler.Graphic)

			startGameButton = new MenuButton("Start Game", 24, 0,0)
			startGameButton.alpha = 0
			startGameButton.visible = false
			startGameButton.x = 300-startGameButton.width/2+10
			startGameButton.y = 470

			g.addChild(g9)
			g.graphics.beginFill(0, 0)
			g.graphics.drawRect(0, 0,600, 600)
			g.addChild(txt)
			g.addChild(startGameButton)
			g.addChild(logo)

			addChild(g)

			startGameButton.addEventListener(MouseEvent.CLICK, onClick_startGame)
			stage.addEventListener(Event.ENTER_FRAME, onStep)

			ModernDisplay.Init(this, stage, 600, 600);
		}

		public function onClick_startGame(e: MouseEvent): void{
			stage.removeEventListener(Event.ENTER_FRAME, onStep);
			startGameButton.removeEventListener(MouseEvent.CLICK, onClick_startGame);

			removeChild(BGHandler.Graphic)
			nextFrame();
			var mainClass: Class = Class(getDefinitionByName("TD"));
			SFX.musicOn = SimpleSave.read('option-music', 1);

			if (mainClass){
				app = new mainClass();
				addChild(app as DisplayObject)
			}
			removeChild(g)
			g = null
		}

		public function onStep(event: Event): void{
			if (framesLoaded < totalFrames && root.loaderInfo.bytesLoaded < root.loaderInfo.bytesTotal - 1024) {
				var percent: uint=(root.loaderInfo.bytesLoaded/root.loaderInfo.bytesTotal)*100
				txt.htmlText="<font face='fonter' size='22'>Loaded: "+percent+"%</font>"
				txt.x = 300-txt.width/2;

			} else if (!startGameButton.visible) {
				txt.htmlText="<font face='fonter' size='22'>Online services no longer exist.</font>"
				startGameButton.visible = true

				txt.x = 300 - txt.width / 2
				FAILED = true

			} else if (startGameButton.alpha < 1){
				startGameButton.alpha += 0.05
			}
		}
	}
}