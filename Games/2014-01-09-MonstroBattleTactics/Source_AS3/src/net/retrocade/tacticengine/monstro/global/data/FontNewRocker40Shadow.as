
package net.retrocade.tacticengine.monstro.global.data {
    import flash.utils.ByteArray;

    import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
    import net.retrocade.tacticengine.monstro.global.core.CoreInit;

    import starling.text.BitmapFont;
    import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class FontNewRocker40Shadow extends BitmapFont{
        [Embed(source="/../assets/gfx/fonts/NewRocker_40_Shaded.fnt", mimeType="application/octet-stream")] private static const font_definition:Class;
        [Embed(source="/../assets/gfx/fonts/NewRocker_40_Shaded_0.png")] private static const font_png:Class;

		private static var _texture:Texture;

        public function FontNewRocker40Shadow() {
            var fontDefinition:ByteArray = new font_definition;

            _offsetY = 0;

			_texture = Texture.fromEmbeddedAsset(font_png, true);

            super(
                    _texture,
                    new XML(fontDefinition.readUTFBytes(fontDefinition.length))
            );

			smoothing = TextureSmoothing.TRILINEAR;
        }
    }
}
