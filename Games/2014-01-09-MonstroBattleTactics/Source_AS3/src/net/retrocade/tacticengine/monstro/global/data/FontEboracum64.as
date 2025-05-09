
package net.retrocade.tacticengine.monstro.global.data {
    import flash.utils.ByteArray;

    import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
    import net.retrocade.tacticengine.monstro.global.core.CoreInit;

    import starling.text.BitmapFont;
    import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class FontEboracum64 extends BitmapFont{
        [Embed(source="/../assets/gfx/fonts/eboracum_64.fnt", mimeType="application/octet-stream")] private static const font_definition:Class;
        [Embed(source="/../assets/gfx/fonts/eboracum_64_0.png")] private static const font_png:Class;

		private static var _texture:Texture;

        public function FontEboracum64() {
            var fontDefinition:ByteArray = new font_definition;

            _offsetY = 0;

			_texture = Texture.fromEmbeddedAsset(font_png, true, false);

            super(
                    _texture,
                    new XML(fontDefinition.readUTFBytes(fontDefinition.length))
            );
			this.smoothing = TextureSmoothing.TRILINEAR;
        }
    }
}
