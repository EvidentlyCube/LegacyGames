package Classes.Scenes{
	import Classes.Menu.*;

	import LoadingDir.Loading;

	import flash.display.Sprite;
	import flash.geom.Rectangle;

	import mx.core.BitmapAsset;
	public class TMenuScene extends TScene{
		public static var created: Boolean = false
		public static var logo: BitmapAsset
		public static var tix: Number = 0
		public static var menuMain: TMainMenu
		public static var container: Sprite
		public function TMenuScene(){
			if (created){container.alpha = 0;return}
			container = new Sprite
			container.alpha = 0
			logo = new (Loading.g_logo)
			menuMain = new TMainMenu()
			created = true
			container.addChild(logo)
			container.addChild(menuMain)
		}
		override public function update(): void{
			//tix += 0.03
			logo.y = Math.sin(tix)*4
			if (container.alpha < 1){container.alpha += 0.05}
			menuMain.update()
			if (TD.layerFader.alpha > 0){TD.layerFader.alpha -= 0.05}
		}
		override public function add(): void{
			TD.addLayer(TD.layerBg)
			TD.addLayer(container)
			TD.addLayer(TD.layerFader)
			TD.layerFader.alpha = 1
		}
		override public function remove(): void{
			TD.removeLayer(TD.layerBg)
			TD.removeLayer(container)
			TD.removeLayer(TD.layerFader)
			TD.layerFaderData.fillRect(new Rectangle(0, 0,600, 600), 0x00000000)
			//TD.layerFaderData.draw(container)
		}
	}
}