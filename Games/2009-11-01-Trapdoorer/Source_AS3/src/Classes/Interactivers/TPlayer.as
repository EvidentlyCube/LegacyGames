package Classes.Interactivers{
	import Classes.Menu.THelpWindow;
	import Classes.Menu.TAchievementsPanel;
	import Classes.SFX;
	import Classes.Scenes.TLevelScene;
	import Classes.Scenes.TScene;
	import Classes.TLevData;
	import Classes.TLevel;
	import Classes.UndoHandler;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import mx.core.BitmapAsset;
	/*STATIC*/ public class TPlayer{
		[Embed("../../../assets/gfx/by_maurycy/gameplay/Player.png")] public static var g: Class;
		public static var active: Boolean = false
		public static var x: int
		public static var y: int
		public static var z: int
		public static var moveX: int
		public static var moveY: int
		public static var moveZ: int
		public static var gfx: Sprite
		public static var keyMode: uint = 1
		public function TPlayer(){
			var t: BitmapAsset = new g
			t.x = -25
			t.y = -25
			gfx = new Sprite
			gfx.addChild(t)
		}
		public static function update(e: Event): void{
			if (TLevel.levelType == 1 && TLevData.lastSelected.id == "66" && x == 600 && y == 875){
				TAchievementsPanel.awardAchievement(9)
			}
			if (!active){
				return
			}
			if(z > 0){
				if (z >= 3){
					moveZ = -1
				}
				gfx.alpha = 1-z/10
				gfx.scaleX = 0.5+z/10
				gfx.scaleY = 0.5+z/10
			} else if(z == 0){
				moveX = 0
				moveY = 0
				gfx.alpha = 1
				gfx.scaleX = 0.5
				gfx.scaleY = 0.5
				if (TLevel.checkAt(x, y)!=null){
					if (moveZ < 0){
						TLevel.Land(x, y)
					}
					moveZ = 0
				} else {
					z = -1
				}
			} else {
				gfx.alpha = 1+z/10
				gfx.scaleX = 0.5+z/10
				gfx.scaleY = 0.5+z/10
				if (z == -10){
					TAchievementsPanel.awardAchievement(0)
					UndoHandler.undo();
				}
			}

			x += moveX*5
			y += moveY*5
			z += moveZ
			gfx.x = x+13.5
			gfx.y = y+13.5
		}
		public static function drop(_x: int, _y: int): void{
			if (TScene.paused){return}
			SFX.Play("jump2")
			x=_x*25
			y=_y*25
			z = 10
			moveX = 0
			moveY = 0
			moveZ = -1

			UndoHandler.prune()
			active = true
			TD.layerAbove.addChild(gfx)
			TD.STG.addEventListener(KeyboardEvent.KEY_DOWN, keyHit)
			TD.STG.addEventListener(Event.ENTER_FRAME, update)
		}
		private static function keyHit(e: KeyboardEvent): void{

			if (TScene.paused){return}
			switch(e.keyCode){
				case(76): TLevelScene.scrollMode = 1-TLevelScene.scrollMode;return;
				case(75): keyMode = 1-keyMode;return;
				case(72):
					if (TD.curScene as TLevelScene){
						new THelpWindow()
					}
					return
			}
			if (keyMode == 1){
				switch (e.keyCode){
					case(Keyboard.RIGHT):
					case(Keyboard.NUMPAD_6):
					case(68):
						jumpTo(1, 0);break;
					case(Keyboard.PAGE_DOWN):
					case(Keyboard.NUMPAD_3):
					case(67):
						jumpTo(1, 1);break;
					case(Keyboard.DOWN):
					case(Keyboard.NUMPAD_2):
					case(88):
					case(83):
						jumpTo(0, 1);break;
					case(Keyboard.END):
					case(Keyboard.NUMPAD_1):
					case(90):
						jumpTo(-1, 1);break;
					case(Keyboard.LEFT):
					case(Keyboard.NUMPAD_4):
					case(65):
						jumpTo(-1, 0);break;
					case(Keyboard.HOME):
					case(Keyboard.NUMPAD_7):
					case(81):
						jumpTo(-1, -1);break;
					case(Keyboard.UP):
					case(Keyboard.NUMPAD_8):
					case(87):
						jumpTo(0, -1);break;
					case(Keyboard.PAGE_UP):
					case(Keyboard.NUMPAD_9):
					case(69):
						jumpTo(1, -1);break;
					case(Keyboard.BACKSPACE):
					case(85):
						UndoHandler.undo()
						break;
				}
			} else {
				switch (e.keyCode){
					case(Keyboard.RIGHT):
					case(Keyboard.NUMPAD_6):
						jumpTo(1, 0);break;
					case(Keyboard.PAGE_DOWN):
					case(Keyboard.NUMPAD_3):
					case(83):
						jumpTo(1, 1);break;
					case(Keyboard.DOWN):
					case(Keyboard.NUMPAD_2):
						jumpTo(0, 1);break;
					case(Keyboard.END):
					case(Keyboard.NUMPAD_1):
					case(65):
						jumpTo(-1, 1);break;
					case(Keyboard.LEFT):
					case(Keyboard.NUMPAD_4):
						jumpTo(-1, 0);break;
					case(Keyboard.HOME):
					case(Keyboard.NUMPAD_7):
					case(81):
						jumpTo(-1, -1);break;
					case(Keyboard.UP):
					case(Keyboard.NUMPAD_8):
						jumpTo(0, -1);break;
					case(Keyboard.PAGE_UP):
					case(Keyboard.NUMPAD_9):
					case(87):
						jumpTo(1, -1);break;
					case(Keyboard.BACKSPACE):
					case(85):
						UndoHandler.undo()
						break;
				}
			}
		}
		public static function jumpTo(_x: int, _y: int): void{
			if (z!=0 || moveZ!=0 || !active){return}
			if (TLevel.CanLand(x+_x*25, y+_y*25)){
				SFX.Play("jump")
				UndoHandler.commitStep()
				moveX=_x
				moveY=_y
				moveZ = 1
				z = 1
				TLevel.JumpOff(x, y)
			}
		}
		public static function kill(restart: Boolean = false): void{
			active = false
			if (TD.layerAbove.contains(gfx)){TD.layerAbove.removeChild(gfx)}
			TD.STG.removeEventListener(KeyboardEvent.KEY_DOWN, keyHit)
			TD.STG.removeEventListener(Event.ENTER_FRAME, update)
			if (restart){TLevel.Restart()}
		}
	}
}