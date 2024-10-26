package  {
    import flash.utils.getTimer;
    import net.retrocade.utils.UString;
	/**
     * ...
     * @author
     */
    public class ASSESS {
        private static var assesses:Array = [];
        private static var current :uint  = 0;

        public static function on():void {
            return;
            assesses[current++] = getTimer();
        }

        public static function off(message:String = ""):void {
            return;
            if (current == 0)
                throw new Error("Tried to stop when there were none active");

            if (message) message += ": ";

            var time:String = (getTimer() - assesses[--current]).toString();

            if (time.length > 3)
                time = time.substr(0, time.length - 3) + "." + time.substr(time.length - 3);
            else
                time = "0." + UString.extendFromLeft(time, 3);

            trace(message + time + "s.");
        }
    }
}