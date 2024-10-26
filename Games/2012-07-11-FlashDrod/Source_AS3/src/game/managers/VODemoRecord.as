package game.managers {
    import flash.utils.ByteArray;
    import game.global.Commands;
    import game.global.PackedVars;
    import net.retrocade.utils.Base64;
    import net.retrocade.utils.USecure;
    import net.retrocade.vault.Safe;
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class VODemoRecord {
        private var _roomID:uint;
        private var _score :Safe;
        private var _demo  :ByteArray;

        private var _startX:uint;
        private var _startY:uint;
        private var _startO:uint;

        private var _endedScripts:Array;
        private var _gameVars    :PackedVars;

        public  var wasUploaded:Boolean = false;


        public function get roomID():uint {
            return _roomID;
        }

        public function get score():uint {
            return _score.get();
        }

        public function get startX():uint {
            return _startX;
        }

        public function get startY():uint {
            return _startY;
        }

        public function get startO():uint {
            return _startO;
        }

        public function get endedScripts():Array {
            return _endedScripts;
        }

        public function get gameVars():PackedVars {
            return _gameVars;
        }

        public function get demoBuffer():ByteArray {
            return _demo;
        }

        public function VODemoRecord(roomID:uint, data:String = null) {
            _roomID = roomID;
            _score  = new Safe();
            _demo   = new ByteArray();

            _endedScripts = [];
            _gameVars = new PackedVars();

            _score.set(uint.MAX_VALUE);

            if (data)
                load(data);
        }

        /**
         * @return
         */
        public function saveDemo(newScore:Number, startX:uint, startY:uint, startO:uint, endedScripts:Array, gameVars:PackedVars):Boolean {
            if (newScore < score && newScore > 1){
                _score.set(newScore);
                _startX = startX;
                _startY = startY;
                _startO = startO;
                _endedScripts = endedScripts.concat();
                _gameVars     = gameVars.clone();

                _demo  = Commands.getBuffer();

                wasUploaded = false;

                return true;
            }

            return false;
        }

        public function clearDemo():void {
            _score.set(uint.MAX_VALUE);

            _demo.length = 0;
        }

        public function load(data:String):void {
            var buffer:ByteArray = Base64.decodeByteArray(data);

            USecure.unscrambleByteArray(buffer, buffer.length);

            buffer.uncompress();

            _roomID     = buffer.readUnsignedInt();
            _startX     = buffer.readUnsignedInt();
            _startY     = buffer.readUnsignedInt();
            _startO     = buffer.readUnsignedInt();
            _score.setFromString(buffer.readUTF());
            _endedScripts = JSON.parse(buffer.readUTF()) as Array;
            _gameVars = new PackedVars(Base64.decodeByteArray(buffer.readUTF()));

            buffer.readBytes(_demo);
        }

        public function save():String {
            var buffer:ByteArray = new ByteArray();

            _demo.position = 0;

            buffer.writeUnsignedInt(_roomID);
            buffer.writeUnsignedInt(_startX);
            buffer.writeUnsignedInt(_startY);
            buffer.writeUnsignedInt(_startO);
            buffer.writeUTF(_score.getSafeAsString());
            buffer.writeUTF(JSON.stringify(_endedScripts));
            buffer.writeUTF(Base64.encodeByteArray(_gameVars.pack()));
            buffer.writeBytes(_demo);

            buffer.compress();

            USecure.scrambleByteArray(buffer, buffer.length);

            return Base64.encodeByteArray(buffer);
        }
    }

}