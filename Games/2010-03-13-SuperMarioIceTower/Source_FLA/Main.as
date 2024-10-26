package{
	import flash.display.*
	import flash.events.*
	import flash.media.*
	import flash.ui.Keyboard;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import src.*;
	public class Main extends MovieClip{
		public static var self:Main;

		public static var pla:player

		public static var SFX:uint=1
		public static var MUSIC:uint=1

		public static var lev_y:int=0
		public static var lev_floor:uint=0
		public static var display:Sprite=new Sprite
		public static var coins:Sprite=new Sprite
		public static var bg:Sprite=new Sprite
		public static var front:Sprite=new Sprite

		public static var climb_speed:Number=1
		public static var __climber:Number=0

		public static var holdLeft:Boolean=false
		public static var holdRight:Boolean=false
		public static var holdJump:Boolean=false

		public static var scroller:Number=0

		public static var sScore:uint=0
		public static var sLastFloor:uint=0
		public static var sCombo:uint=0
		public static var sMaxFloor:uint=0
		public static var sMaxCombo:uint=0
		public static var sLastStatus:uint = 0;

		public static var musVol:uint=5
		public static var sfxVol:uint=5
		public static var char:uint=0
		public static var optsCoins:Boolean=false

		public static var sch:SoundChannel
		public static var str:SoundTransform=new SoundTransform()

		public static var hudComboBar:Function
		public static var hudComboTxt:Function
		public function Main():void{
			self=this
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown)
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp)

			ModernDisplay.Init(this, stage, 500, 500);
		}
		public static function startLevel():void{
			lev_y=0
			lev_floor=0

			climb_speed=1
			__climber=0
			scroller=0
			sScore=0
			sLastFloor=0
			sCombo=0
			sMaxFloor=0
			sMaxCombo=0

			trace(char)
			switch(char){
				case(0):
					pla=new player(240, 450, new PlayerGFX1, 10, -23);
					break;
				case(1):
					pla=new player(240, 450, new PlayerGFX2, 10, -23);
					break;
				case(2):
					pla=new player(240, 450, new PlayerGFX3, 10, -11);
					break;
				case(3):
					pla=new player(240, 450, new PlayerGFX4, 10, -16);
					break;
			}

			self.addChild(new WALLS_BACK(0))
			self.addChild(new WALLS_BACK(1))
			self.addChild(new WALLS_BACK(2))
			self.addChild(bg)
			self.addChild(display)
			self.addChild(pla.gfx)
			self.addChild(new WALLS(0))
			self.addChild(new WALLS(1))
			self.addChild(new WALLS(2))
			self.addChild(new HUD)
			self.addChild(front)
			self.stage.addEventListener(Event.ENTER_FRAME, levelStep)
			for (var i:uint=0; i<25; i++){
				makeFloor()
			}
		}
		public static function endLevel():void{
			self.stage.removeEventListener(Event.ENTER_FRAME, levelStep)
			while(display.numChildren>0){
				display.removeChildAt(0)
			}
			while(coins.numChildren>0){
				coins.removeChildAt(0)
			}
			while(self.numChildren>0){
				self.removeChildAt(0)
			}
		}
		private static function levelStep(e:Event):void{
			bg.y=-lev_y/3
			if (lev_y<0){
				__climber+=climb_speed;
				while(__climber>=1){
					lev_y-=1
					__climber-=1
				}
			}
			display.y=-lev_y
			pla.update()
			if (pla.y<lev_y+250){
				scroller-=0.1
			} else {
				scroller+=0.5
			}
			if (scroller>0){scroller=0}
			if (scroller<-5.5){scroller=-5.5}
			lev_y+=Math.floor(scroller)
			var a:floor
			for (var i:int=display.numChildren-1; i>=0; i--){
				a=display.getChildAt(i) as floor
				a.update()
			}
			if (Math.random()<01 && (bg.numChildren==0 || bg.getChildAt(bg.numChildren-1).y>lev_y/3+50)){
				if (Math.random()<0.5){
					bg.addChild(new BG_WINDOW(50+Math.random()*300, lev_y/3-100))
				} else {
					bg.addChild(new BG_LANTERN(50+Math.random()*300, lev_y/3-100))
				}
			}
		}
		public static function makeFloor():void{
			if (lev_floor%50==0){
				trace(lev_floor)
				display.addChild(new floor(0,475-lev_floor*50,20, lev_floor))
			} else {
				var wid:uint=3+Math.floor(Math.min(Math.random(),Math.random())*(Math.max(2, 8-lev_floor/50)))
				var x:uint=25+Math.floor(Math.random()*(450-wid*25))
				display.addChild(new floor(x, 475-lev_floor*50, wid, lev_floor))
			}
			lev_floor++
		}
		private static function keyDown(e:KeyboardEvent):void{
			switch (e.keyCode){
				case(Keyboard.LEFT):holdLeft=true;return;
				case(Keyboard.RIGHT):holdRight=true;return;
				case(("Z").charCodeAt(0)):holdJump=true;return;
			}
		}
		private static function keyUp(e:KeyboardEvent):void{
			switch (e.keyCode){
				case(Keyboard.LEFT):holdLeft=false;return;
				case(Keyboard.RIGHT):holdRight=false;return;
				case(("Z").charCodeAt(0)):holdJump=false;return;
			}
		}
		public static function coined():void{
			sScore+=(1+Math.floor(Math.sqrt(sLastFloor)))*Math.max(1, Math.round(sCombo*sCombo/500))
			hudComboTxt(-1234)
		}
		public static function landed(_f:uint):void{
			if (_f <= sLastFloor+1){
				sLastFloor = _f
				sCombo=0
				if (lev_y < 0){
					sScore+=10+Math.floor(sLastFloor/10)
				}
				sLastStatus = 0;
			} else {
				sCombo+=_f-sLastFloor
				sLastFloor=_f
				sMaxCombo=Math.max(sMaxCombo, sCombo)
				sMaxFloor=Math.max(sMaxFloor, _f)
				if (lev_y < 0){
					sScore+=(10+Math.floor(sLastFloor/10))*sCombo
				}

				var st:STATUSER;

				if (sCombo >= 10 && sLastStatus<1){
					sLastStatus = 1;
					st = new STATUSER;
					st.gs = 1;
				} else if (sCombo >= 20 && sLastStatus<2){
					sLastStatus = 2;
					st = new STATUSER;
					st.gs = 2;
				} else if (sCombo >= 40 && sLastStatus<3){
					sLastStatus = 3;
					st = new STATUSER;
					st.gs = 3;
				} else if (sCombo >= 60 && sLastStatus<4){
					sLastStatus = 4;
					st = new STATUSER;
					st.gs = 4;
				} else if (sCombo >= 100 && sLastStatus<5){
					sLastStatus = 5;
					st = new STATUSER;
					st.gs = 5;
				} else if (sCombo >= 140 && sLastStatus<6){
					sLastStatus = 6;
					st = new STATUSER;
					st.gs = 6;
				} else if (sCombo >= 200 && sLastStatus<7){
					sLastStatus = 7;
					st = new STATUSER;
					st.gs = 7;
				} else if (sCombo >= 300 && sLastStatus<8){
					sLastStatus = 8;
					st = new STATUSER;
					st.gs = 8;
				}
				if (st){
					self.addChild(st);
				}
			}
			hudComboTxt(sCombo)
			hudComboBar(sCombo)
		}
		public static function dead():void{

		}
	}
}