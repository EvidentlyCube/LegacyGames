/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 28.09.13
 * Time: 17:11
 * To change this template use File | Settings | File Templates.
 */
package game.global {
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;

	public class Gfx {

		[Embed(source="/../assets/gfx/tiles/tileset.png", mimeType="image/png")]
		private static var _tileset_:Class;
		[Embed(source='/../assets/gfx/bgs/backgroundTitleScreen.png', mimeType="image/png")]
		private static var _background_titleScreen_:Class;
		[Embed(source='/../assets/gfx/bgs/backgroundIngame.png', mimeType="image/png")]
		private static var _background_ingame_:Class;
		[Embed(source="/../assets/gfx/bgs/logo_regular.png")]
		private static var _logo_regular_:Class;

		public static function get tilesetClass():Class {
			return _tileset_;
		}

		public static function get logoBitmap():Bitmap {
			return new _logo_regular_;
		}

		public static function get backgroundTitleScreenBitmapData():BitmapData {
			return RetrocamelBitmapManager.getBD(_background_titleScreen_);
		}

		public static function get backgroundIngameBitmapData():BitmapData {
			return RetrocamelBitmapManager.getBD(_background_ingame_);
		}
	}
}
