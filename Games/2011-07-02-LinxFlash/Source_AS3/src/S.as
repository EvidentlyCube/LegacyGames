package {
public function S():SettingsClass {
    return SettingsClass.instance;
}
}

import net.retrocade.camel.interfaces.rISettings;

class SettingsClass implements rISettings {
    public static var instance:SettingsClass = new SettingsClass();


    // ::::::::::::::::::::::::::::::::::::::::::::::
    // :: Game Settings
    // ::::::::::::::::::::::::::::::::::::::::::::::

    public function get eventsCount():uint {
        return 1;
    }

    public function get languages():Array {
        return ['en', 'pl'];
    }

    public function get languagesNames():Array {
        return ['English', 'Polski'];
    }

    public function get gameWidth():uint {
        return 512;
    }

    public function get gameHeight():uint {
        return 448;
    }

    public function get swfWidth():uint {
        return 512;
    }

    public function get swfHeight():uint {
        return 448;
    }

    public function get levelWidth():uint {
        return 192;
    }

    public function get levelHeight():uint {
        return 224;
    }

    public function get saveStorageName(): String {
        return 'flash-linx-101';
    }

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Retrocade
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public var GAME_ID                                 :String         = "17";

        public var DEBUG                                   :Boolean        = false;

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Game Data
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public var TOTAL_LEVELS                            :int            = 40;



        public var SAVE_STORAGE_NAME                       :String         = 'Linx';
        public var SAVE_CRYPTO_KEY                         :String         = '4iJuc8ZO0DM#]\34';

        public var playfieldOffsetX                      :uint           = 64;
        public var playfieldOffsetY                      :uint           = 0;


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Engines
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public var SPATIAL_HASH_CELL                       :Number         = 32;
        public var SPATIAL_HASH_MAX_BUCKETS                :Number         = 1001;

        public var TILE_GRID_TILE_WIDTH                    :Number         = 16;
        public var TILE_GRID_TILE_HEIGHT                   :Number         = 16;
        public var TILE_GRID_WIDTH                         :Number         = 12;
        public var TILE_GRID_HEIGHT                        :Number         = 14;
}