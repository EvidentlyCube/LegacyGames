package Obs{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;
	import flash.events.KeyboardEvent;

	import mx.core.BitmapAsset;

	public dynamic class Loader extends MovieClip{
		public var app:Object;
		[Embed(source="/../assets/fonts/setback/setbackt.ttf",fontFamily="Fonter", embedAsCFF="false")] private var fonter:Class;
		[Embed(source="/../assets/gfx/logo.jpg")]
		private var GLOGO:Class;
		public var logo:BitmapAsset
		public var gfx:Sprite=new Sprite;
		public var txt:TextField=new TextField
		public var loaded:Boolean=false
		public function Loader(){
			stop();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			logo=new GLOGO;
			logo.x=0
			logo.y=0
			txt.y=400
			txt.embedFonts=true
			txt.autoSize=TextFieldAutoSize.CENTER
			gfx.addChild(logo)
			gfx.addChild(txt)
			addChild(gfx)
			txt.textColor=0xFFFFFF
			txt.scaleX=1
			txt.scaleY=1

			var percent:Number = Math.floor((root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal)*100)/100;
			txt.htmlText="<font face='Fonter' size='30'>"+Math.floor(percent*100)/100+"%</font>";
			txt.x=300-txt.width/2
			gfx.visible=false
			var lox:Sprite=new Sprite
			lox.graphics.beginFill(0xFFFFFF,0.2)
			lox.graphics.drawRect(0,465,156,141)
			lox.buttonMode=true
			lox.alpha=0
			lox.addEventListener(MouseEvent.MOUSE_OVER,function():void{lox.alpha=1})
			lox.addEventListener(MouseEvent.MOUSE_OUT,function():void{lox.alpha=0})
			lox.addEventListener(MouseEvent.CLICK,function():void{openWindow("http://mauft.com","_blank")})
			var vox:Sprite=new Sprite
			vox.graphics.beginFill(0xFFFFFF,0.2)
			vox.graphics.drawRect(0,403,600,31)
			vox.buttonMode=true
			vox.alpha=0
			vox.addEventListener(MouseEvent.MOUSE_OVER,function():void{vox.alpha=1})
			vox.addEventListener(MouseEvent.MOUSE_OUT,function():void{vox.alpha=0})
			vox.addEventListener(MouseEvent.CLICK,clickman)
			gfx.addChild(vox)
			gfx.addChild(lox)
			gfx.visible=true

			ModernDisplay.Init(this, stage, 600, 600);
		}
		public function clickman(e:Event):void{
			if (loaded){
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				removeChild(gfx)
				gfx.removeEventListener(MouseEvent.MOUSE_DOWN, clickman)
				nextFrame();
				var mainClass:Class = Class(getDefinitionByName("Game"));
				if(mainClass){
					app = new mainClass();
					addChild(app as DisplayObject);
					stage.addEventListener(MouseEvent.CLICK, click);
					stage.addEventListener(KeyboardEvent.KEY_DOWN, Keyboarded);
				}
			}
		}
		public function click(e:Event):void{
			if (app!=null){
				app.Clicked(e)
			}
		}
		public function Keyboarded(e:KeyboardEvent):void{
			if (app!=null){
				app.Keyboarded(e)
			}
		}
		public function onEnterFrame(event:Event):void{
			if(framesLoaded == totalFrames){
				init()
			} else {
				var percent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				txt.htmlText="<font face='Fonter' size='30'>"+Math.floor(percent*10000)/100+"%</font>";
				txt.x=300-txt.width/2
			}
		}

		private function init():void{
			txt.htmlText="<font face='Fonter' size='30'>Game Loaded. Click to play!</font>";
			txt.x=300-txt.width/2
			loaded=true
		}
		public static function openWindow(url:String, _window:String="", features:String=""):void {
			navigateToURL(new URLRequest(url),_window)
		}
	}
}