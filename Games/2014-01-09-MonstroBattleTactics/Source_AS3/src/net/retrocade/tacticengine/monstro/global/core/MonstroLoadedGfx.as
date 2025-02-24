package net.retrocade.tacticengine.monstro.global.core {
	import starling.textures.Texture;

	public class MonstroLoadedGfx {
		public static var mapBackgrounds:Texture;
		public static var mapParchment:Texture;

		public static function initialize():void{
			mapBackgrounds = Texture.fromBitmapData(MonstroGraphicFilesLoader.getBitmapData(MonstroGraphicFilesLoader.MAP_BACKGROUNDS));
			mapParchment = Texture.fromBitmapData(MonstroGraphicFilesLoader.getBitmapData(MonstroGraphicFilesLoader.MAP_PARCHMENT));
		}
	}
}
