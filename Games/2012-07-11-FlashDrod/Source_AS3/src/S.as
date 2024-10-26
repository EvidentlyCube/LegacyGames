package{
    public class S {

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Game Specific settings
        // ::::::::::::::::::::::::::::::::::::::::::::::

        CF::lib{
            public static const VERSION                                 :String         = "Kdd3 V0.79";
            public static const SAVE_STORAGE_NAME                       :String         = 'drod/KDDLite2_rc';
            public static const SAVE_CRYPTO_KEY                         :String         = '49fidDnWI0@kapcd';
        }

        CF::holdKdd1 {
            public static const VERSION                                 :String         = "Kdd1 \nV0.99h";
            public static const SAVE_STORAGE_NAME                       :String         = 'drod/KDDLite1_rc';
            public static const SAVE_CRYPTO_KEY                         :String         = '3523dX9Sdwq#]\34';
            public static const FILE_SIZE                               :Number         = 9425054;
        }
        CF::holdKdd2{
            public static const VERSION                                 :String         = "Kdd2 \nV0.99h";
            public static const SAVE_STORAGE_NAME                       :String         = 'drod/KDDLite2_rc';
            public static const SAVE_CRYPTO_KEY                         :String         = '4D=zdD9S-S[]aScR';
            public static const FILE_SIZE                               :Number         = 11223849;
        }
        CF::holdKdd3{
            public static const VERSION                                 :String         = "Kdd3 \nV0.99h";
            public static const SAVE_STORAGE_NAME                       :String         = 'drod/KDDLite3_rc2';
            public static const SAVE_CRYPTO_KEY                         :String         = '0-S_Za0[23"20oSw';
            public static const FILE_SIZE                               :Number         = 10718495;
        }

        public static const SAVE_CNET_KEYS_STORAGE:String = "drod/cnetKeys";
		public static const SAVE_OPTIONS_STORAGE  :String = "drod/settings";


		// ::::::::::::::::::::::::::::::::::::::::::::::
		// :: Retrocade
		// ::::::::::::::::::::::::::::::::::::::::::::::

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Game Data
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static const INTERNAL_VERSION                        :String         = "100";

        public static const SIZE_GAME_WIDTH                         :int            = 760;
        public static const SIZE_GAME_HEIGHT                        :int            = 600;
        public static const SIZE_SWF_WIDTH                          :int            = 760;
        public static const SIZE_SWF_HEIGHT                         :int            = 600;

        public static const LEVEL_OFFSET_X                          :int            = 159;
        public static const LEVEL_OFFSET_Y                          :int            = 43;

        public static const LEVEL_WIDTH                             :int            = 27;
        public static const LEVEL_HEIGHT                            :int            = 25;
        public static const LEVEL_TILE_WIDTH                        :int            = 22;
        public static const LEVEL_TILE_HEIGHT                       :int            = 22;
        public static const LEVEL_TILE_WIDTH_HALF                   :int            = 11;
        public static const LEVEL_TILE_HEIGHT_HALF                  :int            = 11;
        public static const LEVEL_TOTAL                             :int            = 675;

        public static const LEVEL_WIDTH_PIXELS                      :uint           = 594;
        public static const LEVEL_HEIGHT_PIXELS                     :uint           = 550;

        public static const LANGUAGES								:Array			= ['de', 'en', 'es', 'fi', 'fr', 'nl', 'pt'];
        public static const LANGUAGES_NAMES 						:Array			= ['Deutsch', 'English', 'Español', 'Suomi', 'Français',  'Nederlands', 'Português'];

        public static const MOCHI_RESOLUTION                        :String         = '512x448';
        public static const MOCHI_BAR_COLOR                         :uint           = 0xDDFF00;
        public static const MOCHI_BAR_OUTLINE_COLOR                 :uint           = 0x336600;



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Engines
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static const SPATIAL_HASH_CELL                       :Number         = 32;
        public static const SPATIAL_HASH_MAX_BUCKETS                :Number         = 1001;

        public static const TILE_GRID_TILE_WIDTH                    :Number         = 22;
        public static const TILE_GRID_TILE_HEIGHT                   :Number         = 22;
        public static const TILE_GRID_WIDTH                         :Number         = 27;
        public static const TILE_GRID_HEIGHT                        :Number         = 25;
    }
}