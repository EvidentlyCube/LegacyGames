package net.retrocade.stats.core {
    import flash.net.registerClassAlias;

    import net.retrocade.stats.outputs.IStatsOutput;
    import net.retrocade.stats.pusher.IStatsPusher;
    import net.retrocade.stats.pusher.ManualStatsPusher;

    public class Stats {
        private static var _instance:Stats;
        private static var _instantiateLock:Boolean = true;

        public static function get instance():Stats {
            if (!_instance) {
                _instantiateLock = false;
                _instance = new Stats();
                _instantiateLock = true;

                registerClassAlias("AnalyticsData", StatsData);
                registerClassAlias("String", String);
                registerClassAlias("VectorString", Vector.<String> as Class);
            }

            return _instance;
        }

        private var _pusher:IStatsPusher;
        private var _outputs:Vector.<IStatsOutput>;

        public function Stats() {
            if (_instantiateLock) {
                throw new Error("It is impossible to manually instantiate Analytics class");
            }

            _outputs = new Vector.<IStatsOutput>();
            _pusher = new ManualStatsPusher();
        }

        public function setPusher(pusher:IStatsPusher):void {
            if (pusher == null) {
                throw new ArgumentError("Pusher can't be null");
            }

            _pusher = pusher;
            updateOutputsInPusher();
        }

        public function addOutput(output:IStatsOutput):void {
            if (output == null) {
                throw new ArgumentError("Output can't be null");
            }

            _outputs.push(output);

            updateOutputsInPusher();
        }

        public function addData(data:StatsData):void {
            if (_outputs.length == 0) {
                throw new ReferenceError("No outputs were added");
            }

            if (!_pusher) {
                throw new ReferenceError("No pusher hooked");
            }

            for each(var output:IStatsOutput in _outputs) {
                output.addData(data);
                _pusher.dataAdded(data, output);
            }
        }

        public function pushAllData():void {
            for each(var output:IStatsOutput in _outputs) {
                output.pushAllData();
            }
        }

        protected function updateOutputsInPusher():void {
            if (_pusher) {
                _pusher.outputs = _outputs;
            }
        }

        public function get outputCount():uint {
            return _outputs.length;
        }
    }
}