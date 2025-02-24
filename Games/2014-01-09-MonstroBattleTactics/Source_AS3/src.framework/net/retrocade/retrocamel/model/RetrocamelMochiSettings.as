


package net.retrocade.retrocamel.model {

    public class RetrocamelMochiSettings {
        public var id:String;
        public var preAdResolution:String;
        public var preAdOutlineColor:uint;
        public var preAdBackgroundColor:uint;
        public var preAdBarColor:uint;

        private var _scores:Object = [];

        public function getScoreObject(scoreName:String):Object{
            return _scores[scoreName];
        }

        public function addScoreObject(scoreName:String, object:Object):void{
            _scores[scoreName] = object;
        }
    }
}
