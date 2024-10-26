package net.retrocade.utils{
    import net.retrocade.camel.global.retrocamel_int;

    use namespace retrocamel_int;

    public class Rand{
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        /**
         * @private
         * The seed
         */
        retrocamel_int static var _seed:uint = 1;

        /**
         * Seed of the PRNG, can not be set to 0
         */
        public static function set seed(newSeed:uint):void{
            if (newSeed == 0)
                throw new ArgumentError("Seed can never be 0");

            _seed = newSeed;
        }

        /**
         * @private
         */
        public static function get seed():uint{
            return _seed;
        }



        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        /**
         * Retrieves a random Number between 0 and 1
         */
        public static function get om():Number{
            return (((((_seed = (_seed * 16807) % 0x7FFFFFFF)) - 1) / 0x7FFFFFFF));
        }

        /**
         * Retrieves a random uint between min (inclusive) and max (exclusive)
         */
        public static function u(min:uint = 0, max:uint = uint.MAX_VALUE):uint{
            return (((((_seed = (_seed * 16807) % 0x7FFFFFFF)) - 1) / 0x7FFFFFFF)) * (max - min) + min | 0;
        }
        
        /**
         * Retrieves a random int between min (inclusive) and max (exclusive)
         */
        public static function i(min:int = int.MIN_VALUE, max:int = int.MAX_VALUE):int{
            return (((((_seed = (_seed * 16807) % 0x7FFFFFFF)) - 1) / 0x7FFFFFFF)) * (max - min) + min | 0;
        }

        /**
         * Retrieves a random boolean
         */
        public static function get b():Boolean {
            return ((((_seed = (_seed * 16807) % 0x7FFFFFFF)) - 1) / 0x7FFFFFFF) > 0.5;
        }

        /**
         * Retrieves a random Number of value (-a, a)
         */
        public static function fmid(a:Number):Number{
            return (((((_seed = (_seed * 16807) % 0x7FFFFFFF)) - 1) / 0x7FFFFFFF)) * a * 2 - a;
        }

        /**
         * Generates and returns next raw number from the engine
         */
        retrocamel_int static function generate():uint{
            return ((_seed = (_seed * 16807) % 0x7FFFFFFF));
        }





        /****************************************************************************************************************/
        /**                                                                                         INSTANCE VARIABLES  */
        /****************************************************************************************************************/

        retrocamel_int var _seed:uint = 1;

        /**
         * Seed of the PRNG, can not be set to 0
         */
        public function set seed(newSeed:uint):void{
            if (newSeed == 0)
                throw new ArgumentError("Seed can never be 0");

            this._seed = newSeed;
        }

        /**
         * @private
         */
        public function get seed():uint{
            return this._seed;
        }


        /****************************************************************************************************************/
        /**                                                                                         INSTANCE FUNCTIONS  */
        /****************************************************************************************************************/

        public function Rand(newSeed:uint){
            this.seed = Math.max(1, newSeed);
        }

        /**
         * Retrieves a random Number between 0 and 1
         */
        public function get om():Number{
            return ((((this._seed = (this._seed * 16807) % 0x7FFFFFFF)) - 1) / 0x7FFFFFFF);
        }

        /**
         * Retrieves a random uint between min (inclusive) and max (exclusive) <min, max)
         */
        public function u(min:uint = 0, max:uint = uint.MAX_VALUE):uint{
            return (((((this._seed = (this._seed * 16807) % 0x7FFFFFFF)) - 1) / 0x7FFFFFFF)) * (max - min) + min | 0;
        }

        public function get b():Boolean {
            return ((((this._seed = (this._seed * 16807) % 0x7FFFFFFF)) - 1) / 0x7FFFFFFF) > 0.5;
        }

        /**
         * Retrieves a random Number of value (-a, a)
         */
        public function fmid(a:Number):Number{
            return (((((this._seed = (this._seed * 16807) % 0x7FFFFFFF)) - 1) / 0x7FFFFFFF)) * a * 2 - a;
        }

        /**
         * Generates and returns next raw number from the engine
         */
        retrocamel_int function generate():uint{
            return ((this._seed = (this._seed * 16807) % 0x7FFFFFFF));
        }
    }
}