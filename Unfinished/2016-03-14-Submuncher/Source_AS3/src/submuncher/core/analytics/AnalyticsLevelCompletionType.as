package submuncher.core.analytics {
    import flash.errors.MemoryError;

    public class AnalyticsLevelCompletionType {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<AnalyticsLevelCompletionType> = new Vector.<AnalyticsLevelCompletionType>();

        public static var DIED:AnalyticsLevelCompletionType = new AnalyticsLevelCompletionType("lose");
        public static var COMPLETED:AnalyticsLevelCompletionType = new AnalyticsLevelCompletionType("completed");
        public static var SECRET:AnalyticsLevelCompletionType = new AnalyticsLevelCompletionType("secret");
        public static var DOCUMENT:AnalyticsLevelCompletionType = new AnalyticsLevelCompletionType("document");
        public static var PAR:AnalyticsLevelCompletionType = new AnalyticsLevelCompletionType("par");
        public static var PAR_SECRET:AnalyticsLevelCompletionType = new AnalyticsLevelCompletionType("par+secret");
        public static var PAR_DOCUMENT:AnalyticsLevelCompletionType = new AnalyticsLevelCompletionType("document+par");
        public static var DOCUMENT_SECRET:AnalyticsLevelCompletionType = new AnalyticsLevelCompletionType("document+secret");
        public static var PAR_DOCUMENT_SECRET:AnalyticsLevelCompletionType = new AnalyticsLevelCompletionType("document+par+secret");

        {
            _creationLock = true;
        }

        private var _name:String;
        private var _metadata:Object;

        public function get name():String {
            return _name;
        }

        public function AnalyticsLevelCompletionType(name:String) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _name = name;

            _collection.push(this);
        }

        public static function byParams(completed:Boolean, secret:Boolean, document:Boolean, par:Boolean):AnalyticsLevelCompletionType {
            if (!completed){
                return DIED;
            } else if (!secret && !document && !par){
                return COMPLETED;
            } else if (secret && !document && !par){
                return SECRET;
            } else if (!secret && document && !par){
                return DOCUMENT;
            } else if (!secret && !document && par){
                return PAR;
            } else if (secret && !document && par){
                return PAR_SECRET;
            } else if (!secret && document && par){
                return PAR_DOCUMENT;
            } else if (secret && document && !par){
                return DOCUMENT_SECRET;
            } else {
                return PAR_DOCUMENT_SECRET;
            }
        }

        public static function byName(name:String):AnalyticsLevelCompletionType {
            for each(var element:AnalyticsLevelCompletionType in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid enum");
        }


        public static function hasName(name:String):Boolean {
            for each(var element:AnalyticsLevelCompletionType in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
