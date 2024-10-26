package Classes{
	//import Editor.TopPanelMonster;

	//import Classes.Interactivers.TPlayer;
	//import Classes.Menu.THelpWindow;
	//import Classes.Scenes.TLevelScene;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	public class SFX{
		[Embed("../../assets/sfx/break.mp3")] private var _srcBreak: Class;
		[Embed("../../assets/sfx/complete.mp3")] private var _srcComplete: Class;
		[Embed("../../assets/sfx/hit.mp3")] private var hit: Class;
		[Embed("../../assets/sfx/hit2.mp3")] private var hit2: Class;
		[Embed("../../assets/sfx/jump.mp3")] private var jump: Class;
		[Embed("../../assets/sfx/jump2.mp3")] private var jump2: Class;
		[Embed("../../assets/sfx/switch.mp3")] private var swi: Class;
		[Embed("../../assets/sfx/over.mp3")] private var over: Class;
		[Embed("../../assets/sfx/over2.mp3")] private var over2: Class;
		[Embed("../../assets/sfx/click.mp3")] private var click: Class;
		[Embed("../../assets/sfx/click2.mp3")] private var click2: Class;

		private static var BREAK: Sound;
		private static var COMPLETE: Sound;
		private static var HIT: Sound;
		private static var HIT2: Sound;
		private static var JUMP: Sound;
		private static var JUMP2: Sound;
		private static var SWITCH: Sound;
		private static var MUSIC1: Sound;
		private static var MUSIC2: Sound;
		private static var MUSIC3: Sound;
		private static var MUSIC4: Sound;
		private static var OVER: Sound;
		private static var OVER2: Sound;
		private static var CLICK: Sound;
		private static var CLICK2: Sound;
		private var musicChannel: SoundChannel
		private static var musicId: uint = 0
		public static var soundOn: uint = 1
		public static var musicOn: uint = 1
		public static var hotkeys: Boolean = true
		public static function toggleSound(): void {
			soundOn = 1 - soundOn;
			SimpleSave.writeFlush('option-sfx', soundOn);
		}
		public static function toggleMusic(): void {
			musicOn = 1 - musicOn;
			SimpleSave.writeFlush('option-music', musicOn);
		}
		public function SFX(stg: Stage){
			BREAK = new _srcBreak
			COMPLETE = new _srcComplete()
			HIT = new hit
			HIT2 = new hit2
			JUMP = new jump
			JUMP2 = new jump2
			SWITCH = new swi
			OVER = new over
			OVER2 = new over2
			CLICK = new click
			CLICK2 = new click2
			stg.addEventListener(Event.ENTER_FRAME, Step)
			stg.addEventListener(KeyboardEvent.KEY_DOWN, Key)
		}
		public static function fill(c1: Class, c2: Class, c3: Class, c4: Class): void{
			if (MUSIC1){return}
			MUSIC1 = new c1
			MUSIC2 = new c2
			MUSIC3 = new c3
			MUSIC4 = new c4
		}
		private function Step(e: Event): void{
			if (!MUSIC1){return}
			if (musicOn){
				if (musicChannel == null){
					switch(musicId){
						case(0): musicChannel = MUSIC1.play();break;
						case(1): musicChannel = MUSIC2.play();break;
						case(2): musicChannel = MUSIC3.play();break;
						case(3): musicChannel = MUSIC4.play();break;
					}
					musicChannel.addEventListener(Event.SOUND_COMPLETE, Played)
				}
 			} else {
 				if (musicChannel!=null){
 					musicChannel.removeEventListener(Event.SOUND_COMPLETE, Played)
 					musicChannel.stop()
 					musicChannel = null
 					musicId++
 					if (musicId > 3){musicId = 0}
 				}
 			}
		}

		private function Key(e: KeyboardEvent): void{
			if (!MUSIC1 || !hotkeys){return}
			if (e.keyCode == 77){
				toggleMusic();
			} else if(e.keyCode == 70){
				toggleSound();
			}
				/*
			} else if(e.keyCode == 76){ //L
				TLevelScene.scrollMode = 1-TLevelScene.scrollMode
			} else if(e.keyCode == 75){ //K

				TPlayer.keyMode = 1-TPlayer.keyMode
			} else if(e.keyCode == 72){ //H
				if (TD.curScene as TLevelScene){
					new THelpWindow()
				}
			}*/
		}

		private function Played(e: Event): void{
			musicChannel = null
			musicId += 1
			if (musicId > 3){musicId = 0}
		}
		public static function Play(type: String): void{
			if (!soundOn){return}
			switch(type.toLowerCase()){
				case("break"):
					BREAK.play()
					break;
				case("complete"):
					COMPLETE.play()
					break;
				case("hit"):
					HIT.play()
					break;
				case("hit2"):
					HIT2.play()
					break;
				case("jump"):
					JUMP.play()
					break;
				case("jump2"):
					JUMP2.play()
					break;
				case("switch"):
					SWITCH.play()
					break;
				case("over"):
					OVER.play()
					break;
				case("over2"):
					OVER2.play()
					break;
				case("click"):
					CLICK.play()
					break;
				case("click2"):
					CLICK2.play()
					break;
				case("END"):
					musicId = 1
					break;
			}
		}
	}
}