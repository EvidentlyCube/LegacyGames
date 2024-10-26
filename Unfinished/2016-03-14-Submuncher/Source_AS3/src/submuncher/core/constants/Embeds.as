package submuncher.core.constants {
    import flash.display.BitmapData;
    import flash.errors.MemoryError;
    // import flash.filesystem.File;
    import flash.utils.ByteArray;

    public class Embeds {
        [Embed(source="/../assets/gfx/sheets/sprites.png")] public static var SPRITES_PNG:Class;
        [Embed(source="/../assets/gfx/sheets/tileset.png")] public static var TILESET_PNG:Class;
        [Embed(source="/../assets/gfx/sheets/tileset_bg.png")] public static var TILESET_BACKGROUND_PNG:Class;
        [Embed(source="/../assets/gfx/sheets/sprites.json", mimeType = "application/octet-stream")] public static var SPRITES_JSON:Class;
        [Embed(source="/../assets/gfx/backgrounds/water_background.png")] public static var BACKGROUND_WATER_PNG:Class;
        [Embed(source="/../assets/gfx/sheets/background_a.png")] public static var BACKGROUND_A_PNG:Class;
        [Embed(source="/../assets/gfx/sheets/background_a.json", mimeType = "application/octet-stream")] public static var BACKGROUND_A_JSON:Class;
        [Embed(source="/../assets/gfx/sheets/edge_cover_grid9.png")] public static var EDGE_COVER_GRID9_PNG:Class;
        [Embed(source="/../assets/gfx/sheets/gui.png")] public static var GUI_PNG:Class;
        [Embed(source="/../assets/gfx/sheets/gui.json", mimeType = "application/octet-stream")] public static var GUI_JSON:Class;
        [Embed(source="/../assets/fonts/pixelmix.fnt", mimeType = "application/octet-stream")] public static var FONT_OLD_DATA:Class;
        [Embed(source="/../assets/fonts/pixelmix_shadow.fnt", mimeType = "application/octet-stream")] public static var FONT_OLD_SHADOW_DATA:Class;
        [Embed(source="/../assets/fonts/coders_crux_regular.fnt", mimeType = "application/octet-stream")] public static var FONT_REGULAR_DATA:Class;
        [Embed(source="/../assets/fonts/coders_crux_bold.fnt", mimeType = "application/octet-stream")] public static var FONT_BOLD_DATA:Class;
        [Embed(source="/../assets/i18n/en.txt", mimeType = "application/octet-stream")] public static var I18N_ENGLISH:Class;
        [Embed(source="/../assets/gfx/backgrounds/map.png")] public static var LEVEL_SELECTION_MAP_PNG:Class;
        [Embed(source="/../assets/gfx/sheets/editor_base_fg.png")] public static var EDITOR_BASE_FG_TILESET_PNG:Class;
        [Embed(source="/../assets/gfx/sheets/editor_base_fg_v.png")] public static var EDITOR_BASE_FG_VAR_TILESET_PNG:Class;
    }
}
