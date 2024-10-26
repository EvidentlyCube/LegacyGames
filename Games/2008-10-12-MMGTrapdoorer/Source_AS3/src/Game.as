package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import Obs.*;

	 [Frame(factoryClass="Obs.Loader")]

	public class Game extends Sprite{
		[Embed(source = "/../assets/gfx/back.jpg")] private var GFC:Class;

		public static var Self:Game
		public static var layerback:Sprite = new Sprite
		public static var layerblos:Sprite = new Sprite
		public static var layertop:Sprite = new Sprite
		public static var layertext:Sprite = new Sprite
		public static var level:Array
		public static var lid:uint=0
		public static var effects:Array = new Array()
		public static var flasher:Sprite=new Sprite
		public function Game() {
			new LevStr;
			new Sounder;
			flasher.graphics.beginFill(0xFFFFFF)
			flasher.graphics.drawRect(0, 0, 600, 600)
			flasher.graphics.endFill()
			flasher.alpha=0
			var Gief:Sprite=new Sprite
			var gief2:Bitmap=new GFC
			Gief.graphics.beginBitmapFill(gief2.bitmapData,null,true)
			Gief.graphics.drawRect(0,0,600,600)
			Gief.graphics.endFill()
			layerback.addChild(Gief)
			addChild(layerback)
			addChild(layerblos)
			addChild(layertop)
			addChild(layertext)
			addChild(flasher)
			Self = this;
			new Pointer;
			Pointer.Initia()
			new Player()
			addEventListener(Event.ENTER_FRAME, Step);
			level = new Array(20)
			var i:uint
			for (i= 0; i < 20; i++) {
				level[i]=new Array(20)
			}
			fillLevel(lid);

			CheatCodes.Init();
			CheatCodes.AddCheat(
				"OMIT",
				function(): void {
					Player.gotoNextLevel();
				}
			)
		}
		private function Step(e:Event):void {
			Sounder.Update()
			if (flasher.alpha>0) {flasher.alpha-=0.05}
			Pointer.Update(mouseX, mouseY)
			Player.Update()
			for (var i:int = effects.length - 1; i >= 0; i--) {
				if (effects[i] is BloEff){
					BloEff(effects[i]).Update()
				} else {
					effects.splice(i,1)
				}
			}
		}
		public static function At(x:int, y:int):Block {
			if (x < 0 || x > 19 || y < 0 || y > 19) {
				return null;
			}
			return level[x][y];
		}
		public function Clicked(e:MouseEvent):void {
			Player.Clicked(Pointer.x,Pointer.y)
			Sounder.Click()
		}
		public function Keyboarded(e:KeyboardEvent): void {
			CheatCodes.HandleKey(e);

			var x: Number = Math.floor(Player.x / 30);
			var y: Number = Math.floor(Player.y / 30);

			if (Player.state === 3) {
				return;
			} else if (Player.state === 2) {
				x = Math.floor((Player.x + Player.movex) / 30);
				y = Math.floor((Player.y + Player.movey) / 30);
			}

			switch(e.keyCode) {
				case Keyboard.NUMPAD_1:
				case Keyboard.NUMBER_1:
				case Keyboard.Z:
					Player.Clicked(x - 1, y + 1, true);
					break;

				case Keyboard.NUMPAD_3:
				case Keyboard.NUMBER_3:
				case Keyboard.C:
					Player.Clicked(x + 1, y + 1, true);
					break;

				case Keyboard.NUMPAD_9:
				case Keyboard.NUMBER_9:
				case Keyboard.E:
					Player.Clicked(x + 1, y - 1, true);
					break;

				case Keyboard.NUMPAD_7:
				case Keyboard.NUMBER_7:
				case Keyboard.Q:
					Player.Clicked(x - 1, y - 1, true);
					break;

				case Keyboard.NUMPAD_4:
				case Keyboard.NUMBER_4:
				case Keyboard.A:
					Player.Clicked(x - 1, y, true);
					break;

				case Keyboard.NUMPAD_6:
				case Keyboard.NUMBER_6:
				case Keyboard.D:
					Player.Clicked(x + 1, y, true);
					break;

				case Keyboard.NUMPAD_8:
				case Keyboard.NUMBER_8:
				case Keyboard.W:
					Player.Clicked(x, y - 1, true);
					break;

				case Keyboard.NUMPAD_2:
				case Keyboard.NUMBER_2:
				case Keyboard.X:
					Player.Clicked(x, y + 1, true);
					break;

			}
		}
		public static function Sign(x:Number):int{
			if (x>0){return 1;} else if(x<0){return -1;} else {return 0;}
		}
		public static function fillLevel(id:uint):void {
			flasher.alpha=1
			var str:String=LevStr.Get(id)
			Block.count=0
			for (var j:uint=0; j<20; j++) {
				for (var i:uint=0; i<20; i++) {
					if (At(i,j)!=null){At(i,j).removeGFX()}
				if (str.charAt(i+j*20) != "0"){
					level[i][j] = new Block(i,j,Number(str.charAt(i+j*20))-1)} else {level[i][j]=null;}
				}
			}
		}
	}

}