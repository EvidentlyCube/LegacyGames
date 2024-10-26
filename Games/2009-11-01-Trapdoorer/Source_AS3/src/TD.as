package {
	import Classes.SFX;
	import Classes.Data.LevelDatabase;
	import Classes.BGHandler;
	import Classes.CampaignLevels;
	import Classes.Interactivers.TPlayer;
	import Classes.Menu.TAlertWindow;
	import Classes.Menu.TAchievementsPanel;
	import Classes.Menu.TSelectWindow;
	import Classes.Menu.TWindow;
	import Classes.Menu.WindowHandler;
	import Classes.SFXMusic;
	import Classes.Scenes.*;
	import Classes.TLevData;
	import Classes.TLevel;

	import LoadingDir.Loading;

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.IOErrorEvent;
	import flash.text.TextField;
	import flash.display.BitmapData

	public class TD extends Sprite{
		public static var STG: Stage
		public static var curScene: TScene
		public static var pauser: Boolean = false
		public static var self: TD
		public static var display: Sprite = new Sprite
		public static var windows: Sprite = new Sprite
		public static var notes: Sprite = new Sprite
		public static var layerEditor: Sprite = new Sprite
		public static var layerBg: Sprite = new Sprite
		public static var layerBlocks: Sprite = new Sprite
		public static var layerEffects: Sprite = new Sprite
		public static var layerAbove: Sprite = new Sprite
		public static var layerPanel: Sprite = new Sprite
		public static var layerFader: Bitmap
		public static var layerFaderData: BitmapData
		public static var SO:*
		public static var hotkeys: Boolean = true
		public static var selWin: TSelectWindow
		public function TD(){
			layerFaderData = new BitmapData(600, 600, true, 0x00000000)
			layerFader = new Bitmap(layerFaderData, PixelSnapping.ALWAYS, false)

			self = this
			STG = Loading.self.stage

			new TAchievementsPanel();

			var masker: Shape = new Shape
			masker.graphics.beginFill(0)
			masker.graphics.drawRect(0, 0,600, 600)
			masker.graphics.endFill()
			mask = masker

			self.addChild(masker)
			self.addChild(display)
			self.addChild(windows)
			self.addChild(notes)

			new TLevel()
			new WindowHandler()
			new TPlayer()
			new SFXMusic()

			CampaignLevels()
			LevelDatabase.init();

			layerBg.addChild(BGHandler.Graphic)

			setScene(TIntroScene)
			//new TNote("Achievement", "Respect your elders!", new TAchievementsPanel.gfx_ac1)
			STG.addEventListener(Event.ENTER_FRAME, Step)

			CheatCodes.Init()
			 CheatCodes.AddCheat('toot', function(): void {
				if (TD.curScene is TLevelScene) {
					TLevel.endLevel(true);
					SFX.Play("complete")
				}
			 })

            STG.addEventListener(KeyboardEvent.KEY_DOWN, CheatCodes.HandleKey);
		}
		public function Step(e: Event): void{
			WindowHandler.Update()
			curScene.update()
		}
		public static function addLayer(layer: DisplayObject): void{
			display.addChild(layer)
		}
		public static function removeLayer(layer: DisplayObject): void{
			display.removeChild(layer)
		}
		public static function clearLayer(layer: DisplayObjectContainer): void{
			while (layer.numChildren > 0){
				layer.removeChildAt(0)
			}
		}
		public static function setScene(sceneID: Class): void{
			if (curScene!=null){curScene.remove()}
			curScene = new sceneID
			curScene.add()
		}
		public static function refocus(): void{
			STG.focus = STG
		}
	}
}
