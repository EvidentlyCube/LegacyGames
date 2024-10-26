package objects{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	import flash.events.KeyboardEvent;
	import mx.core.BitmapAsset;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent
	import flash.external.ExternalInterface;
	import flash.net.URLRequest
	import flash.net.navigateToURL;

	public class Loading extends MovieClip{
		public var app:Object;
		[Embed(source="../logo4.png")]
		private var GLOGO:Class;
		public var logo:BitmapAsset
		public var gfx:Sprite=new Sprite;
		public var rect:Shape=new Shape;
		public var txt:TextField=new TextField
		public function Loading(){
			stop();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			rect.graphics.beginFill(0x000070)
			rect.graphics.drawRect(0,0,400,375)
			rect.graphics.endFill()
			logo=new GLOGO;
			logo.x=200-logo.width/2
			logo.y=80
			txt.y=290
			txt.autoSize=TextFieldAutoSize.CENTER
			gfx.addChild(rect)
			gfx.addChild(logo)
			gfx.addChild(txt)
			addChild(gfx)
			txt.textColor=0xFFFFFF
			txt.scaleX=1
			txt.scaleY=1

			var percent:Number = Math.floor((root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal)*100)/100;
			txt.htmlText="<font face='verdana'>"+Math.floor(percent*100)/100+"%</font>";
			txt.x=200-txt.width/2
			gfx.addEventListener(MouseEvent.MOUSE_DOWN,clickman)


			ModernDisplay.Init(this, stage, 400, 375);
		}
		public function clickman(e:Event):void{
			openWindow("http://www.softendo.com","_blank")
		}
		public function onEnterFrame(event:Event):void{
			if(framesLoaded == totalFrames){
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				removeChild(gfx)
				gfx.removeEventListener(MouseEvent.MOUSE_DOWN, clickman)
				nextFrame();
				init();
			} else {
				/*
				var percent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				graphics.beginFill(0);
				graphics.drawRect(0, stage.stageHeight / 2 - 10,
				stage.stageWidth * percent, 20);
				graphics.endFill();
				*/
				var percent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				txt.htmlText="<font face='verdana'>"+Math.floor(percent*10000)/100+"%</font>";
				txt.x=200-txt.width/2
			}
		}

		private function init():void{
			var mainClass:Class = Class(getDefinitionByName("Mario"));
			if(mainClass){
				app = new mainClass();
				addChild(app as DisplayObject);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			}
		}
		private function keyDown(e:KeyboardEvent):void{
			if (app!=null){
				app.keyDown(e);
			}
		}
		private function keyUp(e:KeyboardEvent):void{
			if (app!=null){
				app.keyUp(e);
			}
		}
		public static function openWindow(url:String, _window:String="", features:String=""):void {
			var window:String = _window;
			//Sets function name into a variable to be executed by ExternalInterface.
			//Otherwise Flex will try to find a local function or value by that name.

			var WINDOW_OPEN_FUNCTION:String = "window.open";
			var myURL:URLRequest = new URLRequest(url);
			var browserName:String = getBrowserName();

			//If browser is Firefox, use ExternalInterface to call out to browser
			//and launch window via browser's window.open method.
			if(browserName == "Firefox"){
				   ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
			}
			//If IE,
			else if(browserName == "IE"){
				ExternalInterface.call("function setWMWindow() {window.open('" + url + "');}");
			}
			//If Safari
			else if(browserName == "Safari"){
				navigateToURL(myURL, window);
			}
			//If Opera
			else if(browserName == "Opera"){
				navigateToURL(myURL, window);
			}
			//Otherwise, use Flex's native 'navigateToURL()' function to pop-window.
			//This is necessary because Safari 3 no longer works with the above ExternalInterface work-a-round.
			else{
				navigateToURL(myURL, window);
			}

			/*Alternate methodology...
			   var popSuccess:Boolean = ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
			if(popSuccess == false){
				navigateToURL(myURL, window);
			}*/
		}

		private static function getBrowserName():String {
			var browser:String;

			//Uses external interface to reach out to browser and grab browser useragent info.
			var browserAgent:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");

			//Determines brand of browser using a find index. If not found indexOf returns (-1).
			if(browserAgent != null && browserAgent.indexOf("Firefox") >= 0) {
				browser = "Firefox";
			}
			else if(browserAgent != null && browserAgent.indexOf("Safari") >= 0){
				browser = "Safari";
			}
			else if(browserAgent != null && browserAgent.indexOf("MSIE") >= 0){
				browser = "IE";
			}
			else if(browserAgent != null && browserAgent.indexOf("Opera") >= 0){
				browser = "Opera";
			}
			else {
				browser = "Undefined";
			}
			return (browser);
		}
	}
}