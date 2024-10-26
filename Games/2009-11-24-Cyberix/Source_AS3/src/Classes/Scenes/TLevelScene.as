package Classes.Scenes
{
	import Classes.Interactivers.TObject;
	import Classes.Menu.TPauseWindow;
	import Classes.Menu.TWindow;
	import Classes.Menu.WindowHandler;
	import Classes.TLevel;
	import Classes.TutorialHandler;

	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	public class TLevelScene extends TScene{
		public static var i:int = 0
		public static var breakUpdate:Boolean = false
		public var selWin:TPauseWindow
		private static var fader:Shape
		public static var command:uint
		public function TLevelScene(){
			fader = new Shape
			fader.graphics.beginFill(0)
			fader.graphics.drawRect(0,0,600,600)
			reset()
			Game.STG.addEventListener(KeyboardEvent.KEY_DOWN,this.hitEscape)
			Game.refocus()
		}
		public static function reset():void{
			fader.alpha = 1
			command = 0
			TScene.paused = false
			Game.refocus()
		}
		public static function set alpha(a:Number):void{
			fader.alpha = a
		}
		public static function get alpha():Number{
			return fader.alpha
		}
		override public function update():void{
			if (TScene.paused){return}
			if (command == 0){
				if (fader.alpha > 0){fader.alpha -= 0.04}
			} else {
				if (fader.alpha < 1.1){fader.alpha += 0.04}
				if (fader.alpha >= 1.1){
					switch (command){
						case(1)://restart level
							TLevel.Restart(true)
							break;
						case(2)://end level
							TLevel.endLevel(false,true)
							break;
						case(3)://complete level
							TLevel.endLevel(true,true)
							break;
					}
				}
			}
			var child:*
			for (i = Game.layerObjects.numChildren - 1;i >= 0;i--){
				if (breakUpdate){
					breakUpdate = false
					break
				}
				child = Game.layerObjects.getChildAt(i)
				child.Update()
			}
			for (i = Game.layerEffects.numChildren - 1;i >= 0;i--){
				child = Game.layerEffects.getChildAt(i)
				child.Update()
			}
		}
		public function hitEscape(e:KeyboardEvent):void{
			if (WindowHandler.windowsCount){return;}
			if (e.keyCode == 82){
				TLevel.Restart()
			}
			if (e.keyCode == Keyboard.ESCAPE || e.keyCode === Keyboard.P){
				selWin = new TPauseWindow()
			}
		}
		public function menuRestart(e:Event):void{
			selWin.removeEventListener(TWindow.CHOICE1,menuRestart)
			selWin.removeEventListener(TWindow.CHOICE2,menuReturn)
			selWin.removeEventListener(TWindow.CHOICE3,menuQuit)
			selWin = null
			TScene.paused = false
			TLevel.Restart()
		}
		public function menuReturn(e:Event):void{
			selWin.removeEventListener(TWindow.CHOICE1,menuRestart)
			selWin.removeEventListener(TWindow.CHOICE2,menuReturn)
			selWin.removeEventListener(TWindow.CHOICE3,menuQuit)
			selWin = null
			TScene.paused = false
		}
		public function menuQuit(e:Event):void{
			selWin.removeEventListener(TWindow.CHOICE1,menuRestart)
			selWin.removeEventListener(TWindow.CHOICE2,menuReturn)
			selWin.removeEventListener(TWindow.CHOICE3,menuQuit)
			selWin = null
			TScene.paused = false
			TLevel.endLevel(false)
		}
		public static function killedObject(object:TObject):void{
			if (Game.layerObjects.getChildIndex(object) < i){
				i--;
			}
		}
		override public function add():void{
			//TPlayer.canMove = true
			Game.addLayer(Game.layerBg)
			Game.addLayer(Game.layerFloor)
			Game.addLayer(Game.layerItems)
			Game.addLayer(Game.layerObjects)
			Game.addLayer(Game.layerEffects)
			Game.addLayer(Game.layerPlayer)
			Game.addLayer(TutorialHandler.gfx)
			Game.addLayer(fader)
		}
		override public function remove():void{
			TLevel.Clear()
			//TPlayer.canMove = false
			Game.STG.removeEventListener(KeyboardEvent.KEY_DOWN,this.hitEscape)
			Game.removeLayer(Game.layerBg)
			Game.removeLayer(Game.layerFloor)
			Game.removeLayer(Game.layerItems)
			Game.removeLayer(Game.layerObjects)
			Game.removeLayer(Game.layerEffects)
			Game.removeLayer(Game.layerPlayer)
			Game.removeLayer(TutorialHandler.gfx)
			Game.removeLayer(fader)
		}
	}
}