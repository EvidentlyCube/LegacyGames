package game.global {
    import flash.geom.Point;
    import flash.system.Security;
    import game.achievements.Achievement;
    import game.windows.TWindowMessage;
    import net.retrocade.utils.Base64;
	import net.retrocade.utils.Log;

    import game.managers.VODemoRecord;

    import net.retrocade.camel.core.rSave;
    import net.retrocade.standalone.QuickLoader;
    import net.retrocade.standalone.QuickURLLoader;
    import net.retrocade.utils.Rand;
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class CaravelConnect {

        private static const API_URL:String = "http://forum.caravelgames.com/flash/gameflash.php";



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Broken
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * A flag that indicates that there were problems with connection and no cnet
         * calls are being resolved
         */
        private static var _broken:Boolean = false;

        public static function get isBroken():Boolean {
            return _broken;
        }

        public static function set isBroken(value:Boolean):void {
            _broken = value;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Misc Vars
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static var cnetName:String = "";
        public static var cnetPass:String = "";

        public static function saveCnetCredentials():void {
            rSave.setStorage(S.SAVE_CNET_KEYS_STORAGE);
            rSave.save(C.SETTING_CNET_NAME,      cnetName, false);
            rSave.save(C.SETTING_CNET_PASS,      cnetPass, false);
            rSave.flush();
            rSave.setStorage(S.SAVE_STORAGE_NAME);
        }

        public static function loadCnetCredentials():void {
            rSave.setStorage(S.SAVE_CNET_KEYS_STORAGE);
            cnetName = rSave.load(C.SETTING_CNET_NAME, "", false);
            cnetPass = rSave.load(C.SETTING_CNET_PASS, "", false);
            rSave.setStorage(S.SAVE_STORAGE_NAME);
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Get Data
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Format:
         *  - id
         *  - text
         *  - timestamp
         *  - url
         */
        public static var news :Array = [];

        /**
         * Format:
         *  - id
         *  - title
         *  - timestamp
         *  - description
         *  - url
         */
        public static var games:Array = [];

        /**
         * Checks if news/games data was successfully loaded from the server
         * @return
         */
        public static function isDataLoaded():Boolean {
            return true;
        }


        private static var _dataLoader:QuickURLLoader;

        public static function getData():void {
            // This function fetched news & games data
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Login
        // ::::::::::::::::::::::::::::::::::::::::::::::

        public static function login(callback:Function = null):void {
            // This function logged into CNet
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Submit Score
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Submits a score for a given room. It automatically retrieves the score info from Progress
         * @param	roomIDs ID or array of IDs of the rooms which scores are submitted
		 * @param callback takes one parameter:
         *  on success ({place:Number, roomID:uint});
         *  on failure (null)
         */
        public static function submitScore(roomIDs:*, callback:Function, enteredRoom:int = -1):void {
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Retrieve Demos
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Retrieves score for a given room id
         * @param	roomID RoomID to get the scores for
         * @param	callback Function which takes one argument:
         * on success: array of objects {score:uint, name:String},
         * on failure: null
         */
        public static function retrieveScores(roomID:uint, callback:Function):void {
        }

        /**
         * Cancel retrieving scores if process is running
         */
        public static function retrieveScoresCancel(): void {

        }


        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Achievemets Rewarding
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Retrieves score for a given room id
         * @param	roomID RoomID to get the scores for
         * @param	callback Function which takes one argument:
         * on success: array of objects {score:uint, name:String},
         * on failure: null
         */
        public static function reportAchievement(achievement:Achievement):void {
        }
    }
}