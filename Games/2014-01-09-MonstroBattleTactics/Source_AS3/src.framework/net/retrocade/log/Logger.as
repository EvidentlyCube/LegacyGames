

/**
 * Created by Skell on 11.12.13.
 */
package net.retrocade.log {
    import net.retrocade.functions.printf;
    import net.retrocade.utils.UtilsString;

    public class Logger {
        public var logCallback:Function;

        public function Logger(){
        }

        public function log(message:String, logType:LogType):void{
            var date:Date = new Date();
            var logMessage:String = printf(
                "[%%-%%-%% %%:%%:%%.%% %%] %%",
                UtilsString.padLeft(date.date, 2),
                UtilsString.padLeft(date.month + 1, 2),
                date.fullYear + 1,
                UtilsString.padLeft(date.hours, 2),
                UtilsString.padLeft(date.minutes, 2),
                UtilsString.padLeft(date.seconds, 2),
                UtilsString.padLeft(date.milliseconds, 3),
                logType.name,
                message
            );

            if (logCallback !== null && logCallback.length == 2){
                logCallback(logMessage, logType);
            } else {
                trace(logMessage);
            }
        }
    }
}
