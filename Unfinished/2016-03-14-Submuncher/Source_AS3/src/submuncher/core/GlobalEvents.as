package submuncher.core {
    import net.retrocade.signal.Signal;

    public class GlobalEvents {
        private static var _onStageResized:Signal = new Signal();

        public static function get onStageResized():Signal {
            return _onStageResized;
        }
    }
}
