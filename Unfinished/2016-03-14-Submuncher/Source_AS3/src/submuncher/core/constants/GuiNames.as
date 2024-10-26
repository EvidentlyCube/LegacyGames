package submuncher.core.constants {
    public class GuiNames {
        public static const MONITOR_BACKGROUND:String = "level_selection_menu";
        public static const MONITOR_COMPLETION:String = "monitor_completion";
        public static const MONITOR_COMPLETION_DONE:String = "monitor_completion_done";
        public static const MONITOR_DOCUMENT:String = "monitor_document";
        public static const MONITOR_DOCUMENT_DONE:String = "monitor_document_done";
        public static const MONITOR_EXIT:String = "monitor_exit";
        public static const MONITOR_EXIT_SELECTED:String = "monitor_exit_selected";
        public static const MONITOR_LEVEL:String = "monitor_level";
        public static const MONITOR_LEVEL_COMPLETED:String = "monitor_level_completed";
        public static const MONITOR_LEVEL_COMPLETED_SELECTED:String = "monitor_level_completed_selected";
        public static const MONITOR_LEVEL_SELECTED:String = "monitor_level_selected";
        public static const MONITOR_NEXT:String = "monitor_next";
        public static const MONITOR_NEXT_COMPLETED:String = "monitor_next_completed";
        public static const MONITOR_NEXT_COMPLETED_SELECTED:String = "monitor_next_completed_selected";
        public static const MONITOR_NEXT_SELECTED:String = "monitor_next_selected";
        public static const MONITOR_OPTIONAL:String = "monitor_optional";
        public static const MONITOR_OPTIONAL_COMPLETED:String = "monitor_optional_completed";
        public static const MONITOR_OPTIONAL_COMPLETED_SELECTED:String = "monitor_optional_completed_selected";
        public static const MONITOR_OPTIONAL_SELECTED:String = "monitor_optional_selected";
        public static const MONITOR_PAR:String = "monitor_par";
        public static const MONITOR_PAR_DONE:String = "monitor_par_done";
        public static const MONITOR_PREV:String = "monitor_prev";
        public static const MONITOR_PREV_COMPLETED:String = "monitor_prev_completed";
        public static const MONITOR_PREV_COMPLETED_SELECTED:String = "monitor_prev_completed_selected";
        public static const MONITOR_PREV_SELECTED:String = "monitor_prev_selected";
        public static const MONITOR_SECRET:String = "monitor_secret";
        public static const MONITOR_SECRET_DONE:String = "monitor_secret_done";
        public static const MONITOR_RESTART:String = "monitor_restart";
        public static const MONITOR_RESTART_SELECTED:String = "monitor_restart_selected";
        public static const MONITOR_NEXT_LEVEL:String = "monitor_next_level";
        public static const MONITOR_NEXT_LEVEL_SELECTED:String = "monitor_next_level_selected";
        public static const SCREEN_BACKGROUND:String = "screen_background";
        public static const DIGITS:String = "digits";
        public static const HUD_TIME:String = "hud_time";
        public static const HUD_AMMO:String = "hud_ammo";
        public static const HUD_KEYS_BLUE:String = "hud_keys_blue";
        public static const HUD_KEYS_GRAY:String = "hud_keys_gray";
        public static const HUD_KEYS_GREEN:String = "hud_keys_green";
        public static const HUD_KEYS_ORANGE:String = "hud_keys_orange";
        public static const HUD_KEYS_RED:String = "hud_keys_red";
        public static const SCANLINE:String = "scanline";

        public static const FONT_OLD:String = "pixelmix_font";
        public static const FONT_OLD_SHADOW:String = "pixelmix_font_shadow";

        public static const FONT_ORANGE:String = "font_orange";
        public static const FONT_GREEN:String = "font_green";
        public static const FONT_RED:String = "font_red";
        public static const FONT_ORANGE_BOLD:String = "font_orange_bold";
        public static const FONT_GREEN_BOLD:String = "font_green_bold";
        public static const FONT_RED_BOLD:String = "font_red_bold";

        public static function getHudKeyIcon(color:LockColor):String {
            switch(color){
                case(LockColor.BLUE): return HUD_KEYS_BLUE;
                case(LockColor.GRAY): return HUD_KEYS_GRAY;
                case(LockColor.GREEN): return HUD_KEYS_GREEN;
                case(LockColor.ORANGE): return HUD_KEYS_ORANGE;
                case(LockColor.RED): return HUD_KEYS_RED;
                default: throw new Error("Invalid color for hud key icon: " + color);
            }
        }
    }
}
