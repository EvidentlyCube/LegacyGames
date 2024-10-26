package game.levels{
    import flash.utils.ByteArray;

    public class LevelManager{
        [Embed(source = '/../assets/levels/normal/1.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_0_1:Class;
        [Embed(source = '/../assets/levels/normal/2.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_0_2:Class;
        [Embed(source = '/../assets/levels/normal/3.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_0_3:Class;
        [Embed(source = '/../assets/levels/normal/4.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_0_4:Class;
        [Embed(source = '/../assets/levels/normal/5.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_0_5:Class;
        [Embed(source = '/../assets/levels/normal/6.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_0_6:Class;
        [Embed(source = '/../assets/levels/normal/7.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_0_7:Class;
        [Embed(source = '/../assets/levels/normal/8.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_0_8:Class;
        [Embed(source = '/../assets/levels/normal/9.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_0_9:Class;
        [Embed(source = '/../assets/levels/normal/10.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_10:Class;
        [Embed(source = '/../assets/levels/normal/11.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_11:Class;
        [Embed(source = '/../assets/levels/normal/12.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_12:Class;
        [Embed(source = '/../assets/levels/normal/13.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_13:Class;
        [Embed(source = '/../assets/levels/normal/14.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_14:Class;
        [Embed(source = '/../assets/levels/normal/15.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_15:Class;
        [Embed(source = '/../assets/levels/normal/16.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_16:Class;
        [Embed(source = '/../assets/levels/normal/17.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_17:Class;
        [Embed(source = '/../assets/levels/normal/18.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_18:Class;
        [Embed(source = '/../assets/levels/normal/19.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_19:Class;
        [Embed(source = '/../assets/levels/normal/20.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_20:Class;
        [Embed(source = '/../assets/levels/normal/21.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_21:Class;
        [Embed(source = '/../assets/levels/normal/22.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_22:Class;
        [Embed(source = '/../assets/levels/normal/23.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_23:Class;
        [Embed(source = '/../assets/levels/normal/24.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_24:Class;
        [Embed(source = '/../assets/levels/normal/25.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_25:Class;
        [Embed(source = '/../assets/levels/normal/26.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_26:Class;
        [Embed(source = '/../assets/levels/normal/27.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_27:Class;
        [Embed(source = '/../assets/levels/normal/28.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_28:Class;
        [Embed(source = '/../assets/levels/normal/29.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_29:Class;
        [Embed(source = '/../assets/levels/normal/30.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_30:Class;
        [Embed(source = '/../assets/levels/normal/31.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_31:Class;
        [Embed(source = '/../assets/levels/normal/32.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_32:Class;
        [Embed(source = '/../assets/levels/normal/33.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_33:Class;
        [Embed(source = '/../assets/levels/normal/34.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_34:Class;
        [Embed(source = '/../assets/levels/normal/35.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_35:Class;
        [Embed(source = '/../assets/levels/normal/36.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_36:Class;
        [Embed(source = '/../assets/levels/normal/37.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_37:Class;
        [Embed(source = '/../assets/levels/normal/38.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_38:Class;
        [Embed(source = '/../assets/levels/normal/39.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_39:Class;
        [Embed(source = '/../assets/levels/normal/40.lvl', mimeType = "application/octet-stream")]  private static var levelClass_0_40:Class;

        [Embed(source = '/../assets/levels/easy/1.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_1_1:Class;
        [Embed(source = '/../assets/levels/easy/2.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_1_2:Class;
        [Embed(source = '/../assets/levels/easy/3.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_1_3:Class;
        [Embed(source = '/../assets/levels/easy/4.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_1_4:Class;
        [Embed(source = '/../assets/levels/easy/5.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_1_5:Class;
        [Embed(source = '/../assets/levels/easy/6.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_1_6:Class;
        [Embed(source = '/../assets/levels/easy/7.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_1_7:Class;
        [Embed(source = '/../assets/levels/easy/8.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_1_8:Class;
        [Embed(source = '/../assets/levels/easy/9.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_1_9:Class;
        [Embed(source = '/../assets/levels/easy/10.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_10:Class;
        [Embed(source = '/../assets/levels/easy/11.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_11:Class;
        [Embed(source = '/../assets/levels/easy/12.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_12:Class;
        [Embed(source = '/../assets/levels/easy/13.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_13:Class;
        [Embed(source = '/../assets/levels/easy/14.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_14:Class;
        [Embed(source = '/../assets/levels/easy/15.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_15:Class;
        [Embed(source = '/../assets/levels/easy/16.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_16:Class;
        [Embed(source = '/../assets/levels/easy/17.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_17:Class;
        [Embed(source = '/../assets/levels/easy/18.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_18:Class;
        [Embed(source = '/../assets/levels/easy/19.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_19:Class;
        [Embed(source = '/../assets/levels/easy/20.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_20:Class;
        [Embed(source = '/../assets/levels/easy/21.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_21:Class;
        [Embed(source = '/../assets/levels/easy/22.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_22:Class;
        [Embed(source = '/../assets/levels/easy/23.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_23:Class;
        [Embed(source = '/../assets/levels/easy/24.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_24:Class;
        [Embed(source = '/../assets/levels/easy/25.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_25:Class;
        [Embed(source = '/../assets/levels/easy/26.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_26:Class;
        [Embed(source = '/../assets/levels/easy/27.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_27:Class;
        [Embed(source = '/../assets/levels/easy/28.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_28:Class;
        [Embed(source = '/../assets/levels/easy/29.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_29:Class;
        [Embed(source = '/../assets/levels/easy/30.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_30:Class;
        [Embed(source = '/../assets/levels/easy/31.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_31:Class;
        [Embed(source = '/../assets/levels/easy/32.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_32:Class;
        [Embed(source = '/../assets/levels/easy/33.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_33:Class;
        [Embed(source = '/../assets/levels/easy/34.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_34:Class;
        [Embed(source = '/../assets/levels/easy/35.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_35:Class;
        [Embed(source = '/../assets/levels/easy/36.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_36:Class;
        [Embed(source = '/../assets/levels/easy/37.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_37:Class;
        [Embed(source = '/../assets/levels/easy/38.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_38:Class;
        [Embed(source = '/../assets/levels/easy/39.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_39:Class;
        [Embed(source = '/../assets/levels/easy/40.lvl', mimeType = "application/octet-stream")]  private static var levelClass_1_40:Class;

        [Embed(source = '/../assets/levels/hard/1.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_2_1:Class;
        [Embed(source = '/../assets/levels/hard/2.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_2_2:Class;
        [Embed(source = '/../assets/levels/hard/3.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_2_3:Class;
        [Embed(source = '/../assets/levels/hard/4.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_2_4:Class;
        [Embed(source = '/../assets/levels/hard/5.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_2_5:Class;
        [Embed(source = '/../assets/levels/hard/6.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_2_6:Class;
        [Embed(source = '/../assets/levels/hard/7.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_2_7:Class;
        [Embed(source = '/../assets/levels/hard/8.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_2_8:Class;
        [Embed(source = '/../assets/levels/hard/9.lvl',  mimeType = "application/octet-stream")]  private static var levelClass_2_9:Class;
        [Embed(source = '/../assets/levels/hard/10.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_10:Class;
        [Embed(source = '/../assets/levels/hard/11.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_11:Class;
        [Embed(source = '/../assets/levels/hard/12.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_12:Class;
        [Embed(source = '/../assets/levels/hard/13.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_13:Class;
        [Embed(source = '/../assets/levels/hard/14.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_14:Class;
        [Embed(source = '/../assets/levels/hard/15.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_15:Class;
        [Embed(source = '/../assets/levels/hard/16.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_16:Class;
        [Embed(source = '/../assets/levels/hard/17.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_17:Class;
        [Embed(source = '/../assets/levels/hard/18.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_18:Class;
        [Embed(source = '/../assets/levels/hard/19.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_19:Class;
        [Embed(source = '/../assets/levels/hard/20.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_20:Class;
        [Embed(source = '/../assets/levels/hard/21.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_21:Class;
        [Embed(source = '/../assets/levels/hard/22.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_22:Class;
        [Embed(source = '/../assets/levels/hard/23.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_23:Class;
        [Embed(source = '/../assets/levels/hard/24.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_24:Class;
        [Embed(source = '/../assets/levels/hard/25.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_25:Class;
        [Embed(source = '/../assets/levels/hard/26.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_26:Class;
        [Embed(source = '/../assets/levels/hard/27.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_27:Class;
        [Embed(source = '/../assets/levels/hard/28.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_28:Class;
        [Embed(source = '/../assets/levels/hard/29.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_29:Class;
        [Embed(source = '/../assets/levels/hard/30.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_30:Class;
        [Embed(source = '/../assets/levels/hard/31.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_31:Class;
        [Embed(source = '/../assets/levels/hard/32.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_32:Class;
        [Embed(source = '/../assets/levels/hard/33.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_33:Class;
        [Embed(source = '/../assets/levels/hard/34.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_34:Class;
        [Embed(source = '/../assets/levels/hard/35.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_35:Class;
        [Embed(source = '/../assets/levels/hard/36.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_36:Class;
        [Embed(source = '/../assets/levels/hard/37.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_37:Class;
        [Embed(source = '/../assets/levels/hard/38.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_38:Class;
        [Embed(source = '/../assets/levels/hard/39.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_39:Class;
        [Embed(source = '/../assets/levels/hard/40.lvl', mimeType = "application/octet-stream")]  private static var levelClass_2_40:Class;

        [Embed(source = '/../assets/levels/branded/001.oel',  mimeType = "application/octet-stream")]  private static var levelClass_3_1:Class;
        [Embed(source = '/../assets/levels/branded/002.oel',  mimeType = "application/octet-stream")]  private static var levelClass_3_2:Class;
        [Embed(source = '/../assets/levels/branded/003.oel',  mimeType = "application/octet-stream")]  private static var levelClass_3_3:Class;
        [Embed(source = '/../assets/levels/branded/004.oel',  mimeType = "application/octet-stream")]  private static var levelClass_3_4:Class;
        [Embed(source = '/../assets/levels/branded/005.oel',  mimeType = "application/octet-stream")]  private static var levelClass_3_5:Class;
        [Embed(source = '/../assets/levels/branded/006.oel',  mimeType = "application/octet-stream")]  private static var levelClass_3_6:Class;
        [Embed(source = '/../assets/levels/branded/007.oel',  mimeType = "application/octet-stream")]  private static var levelClass_3_7:Class;
        [Embed(source = '/../assets/levels/branded/008.oel',  mimeType = "application/octet-stream")]  private static var levelClass_3_8:Class;
        [Embed(source = '/../assets/levels/branded/009.oel',  mimeType = "application/octet-stream")]  private static var levelClass_3_9:Class;
        [Embed(source = '/../assets/levels/branded/010.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_10:Class;
        [Embed(source = '/../assets/levels/branded/011.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_11:Class;
        [Embed(source = '/../assets/levels/branded/012.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_12:Class;
        [Embed(source = '/../assets/levels/branded/013.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_13:Class;
        [Embed(source = '/../assets/levels/branded/014.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_14:Class;
        [Embed(source = '/../assets/levels/branded/015.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_15:Class;
        [Embed(source = '/../assets/levels/branded/016.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_16:Class;
        [Embed(source = '/../assets/levels/branded/017.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_17:Class;
        [Embed(source = '/../assets/levels/branded/018.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_18:Class;
        [Embed(source = '/../assets/levels/branded/019.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_19:Class;
        [Embed(source = '/../assets/levels/branded/020.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_20:Class;
        [Embed(source = '/../assets/levels/branded/021.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_21:Class;
        [Embed(source = '/../assets/levels/branded/022.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_22:Class;
        [Embed(source = '/../assets/levels/branded/023.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_23:Class;
        [Embed(source = '/../assets/levels/branded/024.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_24:Class;
        [Embed(source = '/../assets/levels/branded/025.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_25:Class;
        [Embed(source = '/../assets/levels/branded/026.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_26:Class;
        [Embed(source = '/../assets/levels/branded/027.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_27:Class;
        [Embed(source = '/../assets/levels/branded/028.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_28:Class;
        [Embed(source = '/../assets/levels/branded/029.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_29:Class;
        [Embed(source = '/../assets/levels/branded/030.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_30:Class;
        [Embed(source = '/../assets/levels/branded/031.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_31:Class;
        [Embed(source = '/../assets/levels/branded/032.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_32:Class;
        [Embed(source = '/../assets/levels/branded/033.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_33:Class;
        [Embed(source = '/../assets/levels/branded/034.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_34:Class;
        [Embed(source = '/../assets/levels/branded/035.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_35:Class;
        [Embed(source = '/../assets/levels/branded/036.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_36:Class;
        [Embed(source = '/../assets/levels/branded/037.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_37:Class;
        [Embed(source = '/../assets/levels/branded/038.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_38:Class;
        [Embed(source = '/../assets/levels/branded/039.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_39:Class;
        [Embed(source = '/../assets/levels/branded/040.oel', mimeType = "application/octet-stream")]  private static var levelClass_3_40:Class;

        private static var _instance:LevelManager;

        public static function get instance():LevelManager{
            if (!_instance) {
                _instance = new LevelManager();
            }

            return _instance;
        }

        final public function getLevel(gameMode:int, levelID:int):ByteArray{
            var name:String = "levelClass_" + gameMode + "_" + levelID;

            var levelClass:* = LevelManager[name];
            var byteArray:ByteArray = new (levelClass) as ByteArray;
            byteArray.position = 0;

            return byteArray;
        }

        public function loadHelp(gameMode:int, levelID:int):void{

        }

        public function getNextTutorialLevel(gameMode:int, id:int):int{
            return -1
        }
    }
}