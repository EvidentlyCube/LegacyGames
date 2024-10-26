 package {
	import Classes.*;
	import Classes.Menu.*;
	import Classes.Scenes.*;
	import Classes.Items.*;
	import Classes.Interactivers.*;
	import Classes.Data.*;
	import Editor.*;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.SharedObject;

	public class Game extends Sprite{
		public static var STG:Stage
		public static var curScene:TScene
		public static var pauser:Boolean = false
		public static var self:Game
		public static var display:Sprite = new Sprite
		public static var windows:Sprite = new Sprite
		public static var notes:Sprite = new Sprite
		public static var layerEditor:Sprite = new Sprite
		public static var layerBg:Sprite = new Sprite
		public static var layerPlayer:Sprite = new Sprite
		public static var layerEffects:Sprite = new Sprite
		public static var layerObjects:Sprite = new Sprite
		public static var layerItems:Sprite = new Sprite
		public static var layerFloor:Sprite = new Sprite
		public static var layerMenuBg:Sprite = new Sprite
		public static var SO:*
		public static var SOact:Boolean = false
		public function Game(){
			self = this
			STG = Loading.self.stage

			var mask:Shape = new Shape
			mask.graphics.beginFill(0)
			mask.graphics.drawRect(0,0,600,600)
			mask.graphics.endFill()

			this.mask = mask

			addChild(mask)
			addChild(display)
			addChild(windows)
			addChild(notes)


			new TLevel()
			new TWindow()
			new WindowHandler()
			new ControlsHandler()
			new TutorialHandler()
			new SFX()
			new BGHandler()
			new MenuBG()
			new SOHandler()

			LevelDatabase.init();

			setScene(TMenuScene)

			var s:SharedObject = SharedObject.getLocal("levz")

			addEventListener(Event.ENTER_FRAME,Step)

			CheatCodes.Init()
			 CheatCodes.AddCheat('toot', function(): void {
				if (Game.curScene is TLevelScene) {
					TLevel.endLevel(true);
					SFX.Play("complete")
				}
			 })
            STG.addEventListener(KeyboardEvent.KEY_DOWN, CheatCodes.HandleKey);
		}
		public function Step(e:Event):void{
			SFX.Step()
			WindowHandler.Update()
			curScene.update()
		}
		public static function addLayer(layer:DisplayObject):void{
			display.addChild(layer)
		}
		public static function removeLayer(layer:DisplayObject):void{
			display.removeChild(layer)
		}
		public static function clearLayer(layer:DisplayObjectContainer):void{
			while (layer.numChildren > 0){
				layer.removeChildAt(0)
			}
		}
		public static function setScene(sceneID:Class):void{
			if (curScene != null){curScene.remove()}
			curScene = new sceneID
			curScene.add()
		}
		public static function refocus():void{
			STG.focus = STG
		}
	}
}
