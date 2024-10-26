package {

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

	public dynamic class Loading extends MovieClip{
		public var app:Object;
		[Embed(source="/../assets/fonts/ravie/ravie.ttf",fontFamily="fonter",embedAsCFF="false")] private var fonter:Class;
		[Embed(source="/../assets/gfx/Loading.jpg")] private var gf:Class;
		public static var gfx:Sprite=new Sprite
		public static var self:Loading
		public static var loaded:Boolean=false
		public static var txt:TextField=new TextField
		public static var txth:Sprite=new Sprite
		public static var logh:Sprite=new Sprite
		public static var m:Sprite=new Sprite
		public static var lc:LocalConnection=new LocalConnection()
		public function Loading(){
			self=this
			gfx.addChild(new gf)
			gfx.addChild(txt)
			txt.y=360
			gfx.addChild(txth)
			gfx.addChild(logh)
			gfx.addChild(m)
			logh.graphics.beginFill(0,0)
			logh.graphics.drawRect(146,96,259,222)
			logh.graphics.endFill()
			logh.buttonMode=true
			logh.addEventListener(MouseEvent.CLICK,function():void{openWindow("http://mauft.com","_blank")})
			m.graphics.beginFill(0,0)
			m.buttonMode=true
			m.graphics.drawRect(440,300,100,100)

			txth.visible=false
			txth.graphics.beginFill(0,0)
			txth.graphics.drawRect(20,360,400,30)
			txth.buttonMode=true
			txth.addEventListener(MouseEvent.CLICK,clickman2)
			addChild(gfx)
			txt.embedFonts=true
			txt.selectable=false
			txt.autoSize="center"
			txt.textColor=0xFFFFFF
			var a:Array=txt.filters
			a.push(new DropShadowFilter(2,45,0,1,2,2,1))
			txt.filters=a
			txt.htmlText="<font face='fonter' size='18'>Loaded: 0%</font>"
			txt.x=210-txt.width/2
			addEventListener(Event.ENTER_FRAME,onEnterFrame)

			ModernDisplay.Init(this, stage, 540, 400);
		}

		public function clickman2(e:MouseEvent):void{
			if (!loaded){return}
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				txth.removeEventListener(MouseEvent.CLICK,clickman2)
				removeChild(gfx)
				nextFrame();
				var mainClass:Class = Class(getDefinitionByName("Mecard"));
				if(mainClass){
					app = new mainClass();
					addChild(app as DisplayObject)
				}
		}
		public function onEnterFrame(event:Event):void{

			if(framesLoaded >= totalFrames || root.loaderInfo.bytesLoaded>=root.loaderInfo.bytesTotal || loaded){
				if (loaded==false){
					init()
				}
				return
			}
			var percent:uint = Math.floor((root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal)*100);
			if (percent>=99){
				if (!loaded){init()}
			} else {
				txt.htmlText="<font face='fonter' size='18'>Loaded: "+percent.toString()+"%</font>"
				txt.x=210-txt.width/2
			}
		}

		private function init():void{
			loaded=true
			txt.htmlText="<font face='fonter' size='18'>Game Loaded. Click here to play!</font>"
			txt.x=210-txt.width/2
			txth.visible=true
		}
		public static function openWindow(url:String, _window:String="", features:String=""):void {
			navigateToURL(new URLRequest(url),_window)
			return;
		}
	}
}