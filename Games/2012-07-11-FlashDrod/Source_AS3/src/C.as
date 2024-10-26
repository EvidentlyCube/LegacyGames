package{
    public class C{

        // Tiles
        public static const T_EMPTY         :uint = 0;
        public static const T_FLOOR         :uint = 1;
        public static const T_PIT           :uint = 2;
        public static const T_STAIRS        :uint = 3;
        public static const T_WALL          :uint = 4;
        public static const T_WALL_BROKEN   :uint = 5;
        public static const T_DOOR_C        :uint = 6;
        public static const T_DOOR_G        :uint = 7;
        public static const T_DOOR_R        :uint = 8;
        public static const T_DOOR_Y        :uint = 9;
        public static const T_DOOR_YO       :uint = 10;
        public static const T_TRAPDOOR      :uint = 11;
        public static const T_OBSTACLE      :uint = 12;
        public static const T_ARROW_N       :uint = 13;
        public static const T_ARROW_NE      :uint = 14;
        public static const T_ARROW_E       :uint = 15;
        public static const T_ARROW_SE      :uint = 16;
        public static const T_ARROW_S       :uint = 17;
        public static const T_ARROW_SW      :uint = 18;
        public static const T_ARROW_W       :uint = 19;
        public static const T_ARROW_NW      :uint = 20;
        public static const T_POTION_I      :uint = 21;
        public static const T_POTION_M      :uint = 22;
        public static const T_SCROLL        :uint = 23;
        public static const T_ORB           :uint = 24;
        public static const T_SNK_EW        :uint = 25;
        public static const T_SNK_NS        :uint = 26;
        public static const T_SNK_NW        :uint = 27;
        public static const T_SNK_NE        :uint = 28;
        public static const T_SNK_SW        :uint = 29;
        public static const T_SNK_SE        :uint = 30;
        public static const T_SNKT_S        :uint = 31;
        public static const T_SNKT_W        :uint = 32;
        public static const T_SNKT_N        :uint = 33;
        public static const T_SNKT_E        :uint = 34;
        public static const T_TAR           :uint = 35;
        public static const T_CHECKPOINT    :uint = 36;

        public static const T_DOOR_B        :uint = 37;
        public static const T_POTION_SP     :uint = 38;
        public static const T_FLOW_SOURCE   :uint = 39;
        public static const T_FLOW_INNER    :uint = 40;
        public static const T_FLOW_EDGE     :uint = 41;
        public static const T_LIGHT_CEILING :uint = 42;
        public static const T_BOMB          :uint = 43;
        public static const T_FUSE          :uint = 44;
        public static const T_NODIAGONAL    :uint = 45;
        public static const T_TOKEN         :uint = 46;
        public static const T_TUNNEL_N      :uint = 47;
        public static const T_TUNNEL_S      :uint = 48;
        public static const T_MIRROR        :uint = 49;
        public static const T_POTION_C      :uint = 50;
        public static const T_POTION_D      :uint = 51;
        public static const T_PLATFORM_W    :uint = 52;
        public static const T_PLATFORM_P    :uint = 53;
        public static const T_FLOOR_MOSAIC  :uint = 54;
        public static const T_FLOOR_ROAD    :uint = 55;
        public static const T_FLOOR_GRASS   :uint = 56;
        public static const T_FLOOR_DIRT    :uint = 57;
        public static const T_FLOOR_ALT     :uint = 58;
        public static const T_WALL_MASTER   :uint = 59;
        public static const T_MUD           :uint = 60;
        public static const T_STAIRS_UP     :uint = 61;
        public static const T_WALL_HIDDEN   :uint = 62;
        public static const T_TUNNEL_E      :uint = 63;
        public static const T_TUNNEL_W      :uint = 64;
        public static const T_FLOOR_IMAGE   :uint = 65;
        public static const T_WALL2         :uint = 66;
        public static const T_WATER         :uint = 67;
        public static const T_DOOR_GO       :uint = 68;
        public static const T_DOOR_CO       :uint = 69;
        public static const T_DOOR_RO       :uint = 70;
        public static const T_DOOR_BO       :uint = 71;
        public static const T_TRAPDOOR_WATER:uint = 72;
        public static const T_GOO           :uint = 73;
        public static const T_LIGHT         :uint = 74;
        public static const T_HOT           :uint = 75;
        public static const T_GEL           :uint = 76;
        public static const T_STATION       :uint = 77;
        public static const T_PRESSPLATE    :uint = 78;
        public static const T_BRIDGE        :uint = 79;
        public static const T_BRIDGE_H      :uint = 80;
        public static const T_BRIDGE_V      :uint = 81;
        public static const T_PIT_IMAGE     :uint = 82;
        public static const T_WALL_IMAGE    :uint = 83;
        public static const T_DARK_CEILING  :uint = 84;
        public static const T_WALLLIGHT     :uint = 85;
        public static const T_EMPTY_F       :uint = 86;

        public static const M_ROACH         :uint = 0;
        public static const M_QROACH        :uint = 1;
        public static const M_REGG          :uint = 2;
        public static const M_GOBLIN        :uint = 3;
        public static const M_NEATHER       :uint = 4;
        public static const M_WWING         :uint = 5;
        public static const M_EYE           :uint = 6;
        public static const M_SERPENT       :uint = 7;
        public static const M_TARMOTHER     :uint = 8;
        public static const M_TARBABY       :uint = 9;
        public static const M_BRAIN         :uint = 10;
        public static const M_MIMIC         :uint = 11;
        public static const M_SPIDER        :uint = 12;
        public static const M_SERPENTG      :uint = 13;
        public static const M_SERPENTB      :uint = 14;
        public static const M_ROCKGOLEM     :uint = 15;
        public static const M_WATERSKIPPER  :uint = 16;
        public static const M_SKIPPERNEST   :uint = 17;
        public static const M_AUMTLICH      :uint = 18;
        public static const M_CLONE         :uint = 19;
        public static const M_DECOY         :uint = 20;
        public static const M_WUBBA         :uint = 21;
        public static const M_SEEP          :uint = 22;
        public static const M_STALWART      :uint = 23;
        public static const M_HALPH         :uint = 24;
        public static const M_SLAYER        :uint = 25;
        public static const M_FEGUNDO       :uint = 26;
        public static const M_FEGUNDOASHES  :uint = 27;
        public static const M_GUARD         :uint = 28;
        public static const M_CHARACTER     :uint = 29;
        public static const M_MUDMOTHER     :uint = 30;
        public static const M_MUDBABY       :uint = 31;
        public static const M_GELMOTHER     :uint = 32;
        public static const M_GELBABY       :uint = 33;
        public static const M_CITIZEN       :uint = 34;
        public static const M_ROCKGIANT     :uint = 35;
        public static const M_HALPH2        :uint = 36;
        public static const M_SLAYER2       :uint = 37;
        public static const M_NEGOTIATOR    :uint = 10000;
        public static const M_CITIZEN1      :uint = 10001;
        public static const M_CITIZEN2      :uint = 10002;
        public static const M_GOBLINKING    :uint = 10003;
        public static const M_INSTRUCTOR    :uint = 10004;
        public static const M_MUDCOORDINATOR:uint = 10005;
        public static const M_TARTECHNICIAN :uint = 10006;
        public static const M_EYE_ACTIVE    :uint = 10007;
        public static const M_BEETHRO       :uint = 10008;
        public static const M_CITIZEN3      :uint = 10009;
        public static const M_CITIZEN4      :uint = 10010;
        public static const M_BEETHRO_IN_DISGUISE:uint = 10011;

        public static const MONSTER_TYPES:uint = 38;

        // Commands

        public static const CMD_UNSPECIFIED         :uint = 0;
        public static const CMD_N                   :uint = 1;
        public static const CMD_NE                  :uint = 2;
        public static const CMD_W                   :uint = 3;
        public static const CMD_E                   :uint = 5;
        public static const CMD_SW                  :uint = 6;
        public static const CMD_S                   :uint = 7;
        public static const CMD_SE                  :uint = 8;
        public static const CMD_C                   :uint = 9;
        public static const CMD_CC                  :uint = 10;
        public static const CMD_NW                  :uint = 11;
        public static const CMD_WAIT                :uint = 12;
        public static const CMD_RESTART             :uint = 14;
        public static const CMD_YES                 :uint = 15;
        public static const CMD_NO                  :uint = 16;
        public static const CMD_RESTART_FULL        :uint = 17;
        public static const CMD_RESTART_PART        :uint = 18;
        public static const CMD_UNDO                :uint = 19;
        public static const CMD_CLONE               :uint = 20;
        public static const CMD_DOUBLE              :uint = 21;
        public static const CMD_ANSWER              :uint = 22;
        public static const CMD_COMMAND_COUNT       :uint = 23;


        // Orientation

        public static const NW                      :uint = 0;
        public static const N                       :uint = 1;
        public static const NE                      :uint = 2;
        public static const W                       :uint = 3;
        public static const NO_ORIENTATION          :uint = 4;
        public static const E                       :uint = 5;
        public static const SW                      :uint = 6;
        public static const S                       :uint = 7;
        public static const SE                      :uint = 8;
        public static const ORIENTATION_COUNT       :uint = 9;

        public static const CID_MONSTER_KILLED_PLAYER       :uint = 0;
        public static const CID_SNAKE_DIED_FROM_TRUNCATION  :uint = 1;
        public static const CID_MONSTER_DIED_FROM_STAB      :uint = 2;
        public static const CID_EXIT_ROOM                   :uint = 3;
        public static const CID_EXIT_LEVEL_PENDING          :uint = 4;
        public static const CID_WIN_GAME                    :uint = 5;
        public static const CID_CONQUER_ROOM                :uint = 6;
        public static const CID_COMPLETE_LEVEL              :uint = 7;
        public static const CID_STEP_ON_SCROLL              :uint = 8;
        public static const CID_EGG_HATCHED                 :uint = 9;
        public static const CID_HALPH_INTERRUPTED           :uint = 10;
        public static const CID_HALPH_HURRY_UP              :uint = 11;
        public static const CID_PLOTS                       :uint = 12;
        public static const CID_TRAPDOOR_REMOVED            :uint = 13;
        public static const CID_TARSTUFF_DESTROYED          :uint = 14;
        public static const CID_TAR_GREW                    :uint = 15;
        public static const CID_MONSTER_SPOKE               :uint = 16;
        public static const CID_MONSTER_EXITS_ROOM          :uint = 17;
        public static const CID_EXIT_ROOM_PENDING           :uint = 18;
        public static const CID_CRUMBLY_WALL_DESTROYED      :uint = 19;
        public static const CID_ORB_ACTIVATED_BY_PLAYER     :uint = 20;
        public static const CID_ORB_ACTIVATED_BY_DOUBLE     :uint = 21;
        public static const CID_ROOM_CONQUER_PENDING        :uint = 22;
        public static const CID_DRANK_POTION                :uint = 23;
        public static const CID_DOUBLE_PLACED               :uint = 24;
        public static const CID_HIT_OBSTACLE                :uint = 25;
        public static const CID_SWING_SWORD                 :uint = 26;
        public static const CID_SCARED                      :uint = 27;
        public static const CID_STEP                        :uint = 28;
        public static const CID_SWORDSMAN_AFRAID            :uint = 29;
        public static const CID_SWORDSMAN_AGGRESSIVE        :uint = 30;
        public static const CID_SWORDSMAN_NORMAL            :uint = 31;
        public static const CID_EVIL_EYE_WOKE               :uint = 32;
        public static const CID_TAR_BABY_FORMED             :uint = 33;
        public static const CID_CHECKPOINT_ACTIVATED        :uint = 34;
        public static const CID_NEATHER_LAUGHING            :uint = 35;
        public static const CID_NEATHER_FRUSTRATED          :uint = 36;
        public static const CID_NEATHER_SCARED              :uint = 37;
        public static const CID_SWORDSMAN_TIRED             :uint = 38;
        public static const CID_ALL_TRAPDOORS_REMOVED       :uint = 39;
        public static const CID_ALL_TAR_REMOVED             :uint = 40;
        public static const CID_ROOM_EXIT_LOCKED            :uint = 41;
        public static const CID_MONSTER_PIECE_STABBED       :uint = 42;
        public static const CID_FUSE_BURNING                :uint = 43;
        public static const CID_BOMB_EXPLODED               :uint = 44;
        public static const CID_EXPLOSION                   :uint = 45;
        public static const CID_EXPLOSION_KILLED_PLAYER     :uint = 46;
        public static const CID_NPC_TYPE_CHANGE             :uint = 47;
        public static const CID_PLAYER_FROZEN               :uint = 48;
        public static const CID_ZOMBIE_GAZE                 :uint = 49;
        public static const CID_WUBBA_STABBED               :uint = 50;
        public static const CID_SLAYER_COMBAT               :uint = 51;
        public static const CID_HALPH_ENTERED               :uint = 52;
        public static const CID_HALPH_DIED                  :uint = 53;
        public static const CID_HALPH_FOLLOWING             :uint = 54;
        public static const CID_HALPH_WAITING               :uint = 55;
        public static const CID_HALPH_STRIKING              :uint = 56;
        public static const CID_HALPH_CANT_OPEN             :uint = 57;
        public static const CID_SLAYER_ENTERED              :uint = 58;
        public static const CID_WISP_ON_PLAYER              :uint = 59;
        public static const CID_SECRET_ROOM_FOUND           :uint = 60;
        public static const CID_SPEECH                      :uint = 61;
        public static const CID_MUD_GREW                    :uint = 62;
        public static const CID_MUD_BABY_FORMED             :uint = 63;
        public static const CID_SWORDFIGHT                  :uint = 64;
        public static const CID_SET_MUSIC                   :uint = 65;
        public static const CID_ALL_BRAINS_REMOVED          :uint = 66;
        public static const CID_TUNNEL                      :uint = 67;
        public static const CID_ORB_ACTIVATED               :uint = 68;
        public static const CID_FEGUNDO_TO_ASH              :uint = 69;
        public static const CID_ASH_TO_FEGUNDO              :uint = 70;
        public static const CID_AMBIENT_SOUND               :uint = 71;
        public static const CID_MIRROR_SHATTERED            :uint = 72;
        public static const CID_OBJECT_FELL                 :uint = 73;
        public static const CID_PLAYER_BURNED               :uint = 74;
        public static const CID_MONSTER_BURNED              :uint = 75;
        public static const CID_GEL_GREW                    :uint = 76;
        public static const CID_GEL_BABY_FORMED             :uint = 77;
        public static const CID_NPC_BEETHRO_DIED            :uint = 78;
        public static const CID_PRESSURE_PLATE              :uint = 79;
        public static const CID_PRESSURE_PLATE_RELEASED     :uint = 80;
        public static const CID_CRITICAL_NPC_DIED           :uint = 81;
        public static const CID_BRIAR_KILLED_PLAYER         :uint = 82;
        public static const CID_TOKEN_TOGGLED               :uint = 83;
        public static const CID_LIGHT_TOGGLED               :uint = 84;
        public static const CID_SPLASH                      :uint = 85;
        public static const CID_NPC_KILLED                  :uint = 86;
        public static const CID_OBJECT_BUILT                :uint = 87;
        public static const CID_PLAY_VIDEO                  :uint = 88;
        public static const CID_BRIAR_EXPANDED              :uint = 89;
        public static const CID_ORB_DAMAGED                 :uint = 90;
        public static const CID_HOLD_MASTERED               :uint = 91;
        public static const CID_BUMPED_MASTER_WALL          :uint = 92;
        public static const CID_BLACK_GATES_TOGGLED         :uint = 93;
        public static const CID_RED_GATES_TOGGLED           :uint = 94;
        public static const CID_SWORDSMAN_STABBED_MONSTER   :uint = 95;
        public static const CID_ENTER_ROOM                  :uint = 96;
        public static const CID_SUBMIT_SCORE                :uint = 97;
		public static const CID_ROOM_FIRST_VISIT            :uint = 98;
        public static const CID_COUNT                       :uint = 99;

        public static const CIDA_PLAYER_LEFT_ROOM           :Array = [CID_EXIT_ROOM_PENDING, CID_EXIT_ROOM,
        CID_EXIT_LEVEL_PENDING, CID_WIN_GAME, CID_MONSTER_KILLED_PLAYER, CID_EXPLOSION_KILLED_PLAYER,
        CID_BRIAR_KILLED_PLAYER, CID_HALPH_DIED, CID_PLAYER_BURNED, CID_NPC_BEETHRO_DIED, CID_CRITICAL_NPC_DIED];

        public static const CIDA_PLAYER_DIED                :Array = [CID_MONSTER_KILLED_PLAYER,
        CID_EXPLOSION_KILLED_PLAYER, CID_BRIAR_KILLED_PLAYER, CID_HALPH_DIED, CID_PLAYER_BURNED,
        CID_NPC_BEETHRO_DIED, CID_CRITICAL_NPC_DIED];

        public static const CIDA_MONSTER_DIED               :Array = [CID_SNAKE_DIED_FROM_TRUNCATION,
        CID_MONSTER_DIED_FROM_STAB, CID_MONSTER_EXITS_ROOM, CID_MONSTER_BURNED];

        public static const CIDA_MONSTER_STABBED            :Array = [CID_MONSTER_DIED_FROM_STAB,
        CID_MONSTER_PIECE_STABBED, CID_TARSTUFF_DESTROYED];

        /** 0 - Opaque, 1 - Transparent, 2 - Monster, 3 - Floor **/
        public static const TILE_LAYER:Array = [1, //T_EMPTY         0
            0, //T_FLOOR         1
            0, //T_PIT           2
            0, //T_STAIRS        3
            0, //T_WALL          4
            0, //T_WALL_B        5
            0, //T_DOOR_C        6
            0, //T_DOOR_M        7
            0, //T_DOOR_R        8
            0, //T_DOOR_Y        9
            0, //T_DOOR_YO       10
            0, //T_TRAPDOOR      11
            1, //T_OBSTACLE      12 //was muin layer 0 before v2.0
            3, //T_ARROW_N       13 //arrows were in layer 1 before v3.0
            3, //T_ARROW_NE      14
            3, //T_ARROW_E       15
            3, //T_ARROW_SE      16
            3, //T_ARROW_S       17
            3, //T_ARROW_SW      18
            3, //T_ARROW_W       19
            3, //T_ARROW_NW      20
            1, //T_POTION_I      21
            1, //T_POTION_K      22
            1, //T_SCROLL        23
            1, //T_ORB           24
            2, //T_SNK_EW        25
            2, //T_SNK_NS        26
            2, //T_SNK_NW        27
            2, //T_SNK_NE        28
            2, //T_SNK_SW        29
            2, //T_SNK_SE        30
            2, //T_SNKT_S        31
            2, //T_SNKT_W        32
            2, //T_SNKT_N        33
            2, //T_SNKT_E        34
            1, //T_TAR           35
            0, //T_CHECKPOINT    36

            0, //T_DOOR_B        37
            1, //T_POTION_SP     38
            1, //T_FLOW_SOURCE   39
            1, //T_FLOW_INNER    40
            1, //T_FLOW_EDGE     41
            3, //T_LIGHT_CEILING 42 //front end only -- show on f-layer menu
            1, //T_BOMB          43
            1, //T_FUSE          44
            3, //T_NODIAGONAL    45 //was in layer 1 before v3.0
            1, //T_TOKEN         46
            0, //T_TUNNEL_N      47
            0, //T_TUNNEL_S      48
            1, //T_MIRROR        49
            1, //T_POTION_C      50
            1, //T_POTION_D      51
            0, //T_PLATFORM_W    52
            0, //T_PLATFORM_P    53
            0, //T_FLOOR_M       54
            0, //T_FLOOR_ROAD    55
            0, //T_FLOOR_GRASS   56
            0, //T_FLOOR_DIRT    57
            0, //T_FLOOR_ALT     58
            0, //T_WALL_M        59
            1, //T_MUD           60
            0, //T_STAIRS_UP     61
            0, //T_WALL_H        62
            0, //T_TUNNEL_E      63
            0, //T_TUNNEL_W      64
            0, //T_FLOOR_IMAGE   65
            0,	//T_WALL2         66
            0,	//T_WATER         67
            0, //T_DOOR_GO       68
            0, //T_DOOR_CO       69
            0, //T_DOOR_RO       70
            0, //T_DOOR_BO       71
            0, //T_TRAPDOOR2     72
            0, //T_GOO           73
            1, //T_LIGHT			74
            0, //T_HOT           75
            1, //T_GEL           76
            1, //T_STATION       77
            0, //T_PRESSPLATE    78
            0, //T_BRIDGE        79
            0, //T_BRIDGE_H      80
            0, //T_BRIDGE_V      81
            0, //T_PIT_IMAGE     82
            0, //T_WALL_IMAGE    83
            3, //T_DARK_CEILING  84 //front end only -- show on f-layer menu
            3, //T_WALLLIGHT     85 //front end only -- show on f-layer menu
            0, //T_SHALLOW_WATER 86
            1, //T_HORN_SQUAD    87
            1, //T_HORN_SOLIDER  88

            3  //T_EMPTY_F       TOTAL+2
        ];

        // ORB ACTION TYPE
        public static const OAT_PLAYER            :uint = 0;
        public static const OAT_MONSTER           :uint = 1;
        public static const OAT_ITEM              :uint = 2;
        public static const OAT_SCRIPT_ORB        :uint = 3;
        public static const OAT_PRESSURE_PLATE    :uint = 4;
        public static const OAT_PRESSURE_PLATE_UP :uint = 5;
        public static const OAT_SCRIPT_PLATE      :uint = 6;

        // ORB ACTION
        public static const OA_NULL  :uint = 0;
        public static const OA_TOGGLE:uint = 1;
        public static const OA_OPEN  :uint = 2;
        public static const OA_CLOSE :uint = 3;

        public static const MOVEMENT_GROUND:uint = 0;
        public static const MOVEMENT_AIR   :uint = 1;
        public static const MOVEMENT_WALL  :uint = 2;
        public static const MOVEMENT_WATER :uint = 3;

        public static const TURNS_PER_CYCLE:uint = 30;
        public static const DEFAULT_SMELL_RANGE:uint = 5;

        public static const TAR_NO:uint = 0;
        public static const TAR_OLD:uint = 1;
        public static const TAR_NEW:uint = 2;

        public static const FONT_FAMILY:String = "tomNewRoman";

        public static const REND_WALL_TEXTURE      :uint = 0x01;
        public static const REND_WALL_HIDDEN_SECRET:uint = 0x02;

        public static const REND_PIT_IS_SIDE      :uint = 0x80000000;
        public static const REND_PIT_IS_SIDE_SMALL:uint = 0x40000000;
        public static const REND_PIT_ADD_SHADOW   :uint = 0x20000000;
        public static const REND_PIT_COORDS_MASK  :uint = 0x1FFFFFFF; // Masked to remove the above two flags
        public static const REND_PIT_COORD_MULTIP :uint = 0x00000020; // Multiplier for coordinates

        public static const CC_APPEAR                       :uint = 0;
        public static const CC_APPEAR_AT                    :uint = 1;
        public static const CC_MOVE_TO                      :uint = 2;
        public static const CC_WAIT                         :uint = 3;
        public static const CC_WAIT_FOR_CUE_EVENT           :uint = 4;
        public static const CC_WAIT_FOR_RECT                :uint = 5;
        public static const CC_SPEECH                       :uint = 6;
        public static const CC_IMPERATIVE                   :uint = 7;
        public static const CC_DISAPPEAR                    :uint = 8;
        public static const CC_TURN_INTO_MONSTER            :uint = 9;
        public static const CC_FACE_DIRECTION               :uint = 10;
        public static const CC_WAIT_FOR_NOT_RECT            :uint = 11;
        public static const CC_WAIT_FOR_DOOR_TO             :uint = 12;
        public static const CC_LABEL                        :uint = 13;
        public static const CC_GOTO                         :uint = 14;
        public static const CC_GOTO_IF                      :uint = 15;
        public static const CC_WAIT_FOR_MONSTER             :uint = 16;
        public static const CC_WAIT_FOR_NOT_MONSTER         :uint = 17;
        public static const CC_WAIT_FOR_TURN                :uint = 18;
        public static const CC_WAIT_FOR_CLEAN_ROOM          :uint = 19;
        public static const CC_WAIT_FOR_PLAYER_TO_FACE      :uint = 20;
        public static const CC_ACTIVATE_ITEM_AT             :uint = 21;
        public static const CC_END_SCRIPT                   :uint = 22;
        public static const CC_WAIT_FOR_HALPH               :uint = 23;
        public static const CC_WAIT_FOR_NOT_HALPH           :uint = 24;
        public static const CC_WAIT_FOR_CHARACTER           :uint = 25;
        public static const CC_WAIT_FOR_NOT_CHARACTER       :uint = 26;
        public static const CC_FLUSH_SPEECH                 :uint = 27;
        public static const CC_QUESTION                     :uint = 28;
        public static const CC_SET_MUSIC                    :uint = 29;
        public static const CC_END_SCRIPT_ON_EXIT           :uint = 30;
        public static const CC_IF                           :uint = 31;
        public static const CC_IF_ELSE                      :uint = 32;
        public static const CC_IF_END                       :uint = 33;
        public static const CC_LEVEL_ENTRANCE               :uint = 34;
        public static const CC_VAR_SET                      :uint = 35;
        public static const CC_WAIT_FOR_VAR                 :uint = 36;
        public static const CC_SET_PLAYER_APPEARANCE        :uint = 37;
        public static const CC_CUT_SCENE                    :uint = 38;
        public static const CC_MOVE_REL                     :uint = 39;
        public static const CC_SET_PLAYER_SWORD             :uint = 40;
        public static const CC_ANSWER_OPTION                :uint = 41;
        public static const CC_BUILD_MARKER                 :uint = 42;
        public static const CC_AMBIENT_SOUND                :uint = 43;
        public static const CC_AMBIENT_SOUND_AT             :uint = 44;
        public static const CC_WAIT_FOR_NO_BUILDING         :uint = 45;
        public static const CC_PLAY_VIDEO                   :uint = 46;
        public static const CC_WAIT_FOR_PLAYER_TO_MOVE      :uint = 47;
        public static const CC_WAIT_FOR_PLAYER_TO_TOUCH_ME  :uint = 48;
        public static const CC_SET_NPC_APPEARANCE           :uint = 49;
        public static const CC_COUNT                        :uint = 50;

        public static const IMP_VULNERABLE          :uint = 0;
        public static const IMP_INVULNERABLE        :uint = 1;
        public static const IMP_MISSION_CRITICAL    :uint = 2;
        public static const IMP_REQUIRED_TO_CONQUER :uint = 3;
        public static const IMP_DIE                 :uint = 4;
        public static const IMP_DIE_SPECIAL         :uint = 5;
        public static const IMP_SAFE                :uint = 6;
        public static const IMP_DEADLY              :uint = 7;
        public static const IMP_SWORD_SAFE_TO_PLAYER:uint = 8;
        public static const IMP_END_WHEN_KILLED     :uint = 9;
        public static const IMP_FLEXIBLE_BEELINING  :uint = 10;
        public static const IMP_DIRECT_BEELINING    :uint = 11;

        public static const FLAG_PLAYER  :uint = 0x00000001;
        public static const FLAG_HALPH   :uint = 0x00000002;
        public static const FLAG_MONSTER :uint = 0x00000004;
        public static const FLAG_NPC     :uint = 0x00000008;
        public static const FLAG_PDOUBLE :uint = 0x00000010;
        public static const FLAG_SELF    :uint = 0x00000020;
        public static const FLAG_SLAYER  :uint = 0x00000040;
        public static const FLAG_BEETHRO :uint = 0x00000080;
        public static const FLAG_STALWART:uint = 0x00000100;

        public static const UVT_byte            :uint = 0;
        public static const UVT_char_string     :uint = 1;
        public static const UVT_deprecated_dword:uint = 2;
        public static const UVT_int             :uint = 3;
        public static const UVT_deprecated_uchar:uint = 4;
        public static const UVT_uint            :uint = 5;
        public static const UVT_wchar_string    :uint = 6;
        public static const UVT_byte_buffer     :uint = 7;
        public static const UVT_bool            :uint = 8;
        public static const UVT_unknown         :uint = 9;

        public static const SPEAK_Beethro           :uint = 0;	//don't change these constants
        public static const SPEAK_Citizen1          :uint = 6;
        public static const SPEAK_Citizen2          :uint = 7;
        public static const SPEAK_Citizen3          :uint = 45;
        public static const SPEAK_Citizen4          :uint = 46;
        public static const SPEAK_Custom            :uint = 5;
        public static const SPEAK_EyeActive         :uint = 15;
        public static const SPEAK_GoblinKing        :uint = 8; //deprecated
        public static const SPEAK_Instructor        :uint = 10; //deprecated
        public static const SPEAK_MudCoordinator    :uint = 11; //deprecated
        public static const SPEAK_Negotiator        :uint = 3; //deprecated
        public static const SPEAK_None              :uint = 4;
        public static const SPEAK_TarTechnician     :uint = 13; //deprecated
        public static const SPEAK_BeethroInDisguise :uint = 47;
        public static const SPEAK_Self              :uint = 50;
        public static const SPEAK_Halph             :uint = 1;
        public static const SPEAK_Slayer            :uint = 2;
        public static const SPEAK_Goblin            :uint = 9;
        public static const SPEAK_RockGolem         :uint = 12;
        public static const SPEAK_Guard             :uint = 14;
        public static const SPEAK_Stalwart          :uint = 17;
        public static const SPEAK_Roach             :uint = 18;
        public static const SPEAK_QRoach            :uint = 19;
        public static const SPEAK_RoachEgg          :uint = 20;
        public static const SPEAK_WWing             :uint = 21;
        public static const SPEAK_Eye               :uint = 22;
        public static const SPEAK_Serpent           :uint = 23;
        public static const SPEAK_TarMother         :uint = 24;
        public static const SPEAK_TarBaby           :uint = 25;
        public static const SPEAK_Brain             :uint = 26;
        public static const SPEAK_Mimic             :uint = 27;
        public static const SPEAK_Spider            :uint = 28;
        public static const SPEAK_SerpentG          :uint = 29;
        public static const SPEAK_SerpentB          :uint = 30;
        public static const SPEAK_WaterSkipper      :uint = 31;
        public static const SPEAK_WaterSkipperNest  :uint = 32;
        public static const SPEAK_Aumtlich          :uint = 33;
        public static const SPEAK_Clone             :uint = 34;
        public static const SPEAK_Decoy             :uint = 35;
        public static const SPEAK_Wubba             :uint = 36;
        public static const SPEAK_Seep              :uint = 37;
        public static const SPEAK_Fegundo           :uint = 38;
        public static const SPEAK_FegundoAshes      :uint = 39;
        public static const SPEAK_MudMother         :uint = 40;
        public static const SPEAK_MudBaby           :uint = 41;
        public static const SPEAK_GelMother         :uint = 42;
        public static const SPEAK_GelBaby           :uint = 43;
        public static const SPEAK_Citizen           :uint = 16;
        public static const SPEAK_RockGiant         :uint = 44;
        public static const SPEAK_Slayer2           :uint = 48;
        public static const SPEAK_Halph2            :uint = 49;
    	public static const SPEAK_Count             :uint = 51;

        public static const VAR_Assign              :uint = 0;
        public static const VAR_Inc                 :uint = 1;
        public static const VAR_Dec                 :uint = 2;
        public static const VAR_AssignText          :uint = 3;
        public static const VAR_AppendText          :uint = 4;
        public static const VAR_MultiplyBy          :uint = 5;
        public static const VAR_DivideBy            :uint = 6;
        public static const VAR_Mod                 :uint = 7;

        public static const VAR_Equals              :uint = 0;
        public static const VAR_Greater             :uint = 1;
        public static const VAR_Less                :uint = 2;
        public static const VAR_EqualsText          :uint = 3;

        public static const SPEAKERS                :Array = [
            M_BEETHRO, M_HALPH, M_SLAYER, M_NEGOTIATOR, -2, -2,
            M_CITIZEN1, M_CITIZEN2, M_GOBLINKING, M_GOBLIN,
            M_INSTRUCTOR, M_MUDCOORDINATOR, M_ROCKGOLEM, M_TARTECHNICIAN, M_GUARD, M_EYE,
            M_CITIZEN, M_STALWART, M_ROACH, M_QROACH, M_REGG, M_WWING, M_EYE,
            M_SERPENT, M_TARMOTHER, M_TARBABY, M_BRAIN, M_MIMIC, M_SPIDER,
            M_SERPENTG, M_SERPENTB, M_WATERSKIPPER, M_SKIPPERNEST, M_AUMTLICH, M_CLONE,
            M_DECOY, M_WUBBA, M_SEEP, M_FEGUNDO, M_FEGUNDOASHES, M_MUDMOTHER,
            M_MUDBABY, M_GELMOTHER, M_GELBABY, M_ROCKGIANT, M_CITIZEN3, M_CITIZEN4,
            M_BEETHRO_IN_DISGUISE, M_SLAYER2, M_HALPH2
        ];

        public static const SPEAKER_COLOUR          :Array = [
            0xFFFF00,  //Beethro
            0xFFF719,  //Halph
            0xFFC0FF,  //Slayer
            0xD0BAA3,  //Negotiator
            0xFFFFFF,  //(none)
            0xFFFFFF,  //(custom)
            0xC0C0FF,  //Citizen 1
            0xFF80FF,  //Citizen 2
            0x40FF40,  //Goblin King
            0x20FF20,  //Goblin
            0x40FFFF,  //Instructor
            0xFF6400,  //Mud Coordinator
            0xC08060,  //Rock golem
            0xA380FF,  //Tar Technician
            0xFF6060,  //Guard
            0xFFFFFF,  //Evil eye (active)
            0xD2D2C8,  //Citizen
            0xFFFF80,  //Stalwart
            0xA0A0A0,  //roach
            0xC0C0C0,  //roach queen
            0xA0A0A0,	//roach egg
            0x808080,  //wwing
            0xFFFFFF,  //evil eye
            0xFF6060,  //red serpent
            0x4040C0,  //tar mother
            0x4040C0,  //tarbaby
            0xFF2020,  //brain
            0x23C8DD,  //mimic
            0x60C0C0,  //spider
            0x60FF60,  //green serpent
            0x8080FF,  //blue serpent
            0x303030,  //water skipper
            0x303030,  //water skipper nest
            0xDDDDDD,  //aumtlich
            0xFFFF28,  //clone
            0xA0A0A0,  //decoy
            0xFFFFFF,  //wubba
            0xC4C4C4,  //seep
            0xC0C05C,  //fegundo
            0xC0C05C,  //fegundo ashes
            0xC04040,  //mud mother
            0xC04040,  //mudbaby
            0x40C040,  //gel mother
            0x40C040,  //gelbaby
            0xC08060,  //rock giant
            0xFFC0FF,  //Citizen 3
            0xFF80FF,  //Citizen 4
            0xFFFF00,  //Beethro in disguise
            0xFFC0FF,  //Slayer2
            0xFFF719   //Halph2
        ];

        public static const SETTING_VOLUME_EFFECTS:String = "volEff";
        public static const SETTING_VOLUME_VOICES :String = "volVoic";
        public static const SETTING_VOLUME_MUSIC  :String = "volMus";
        public static const SETTING_REPEAT        :String = "repeat";
        public static const SETTING_CNET_NAME     :String = "cName";
        public static const SETTING_CNET_PASS     :String = "cPass";
        public static const SETTING_MOVE_COUNTER  :String = "moveCounter";

        public static const SETTINGS_SAVE_SIZE:uint = 1024 * 1024 * 256;

        public static const MUSIC_TITLE     :String = "musicTitle";
        public static const MUSIC_AMBIENT   :String = "musicAmbient";
        public static const MUSIC_PUZZLE    :String = "musicPuzzle";
        public static const MUSIC_ACTION    :String = "musicAction";
        public static const MUSIC_OUTRO     :String = "musicOutro";
        public static const MUSIC_LEVEL_EXIT:String = "musicExit";
    }
}