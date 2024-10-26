/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 12.01.13
 * Time: 16:59
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.data {
    import flash.utils.ByteArray;

    import net.retrocade.camel.global.rGfx;

    import starling.text.BitmapFont;
    import starling.textures.Texture;

    public class MonstroFont24 extends BitmapFont{
        [Embed(source="/../assets/gfx/sheets/epilog_24.fnt", mimeType="application/octet-stream")] private static const font_definition:Class;
        [Embed(source="/../assets/gfx/sheets/guiSheet.png")] private static var _gui_set_class:Class;

        public static var guiSetTexture:Texture;

        public function MonstroFont24() {
            var fontDefinition:ByteArray = new font_definition;

            guiSetTexture = Texture.fromBitmapData(rGfx.getBD(_gui_set_class));

            super(
                    guiSetTexture,
                    new XML(fontDefinition.readUTFBytes(fontDefinition.length))
            );
        }
    }
}
