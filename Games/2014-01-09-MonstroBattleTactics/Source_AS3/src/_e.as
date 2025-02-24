package  {
    import net.retrocade.tacticengine.core.log;
    import net.retrocade.log.LogType;

    public function _e(context:String, error: Error): void{
        L::OG{
            log("!!! EXCEPTION CAUGHT !!!", LogType.ERROR);
            log("Context: " + context, LogType.ERROR);
            log("Type: " + error.name, LogType.ERROR);
            log("Message: " + error.message, LogType.ERROR);
            log("Stack Trace: " + error.getStackTrace(), LogType.ERROR);
        }
    }
}