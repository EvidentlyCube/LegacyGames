package objects{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getDefinitionByName;

	import mx.core.BitmapAsset;

	public dynamic class Loading extends MovieClip {
		public var app:Object;
		[Embed(source="../../assets/gfx/ui/loader.jpg")]
		private var GLOGO:Class;
		public var logo:BitmapAsset;
		public var rect:Sprite=new Sprite;
		public var gfx:Sprite=new Sprite;
		public var txt:TextField=new TextField;
		public var loaded:Boolean=false;
		public static var locked:uint=0;
		public static var r1:Sprite;
		public static var r2:Sprite;
		public function Loading(){
			stop();

			r1=new Sprite;
			r1.graphics.beginFill(0xFFFFFF,0.2);
			r1.graphics.drawRect(12,131,374,104);
			r1.graphics.endFill();
			r1.buttonMode=true;
			r1.alpha=0;
			r1.addEventListener(MouseEvent.CLICK,function (e:Event = null):void{openWindow("http://www.minijuegos.com","_blank")});
			r1.addEventListener(MouseEvent.MOUSE_OVER,function (e:Event = null):void{r1.alpha=1});
			r1.addEventListener(MouseEvent.MOUSE_OUT,function (e:Event = null):void{r1.alpha=0});

			r2=new Sprite;
			r2.graphics.beginFill(0xFFFFFF,0.2);
			r2.graphics.drawRect(12,250,374,45);
			r2.graphics.endFill();
			r2.buttonMode=true;
			r2.alpha=0;
			r2.addEventListener(MouseEvent.CLICK,clickman);
			r2.addEventListener(MouseEvent.MOUSE_OVER,function (e:Event = null):void{r2.alpha=1});
			r2.addEventListener(MouseEvent.MOUSE_OUT,function (e:Event = null):void{r2.alpha=0});

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			logo=new GLOGO;
			logo.x=200-logo.width/2;
			logo.y=0;
			rect.graphics.beginFill(0x000000);
			rect.graphics.drawRect(0,0,400,375);
			rect.graphics.endFill();
			txt.y=260;
			txt.autoSize=TextFieldAutoSize.NONE;
			txt.width=250;
			gfx.addChild(rect);
			gfx.addChild(logo);
			gfx.addChild(txt);
			addChild(gfx);
			txt.textColor=0xFFFFFF;
			txt.scaleX=1;
			txt.scaleY=1;

			var percent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
			txt.htmlText="<p align='center'><font color='#FFFFFF' size='20'>"+Math.floor(percent*10000)/100+"%</font></p>";
			txt.x=75;
			txt.selectable=false;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown2);
			gfx.addChild(r1);
			gfx.addChild(r2);


			ModernDisplay.Init(this, stage, 400, 375);
			CheatCodes.Init()

			stage.addEventListener(KeyboardEvent.KEY_DOWN, CheatCodes.HandleKey);
		}
		public function clickman(e:Event):void{
			if (loaded){
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				removeChild(gfx);
				gfx.removeEventListener(MouseEvent.MOUSE_DOWN, clickman);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown2);
				nextFrame();
				var mainClass:Class = Class(getDefinitionByName("Mario"));
				if(mainClass){
					app = new mainClass();
					addChild(app as DisplayObject);
					//stage.addEventListener(MouseEvent.CLICK, click);
					stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
					stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
				}
			}
		}
		private function keyDown(e:KeyboardEvent):void{
			if (app!=null){
				app.keyDown(e);
			}
		}
		private function keyDown2(e:KeyboardEvent):void{
			switch (locked){
				case 0:if (e.keyCode==80){locked=1;}break;
				case 1:if (e.keyCode==53){locked=2;}break;
				case 2:if (e.keyCode==75){locked=3;}break;
				case 3:if (e.keyCode==71){locked=4;}break;
				case 4:if (e.keyCode==66){locked=5;}break;
				case 5:if (e.keyCode==49){locked=6;}break;
			}
			/*
			p - 80
			5 - 53
			k - 75
			g - 71
			b - 66
			1 - 49
			*/
		}
		private function keyUp(e:KeyboardEvent):void{
			if (app!=null){
				app.keyUp(e);
			}
		}
		public function onEnterFrame(event:Event):void{
			if(framesLoaded == totalFrames){
				init()
			} else {
				/*
				var percent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				graphics.beginFill(0);
				graphics.drawRect(0, stage.stageHeight / 2 - 10,
				stage.stageWidth * percent, 20);
				graphics.endFill();
				*/
				var percent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				txt.htmlText="<p align='center'><font color='#FFFFFF' size='20'>"+Math.floor(percent*10000)/100+"%</font></p>";
				txt.x=75
			}
		}

		private function init():void{
			txt.htmlText="<p align='center'><font color='#FFFFFF' size='20'>Game Loaded. Click to play!</font></p>";
			txt.x=75;
			loaded=true
		}
		public static function openWindow(url:String, _window:String="_blank"):void {
			navigateToURL(new URLRequest(url), _window);
		}

	}
}
