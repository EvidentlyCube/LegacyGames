package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.LocalConnection;
	import flash.text.TextField;

	[Frame(factoryClass="Loading")]
	dynamic public class Mecard extends MovieClip{
		[Embed("/../assets/gfx/back.jpg")] private var g:Class;
		[Embed("/../assets/gfx/sfx.png")] private var gs:Class;
		[Embed("/../assets/gfx/music.png")] private var gm:Class;
		[Embed("/../assets/music/cybernet/Cybernet.mp3")] private var smus:Class
		[Embed("/../assets/sfx/sfx1.mp3")] private var sfx1:Class
		[Embed("/../assets/sfx/sfx2.mp3")] private var sfx2:Class
		[Embed("/../assets/sfx/sfx3.mp3")] private var sfx3:Class
		public static var mus:Sound
		public static var s1:Sound
		public static var s2:Sound
		public static var s3:Sound
		public static var sc:SoundChannel
		public static var layer:Sprite
		private static var timer:TextField
		public static var time:uint=0
		private static var sfx:Sprite=new Sprite
		private static var music:Sprite=new Sprite
		public static var STG:Stage
		public static var ch:CardHandler
		public static var stoped:Boolean=false
		public function Mecard(){
			STG=Loading.self.stage
			mus=new smus
			s1=new sfx1
			s2=new sfx2
			s3=new sfx3
			layer=new Sprite
			addChild(new g)
			addChild(layer)
			timer=new TextField
			timer.embedFonts=true
			timer.textColor=0xFFFFFF
			timer.width=300
			timer.selectable=false
			timer.height=30
			timer.htmlText="<font face='fonter' size='16' color='#FFFFFF'>Click on any card to start</font>"
			timer.x=130
			timer.y=12
			var a:Array=timer.filters
			a.push(new DropShadowFilter(2,45,0,1,2,2,1))
			timer.filters=a
			addChild(timer)
			ch=new CardHandler()

			sfx.addChild(new gs)
			music.addChild(new gm)
			music.x=446
			music.y=13
			music.buttonMode=true
			sfx.x=499
			sfx.y=13
			sfx.buttonMode=true
			addChild(music)
			addChild(sfx)


			sfx.addEventListener(MouseEvent.CLICK,function():void{
				playx(1)
				if (sfx.alpha==1){sfx.alpha=0.4} else {sfx.alpha=1}
			})
			music.addEventListener(MouseEvent.CLICK,function():void{
				if (music.alpha==1){
					music.alpha=0.4
					if (sc!=null){
						sc.stop()
						sc=null
					}
				} else {
					music.alpha=1
				}
				playx(1)
			})

			STG.addEventListener(Event.ENTER_FRAME,ch.update)
			STG.addEventListener(Event.ENTER_FRAME,Update)
		}
		public static function rem():void{
			trace("FIN!")
			time=0
			//STG.removeEventListener(Event.ENTER_FRAME,ch.update)
			ch=new CardHandler()
			stoped=false
			timer.htmlText="<font face='fonter' size='16' color='#FFFFFF'>Click on any card to start</font>"
			//STG.addEventListener(Event.ENTER_FRAME,ch.update)
		}
		public static function playx(i:uint):void{
			if (sfx.alpha==1){
				if (i==1){
					s1.play()
				} else if(i==2){
					s2.play()
				} else {
					s3.play()
				}
			}
		}
		private function Update(e:Event):void{
			if (time==0 || stoped){return}
			time++
			if (music.alpha==1 && sc==null){
				sc=mus.play(0,100)
			}
			timer.htmlText="<font face='fonter' size='20' color='#FFFFFF'>Time Passed: "+Math.floor(time/60).toString()+" sec.</font>"
		}
	}
}
