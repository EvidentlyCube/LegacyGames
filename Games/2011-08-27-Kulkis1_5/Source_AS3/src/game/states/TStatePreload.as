package game.states {
	import flash.display.Bitmap;
	import flash.display.Sprite;

	import game.core.preloader.Preloader;

	import game.global.Make;

	import net.retrocade.retrocamel.components.RetrocamelStateBase;
	import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
	import net.retrocade.retrocamel.locale._;

	public class TStatePreload extends RetrocamelStateBase {
		[Embed(source="../../../assets/gfx/by_cage/bgs/title15_regular.png")] public static var __logo_r__:Class;

		private var logo:Bitmap;
		private var desc:RetrocamelBitmapText;

		private var load:RetrocamelBitmapText;
		private var loadWaver:Number = 0;

		private var parent:Sprite = new Sprite;

		public function TStatePreload() {
			logo = new TStatePreload['__logo_r__'];

			logo.scaleX = logo.scaleY = 2;
			logo.x = (S().gameWidth - logo.width) / 2 | 0;
			logo.y = 40;

			desc = Make().text("");

			desc.align = RetrocamelBitmapText.ALIGN_MIDDLE;
			desc.setScale(2);
			desc.text = desc.getWordWrapToWidth(_("preloadDesc"), 230);

			desc.x = (S().gameWidth - desc.width) / 2;
			desc.y = 230;

			load = Make().text(_("loading") + " " + Preloader.percent.toFixed(1) + "%");
			load.setScale(2);

			parent.addChild(logo);
			parent.addChild(desc);
			parent.addChild(load);
		}

		override public function create():void {
			Preloader.loaderLayer.add(parent);
			RetrocamelEffectFadeScreen.makeIn().duration(500).run();
		}

		override public function destroy():void {
			Preloader.loaderLayer.remove(parent);
		}

		override public function update():void {
			super.update();

			load.text = _("loading") + " " + Preloader.percent.toFixed(1) + "%";
			load.x = (S().gameWidth - load.width) / 2;
			load.y = 187 + Math.cos(loadWaver += Math.PI / 110) * 5;
		}
	}
}