package {
    public class S {
        public static const FONT_OLD:String = "Pixelmix";
        public static const FONT_OLD_SHADOW:String = "Pixelmix_Shadow";

        public static const FONT_ORANGE:String = "font_orange";
        public static const FONT_GREEN:String = "font_green";
        public static const FONT_RED:String = "font_red";
        public static const FONT_ORANGE_BOLD:String = "font_orange_bold";
        public static const FONT_GREEN_BOLD:String = "font_green_bold";
        public static const FONT_RED_BOLD:String = "font_red_bold";

        public static function get debug():Boolean {
            return false;
        }

        public static function get eventsCount():uint {
            return 0;
        }

        public static function get languages():Array {
            return ['en'];
        }

        public static function get scale():uint {
            return 2;
        }

        public static function get scaleToFull():Boolean {
            return false;
        }

        public static function get backgroundColor():uint {
            return 0x080F17;
        }

        public static function get gameWidth():uint {
            return 480; //30 tiles
        }

        public static function get gameHeight():uint {
            return 352; //22 tiles
        }

        public static function get defaultLevelWidthTiles():uint{
            return 30;
        }

        public static function get defaultLevelHeightTiles():uint{
            return 22;
        }

        public static function get tileEdge():uint {
            return 16;
        }

        public static function get tilesetWidthInTiles():uint {
            return 112;
        }
    }
}
