package submuncher.core.fonts {
    import flash.geom.Point;

    import starling.text.BitmapFont;
    import starling.textures.TextureSmoothing;

    import submuncher.core.constants.GameFile;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.GuiNames;

    public class FontOrangeBold extends BitmapFont{
        public function FontOrangeBold() {
            var offset:Point = Gfx.getTextureOffset(GuiNames.FONT_ORANGE_BOLD);
            _offsetX = Math.round(offset.x);
            _offsetY = Math.round(offset.y);

            super(
                Gfx.guiTexture,
                GameFile.FONT_BOLD_DATA.getXml()
            );
            this.smoothing = TextureSmoothing.NONE;
        }
    }
}
