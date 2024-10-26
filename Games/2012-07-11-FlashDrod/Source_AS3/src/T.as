package{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    import game.global.Gfx;

    import net.retrocade.utils.UBitmapData;

    public class T{
        public static const TILES:Array = [];

        public static const TI_DOOR_Y_SE        :uint = 0;
        public static const TI_DOOR_Y_SEW       :uint = 1;
        public static const TI_DOOR_Y_SW        :uint = 2;
        public static const TI_DOOR_Y_NSE       :uint = 3;
        public static const TI_DOOR_Y_NSEW      :uint = 4;
        public static const TI_DOOR_Y_NSW       :uint = 5;
        public static const TI_DOOR_Y_NE        :uint = 6;
        public static const TI_DOOR_Y_NEW       :uint = 7;
        public static const TI_DOOR_Y_NW        :uint = 8;
        public static const TI_DOOR_Y_EW        :uint = 9;
        public static const TI_DOOR_Y_NS        :uint = 10;
        public static const TI_DOOR_Y_W         :uint = 11;
        public static const TI_DOOR_Y_E         :uint = 12;
        public static const TI_DOOR_Y_N         :uint = 13;
        public static const TI_DOOR_Y_S         :uint = 14;
        public static const TI_DOOR_Y           :uint = 15;

        public static const TI_POTION_M         :uint = 16;
        public static const TI_BRAIN            :uint = 17;

        public static const TI_DOOR_YO_SE        :uint = 18;
        public static const TI_DOOR_YO_SEW       :uint = 19;
        public static const TI_DOOR_YO_SW        :uint = 20;
        public static const TI_DOOR_YO_NSE       :uint = 21;
        public static const TI_DOOR_YO_NSEW      :uint = 22;
        public static const TI_DOOR_YO_NSW       :uint = 23;
        public static const TI_DOOR_YO_NE        :uint = 24;
        public static const TI_DOOR_YO_NEW       :uint = 25;
        public static const TI_DOOR_YO_NW        :uint = 26;
        public static const TI_DOOR_YO_EW        :uint = 27;
        public static const TI_DOOR_YO_NS        :uint = 28;
        public static const TI_DOOR_YO_W         :uint = 29;
        public static const TI_DOOR_YO_E         :uint = 30;
        public static const TI_DOOR_YO_N         :uint = 31;
        public static const TI_DOOR_YO_S         :uint = 32;
        public static const TI_DOOR_YO           :uint = 33;

        public static const TI_POTION_I         :uint = 34;
        public static const TI_BRAIN_A          :uint = 35;

        public static const TI_DOOR_G_SE        :uint = 36;
        public static const TI_DOOR_G_SEW       :uint = 37;
        public static const TI_DOOR_G_SW        :uint = 38;
        public static const TI_DOOR_G_NSE       :uint = 39;
        public static const TI_DOOR_G_NSEW      :uint = 40;
        public static const TI_DOOR_G_NSW       :uint = 41;
        public static const TI_DOOR_G_NE        :uint = 42;
        public static const TI_DOOR_G_NEW       :uint = 43;
        public static const TI_DOOR_G_NW        :uint = 44;
        public static const TI_DOOR_G_EW        :uint = 45;
        public static const TI_DOOR_G_NS        :uint = 46;
        public static const TI_DOOR_G_W         :uint = 47;
        public static const TI_DOOR_G_E         :uint = 48;
        public static const TI_DOOR_G_N         :uint = 49;
        public static const TI_DOOR_G_S         :uint = 50;
        public static const TI_DOOR_G           :uint = 51;

        public static const TI_REGG_N           :uint = 52;
        public static const TI_REGG_AN          :uint = 53;

        public static const TI_DOOR_GO_SE        :uint = 54;
        public static const TI_DOOR_GO_SEW       :uint = 55;
        public static const TI_DOOR_GO_SW        :uint = 56;
        public static const TI_DOOR_GO_NSE       :uint = 57;
        public static const TI_DOOR_GO_NSEW      :uint = 58;
        public static const TI_DOOR_GO_NSW       :uint = 59;
        public static const TI_DOOR_GO_NE        :uint = 60;
        public static const TI_DOOR_GO_NEW       :uint = 61;
        public static const TI_DOOR_GO_NW        :uint = 62;
        public static const TI_DOOR_GO_EW        :uint = 63;
        public static const TI_DOOR_GO_NS        :uint = 64;
        public static const TI_DOOR_GO_W         :uint = 65;
        public static const TI_DOOR_GO_E         :uint = 66;
        public static const TI_DOOR_GO_N         :uint = 67;
        public static const TI_DOOR_GO_S         :uint = 68;
        public static const TI_DOOR_GO           :uint = 69;

        public static const TI_REGG_NW           :uint = 70;
        public static const TI_REGG_ANW          :uint = 71;

        public static const TI_DOOR_R_SE        :uint = 72;
        public static const TI_DOOR_R_SEW       :uint = 73;
        public static const TI_DOOR_R_SW        :uint = 74;
        public static const TI_DOOR_R_NSE       :uint = 75;
        public static const TI_DOOR_R_NSEW      :uint = 76;
        public static const TI_DOOR_R_NSW       :uint = 77;
        public static const TI_DOOR_R_NE        :uint = 78;
        public static const TI_DOOR_R_NEW       :uint = 79;
        public static const TI_DOOR_R_NW        :uint = 80;
        public static const TI_DOOR_R_EW        :uint = 81;
        public static const TI_DOOR_R_NS        :uint = 82;
        public static const TI_DOOR_R_W         :uint = 83;
        public static const TI_DOOR_R_E         :uint = 84;
        public static const TI_DOOR_R_N         :uint = 85;
        public static const TI_DOOR_R_S         :uint = 86;
        public static const TI_DOOR_R           :uint = 87;

        public static const TI_REGG_W          :uint = 88;
        public static const TI_REGG_AW         :uint = 89;

        public static const TI_DOOR_RO_SE        :uint = 90;
        public static const TI_DOOR_RO_SEW       :uint = 91;
        public static const TI_DOOR_RO_SW        :uint = 92;
        public static const TI_DOOR_RO_NSE       :uint = 93;
        public static const TI_DOOR_RO_NSEW      :uint = 94;
        public static const TI_DOOR_RO_NSW       :uint = 95;
        public static const TI_DOOR_RO_NE        :uint = 96;
        public static const TI_DOOR_RO_NEW       :uint = 97;
        public static const TI_DOOR_RO_NW        :uint = 98;
        public static const TI_DOOR_RO_EW        :uint = 99;
        public static const TI_DOOR_RO_NS        :uint = 100;
        public static const TI_DOOR_RO_W         :uint = 101;
        public static const TI_DOOR_RO_E         :uint = 102;
        public static const TI_DOOR_RO_N         :uint = 103;
        public static const TI_DOOR_RO_S         :uint = 104;
        public static const TI_DOOR_RO           :uint = 105;

        public static const TI_REGG_SW            :uint = 106;
        public static const TI_REGG_ASW           :uint = 107;

        public static const TI_DOOR_C_SE        :uint = 108;
        public static const TI_DOOR_C_SEW       :uint = 109;
        public static const TI_DOOR_C_SW        :uint = 110;
        public static const TI_DOOR_C_NSE       :uint = 111;
        public static const TI_DOOR_C_NSEW      :uint = 112;
        public static const TI_DOOR_C_NSW       :uint = 113;
        public static const TI_DOOR_C_NE        :uint = 114;
        public static const TI_DOOR_C_NEW       :uint = 115;
        public static const TI_DOOR_C_NW        :uint = 116;
        public static const TI_DOOR_C_EW        :uint = 117;
        public static const TI_DOOR_C_NS        :uint = 118;
        public static const TI_DOOR_C_W         :uint = 119;
        public static const TI_DOOR_C_E         :uint = 120;
        public static const TI_DOOR_C_N         :uint = 121;
        public static const TI_DOOR_C_S         :uint = 122;
        public static const TI_DOOR_C           :uint = 123;

        public static const TI_DOOR_CO_SE        :uint = 126;
        public static const TI_DOOR_CO_SEW       :uint = 127;
        public static const TI_DOOR_CO_SW        :uint = 128;
        public static const TI_DOOR_CO_NSE       :uint = 129;
        public static const TI_DOOR_CO_NSEW      :uint = 130;
        public static const TI_DOOR_CO_NSW       :uint = 131;
        public static const TI_DOOR_CO_NE        :uint = 132;
        public static const TI_DOOR_CO_NEW       :uint = 133;
        public static const TI_DOOR_CO_NW        :uint = 134;
        public static const TI_DOOR_CO_EW        :uint = 135;
        public static const TI_DOOR_CO_NS        :uint = 136;
        public static const TI_DOOR_CO_W         :uint = 137;
        public static const TI_DOOR_CO_E         :uint = 138;
        public static const TI_DOOR_CO_N         :uint = 139;
        public static const TI_DOOR_CO_S         :uint = 140;
        public static const TI_DOOR_CO           :uint = 141;

        public static const TI_ORB               :uint = 143;

        public static const TI_DOOR_B_SE        :uint = 144;
        public static const TI_DOOR_B_SEW       :uint = 145;
        public static const TI_DOOR_B_SW        :uint = 146;
        public static const TI_DOOR_B_NSE       :uint = 147;
        public static const TI_DOOR_B_NSEW      :uint = 148;
        public static const TI_DOOR_B_NSW       :uint = 149;
        public static const TI_DOOR_B_NE        :uint = 150;
        public static const TI_DOOR_B_NEW       :uint = 151;
        public static const TI_DOOR_B_NW        :uint = 152;
        public static const TI_DOOR_B_EW        :uint = 153;
        public static const TI_DOOR_B_NS        :uint = 154;
        public static const TI_DOOR_B_W         :uint = 155;
        public static const TI_DOOR_B_E         :uint = 156;
        public static const TI_DOOR_B_N         :uint = 157;
        public static const TI_DOOR_B_S         :uint = 158;
        public static const TI_DOOR_B           :uint = 159;

        public static const TI_DOOR_BO_SE        :uint = 162;
        public static const TI_DOOR_BO_SEW       :uint = 163;
        public static const TI_DOOR_BO_SW        :uint = 164;
        public static const TI_DOOR_BO_NSE       :uint = 165;
        public static const TI_DOOR_BO_NSEW      :uint = 166;
        public static const TI_DOOR_BO_NSW       :uint = 167;
        public static const TI_DOOR_BO_NE        :uint = 168;
        public static const TI_DOOR_BO_NEW       :uint = 169;
        public static const TI_DOOR_BO_NW        :uint = 170;
        public static const TI_DOOR_BO_EW        :uint = 171;
        public static const TI_DOOR_BO_NS        :uint = 172;
        public static const TI_DOOR_BO_W         :uint = 173;
        public static const TI_DOOR_BO_E         :uint = 174;
        public static const TI_DOOR_BO_N         :uint = 175;
        public static const TI_DOOR_BO_S         :uint = 176;
        public static const TI_DOOR_BO           :uint = 177;

        public static const TI_MASTER_WALL       :uint = 179;

        public static const TI_BEETHRO_NW        :uint = 180;
        public static const TI_BEETHRO_N         :uint = 181;
        public static const TI_BEETHRO_NE        :uint = 182;
        public static const TI_BEETHRO_W         :uint = 183;
        public static const TI_BEETHRO_E         :uint = 185;
        public static const TI_BEETHRO_SW        :uint = 186;
        public static const TI_BEETHRO_S         :uint = 187;
        public static const TI_BEETHRO_SE        :uint = 188;

        public static const TI_MIMIC_NW          :uint = 189;
        public static const TI_MIMIC_N           :uint = 190;
        public static const TI_MIMIC_NE          :uint = 191;
        public static const TI_MIMIC_W           :uint = 192;
        public static const TI_MIMIC_E           :uint = 194;
        public static const TI_MIMIC_SW          :uint = 195;
        public static const TI_MIMIC_S           :uint = 196;
        public static const TI_MIMIC_SE          :uint = 197;

        public static const TI_BEETHRO_SWORD_NW        :uint = 198;
        public static const TI_BEETHRO_SWORD_N         :uint = 199;
        public static const TI_BEETHRO_SWORD_NE        :uint = 200;
        public static const TI_BEETHRO_SWORD_W         :uint = 201;
        public static const TI_BEETHRO_SWORD_E         :uint = 203;
        public static const TI_BEETHRO_SWORD_SW        :uint = 204;
        public static const TI_BEETHRO_SWORD_S         :uint = 205;
        public static const TI_BEETHRO_SWORD_SE        :uint = 206;

        public static const TI_MIMIC_SWORD_NW        :uint = 207;
        public static const TI_MIMIC_SWORD_N         :uint = 208;
        public static const TI_MIMIC_SWORD_NE        :uint = 209;
        public static const TI_MIMIC_SWORD_W         :uint = 210;
        public static const TI_MIMIC_SWORD_E         :uint = 212;
        public static const TI_MIMIC_SWORD_SW        :uint = 213;
        public static const TI_MIMIC_SWORD_S         :uint = 214;
        public static const TI_MIMIC_SWORD_SE        :uint = 215;

        public static const TI_SPIDER_NW         :uint = 216;
        public static const TI_SPIDER_N          :uint = 217;
        public static const TI_SPIDER_NE         :uint = 218;
        public static const TI_SPIDER_W          :uint = 219;
        public static const TI_SPIDER_E          :uint = 221;
        public static const TI_SPIDER_SW         :uint = 222;
        public static const TI_SPIDER_S          :uint = 223;
        public static const TI_SPIDER_SE         :uint = 224;

        public static const TI_ROACH_NW         :uint = 225;
        public static const TI_ROACH_N          :uint = 226;
        public static const TI_ROACH_NE         :uint = 227;
        public static const TI_ROACH_W          :uint = 228;
        public static const TI_ROACH_E          :uint = 230;
        public static const TI_ROACH_SW         :uint = 231;
        public static const TI_ROACH_S          :uint = 232;
        public static const TI_ROACH_SE         :uint = 233;

        public static const TI_SPIDER_ANW         :uint = 234;
        public static const TI_SPIDER_AN          :uint = 235;
        public static const TI_SPIDER_ANE         :uint = 236;
        public static const TI_SPIDER_AW          :uint = 237;
        public static const TI_SPIDER_AE          :uint = 239;
        public static const TI_SPIDER_ASW         :uint = 240;
        public static const TI_SPIDER_AS          :uint = 241;
        public static const TI_SPIDER_ASE         :uint = 242;

        public static const TI_ROACH_ANW         :uint = 243;
        public static const TI_ROACH_AN          :uint = 244;
        public static const TI_ROACH_ANE         :uint = 245;
        public static const TI_ROACH_AW          :uint = 246;
        public static const TI_ROACH_AE          :uint = 248;
        public static const TI_ROACH_ASW         :uint = 249;
        public static const TI_ROACH_AS          :uint = 250;
        public static const TI_ROACH_ASE         :uint = 251;

        public static const TI_RQUEEN_NW         :uint = 252;
        public static const TI_RQUEEN_N          :uint = 253;
        public static const TI_RQUEEN_NE         :uint = 254;
        public static const TI_RQUEEN_W          :uint = 255;
        public static const TI_RQUEEN_E          :uint = 257;
        public static const TI_RQUEEN_SW         :uint = 258;
        public static const TI_RQUEEN_S          :uint = 259;
        public static const TI_RQUEEN_SE         :uint = 260;

        public static const TI_EEYE_NW         :uint = 261;
        public static const TI_EEYE_N          :uint = 262;
        public static const TI_EEYE_NE         :uint = 263;
        public static const TI_EEYE_W          :uint = 264;
        public static const TI_EEYE_E          :uint = 266;
        public static const TI_EEYE_SW         :uint = 267;
        public static const TI_EEYE_S          :uint = 268;
        public static const TI_EEYE_SE         :uint = 269;

        public static const TI_RQUEEN_ANW         :uint = 270;
        public static const TI_RQUEEN_AN          :uint = 271;
        public static const TI_RQUEEN_ANE         :uint = 272;
        public static const TI_RQUEEN_AW          :uint = 273;
        public static const TI_RQUEEN_AE          :uint = 275;
        public static const TI_RQUEEN_ASW         :uint = 276;
        public static const TI_RQUEEN_AS          :uint = 277;
        public static const TI_RQUEEN_ASE         :uint = 278;

        public static const TI_EEYE_ANW         :uint = 279;
        public static const TI_EEYE_AN          :uint = 280;
        public static const TI_EEYE_ANE         :uint = 281;
        public static const TI_EEYE_AW          :uint = 282;
        public static const TI_EEYE_AE          :uint = 284;
        public static const TI_EEYE_ASW         :uint = 285;
        public static const TI_EEYE_AS          :uint = 286;
        public static const TI_EEYE_ASE         :uint = 287;

        public static const TI_WWING_NW         :uint = 288;
        public static const TI_WWING_N          :uint = 289;
        public static const TI_WWING_NE         :uint = 290;
        public static const TI_WWING_W          :uint = 291;
        public static const TI_WWING_E          :uint = 293;
        public static const TI_WWING_SW         :uint = 294;
        public static const TI_WWING_S          :uint = 295;
        public static const TI_WWING_SE         :uint = 296;

        public static const TI_GOBLIN_NW         :uint = 297;
        public static const TI_GOBLIN_N          :uint = 298;
        public static const TI_GOBLIN_NE         :uint = 299;
        public static const TI_GOBLIN_W          :uint = 300;
        public static const TI_GOBLIN_E          :uint = 302;
        public static const TI_GOBLIN_SW         :uint = 303;
        public static const TI_GOBLIN_S          :uint = 304;
        public static const TI_GOBLIN_SE         :uint = 305;

        public static const TI_WWING_ANW         :uint = 306;
        public static const TI_WWING_AN          :uint = 307;
        public static const TI_WWING_ANE         :uint = 308;
        public static const TI_WWING_AW          :uint = 309;
        public static const TI_WWING_AE          :uint = 311;
        public static const TI_WWING_ASW         :uint = 312;
        public static const TI_WWING_AS          :uint = 313;
        public static const TI_WWING_ASE         :uint = 314;

        public static const TI_GOBLIN_ANW         :uint = 315;
        public static const TI_GOBLIN_AN          :uint = 316;
        public static const TI_GOBLIN_ANE         :uint = 317;
        public static const TI_GOBLIN_AW          :uint = 318;
        public static const TI_GOBLIN_AE          :uint = 320;
        public static const TI_GOBLIN_ASW         :uint = 321;
        public static const TI_GOBLIN_AS          :uint = 322;
        public static const TI_GOBLIN_ASE         :uint = 323;

        public static const TI_TMOTHER_WO         :uint = 324;
        public static const TI_TMOTHER_EO         :uint = 325;

        public static const TI_TAR_SE             :uint = 331;
        public static const TI_TAR_SEW            :uint = 332;
        public static const TI_TAR_SW             :uint = 333;
        public static const TI_TAR_INW            :uint = 334;
        public static const TI_TAR_INE            :uint = 335;

        public static const TI_SNK_SE             :uint = 336;
        public static const TI_SNK_SW             :uint = 337;
        public static const TI_SNKH_N             :uint = 338;
        public static const TI_SNKH_E             :uint = 339;
        public static const TI_SNKH_S             :uint = 340;
        public static const TI_SNKH_W             :uint = 341;

        public static const TI_TMOTHER_WC         :uint = 342;
        public static const TI_TMOTHER_EC         :uint = 343;

        public static const TI_TAR_NSE            :uint = 349;
        public static const TI_TAR_NSEW           :uint = 350;
        public static const TI_TAR_NSW            :uint = 351;
        public static const TI_TAR_ISW            :uint = 352;
        public static const TI_TAR_ISE            :uint = 353;

        public static const TI_SNK_NE             :uint = 354;
        public static const TI_SNK_NW             :uint = 355;
        public static const TI_SNKH_AN            :uint = 356;
        public static const TI_SNKH_AE            :uint = 357;
        public static const TI_SNKH_AS            :uint = 358;
        public static const TI_SNKH_AW            :uint = 359;

        public static const TI_SCROLL             :uint = 360;
        public static const TI_CHECKPOINT         :uint = 361;

        public static const TI_TAR_NE             :uint = 367;
        public static const TI_TAR_NEW            :uint = 368;
        public static const TI_TAR_NW             :uint = 369;
        public static const TI_TAR_INWSE          :uint = 370;
        public static const TI_TAR_INESW          :uint = 371;

        public static const TI_SNK_EW             :uint = 372;
        public static const TI_SNK_NS             :uint = 373;
        public static const TI_SNKT_S             :uint = 374;
        public static const TI_SNKT_W             :uint = 375;
        public static const TI_SNKT_N             :uint = 376;
        public static const TI_SNKT_E             :uint = 377;

        public static const TI_TARBABY_NW         :uint = 378;
        public static const TI_TARBABY_N          :uint = 379;
        public static const TI_TARBABY_NE         :uint = 380;
        public static const TI_TARBABY_W          :uint = 381;
        public static const TI_TARBABY_E          :uint = 383;
        public static const TI_TARBABY_SW         :uint = 384;
        public static const TI_TARBABY_S          :uint = 385;
        public static const TI_TARBABY_SE         :uint = 386;
        public static const TI_CITIZEN_NW         :uint = 387;
        public static const TI_CITIZEN_N          :uint = 388;
        public static const TI_CITIZEN_NE         :uint = 389;
        public static const TI_CITIZEN_W          :uint = 390;
        public static const TI_CITIZEN_E          :uint = 392;
        public static const TI_CITIZEN_SW         :uint = 393;
        public static const TI_CITIZEN_S          :uint = 394;
        public static const TI_CITIZEN_SE         :uint = 395;

        public static const TI_TARBABY_ANW         :uint = 396;
        public static const TI_TARBABY_AN          :uint = 397;
        public static const TI_TARBABY_ANE         :uint = 398;
        public static const TI_TARBABY_AW          :uint = 399;
        public static const TI_TARBABY_AE          :uint = 401;
        public static const TI_TARBABY_ASW         :uint = 402;
        public static const TI_TARBABY_AS          :uint = 403;
        public static const TI_TARBABY_ASE         :uint = 404;
        public static const TI_MUDCOORDINATOR_NW   :uint = 405;
        public static const TI_MUDCOORDINATOR_N    :uint = 406;
        public static const TI_MUDCOORDINATOR_NE   :uint = 407;
        public static const TI_MUDCOORDINATOR_W    :uint = 408;
        public static const TI_MUDCOORDINATOR_E    :uint = 410;
        public static const TI_MUDCOORDINATOR_SW   :uint = 411;
        public static const TI_MUDCOORDINATOR_S    :uint = 412;
        public static const TI_MUDCOORDINATOR_SE   :uint = 413;

        public static const TI_EEYEW_NW         :uint = 414;
        public static const TI_EEYEW_N          :uint = 415;
        public static const TI_EEYEW_NE         :uint = 416;
        public static const TI_EEYEW_W          :uint = 417;
        public static const TI_EEYEW_E          :uint = 419;
        public static const TI_EEYEW_SW         :uint = 420;
        public static const TI_EEYEW_S          :uint = 421;
        public static const TI_EEYEW_SE         :uint = 422;
        public static const TI_NEGOTIATOR_NW    :uint = 423;
        public static const TI_NEGOTIATOR_N     :uint = 424;
        public static const TI_NEGOTIATOR_NE    :uint = 425;
        public static const TI_NEGOTIATOR_W     :uint = 426;
        public static const TI_NEGOTIATOR_E     :uint = 428;
        public static const TI_NEGOTIATOR_SW    :uint = 429;
        public static const TI_NEGOTIATOR_S     :uint = 430;
        public static const TI_NEGOTIATOR_SE    :uint = 431;

        public static const TI_DECOY_SWORD_NW   :uint = 432;
        public static const TI_DECOY_SWORD_N    :uint = 433;
        public static const TI_DECOY_SWORD_NE   :uint = 434;
        public static const TI_DECOY_SWORD_W    :uint = 435;
        public static const TI_DECOY_SWORD_E    :uint = 437;
        public static const TI_DECOY_SWORD_SW   :uint = 438;
        public static const TI_DECOY_SWORD_S    :uint = 439;
        public static const TI_DECOY_SWORD_SE   :uint = 440;
        public static const TI_TARTECHNICIAN_NW :uint = 441;
        public static const TI_TARTECHNICIAN_N  :uint = 442;
        public static const TI_TARTECHNICIAN_NE :uint = 443;
        public static const TI_TARTECHNICIAN_W  :uint = 444;
        public static const TI_TARTECHNICIAN_E  :uint = 446;
        public static const TI_TARTECHNICIAN_SW :uint = 447;
        public static const TI_TARTECHNICIAN_S  :uint = 448;
        public static const TI_TARTECHNICIAN_SE :uint = 449;

        public static const TI_SHADOW_N  :uint = 450;
        public static const TI_SHADOW_1  :uint = 451;
        public static const TI_SHADOW_W  :uint = 452;
        public static const TI_SHADOW_N1 :uint = 453;
        public static const TI_SHADOW_W1 :uint = 454;
        public static const TI_SHADOW_NW1:uint = 455;
        public static const TI_SHADOW_NW :uint = 456;

        public static const TI_DECOY_NW:uint = 459;
        public static const TI_DECOY_N:uint = 460;
        public static const TI_DECOY_NE:uint = 461;
        public static const TI_DECOY_W:uint = 462;
        public static const TI_DECOY_E:uint = 464;
        public static const TI_DECOY_SW:uint = 465;
        public static const TI_DECOY_S:uint = 466;
        public static const TI_DECOY_SE:uint = 467;


        // Wall tileset

        public static const TI_OBST_1_2_11         :uint = 0;
        public static const TI_OBST_1_2_12         :uint = 1;
        public static const TI_OBST_2_2_11         :uint = 2;
        public static const TI_OBST_2_2_12         :uint = 3;
        public static const TI_OBST_3_2_11         :uint = 4;
        public static const TI_OBST_3_2_12         :uint = 5;
        public static const TI_OBST_4_2_11         :uint = 6;
        public static const TI_OBST_4_2_12         :uint = 7;
        public static const TI_OBST_7_2_11         :uint = 8;
        public static const TI_OBST_7_2_12         :uint = 9;
        public static const TI_OBST_8_2_11         :uint = 10;
        public static const TI_OBST_8_2_12         :uint = 11;
        public static const TI_OBST_3_1            :uint = 12;
        public static const TI_OBST_1_1            :uint = 13;
        public static const TI_OBST_7_1            :uint = 14;
        public static const TI_OBST_9_1            :uint = 15;
        public static const TI_OBST_9_2_11         :uint = 16;
        public static const TI_OBST_9_2_12         :uint = 16;


        public static const TI_OBST_1_2_21         :uint = 18;
        public static const TI_OBST_1_2_22         :uint = 19;
        public static const TI_OBST_2_2_21         :uint = 20;
        public static const TI_OBST_2_2_22         :uint = 21;
        public static const TI_OBST_3_2_21         :uint = 22;
        public static const TI_OBST_3_2_22         :uint = 23;
        public static const TI_OBST_4_2_21         :uint = 24;
        public static const TI_OBST_4_2_22         :uint = 25;
        public static const TI_OBST_7_2_21         :uint = 26;
        public static const TI_OBST_7_2_22         :uint = 27;
        public static const TI_OBST_8_2_21         :uint = 28;
        public static const TI_OBST_8_2_22         :uint = 29;
        public static const TI_OBST_4_1            :uint = 30;
        public static const TI_OBST_2_1            :uint = 31;
        public static const TI_OBST_8_1            :uint = 32;
        public static const TI_OBST_10_1           :uint = 33;
        public static const TI_OBST_9_2_21         :uint = 34;
        public static const TI_OBST_9_2_22         :uint = 35;


        public static const TI_WALL_SE4             :uint = 36;
        public static const TI_WALL_SE              :uint = 37;
        public static const TI_WALL_SW3             :uint = 38;
        public static const TI_WALL_SW              :uint = 39;
        public static const TI_WALL_NE2             :uint = 40;
        public static const TI_WALL_NE              :uint = 41;
        public static const TI_WALL_NW1             :uint = 42;
        public static const TI_WALL_NW              :uint = 43;
        public static const TI_WALL_S               :uint = 44;
        public static const TI_WALL_W               :uint = 45;
        public static const TI_WALL_N               :uint = 46;
        public static const TI_WALL_E               :uint = 47;
        public static const TI_WALL                 :uint = 48;
        public static const TI_WALL_EW              :uint = 49;
        public static const TI_WALL_NS              :uint = 50;
        public static const TI_OBST_10_2_11         :uint = 52;
        public static const TI_OBST_10_2_12         :uint = 53;

        public static const TI_WALL_SEW34           :uint = 54;
        public static const TI_WALL_SEW3            :uint = 55;
        public static const TI_WALL_SEW4            :uint = 56;
        public static const TI_WALL_SEW             :uint = 57;
        public static const TI_WALL_NEW12           :uint = 58;
        public static const TI_WALL_NEW2            :uint = 59;
        public static const TI_WALL_NEW1            :uint = 60;
        public static const TI_WALL_NEW             :uint = 61;
        public static const TI_WALL_NSE24           :uint = 62;
        public static const TI_WALL_NSE4            :uint = 63;
        public static const TI_WALL_NSE2            :uint = 64;
        public static const TI_WALL_NSE             :uint = 65;
        public static const TI_WALL_NSW13           :uint = 66;
        public static const TI_WALL_NSW3            :uint = 67;
        public static const TI_WALL_NSW1            :uint = 68;
        public static const TI_WALL_NSW             :uint = 69;
        public static const TI_OBST_10_2_21         :uint = 70;
        public static const TI_OBST_10_2_22         :uint = 71;

        public static const TI_WALL_NSEW1234        :uint = 72;
        public static const TI_WALL_NSEW234         :uint = 73;
        public static const TI_WALL_NSEW134         :uint = 74;
        public static const TI_WALL_NSEW34          :uint = 75;
        public static const TI_WALL_NSEW123         :uint = 76;
        public static const TI_WALL_NSEW23          :uint = 77;
        public static const TI_WALL_NSEW13          :uint = 78;
        public static const TI_WALL_NSEW3           :uint = 79;
        public static const TI_WALL_NSEW124         :uint = 80;
        public static const TI_WALL_NSEW24          :uint = 81;
        public static const TI_WALL_NSEW14          :uint = 82;
        public static const TI_WALL_NSEW4           :uint = 83;
        public static const TI_WALL_NSEW12          :uint = 84;
        public static const TI_WALL_NSEW2           :uint = 85;
        public static const TI_WALL_NSEW1           :uint = 86;
        public static const TI_WALL_NSEW            :uint = 87;

        public static const TI_WALLS_SE4             :uint = 90;
        public static const TI_WALLS_SE              :uint = 91;
        public static const TI_WALLS_SW3             :uint = 92;
        public static const TI_WALLS_SW              :uint = 93;
        public static const TI_WALLS_NE2             :uint = 94;
        public static const TI_WALLS_NE              :uint = 95;
        public static const TI_WALLS_NW1             :uint = 96;
        public static const TI_WALLS_NW              :uint = 97;
        public static const TI_WALLS_S               :uint = 98;
        public static const TI_WALLS_W               :uint = 99;
        public static const TI_WALLS_N               :uint = 100;
        public static const TI_WALLS_E               :uint = 101;
        public static const TI_WALLS                 :uint = 102;
        public static const TI_WALLS_EW              :uint = 103;
        public static const TI_WALLS_NS              :uint = 104;

        public static const TI_WALLS_SEW34           :uint = 108;
        public static const TI_WALLS_SEW3            :uint = 109;
        public static const TI_WALLS_SEW4            :uint = 110;
        public static const TI_WALLS_SEW             :uint = 111;
        public static const TI_WALLS_NEW12           :uint = 112;
        public static const TI_WALLS_NEW2            :uint = 113;
        public static const TI_WALLS_NEW1            :uint = 114;
        public static const TI_WALLS_NEW             :uint = 115;
        public static const TI_WALLS_NSE24           :uint = 116;
        public static const TI_WALLS_NSE4            :uint = 117;
        public static const TI_WALLS_NSE2            :uint = 118;
        public static const TI_WALLS_NSE             :uint = 119;
        public static const TI_WALLS_NSW13           :uint = 120;
        public static const TI_WALLS_NSW3            :uint = 121;
        public static const TI_WALLS_NSW1            :uint = 122;
        public static const TI_WALLS_NSW             :uint = 123;

        public static const TI_WALLS_NSEW1234        :uint = 126;
        public static const TI_WALLS_NSEW234         :uint = 127;
        public static const TI_WALLS_NSEW134         :uint = 128;
        public static const TI_WALLS_NSEW34          :uint = 129;
        public static const TI_WALLS_NSEW123         :uint = 130;
        public static const TI_WALLS_NSEW23          :uint = 131;
        public static const TI_WALLS_NSEW13          :uint = 132;
        public static const TI_WALLS_NSEW3           :uint = 133;
        public static const TI_WALLS_NSEW124         :uint = 134;
        public static const TI_WALLS_NSEW24          :uint = 135;
        public static const TI_WALLS_NSEW14          :uint = 136;
        public static const TI_WALLS_NSEW4           :uint = 137;
        public static const TI_WALLS_NSEW12          :uint = 138;
        public static const TI_WALLS_NSEW2           :uint = 139;
        public static const TI_WALLS_NSEW1           :uint = 140;
        public static const TI_WALLS_NSEW            :uint = 141;

        public static const TI_WALLB_SE4             :uint = 144;
        public static const TI_WALLB_SE              :uint = 145;
        public static const TI_WALLB_SW3             :uint = 146;
        public static const TI_WALLB_SW              :uint = 147;
        public static const TI_WALLB_NE2             :uint = 148;
        public static const TI_WALLB_NE              :uint = 149;
        public static const TI_WALLB_NW1             :uint = 150;
        public static const TI_WALLB_NW              :uint = 151;
        public static const TI_WALLB_S               :uint = 152;
        public static const TI_WALLB_W               :uint = 153;
        public static const TI_WALLB_N               :uint = 154;
        public static const TI_WALLB_E               :uint = 155;
        public static const TI_WALLB                 :uint = 156;
        public static const TI_WALLB_EW              :uint = 157;
        public static const TI_WALLB_NS              :uint = 158;

        public static const TI_WALLB_SEW34           :uint = 162;
        public static const TI_WALLB_SEW3            :uint = 163;
        public static const TI_WALLB_SEW4            :uint = 164;
        public static const TI_WALLB_SEW             :uint = 165;
        public static const TI_WALLB_NEW12           :uint = 166;
        public static const TI_WALLB_NEW2            :uint = 167;
        public static const TI_WALLB_NEW1            :uint = 168;
        public static const TI_WALLB_NEW             :uint = 169;
        public static const TI_WALLB_NSE24           :uint = 170;
        public static const TI_WALLB_NSE4            :uint = 171;
        public static const TI_WALLB_NSE2            :uint = 172;
        public static const TI_WALLB_NSE             :uint = 173;
        public static const TI_WALLB_NSW13           :uint = 174;
        public static const TI_WALLB_NSW3            :uint = 175;
        public static const TI_WALLB_NSW1            :uint = 176;
        public static const TI_WALLB_NSW             :uint = 177;

        public static const TI_WALLB_NSEW1234        :uint = 180;
        public static const TI_WALLB_NSEW234         :uint = 181;
        public static const TI_WALLB_NSEW134         :uint = 182;
        public static const TI_WALLB_NSEW34          :uint = 183;
        public static const TI_WALLB_NSEW123         :uint = 184;
        public static const TI_WALLB_NSEW23          :uint = 185;
        public static const TI_WALLB_NSEW13          :uint = 186;
        public static const TI_WALLB_NSEW3           :uint = 187;
        public static const TI_WALLB_NSEW124         :uint = 188;
        public static const TI_WALLB_NSEW24          :uint = 189;
        public static const TI_WALLB_NSEW14          :uint = 190;
        public static const TI_WALLB_NSEW4           :uint = 191;
        public static const TI_WALLB_NSEW12          :uint = 192;
        public static const TI_WALLB_NSEW2           :uint = 193;
        public static const TI_WALLB_NSEW1           :uint = 194;
        public static const TI_WALLB_NSEW            :uint = 195;

        public static const TI_STAIRS_1            :uint = 198;
        public static const TI_STAIRS_2            :uint = 199;
        public static const TI_STAIRS_3            :uint = 200;
        public static const TI_STAIRS_4            :uint = 201;
        public static const TI_STAIRS_5            :uint = 202;

        public static const TI_STAIRS_UP_1            :uint = 203;
        public static const TI_STAIRS_UP_2            :uint = 204;
        public static const TI_STAIRS_UP_3            :uint = 205;

        public static const TI_TRAPDOOR          :uint = 206;
        public static const TI_ARROW_N           :uint = 207;
        public static const TI_ARROW_NE          :uint = 208;
        public static const TI_ARROW_E           :uint = 209;
        public static const TI_ARROW_SE          :uint = 210;
        public static const TI_ARROW_S           :uint = 211;
        public static const TI_ARROW_SW          :uint = 212;
        public static const TI_ARROW_W           :uint = 213;
        public static const TI_ARROW_NW          :uint = 214;

        public static const WALL_SECRET_OFFSET   :uint = 54;
        public static const WALL_BROKEN_OFFSET   :uint = 108;

        public static const ROACH:Array = [
            [
                TI_ROACH_NW, TI_ROACH_N, TI_ROACH_NE,
                TI_ROACH_W,  0,          TI_ROACH_E,
                TI_ROACH_SW, TI_ROACH_S, TI_ROACH_SE
            ],
            [
                TI_ROACH_ANW, TI_ROACH_AN, TI_ROACH_ANE,
                TI_ROACH_AW,  0,           TI_ROACH_AE,
                TI_ROACH_ASW, TI_ROACH_AS, TI_ROACH_ASE
            ]
        ];

        public static const RQUEEN:Array = [
            [
                TI_RQUEEN_NW, TI_RQUEEN_N, TI_RQUEEN_NE,
                TI_RQUEEN_W,  0,           TI_RQUEEN_E,
                TI_RQUEEN_SW, TI_RQUEEN_S, TI_RQUEEN_SE
            ],
            [
                TI_RQUEEN_ANW, TI_RQUEEN_AN, TI_RQUEEN_ANE,
                TI_RQUEEN_AW,  0,            TI_RQUEEN_AE,
                TI_RQUEEN_ASW, TI_RQUEEN_AS, TI_RQUEEN_ASE
            ]
        ];

        public static const GOBLIN:Array = [
            [
                TI_GOBLIN_NW, TI_GOBLIN_N, TI_GOBLIN_NE,
                TI_GOBLIN_W,  0,           TI_GOBLIN_E,
                TI_GOBLIN_SW, TI_GOBLIN_S, TI_GOBLIN_SE
            ],
            [
                TI_GOBLIN_ANW, TI_GOBLIN_AN, TI_GOBLIN_ANE,
                TI_GOBLIN_AW,  0,            TI_GOBLIN_AE,
                TI_GOBLIN_ASW, TI_GOBLIN_AS, TI_GOBLIN_ASE
            ]
        ];

        public static const WWING:Array = [
            [
                TI_WWING_NW, TI_WWING_N, TI_WWING_NE,
                TI_WWING_W,  0,          TI_WWING_E,
                TI_WWING_SW, TI_WWING_S, TI_WWING_SE
            ],
            [
                TI_WWING_ANW, TI_WWING_AN, TI_WWING_ANE,
                TI_WWING_AW,  0,           TI_WWING_AE,
                TI_WWING_ASW, TI_WWING_AS, TI_WWING_ASE
            ]
        ];

        public static const EEYE:Array = [
            [
                TI_EEYE_NW, TI_EEYE_N, TI_EEYE_NE,
                TI_EEYE_W,  0,         TI_EEYE_E,
                TI_EEYE_SW, TI_EEYE_S, TI_EEYE_SE
            ],
            [
                TI_EEYE_ANW, TI_EEYE_AN, TI_EEYE_ANE,
                TI_EEYE_AW,  0,          TI_EEYE_AE,
                TI_EEYE_ASW, TI_EEYE_AS, TI_EEYE_ASE
            ],
            [
                TI_EEYEW_NW, TI_EEYEW_N, TI_EEYEW_NE,
                TI_EEYEW_W,  0,          TI_EEYEW_E,
                TI_EEYEW_SW, TI_EEYEW_S, TI_EEYEW_SE
            ]
        ];

        public static const SPIDER:Array = [
            [
                TI_SPIDER_NW, TI_SPIDER_N, TI_SPIDER_NE,
                TI_SPIDER_W,  0,           TI_SPIDER_E,
                TI_SPIDER_SW, TI_SPIDER_S, TI_SPIDER_SE
            ],
            [
                TI_SPIDER_ANW, TI_SPIDER_AN, TI_SPIDER_ANE,
                TI_SPIDER_AW,  0,            TI_SPIDER_AE,
                TI_SPIDER_ASW, TI_SPIDER_AS, TI_SPIDER_ASE
            ]
        ];

        public static const TARBABY:Array = [
            [
                TI_TARBABY_NW, TI_TARBABY_N, TI_TARBABY_NE,
                TI_TARBABY_W,  0,            TI_TARBABY_E,
                TI_TARBABY_SW, TI_TARBABY_S, TI_TARBABY_SE
            ],
            [
                TI_TARBABY_ANW, TI_TARBABY_AN, TI_TARBABY_ANE,
                TI_TARBABY_AW,  0,             TI_TARBABY_AE,
                TI_TARBABY_ASW, TI_TARBABY_AS, TI_TARBABY_ASE
            ]
        ];

        public static const REGG:Array = [
            [
                TI_REGG_NW, TI_REGG_N, 0,
                TI_REGG_W,  0,         0,
                TI_REGG_SW, 0,         0
            ],
            [
                TI_REGG_ANW, TI_REGG_AN, 0,
                TI_REGG_AW,  0,          0,
                TI_REGG_ASW, 0,          0
            ]
        ];

        public static const BEETHRO:Array = [
            TI_BEETHRO_NW, TI_BEETHRO_N, TI_BEETHRO_NE,
            TI_BEETHRO_W,  0,            TI_BEETHRO_E,
            TI_BEETHRO_SW, TI_BEETHRO_S, TI_BEETHRO_SE
        ];

        public static const DECOY:Array = [
            TI_DECOY_NW, TI_DECOY_N, TI_DECOY_NE,
            TI_DECOY_W,  0,          TI_DECOY_E,
            TI_DECOY_SW, TI_DECOY_S, TI_DECOY_SE
        ];

        public static const DECOY_SWORD:Array = [
            TI_DECOY_SWORD_NW, TI_DECOY_SWORD_N, TI_DECOY_SWORD_NE,
            TI_DECOY_SWORD_W,  0,          TI_DECOY_SWORD_E,
            TI_DECOY_SWORD_SW, TI_DECOY_SWORD_S, TI_DECOY_SWORD_SE
        ];



        public static const SWORD:Array = [
            TI_BEETHRO_SWORD_NW, TI_BEETHRO_SWORD_N, TI_BEETHRO_SWORD_NE,
            TI_BEETHRO_SWORD_W,  0,                  TI_BEETHRO_SWORD_E,
            TI_BEETHRO_SWORD_SW, TI_BEETHRO_SWORD_S, TI_BEETHRO_SWORD_SE
        ];

        public static const MIMIC:Array = [
            TI_MIMIC_NW, TI_MIMIC_N, TI_MIMIC_NE,
            TI_MIMIC_W,  0,          TI_MIMIC_E,
            TI_MIMIC_SW, TI_MIMIC_S, TI_MIMIC_SE
        ];

        public static const BRAIN:Array = [
            TI_BRAIN, TI_BRAIN_A
        ];

        public static const CITIZEN:Array = [
            TI_CITIZEN_NW, TI_CITIZEN_N, TI_CITIZEN_NE,
            TI_CITIZEN_W,  0,          TI_CITIZEN_E,
            TI_CITIZEN_SW, TI_CITIZEN_S, TI_CITIZEN_SE
        ];

        public static const NEGOTIATOR:Array = [
            TI_NEGOTIATOR_NW, TI_NEGOTIATOR_N, TI_NEGOTIATOR_NE,
            TI_NEGOTIATOR_W,  0,          TI_NEGOTIATOR_E,
            TI_NEGOTIATOR_SW, TI_NEGOTIATOR_S, TI_NEGOTIATOR_SE
        ];

        public static const TARTECHNICIAN:Array = [
            TI_TARTECHNICIAN_NW, TI_TARTECHNICIAN_N, TI_TARTECHNICIAN_NE,
            TI_TARTECHNICIAN_W,  0,          TI_TARTECHNICIAN_E,
            TI_TARTECHNICIAN_SW, TI_TARTECHNICIAN_S, TI_TARTECHNICIAN_SE
        ];

        public static const MUDCOORDINATOR:Array = [
            TI_MUDCOORDINATOR_NW, TI_MUDCOORDINATOR_N, TI_MUDCOORDINATOR_NE,
            TI_MUDCOORDINATOR_W,  0,          TI_MUDCOORDINATOR_E,
            TI_MUDCOORDINATOR_SW, TI_MUDCOORDINATOR_S, TI_MUDCOORDINATOR_SE
        ];

        public static const SERPENT:Array = [
            [
                0,         TI_SNKH_N, 0,
                TI_SNKH_W, 0,         TI_SNKH_E,
                0,         TI_SNKH_S, 0
            ],
            [
                0,          TI_SNKH_AN, 0,
                TI_SNKH_AW, 0,          TI_SNKH_AE,
                0,          TI_SNKH_AS, 0
            ],
        ];






        public static const MIMIC_SWORD:Array = [
            TI_MIMIC_SWORD_NW, TI_MIMIC_SWORD_N, TI_MIMIC_SWORD_NE,
            TI_MIMIC_SWORD_W,  0,                TI_MIMIC_SWORD_E,
            TI_MIMIC_SWORD_SW, TI_MIMIC_SWORD_S, TI_MIMIC_SWORD_SE
        ];

        public static const DOOR_Y:Array = [
            TI_DOOR_Y,    TI_DOOR_Y_W,   TI_DOOR_Y_S,   TI_DOOR_Y_SW,
            TI_DOOR_Y_E,  TI_DOOR_Y_EW,  TI_DOOR_Y_SE,  TI_DOOR_Y_SEW,
            TI_DOOR_Y_N,  TI_DOOR_Y_NW,  TI_DOOR_Y_NS,  TI_DOOR_Y_NSW,
            TI_DOOR_Y_NE, TI_DOOR_Y_NEW, TI_DOOR_Y_NSE, TI_DOOR_Y_NSEW
        ];

        public static const DOOR_YO:Array = [
            TI_DOOR_YO,    TI_DOOR_YO_W,   TI_DOOR_YO_S,   TI_DOOR_YO_SW,
            TI_DOOR_YO_E,  TI_DOOR_YO_EW,  TI_DOOR_YO_SE,  TI_DOOR_YO_SEW,
            TI_DOOR_YO_N,  TI_DOOR_YO_NW,  TI_DOOR_YO_NS,  TI_DOOR_YO_NSW,
            TI_DOOR_YO_NE, TI_DOOR_YO_NEW, TI_DOOR_YO_NSE, TI_DOOR_YO_NSEW
        ];

        public static const DOOR_R:Array = [
            TI_DOOR_R,    TI_DOOR_R_W,   TI_DOOR_R_S,   TI_DOOR_R_SW,
            TI_DOOR_R_E,  TI_DOOR_R_EW,  TI_DOOR_R_SE,  TI_DOOR_R_SEW,
            TI_DOOR_R_N,  TI_DOOR_R_NW,  TI_DOOR_R_NS,  TI_DOOR_R_NSW,
            TI_DOOR_R_NE, TI_DOOR_R_NEW, TI_DOOR_R_NSE, TI_DOOR_R_NSEW
        ];

        public static const DOOR_RO:Array = [
            TI_DOOR_RO,    TI_DOOR_RO_W,   TI_DOOR_RO_S,   TI_DOOR_RO_SW,
            TI_DOOR_RO_E,  TI_DOOR_RO_EW,  TI_DOOR_RO_SE,  TI_DOOR_RO_SEW,
            TI_DOOR_RO_N,  TI_DOOR_RO_NW,  TI_DOOR_RO_NS,  TI_DOOR_RO_NSW,
            TI_DOOR_RO_NE, TI_DOOR_RO_NEW, TI_DOOR_RO_NSE, TI_DOOR_RO_NSEW
        ];

        public static const DOOR_C:Array = [
            TI_DOOR_C,    TI_DOOR_C_W,   TI_DOOR_C_S,   TI_DOOR_C_SW,
            TI_DOOR_C_E,  TI_DOOR_C_EW,  TI_DOOR_C_SE,  TI_DOOR_C_SEW,
            TI_DOOR_C_N,  TI_DOOR_C_NW,  TI_DOOR_C_NS,  TI_DOOR_C_NSW,
            TI_DOOR_C_NE, TI_DOOR_C_NEW, TI_DOOR_C_NSE, TI_DOOR_C_NSEW
        ];

        public static const DOOR_CO:Array = [
            TI_DOOR_CO,    TI_DOOR_CO_W,   TI_DOOR_CO_S,   TI_DOOR_CO_SW,
            TI_DOOR_CO_E,  TI_DOOR_CO_EW,  TI_DOOR_CO_SE,  TI_DOOR_CO_SEW,
            TI_DOOR_CO_N,  TI_DOOR_CO_NW,  TI_DOOR_CO_NS,  TI_DOOR_CO_NSW,
            TI_DOOR_CO_NE, TI_DOOR_CO_NEW, TI_DOOR_CO_NSE, TI_DOOR_CO_NSEW
        ];

        public static const DOOR_B:Array = [
            TI_DOOR_B,    TI_DOOR_B_W,   TI_DOOR_B_S,   TI_DOOR_B_SW,
            TI_DOOR_B_E,  TI_DOOR_B_EW,  TI_DOOR_B_SE,  TI_DOOR_B_SEW,
            TI_DOOR_B_N,  TI_DOOR_B_NW,  TI_DOOR_B_NS,  TI_DOOR_B_NSW,
            TI_DOOR_B_NE, TI_DOOR_B_NEW, TI_DOOR_B_NSE, TI_DOOR_B_NSEW
        ];

        public static const DOOR_BO:Array = [
            TI_DOOR_BO,    TI_DOOR_BO_W,   TI_DOOR_BO_S,   TI_DOOR_BO_SW,
            TI_DOOR_BO_E,  TI_DOOR_BO_EW,  TI_DOOR_BO_SE,  TI_DOOR_BO_SEW,
            TI_DOOR_BO_N,  TI_DOOR_BO_NW,  TI_DOOR_BO_NS,  TI_DOOR_BO_NSW,
            TI_DOOR_BO_NE, TI_DOOR_BO_NEW, TI_DOOR_BO_NSE, TI_DOOR_BO_NSEW
        ];

        public static const DOOR_G:Array = [
            TI_DOOR_G,    TI_DOOR_G_W,   TI_DOOR_G_S,   TI_DOOR_G_SW,
            TI_DOOR_G_E,  TI_DOOR_G_EW,  TI_DOOR_G_SE,  TI_DOOR_G_SEW,
            TI_DOOR_G_N,  TI_DOOR_G_NW,  TI_DOOR_G_NS,  TI_DOOR_G_NSW,
            TI_DOOR_G_NE, TI_DOOR_G_NEW, TI_DOOR_G_NSE, TI_DOOR_G_NSEW
        ];

        public static const DOOR_GO:Array = [
            TI_DOOR_GO,    TI_DOOR_GO_W,   TI_DOOR_GO_S,   TI_DOOR_GO_SW,
            TI_DOOR_GO_E,  TI_DOOR_GO_EW,  TI_DOOR_GO_SE,  TI_DOOR_GO_SEW,
            TI_DOOR_GO_N,  TI_DOOR_GO_NW,  TI_DOOR_GO_NS,  TI_DOOR_GO_NSW,
            TI_DOOR_GO_NE, TI_DOOR_GO_NEW, TI_DOOR_GO_NSE, TI_DOOR_GO_NSEW
        ];

        public static const OBSTACLE_MAX_SIZE:uint = 5;
        public static const OBSTACLE_TOP     :uint = 0x80;
        public static const OBSTACLE_LEFT    :uint = 0x40;

        public static const OBSTACLE_INDICES:Array = [
                [0],  //0th index signifies an invalid obstacle type
                [1, 2, 3],     //boulder
                [4, 5, 6],
                [7, 8],        //fern
                [9, 10],
                [11, 12, 13],  //building
                [14, 15, 16],
                [17, 18],      //skulls
                [19, 20],
                [21, 22, 23],  //Goblin statue
                [24, 25, 26],  //Empire statue
                [27, 28],      //desk
                [29, 30],      //bookshelf
                [31],          //chairs
                [32],
                [33],
                [34],
                [35],          //book pedestal
                [36],          //chest
                [37],          //graves
                [38],
                [39],          //crate
                [40, 41, 42],  //table
                [43, 44],      //table w/ runner
                [45, 46],      //clockweight
                [47, 48],      //hut
                [49, 50],      //cauldron
                [51, 52],      //bed
                [53],          //sign post
                [54],          //barrel
                [55, 59],      //pipe
                [56, 57],      //couches
                [58]           //sink
            ];

        public static const OBSTACLE_DIMENSIONS:Array = [
                [0],
                [1,1],[2,2],[3,3],  //boulder
                [1,1],[2,2],[3,3],
                [1,1],[2,2],        //fern
                [1,1],[2,2],
                [1,1],[3,3],[5,5],  //building
                [1,1],[3,3],[5,5],
                [1,1],[2,2],        //skulls
                [1,1],[2,2],
                [1,1],[2,2],[4,4],  //Goblin statue
                [1,1],[2,2],[4,4],  //Empire statue
                [1,1],[3,3],        //desk
                [1,1],[2,1],        //bookshelf
                [1,1],              //chairs
                [1,1],
                [1,1],
                [1,1],
                [1,1],              //book pedestal
                [1,1],              //chest
                [1,1],              //graves
                [1,1],
                [1,1],              //crate
                [1,1],[2,2],[3,3],  //table
                [1,1],[2,2],        //table w/ runner
                [1,1],[4,4],        //clockweight
                [1,1],[3,3],        //hut
                [1,1],[2,2],        //cauldron
                [1,1],[1,2],        //bed
                [1,1],              //sign post
                [1,1],              //barrel
                [1,1],              //pipe
                [1,1],[2,1],        //couches
                [1,1],              //sink
                [3,1]               //pipe (3x1)
            ];

        public static const OBSTACLE_TILES:Array = [
                [],

                [[T.TI_OBST_1_1]], // Boulder 1
                [[T.TI_OBST_1_2_11, T.TI_OBST_1_2_12], [T.TI_OBST_1_2_21, T.TI_OBST_1_2_22]],
                [],

                [[T.TI_OBST_2_1]], // Boulder 2
                [[T.TI_OBST_2_2_11, T.TI_OBST_2_2_12], [T.TI_OBST_2_2_21, T.TI_OBST_2_2_22]],
                [],

                [[T.TI_OBST_3_1]], // Fern 1
                [[T.TI_OBST_3_2_11, T.TI_OBST_3_2_12],[T.TI_OBST_3_2_21, T.TI_OBST_3_2_22]],

                [[T.TI_OBST_4_1]], // Fern 2
                [[T.TI_OBST_4_2_11, T.TI_OBST_4_2_12],[T.TI_OBST_4_2_21, T.TI_OBST_4_2_22]],

                [],[],[], [], [], [], // Buildings

                [[T.TI_OBST_7_1]], // Skulls 1
                [[T.TI_OBST_7_2_11, T.TI_OBST_7_2_12],[T.TI_OBST_7_2_21, T.TI_OBST_7_2_22]],

                [[T.TI_OBST_8_1]], // Skulls 2
                [[T.TI_OBST_8_2_11, T.TI_OBST_8_2_12],[T.TI_OBST_8_2_21, T.TI_OBST_8_2_22]],

                [[T.TI_OBST_10_1]], // Statues 1
                [[T.TI_OBST_10_2_11, T.TI_OBST_10_2_12], [T.TI_OBST_10_2_21, T.TI_OBST_10_2_22]],
                [],

                [[T.TI_OBST_10_1]], // Statues 2
                [[T.TI_OBST_10_2_11, T.TI_OBST_10_2_12], [T.TI_OBST_10_2_21, T.TI_OBST_10_2_22]],
                []
            ];


        public static const STYLE_ABOVEGROUND:String = "Aboveground";
        public static const STYLE_CITY       :String = "City";
        public static const STYLE_DEEP_SPACES:String = "Deep Spaces";
        public static const STYLE_FORTRESS   :String = "Fortress";
        public static const STYLE_FOUNDATION :String = "Foundation";
        public static const STYLE_ICEWORKS   :String = "Iceworks";

        public static const TILES_WALL         :uint = 0;
        public static const TILES_FLOOR        :uint = 1;
        public static const TILES_FLOOR_ALT    :uint = 2;
        public static const TILES_FLOOR_DIRT   :uint = 3;
        public static const TILES_FLOOR_GRASS  :uint = 4;
        public static const TILES_FLOOR_MOSAIC :uint = 5;
        public static const TILES_FLOOR_ROAD   :uint = 6;
        public static const TILES_PIT          :uint = 7;
        public static const TILES_PITSIDE      :uint = 8;
        public static const TILES_PITSIDE_SMALL:uint = 9;

        public static function sanitizeStyleName(styleName:String):String {
            switch(styleName) {
                case(T.STYLE_ABOVEGROUND):
                    CF::styleAbo{
                        return styleName;
                    }
                    break;
                case(T.STYLE_CITY):
                    CF::styleCit{
                        return styleName;
                    }
                    break;
                case(T.STYLE_DEEP_SPACES):
                    CF::styleDee{
                        return styleName;
                    }
                    break;
                case(T.STYLE_FORTRESS):
                    CF::styleFor{
                        return styleName;
                    }
                    break;
                case(T.STYLE_FOUNDATION):
                    CF::styleFou{
                        return styleName;
                    }
                    break;
                case(T.STYLE_ICEWORKS):
                    CF::styleIce{
                        return styleName;
                    }
                    break;
            }

            return CF::defaultStyle;
        }

        { init(); }
        private static function init():void{
            for (var i:uint = 0; i < 720; i++){
                TILES[i] = new Rectangle(
                    (i % 18) * S.LEVEL_TILE_WIDTH,
                    (i / 18 | 0) * S.LEVEL_TILE_HEIGHT,
                    S.LEVEL_TILE_WIDTH,
                    S.LEVEL_TILE_HEIGHT);
            }
        }

        public static function plotPrecise(bitmapData:BitmapData, tile:uint, x:int, y:int, source:BitmapData = null):void{
            UBitmapData.blitPart(source || Gfx.GENERAL_TILES, bitmapData, x, y,
                F.tileToX(tile), F.tileToY(tile),
                S.LEVEL_TILE_WIDTH, S.LEVEL_TILE_HEIGHT);
        }
    }
}