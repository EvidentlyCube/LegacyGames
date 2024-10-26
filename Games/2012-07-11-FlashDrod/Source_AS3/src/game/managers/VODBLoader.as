package game.managers {
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class VODBLoader {

        public var id  :*;
        public var data:*;
        public var callback:Function;

        public function VODBLoader(id:*, data:*, callback:Function) {
            this.id       = id;
            this.data     = data;
            this.callback = callback;
        }

        public function run():void {
            callback(id, data);
        }
    }
}