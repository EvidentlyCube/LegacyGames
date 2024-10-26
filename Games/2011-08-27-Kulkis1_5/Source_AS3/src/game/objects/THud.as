package game.objects {
	import flash.display.BitmapData;

	import game.global.Game;
	import game.global.Make;
	import game.global.Score;

	import net.retrocade.helpers.RetrocamelScrollAssist;
	import net.retrocade.retrocamel.components.RetrocamelUpdatableObject;
	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.core.RetrocamelCore;
	import net.retrocade.retrocamel.display.flash.RetrocamelBitmapText;
	import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlashBlit;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.utils.UtilsString;

	/**
	 * ...
	 * @author
	 */
	public class THud extends RetrocamelUpdatableObject {
		private static var _instance:THud = new THud;
		public static function get instance():THud {
			return _instance;
		}

		private var _layer:RetrocamelLayerFlashBlit;
		private var _livesIcon:BitmapData;
		private var _keyIcon:BitmapData;
		private var _scoreText:RetrocamelBitmapText;
		private var _multiText:RetrocamelBitmapText;

		private var _level:RetrocamelBitmapText;

		public function THud() {
			_livesIcon = RetrocamelBitmapManager.getBDExt(Game._general_, 96, 224, 16, 16);
			_keyIcon = RetrocamelBitmapManager.getBDExt(Game._general_, 160, 240, 16, 16);

			_scoreText = Make().text("", 0xFFFFFF, 2);
			_scoreText.cache = true;
			_scoreText.addShadow();

			_multiText = Make().text("", 0xFFFFFF, 2);
			_multiText.addShadow();

			_level = Make().text("", 0xFFFFFF, 2);
			_level.cache = true;
			_level.addShadow();

			_scoreText.x = S().gameWidth - 120;
			_scoreText.y = 1;

			_multiText.x = S().gameWidth - 120;
			_multiText.y = 17;

			_level.y = 1;
			_level.x = 0;
		}

		override public function update():void {
			// @TODO  Add shadow to the lives
			for (var i:int = 0, l:int = Score.lives.get(); i < l; i++) {
				_layer.draw(_livesIcon, 4 + i * 5 + RetrocamelScrollAssist.x, 4 + RetrocamelScrollAssist.y);
			}

			var offsetX:uint = (S().levelWidth - 8) / 2 - 5 - 3 * Score.keys.get();
			for (i = 0, l = Score.keys.get(); i < l; i++) {
				_layer.draw(_keyIcon, offsetX + i * 5 + RetrocamelScrollAssist.x, 1 + RetrocamelScrollAssist.y);
			}

			_scoreText.text = _("Points:") + " " + UtilsString.padLeft(Score.score.get().toString(), 8);
			_multiText.text = "x" + Score.multiplier.get().toFixed(2);
			_level.text = _("Level:") + " " + Score.level.get();

			_level.x = (S().gameWidth - _level.width) / 2;
			_scoreText.x = S().gameWidth - _scoreText.width - 8;
			_multiText.x = S().gameWidth - _multiText.width - 8;
		}

		public function hookTo(layer:RetrocamelLayerFlashBlit):void {
			RetrocamelCore.groupAfter.add(this);
			_layer = layer;

			Game.lMain.add(_scoreText);
			//Game.lMain.add(_level);
			Game.lMain.add(_multiText);
		}

		public function unhook():void {
			RetrocamelCore.groupAfter.nullify(this);
			Game.lMain.clear();
		}
	}
}