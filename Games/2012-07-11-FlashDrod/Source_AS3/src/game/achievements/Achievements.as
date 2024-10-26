package game.achievements{
    import flash.utils.ByteArray;
    import game.global.CaravelConnect;
    import net.retrocade.camel.rLang;

    import game.windows.TGrowlAchievement;

    import net.retrocade.camel.core.rSave;
    import net.retrocade.utils.Base64;
    import net.retrocade.utils.UByteArray;
    import net.retrocade.utils.USecure;

    public class Achievements {
        private static const SAVE_NAME:String = "7x_99_2";

        private static var _allAchievements        :Array = [];
        private static var _activeAchievements     :Array = [];
        private static var _uncompletedAchievements:Array = [];

        { init(); }

        public static function getAll():Array{
            return _allAchievements.concat();
        }

        private static function init():void {
            CF::holdKdd1{
                AchievementsListKdd1(_allAchievements);
            }

            CF::holdKdd2{
                AchievementsListKdd2(_allAchievements);
            }

            CF::holdKdd3{
                AchievementsListKdd3(_allAchievements);
            }

            loadCompleted();

            for each(var i:Achievement in _allAchievements){
                if (!i.acquired)
                    _uncompletedAchievements.push(i);
            }
        }

        private static function saveCompleted():void {
            var data:ByteArray = new ByteArray(); // The target content

            // Create content
            var content       :ByteArray = new ByteArray();
            var contentJenkins:uint;

            for each (var i:Achievement in _allAchievements) {
                var achievementString:String = i.encode();

                content.writeUTF(achievementString);
            }

            contentJenkins          = USecure.hashByteArrayJenkins(content);
            content       .position = 0;

            data.writeUnsignedInt(content.length);
            data.writeBytes      (content);



            // Create checker 1

            var checker1:String;
            checker1 = countAll() + ":" + countCompleted() + ":" + countUncompleted();
            checker1 = USecure.scrambleString(checker1, contentJenkins);

            data.writeUTF (checker1);



            // Create checker 2

            var checker2:uint = contentJenkins;
            data.writeUnsignedInt(checker2);



            // Finalize

            data.compress();

            var result:String = Base64.encodeByteArray(data);

            rSave.save(SAVE_NAME, result);
            rSave.flush(262144);
        }

        private static function loadCompleted():void{
            try
            {
                var save:String = rSave.load(SAVE_NAME, "");

                var data:ByteArray = Base64.decodeByteArray(save);
                data.uncompress();

                data.position = 0;

                var contentLength:uint      = data.readUnsignedInt();
                var content      :ByteArray = new ByteArray();
                data.readBytes(content, 0, contentLength);

                var checker1:String = data.readUTF();
                var checker2:uint   = data.readUnsignedInt();

                var contentJenkins:uint = USecure.hashByteArrayJenkins(content);


                // Validate checker2
                if (checker2 != contentJenkins)
                    throw new Error ("Invalid achievements data, prunning");


                // Load Achievements

                content.position = 0;

                for each(var a:Achievement in _allAchievements){
                    var achievementString:String = content.readUTF();

                    if (!a.decode(achievementString))
                        throw new Error ("Invalid achievemenets data, prunning");
                }



                // Validate checker1
                checker1 = USecure.unscrambleString(checker1, contentJenkins);
                var checkerData:Array = checker1.split(":");

                if (checkerData.length != 3 ||
                    parseInt(checkerData[0]) != countAll() ||
                    parseInt(checkerData[1]) != countCompleted() ||
                    parseInt(checkerData[2]) != countUncompleted()){
                    throw new Error ("Invalid achievements data, prunning");
                }
            }
            catch (e:Error){
                for (var i:uint = 0, l:uint = _allAchievements.length;
                        i < l; i++){
                    a = _allAchievements[i];
                    a.clear();
                }

                trace("Achievements load failed: ", e.errorID, e.name, e.message);
            }
        }

        public static function initRoomStarted():void {
            _activeAchievements.length = 0;

            saveCompleted();

            for each(var i:Achievement in _allAchievements) {
                if (!i.acquired && i.init())
                    _activeAchievements.push(i);
            }
        }

        public static function turnPassed():void {
            var completed:Array;

            for each(var i:Achievement in _activeAchievements) {
                if (!i.acquired && i.update()) { // returns true if it was completed
                    if (!completed) // We did not preinitialize the array for performance reasons
                        completed = [];

                    completed.push(i);
                }
            }

            if (completed) {
                for each (i in completed) {
                    markAchievementCompleted(i);
                }
            }
        }

        public static function clearAll():void{
            var a:Achievement;

            for (var i:uint = 0, l:uint = _allAchievements.length;
                i < l; i++){
                a = _allAchievements[i];
                a.clear();
            }
        }

        private static function countAll():uint{
            return _allAchievements.length;
        }

        private static function countCompleted():uint{
            var count:uint = 0;

            for each(var a:Achievement in _allAchievements){
                if (a.acquired)
                    count++;
            }

            return count;
        }

        private static function countUncompleted():uint{
            var count:uint = 0;

            for each(var a:Achievement in _allAchievements){
                if (!a.acquired)
                    count++;
            }

            return count;
        }

        private static function markAchievementCompleted(achievement:Achievement):void {
            var index:uint;

            achievement.acquired = true;

            new TGrowlAchievement(achievement);
            CaravelConnect.reportAchievement(achievement);

            saveCompleted();
        }

        public static function uploadCompleted():void {
            for each(var a:Achievement in _allAchievements){
                if (a.acquired) {
                    CaravelConnect.reportAchievement(a);
                }
            }
        }
    }
}

/**

Achievements encoding:


START:

    BASE64 (
        INFLATE(
            UINT (LENGTH (content))
            BYTE_ARRAY (content):
                EACH (achievement){ // in ID order
                    UINT (LENGTH (entry)):

		            LABEL (entry):
                        SCRAMBLE (HASH_JENKINS(code)) {
                            BASE64 (
                                IF (acquired)
                                    BYTE_ARRAY (UINT (id) + STRING (code))
                                ELSE
                                    BYTE_ARRAY (UINT (uint.MAX_VALUE) + STRING (code))
                            )
                        }
                    ENDLABEL .

                }
            ENDLABEL .

	        NULL_BYTE .

            SCRAMBLE (HASH_JENKINS (BYTE_ARRAY::content)){
                STRING (COUNT_ACHIEVEMENTS . ":" . COUNT_COMPLETED . ":" . COUNT_ACHIEVEMENTS - COUNT_COMPLETED)
            } .

	        NULL_BYTE .

            HASH_JENKINS (BYTE_ARRAY::content)
        )
    )
END:

**/