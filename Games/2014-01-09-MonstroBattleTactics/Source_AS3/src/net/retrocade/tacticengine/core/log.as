/**
 * Created by Skell on 11.12.13.
 */
package net.retrocade.tacticengine.core
{
    import net.retrocade.log.LogType;

    public function log(message:String, type:LogType = null):void
    {
        if (!type)
        {
            type = LogType.MESSAGE;
        }

        LogHelper.logger.log(message, type);
    }
}

CF::desktop
{
    import net.retrocade.log.Logger;
    import net.retrocade.log.LogType;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    class LogHelper
    {
        public static var logger:Logger;
        public static var logPath:File;
        public static var errorPath:File;
        {
            init();
        }

        private static function init():void
        {
            logger = new Logger();
            logger.logCallback = log;

            if (CF::drmFree)
            {
                logPath = File.applicationStorageDirectory.resolvePath("monstro.log");
                errorPath = File.applicationStorageDirectory.resolvePath("error.log");
            }
            else if (CF::steam)
            {
                logPath = File.applicationDirectory.resolvePath("monstro.log");
                errorPath = File.applicationDirectory.resolvePath("error.log");

            }

            logPath = new File(logPath.nativePath);
            errorPath = new File(errorPath.nativePath);
        }

        public static function log(message:String, logType:LogType):void
        {
            var fileStream:FileStream;

            if (logType === LogType.ERROR)
            {
                fileStream = new FileStream();
                fileStream.open(errorPath, FileMode.APPEND);
                fileStream.writeUTFBytes(message + "\r\n");
                fileStream.close();
            }
            else
            {
                fileStream = new FileStream();
                fileStream.open(logPath, FileMode.APPEND);
                fileStream.writeUTFBytes(message + "\r\n");
                fileStream.close();
            }
        }
    }
}


CF::flash
{
    import net.retrocade.log.Logger;
    import net.retrocade.log.LogType;

    class LogHelper
    {
        public static var logger:Logger;
        {
            init();
        }

        private static function init():void
        {
            logger = new Logger();
            logger.logCallback = log;
        }

        public static function log(message:String, logType:LogType):void
        {
            trace(logType.name + ":" + message)
        }
    }
}

