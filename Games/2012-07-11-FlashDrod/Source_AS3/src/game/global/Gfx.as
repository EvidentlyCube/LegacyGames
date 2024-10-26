package game.global{
    import flash.display.BitmapData;

    import net.retrocade.camel.core.rGfx;

    public class Gfx{
        [Embed(source="/../assets/gfx/general.png")] public static const CLASS_GENERAL_TILES:Class;
        [Embed(source="/../assets/gfx/effects/effects.png")] public static const CLASS_EFFECTS:Class;

        // Aboveground Style
        CF::styleAbo{
            [Embed(source="/../assets/gfx/style_aboveground/wall.png")]         private static const __above_wall         :Class;
            [Embed(source="/../assets/gfx/style_aboveground/floor.png")]        private static const __above_floor        :Class;
            [Embed(source="/../assets/gfx/style_aboveground/floorAlt.png")]     private static const __above_floor_alt    :Class;
            [Embed(source="/../assets/gfx/style_aboveground/floorDirt.png")]    private static const __above_floor_dirt   :Class;
            [Embed(source="/../assets/gfx/style_aboveground/floorGrass.png")]   private static const __above_floor_grass  :Class;
            [Embed(source="/../assets/gfx/style_aboveground/floorMosaic.png")]  private static const __above_floor_mosaic :Class;
            [Embed(source="/../assets/gfx/style_aboveground/floorRoad.png")]    private static const __above_floor_road   :Class;
            [Embed(source="/../assets/gfx/style_aboveground/pit.png")]          private static const __above_pit          :Class;
            [Embed(source="/../assets/gfx/style_aboveground/pitside.png")]      private static const __above_pitside      :Class;
            [Embed(source="/../assets/gfx/style_aboveground/pitsideSmall.png")] private static const __above_pitside_small:Class;
            [Embed(source="/../assets/gfx/style_aboveground/tiles.png")]        private static const __above_tiles        :Class;
        }

        // City Style
        CF::styleCit{
            [Embed(source="/../assets/gfx/style_city/wall.png")]         private static const __city_wall         :Class;
            [Embed(source="/../assets/gfx/style_city/floor.png")]        private static const __city_floor        :Class;
            [Embed(source="/../assets/gfx/style_city/floorAlt.png")]     private static const __city_floor_alt    :Class;
            [Embed(source="/../assets/gfx/style_city/floorDirt.png")]    private static const __city_floor_dirt   :Class;
            [Embed(source="/../assets/gfx/style_city/floorGrass.png")]   private static const __city_floor_grass  :Class;
            [Embed(source="/../assets/gfx/style_city/floorMosaic.png")]  private static const __city_floor_mosaic :Class;
            [Embed(source="/../assets/gfx/style_city/floorRoad.png")]    private static const __city_floor_road   :Class;
            [Embed(source="/../assets/gfx/style_city/pit.jpg")]          private static const __city_pit          :Class;
            [Embed(source="/../assets/gfx/style_city/pitside.png")]      private static const __city_pitside      :Class;
            [Embed(source="/../assets/gfx/style_city/pitsideSmall.png")] private static const __city_pitside_small:Class;
            [Embed(source="/../assets/gfx/style_city/tiles.png")]        private static const __city_tiles        :Class;
        }

        // Deep spaces Style
        CF::styleDee{
            [Embed(source="/../assets/gfx/style_deep_spaces/wall.jpg")]         private static const __deep_wall         :Class;
            [Embed(source="/../assets/gfx/style_deep_spaces/floor.png")]        private static const __deep_floor        :Class;
            [Embed(source="/../assets/gfx/style_deep_spaces/floorAlt.jpg")]     private static const __deep_floor_alt    :Class;
            [Embed(source="/../assets/gfx/style_deep_spaces/floorDirt.png")]    private static const __deep_floor_dirt   :Class;
            [Embed(source="/../assets/gfx/style_deep_spaces/floorGrass.jpg")]   private static const __deep_floor_grass  :Class;
            [Embed(source="/../assets/gfx/style_deep_spaces/floorMosaic.jpg")]  private static const __deep_floor_mosaic :Class;
            [Embed(source="/../assets/gfx/style_deep_spaces/floorRoad.jpg")]    private static const __deep_floor_road   :Class;
            [Embed(source="/../assets/gfx/style_deep_spaces/pit.jpg")]          private static const __deep_pit          :Class;
            [Embed(source="/../assets/gfx/style_deep_spaces/pitside.png")]      private static const __deep_pitside      :Class;
            [Embed(source="/../assets/gfx/style_deep_spaces/pitsideSmall.png")] private static const __deep_pitside_small:Class;
            [Embed(source="/../assets/gfx/style_deep_spaces/tiles.png")]        private static const __deep_tiles        :Class;
        }

        // Fortress Style
        CF::styleFor{
            [Embed(source="/../assets/gfx/style_fortress/wall.png")]         private static const __fort_wall         :Class;
            [Embed(source="/../assets/gfx/style_fortress/floor.png")]        private static const __fort_floor        :Class;
            [Embed(source="/../assets/gfx/style_fortress/floorAlt.png")]     private static const __fort_floor_alt    :Class;
            [Embed(source="/../assets/gfx/style_fortress/floorDirt.png")]    private static const __fort_floor_dirt   :Class;
            [Embed(source="/../assets/gfx/style_fortress/floorGrass.png")]   private static const __fort_floor_grass  :Class;
            [Embed(source="/../assets/gfx/style_fortress/floorMosaic.png")]  private static const __fort_floor_mosaic :Class;
            [Embed(source="/../assets/gfx/style_fortress/floorRoad.png")]    private static const __fort_floor_road   :Class;
            [Embed(source="/../assets/gfx/style_fortress/pit.png")]          private static const __fort_pit          :Class;
            [Embed(source="/../assets/gfx/style_fortress/pitside.png")]      private static const __fort_pitside      :Class;
            [Embed(source="/../assets/gfx/style_fortress/pitsideSmall.png")] private static const __fort_pitside_small:Class;
            [Embed(source="/../assets/gfx/style_fortress/tiles.png")]        private static const __fort_tiles        :Class;
        }

        // Foundation Style
        CF::styleFou{
            [Embed(source="/../assets/gfx/style_foundation/wall.png")]         private static const __found_wall         :Class;
            [Embed(source="/../assets/gfx/style_foundation/floor.png")]        private static const __found_floor        :Class;
            [Embed(source="/../assets/gfx/style_foundation/floorAlt.jpg")]     private static const __found_floor_alt    :Class;
            [Embed(source="/../assets/gfx/style_foundation/floorDirt.jpg")]    private static const __found_floor_dirt   :Class;
            [Embed(source="/../assets/gfx/style_foundation/floorGrass.jpg")]   private static const __found_floor_grass  :Class;
            [Embed(source="/../assets/gfx/style_foundation/floorMosaic.jpg")]  private static const __found_floor_mosaic :Class;
            [Embed(source="/../assets/gfx/style_foundation/floorRoad.jpg")]    private static const __found_floor_road   :Class;
            [Embed(source="/../assets/gfx/style_foundation/pit.png")]          private static const __found_pit          :Class;
            [Embed(source="/../assets/gfx/style_foundation/pitside.png")]      private static const __found_pitside      :Class;
            [Embed(source="/../assets/gfx/style_foundation/pitsideSmall.png")] private static const __found_pitside_small:Class;
            [Embed(source="/../assets/gfx/style_foundation/tiles.png")]        private static const __found_tiles        :Class;
        }

        // Iceworks Style
        CF::styleIce{
            [Embed(source="/../assets/gfx/style_iceworks/wall.jpg")]         private static const __ice_wall         :Class;
            [Embed(source="/../assets/gfx/style_iceworks/floor.jpg")]        private static const __ice_floor        :Class;
            [Embed(source="/../assets/gfx/style_iceworks/floorAlt.jpg")]     private static const __ice_floor_alt    :Class;
            [Embed(source="/../assets/gfx/style_iceworks/floorDirt.jpg")]    private static const __ice_floor_dirt   :Class;
            [Embed(source="/../assets/gfx/style_iceworks/floorGrass.jpg")]   private static const __ice_floor_grass  :Class;
            [Embed(source="/../assets/gfx/style_iceworks/floorMosaic.jpg")]  private static const __ice_floor_mosaic :Class;
            [Embed(source="/../assets/gfx/style_iceworks/floorRoad.jpg")]    private static const __ice_floor_road   :Class;
            [Embed(source="/../assets/gfx/style_iceworks/pit.png")]          private static const __ice_pit          :Class;
            [Embed(source="/../assets/gfx/style_iceworks/pitside.png")]      private static const __ice_pitside      :Class;
            [Embed(source="/../assets/gfx/style_iceworks/pitsideSmall.png")] private static const __ice_pitside_small:Class;
            [Embed(source="/../assets/gfx/style_iceworks/tiles.png")]        private static const __ice_tiles        :Class;
        }

        [Embed(source="/../assets/gfx/effects/bolts.png")]  private static const __bolts:Class;

        [Embed(source="/../assets/gfx/ui/faces.png")]   private static const __faces:Class;
        [Embed(source="/../assets/gfx/ui/eyes.png")]    private static const __eyes :Class;
        [Embed(source="/../assets/gfx/ui/scrolls.png")] private static const __scrolls:Class;

        [Embed(source='/../assets/gfx/ui/GameScreen.jpg')]           private static const __game_screen:Class;
        [Embed(source="/../assets/gfx/ui/menuBG.jpg")]               public  static const CLASS_MENU_BACKGROUND       :Class;
        [Embed(source="/../assets/gfx/ui/levelStartBackground.jpg")] public  static const CLASS_LEVEL_START_BACKGROUND:Class;
        [Embed(source="/../assets/gfx/ui/titleScreen.jpg")]          public  static const CLASS_TITLE_SCREEN_BACKGROUND:Class;

        CF::holdKdd1{
            [Embed(source="/../assets/gfx/ui/logo_kdd1.png")] public  static const CLASS_LOGO:Class;
        }
        CF::holdKdd2{
            [Embed(source="/../assets/gfx/ui/logo_kdd2.png")] public  static const CLASS_LOGO:Class;
        }
        CF::holdKdd3{
            [Embed(source="/../assets/gfx/ui/logo_kdd3.png")] public  static const CLASS_LOGO:Class;
        }




        [Embed(source="/../assets/gfx/ui/logoCaravel.jpg")]                 public  static const CLASS_LOGO_CARAVEL:Class;
        [Embed(source="/../assets/gfx/ui/logoRetrocade.jpg")]               public  static const CLASS_LOGO_RETROCADE:Class;

        [Embed(source="/../assets/gfx/ui/achievement.png")]              private static const __achievement:Class;
        [Embed(source="/../assets/gfx/ui/lock.png")]                     private static const __lock:Class;

        public static const GENERAL_TILES    :BitmapData = rGfx.getBD(CLASS_GENERAL_TILES);
        public static const EFFECTS_TILES    :BitmapData = rGfx.getBD(CLASS_EFFECTS);

        public static const STYLES:Array = [];

        public static const BOLTS:BitmapData = rGfx.getBD(__bolts);

        public static const SCROLLS    :BitmapData = rGfx.getBD(__scrolls);
        public static const IN_GAME_SCREEN:BitmapData = rGfx.getBD(__game_screen);

        public static const EYES :BitmapData = rGfx.getBD(__eyes);
        public static const FACES:BitmapData = rGfx.getBD(__faces);

        public static const ACHIEVEMENT:BitmapData = rGfx.getBD(__achievement);

        public static const LOCK:BitmapData = rGfx.getBD(__lock);


        { init(); }

        private static function init():void {
            CF::styleAbo{
                initAboveground();
            }

            CF::styleCit{
                initCity();
            }

            CF::styleDee{
                initDeepSpaces();
            }

            CF::styleFor{
                initFortress();
            }

            CF::styleFou{
                initFoundation();
            }

            CF::styleIce{
                initIceworks();
            }
        }

        CF::styleAbo
        private static function initAboveground():void{
            STYLES[T.STYLE_ABOVEGROUND] = [];
            STYLES[T.STYLE_ABOVEGROUND][T.TILES]               = rGfx.getBD(__above_tiles);
            STYLES[T.STYLE_ABOVEGROUND][T.TILES_FLOOR]         = rGfx.getBD(__above_floor);
            STYLES[T.STYLE_ABOVEGROUND][T.TILES_FLOOR_ALT]     = rGfx.getBD(__above_floor_alt);
            STYLES[T.STYLE_ABOVEGROUND][T.TILES_FLOOR_DIRT]    = rGfx.getBD(__above_floor_dirt);
            STYLES[T.STYLE_ABOVEGROUND][T.TILES_FLOOR_GRASS]   = rGfx.getBD(__above_floor_grass);
            STYLES[T.STYLE_ABOVEGROUND][T.TILES_FLOOR_MOSAIC]  = rGfx.getBD(__above_floor_mosaic);
            STYLES[T.STYLE_ABOVEGROUND][T.TILES_FLOOR_ROAD]    = rGfx.getBD(__above_floor_road);
            STYLES[T.STYLE_ABOVEGROUND][T.TILES_PIT]           = rGfx.getBD(__above_pit);
            STYLES[T.STYLE_ABOVEGROUND][T.TILES_PITSIDE]       = rGfx.getBD(__above_pitside);
            STYLES[T.STYLE_ABOVEGROUND][T.TILES_PITSIDE_SMALL] = rGfx.getBD(__above_pitside_small);
            STYLES[T.STYLE_ABOVEGROUND][T.TILES_WALL]          = rGfx.getBD(__above_wall);
        }

        CF::styleCit
        private static function initCity():void{
            STYLES[T.STYLE_CITY] = [];
            STYLES[T.STYLE_CITY][T.TILES]               = rGfx.getBD(__city_tiles);
            STYLES[T.STYLE_CITY][T.TILES_FLOOR]         = rGfx.getBD(__city_floor);
            STYLES[T.STYLE_CITY][T.TILES_FLOOR_ALT]     = rGfx.getBD(__city_floor_alt);
            STYLES[T.STYLE_CITY][T.TILES_FLOOR_DIRT]    = rGfx.getBD(__city_floor_dirt);
            STYLES[T.STYLE_CITY][T.TILES_FLOOR_GRASS]   = rGfx.getBD(__city_floor_grass);
            STYLES[T.STYLE_CITY][T.TILES_FLOOR_MOSAIC]  = rGfx.getBD(__city_floor_mosaic);
            STYLES[T.STYLE_CITY][T.TILES_FLOOR_ROAD]    = rGfx.getBD(__city_floor_road);
            STYLES[T.STYLE_CITY][T.TILES_PIT]           = rGfx.getBD(__city_pit);
            STYLES[T.STYLE_CITY][T.TILES_PITSIDE]       = rGfx.getBD(__city_pitside);
            STYLES[T.STYLE_CITY][T.TILES_PITSIDE_SMALL] = rGfx.getBD(__city_pitside_small);
            STYLES[T.STYLE_CITY][T.TILES_WALL]          = rGfx.getBD(__city_wall);
        }

        CF::styleDee
        private static function initDeepSpaces():void{
            STYLES[T.STYLE_DEEP_SPACES] = [];
            STYLES[T.STYLE_DEEP_SPACES][T.TILES]               = rGfx.getBD(__deep_tiles);
            STYLES[T.STYLE_DEEP_SPACES][T.TILES_FLOOR]         = rGfx.getBD(__deep_floor);
            STYLES[T.STYLE_DEEP_SPACES][T.TILES_FLOOR_ALT]     = rGfx.getBD(__deep_floor_alt);
            STYLES[T.STYLE_DEEP_SPACES][T.TILES_FLOOR_DIRT]    = rGfx.getBD(__deep_floor_dirt);
            STYLES[T.STYLE_DEEP_SPACES][T.TILES_FLOOR_GRASS]   = rGfx.getBD(__deep_floor_grass);
            STYLES[T.STYLE_DEEP_SPACES][T.TILES_FLOOR_MOSAIC]  = rGfx.getBD(__deep_floor_mosaic);
            STYLES[T.STYLE_DEEP_SPACES][T.TILES_FLOOR_ROAD]    = rGfx.getBD(__deep_floor_road);
            STYLES[T.STYLE_DEEP_SPACES][T.TILES_PIT]           = rGfx.getBD(__deep_pit);
            STYLES[T.STYLE_DEEP_SPACES][T.TILES_PITSIDE]       = rGfx.getBD(__deep_pitside);
            STYLES[T.STYLE_DEEP_SPACES][T.TILES_PITSIDE_SMALL] = rGfx.getBD(__deep_pitside_small);
            STYLES[T.STYLE_DEEP_SPACES][T.TILES_WALL]          = rGfx.getBD(__deep_wall);
        }

        CF::styleFor
        private static function initFortress():void{
            STYLES[T.STYLE_FORTRESS] = [];
            STYLES[T.STYLE_FORTRESS][T.TILES]               = rGfx.getBD(__fort_tiles);
            STYLES[T.STYLE_FORTRESS][T.TILES_FLOOR]         = rGfx.getBD(__fort_floor);
            STYLES[T.STYLE_FORTRESS][T.TILES_FLOOR_ALT]     = rGfx.getBD(__fort_floor_alt);
            STYLES[T.STYLE_FORTRESS][T.TILES_FLOOR_DIRT]    = rGfx.getBD(__fort_floor_dirt);
            STYLES[T.STYLE_FORTRESS][T.TILES_FLOOR_GRASS]   = rGfx.getBD(__fort_floor_grass);
            STYLES[T.STYLE_FORTRESS][T.TILES_FLOOR_MOSAIC]  = rGfx.getBD(__fort_floor_mosaic);
            STYLES[T.STYLE_FORTRESS][T.TILES_FLOOR_ROAD]    = rGfx.getBD(__fort_floor_road);
            STYLES[T.STYLE_FORTRESS][T.TILES_PIT]           = rGfx.getBD(__fort_pit);
            STYLES[T.STYLE_FORTRESS][T.TILES_PITSIDE]       = rGfx.getBD(__fort_pitside);
            STYLES[T.STYLE_FORTRESS][T.TILES_PITSIDE_SMALL] = rGfx.getBD(__fort_pitside_small);
            STYLES[T.STYLE_FORTRESS][T.TILES_WALL]          = rGfx.getBD(__fort_wall);
        }

        CF::styleFou
        private static function initFoundation():void{
            STYLES[T.STYLE_FOUNDATION] = [];
            STYLES[T.STYLE_FOUNDATION][T.TILES]               = rGfx.getBD(__found_tiles);
            STYLES[T.STYLE_FOUNDATION][T.TILES_FLOOR]         = rGfx.getBD(__found_floor);
            STYLES[T.STYLE_FOUNDATION][T.TILES_FLOOR_ALT]     = rGfx.getBD(__found_floor_alt);
            STYLES[T.STYLE_FOUNDATION][T.TILES_FLOOR_DIRT]    = rGfx.getBD(__found_floor_dirt);
            STYLES[T.STYLE_FOUNDATION][T.TILES_FLOOR_GRASS]   = rGfx.getBD(__found_floor_grass);
            STYLES[T.STYLE_FOUNDATION][T.TILES_FLOOR_MOSAIC]  = rGfx.getBD(__found_floor_mosaic);
            STYLES[T.STYLE_FOUNDATION][T.TILES_FLOOR_ROAD]    = rGfx.getBD(__found_floor_road);
            STYLES[T.STYLE_FOUNDATION][T.TILES_PIT]           = rGfx.getBD(__found_pit);
            STYLES[T.STYLE_FOUNDATION][T.TILES_PITSIDE]       = rGfx.getBD(__found_pitside);
            STYLES[T.STYLE_FOUNDATION][T.TILES_PITSIDE_SMALL] = rGfx.getBD(__found_pitside_small);
            STYLES[T.STYLE_FOUNDATION][T.TILES_WALL]          = rGfx.getBD(__found_wall);
        }

        CF::styleIce
        private static function initIceworks():void{
            STYLES[T.STYLE_ICEWORKS] = [];
            STYLES[T.STYLE_ICEWORKS][T.TILES]               = rGfx.getBD(__ice_tiles);
            STYLES[T.STYLE_ICEWORKS][T.TILES_FLOOR]         = rGfx.getBD(__ice_floor);
            STYLES[T.STYLE_ICEWORKS][T.TILES_FLOOR_ALT]     = rGfx.getBD(__ice_floor_alt);
            STYLES[T.STYLE_ICEWORKS][T.TILES_FLOOR_DIRT]    = rGfx.getBD(__ice_floor_dirt);
            STYLES[T.STYLE_ICEWORKS][T.TILES_FLOOR_GRASS]   = rGfx.getBD(__ice_floor_grass);
            STYLES[T.STYLE_ICEWORKS][T.TILES_FLOOR_MOSAIC]  = rGfx.getBD(__ice_floor_mosaic);
            STYLES[T.STYLE_ICEWORKS][T.TILES_FLOOR_ROAD]    = rGfx.getBD(__ice_floor_road);
            STYLES[T.STYLE_ICEWORKS][T.TILES_PIT]           = rGfx.getBD(__ice_pit);
            STYLES[T.STYLE_ICEWORKS][T.TILES_PITSIDE]       = rGfx.getBD(__ice_pitside);
            STYLES[T.STYLE_ICEWORKS][T.TILES_PITSIDE_SMALL] = rGfx.getBD(__ice_pitside_small);
            STYLES[T.STYLE_ICEWORKS][T.TILES_WALL]          = rGfx.getBD(__ice_wall);
        }
    }
}