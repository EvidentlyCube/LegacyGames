package Classes{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.text.TextFieldAutoSize
	import mx.core.BitmapAsset;

	public class TutorialHandler{
		[Embed("../../assets/gfx/ui/Textbar.png")] private var g1:Class
		[Embed("../../assets/gfx/gameplay/Wall_CR.png")] private var g2:Class
		private static var bar:BitmapAsset
		private static var cb:BitmapAsset
		private static var txt:TextField
		private static var evented:Boolean = false
		private static var next:Number = 0
		private static var mask:Shape
		public static var gfx:Sprite
		public function TutorialHandler(close:Boolean = false){
			if (gfx == null){
				gfx = new Sprite
				bar = new g1
				bar.y = 577
				bar.x = 2
				cb = new g2
				txt = new TextField
				txt.width = 600
				txt.y = 577
				txt.embedFonts = true
				txt.autoSize = TextFieldAutoSize.CENTER
				txt.textColor = 0xFFFFFF
				var filArr:Array = txt.filters
				var filShad:DropShadowFilter = new DropShadowFilter(2,45,0,1,2,2,1)
				filArr.push(filShad);
				txt.filters = filArr
				txt.selectable = false
				mask = new Shape
				mask.graphics.beginFill(0,1)
				mask.graphics.drawRect(0,580,600,18)
				txt.mask = mask
				//Game.STG.addEventListener(Event.ENTER_FRAME,Update)
				Game.STG.addEventListener(KeyboardEvent.KEY_DOWN,Space)
				return
			}
			txt.htmlText = ""
			while (gfx.numChildren > 0){
				gfx.removeChildAt(0)
			}
			if (evented){
				txt.y = 577
				trace("kill")
				//Game.STG.removeEventListener(Event.ENTER_FRAME,Update)
				//Game.STG.removeEventListener(KeyboardEvent.KEY_DOWN,Space)
				evented = false
			}
			if (close){return}
			if (TLevel.levelType == 1){
				if (TLevData.lastSelected.author == "Crazy Boys"){
					gfx.addChild(cb)
					cb.x = 552 - (25 - TLevel.wid) * 12
					cb.y = 576 - (25 - TLevel.hei) * 12
				}

				switch(TLevData.lastSelected.id){
					case(0):
						Make("Please hit Space to advance.\n" +
							 "Welcome to Cyberix!\n" +
							 "Use Arrow Keys to control player.\n" +
							 "If you get stuck, hit 'R'.\n" +
							 "In order to leave to menu, please hit 'Escape'.\n" +
							 "Your objective is to gather all collectibles and then reach Exit.\n" +
							 "Good Luck!")
						break
					case(7):
						Make("Stoppers (Yellow X'es) stop you when you stomp on them.\n" +
							 "Bouncers, when you hit them, turn you 90 or 180 degrees.\n" +
							 "If a situation happens, where you bounce into the wall,\n" +
							 "upon moving you will bounce from the bouncer as if you\n" +
							 "walked on it from the direction you began to move, eg:\n" +
							 "if you move south, you will bounce as if you entered the\n" +
							 "bouncer from north.")
						break
					case(13):
						Make("Arrows stop you when you try to move against them.\n" +
							 "Diagonal arrows are just a combination of two orthogonal ones.\n" +
							 "Teleporters, as the name implies, teleport you.\n" +
							 "It is impossible to determine where teleport leads, without\n" +
							 "checking it yourself. If you need, make notes on a sheet of paper!")
						break
					case(22):
						Make("Upon hit, the mine explodes killing the colliding object.\n" +
							 "Cannons can fire bullets when you hit the switch.\n" +
							 "Cannons' bullets destroy mines, cannons and kill player.\n" +
							 "Bullets can also bounce from Bouncers.\n" +
							 "If you stomp on the Cannon it will explode after half of a second.")
						break
					case(33):
						Make("Switches, aside from activating cannons, can also toggle items.\n" +
							 "It is impossible to determine its effects prior to hitting it.\n" +
							 "Turnwall will turn Player 90 degrees clockwise or counter clockwise.")
						break
					case(49):
						Make("Pierced Wall allows cannon bullets to fly through them.")
						break
					case(58):
						Make("Waller is a slimy being, which will turn into regular wall\n" +
							"once you slide over it.")
						break
					case(77):
						Make("Crates can be pushed by player and can fill Pits to make them passable\n" +
							 "Some crates can be destroyed by cannon's bullets, and some not.\n" +
							 "Ice creates move in an identical manner as player.\n" +
							 "Regular crates will move only one tile.")
						break
					case(87):
						Make("Cyberix features three hostile enemies.\n" +
							 "Ortho behaves like bullet but it bounces from walls br 180 degrees.\n" +
							 "Waller will move along a wall's one side.\n" +
							 "Turner will bounce from wall 90 degrees clockwise or countrer clockwise.\n" +
							 "All enemies kill you when touched!")
						break
					case(103):
						Make("Mimics mimic the player's movement in exactly the same manner.\n" +
							 "They are dangerous enemies who can be difficult to avoid.\n" +
							 "Sometimes you may also encounter multiple player\n" +
							 "instances in one level. In such case all of them have\n" +
							 "to reach the exit safely, and each exit can be used only once!")
						break

						//87 "Tutorial 09: Enemies"
						//103 "Tutorial 10: Mimics & Players"
				}

			}

		}
		public static function Update(e:Event):void{
			if (next > 0){
				txt.y--
				next -= 1
				if (next < 0){
					txt.y += next
					next = 0
				}
			}
		}
		public static function Space(e:KeyboardEvent):void{
			if (e.keyCode == Keyboard.SPACE && next == 0){
				txt.y -= txt.textHeight / txt.numLines
				//next += txt.textHeight / txt.numLines

				if (txt.y + txt.textHeight <= 577){txt.y = 577}
			}
		}
		public static function Make(t:String = ""):void{
			txt.htmlText = "<p align='center'><font face='Fonter' color='#FFFFFF' size='15'>"+t + "</font></p>"
			gfx.addChild(bar)
			gfx.addChild(txt)
			gfx.addChild(mask)
			evented = true
		}

	}
}