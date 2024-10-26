package submuncher.ingame.core {
    import net.retrocade.utils.UtilsString;

    public class Utils {
        public static function timeAsString(time:int, displayAsFrames:Boolean):String {
            if (displayAsFrames){
                return UtilsString.padLeft(time.toString(), 5);
            } else {
                var minutes:int = (time / 3600);
                var seconds:int = (time / 60) % 60;
                var millisec:Number = Math.round((time % 60 / 60.0) * 1000);

                return minutes.toString() + ":" + UtilsString.padLeft(seconds.toString(), 2) + "." + UtilsString.padLeft(millisec.toString(), 3);
            }
        }
    }
}
