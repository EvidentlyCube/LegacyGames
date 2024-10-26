package game.achievements{
    import flash.display.BitmapData;
    import flash.utils.ByteArray;

    import net.retrocade.utils.Base64;
    import net.retrocade.utils.UBitmapData;
    import net.retrocade.utils.USecure;

    public class Achievement {
        private static var idCounter:uint = 0;

        public var id  :uint;
        public var name:String;
        public var desc:*;

        public var acquired:Boolean = false;

        public var code    :String;

        private var renderedGraphic:BitmapData;

        /**
         * Three param function (bitmapData, x:uint, y:uint) which draws
         * this achievement's graphic into a given bitmapData
         */
        private var _drawFunction:Function;

        /**
         * No-param function which returns true if this achievement should be activated
         */
        private var _init  :Function;

        /**
         * No-param function which returns true if this achievement has been acquired
         */
        private var _update:Function;

        internal var _data  :Object = {};



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Functions
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Called when progress does not load successfully
         */
        public function clear():void{
            _data    = {};
            acquired = false;
        }

        /**
         * Checks if given achievement relates to this room
         * @return True if this achievement relates to current room
         */
        public function init():Boolean{
            return _init.call(this);
        }

        /**
         * Checks if given achievement was completed on this turn
         * @return True if this achievement has just been completed
         */
        public function update():Boolean{
            return _update.call(this);
        }

        /**
         * Draws this achievement to specified bitmap data at given coordinates
         */
        public function drawTo(bitmapData:BitmapData, x:uint, y:uint):void{
            if (!renderedGraphic){
                renderedGraphic = new BitmapData(44, 44, true, 0);
                _drawFunction.call(this, renderedGraphic, 0, 0);
            }

            UBitmapData.draw(renderedGraphic, bitmapData, x, y);
        }



        public function encode():String {
            var jenkins:uint = USecure.hashStringJenkins(code);

            var byteArray:ByteArray = new ByteArray();

            if (acquired)
                byteArray.writeUnsignedInt(id);
            else
                byteArray.writeUnsignedInt(uint.MAX_VALUE);

            byteArray.writeUTF(code);
            byteArray.writeObject(_data);

            var toScramble:String = Base64.encodeByteArray(byteArray);

            return USecure.scrambleString(toScramble, jenkins);
        }

        /**
         * Decodes achievement status and returns true if the data was valid or false if it was invalid
         */
        public function decode(data:String):Boolean{
            var jenkins:uint = USecure.hashStringJenkins(code);

            data = USecure.unscrambleString(data, jenkins);

            var ba        :ByteArray = Base64.decodeByteArray(data);

            var readID    :uint      = ba.readUnsignedInt();
            var readCode  :String    = ba.readUTF();

            _data                    = ba.readObject();

            if (readID != id && readID != uint.MAX_VALUE && readCode != code)
                return false;

            if (readID == id)
                acquired = true;

            return true;
        }

        public static function get(name:String, desc:*, code:String,
                                   draw:Function, init:Function, update:Function):Achievement{
            var achievement:Achievement = new Achievement();

            achievement.id   = idCounter++;
            achievement.name = name;
            achievement.desc = desc;
            achievement.code = code;

            achievement._drawFunction = draw;
            achievement._init         = init;
            achievement._update       = update;

            return achievement;
        }
    }
}