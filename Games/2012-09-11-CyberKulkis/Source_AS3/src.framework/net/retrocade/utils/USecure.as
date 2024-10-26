package net.retrocade.utils{
    import flash.utils.ByteArray;
    
    import net.retrocade.camel.core.retrocamel_int;
    
    use namespace retrocamel_int;
    
    public class USecure{
        
		/**
		 * Hashes a ByteArray using Jenkins Hash into a number.
		 * @param ByteArray ByteArray to hash
		 * @maxValue Maximum returned number, defaults to uint.MAX_VALUE
		 * @returns Hash of the string
		 */
		public static function hashByteArrayJenkins(byteArray:ByteArray, maxValue:uint = uint.MAX_VALUE):uint{
			var hash:uint = 0;
			var i   :uint = 0;
			var l   :uint = byteArray.length;
			
			while (i < l){
				hash += byteArray[i++];
				hash += (hash << 10);
				hash ^= (hash >> 6);
			}
			
			hash += (hash << 3);
			hash ^= (hash >> 11);
			hash += (hash << 15);
			
			return hash % (maxValue - 1) + 1;
		}
        
        /**
		 * Hashes a string using Jenkins Hash into a number.
		 * @param string String to hash
		 * @maxValue Maximum returned number, defaults to uint.MAX_VALUE
		 * @returns Hash of the string
		 */
		public static function hashStringJenkins(string:String, maxValue:uint = uint.MAX_VALUE):uint{
			var hash:uint = 0;
			var i   :uint = 0;
			var l   :uint = string.length;
			
			while (i < l){
				hash += string.charCodeAt(i++);
				hash += (hash << 10);
				hash ^= (hash >> 6);
			}
			
			hash += (hash << 3);
			hash ^= (hash >> 11);
			hash += (hash << 15);
			
			return hash % (maxValue - 1) + 1;
		}
		
        /**
         * Predictively scrambles a ByteArray using a preset seed. If no seed is set it uses the seed from
         * Rand class. Doesn't modify Rand's seed. 
         * @param byteArray ByteArray to scramble, it is modified instead of returning a new one!
         * @param seed Optional seed, if set to 0 (default) Rand.seed is taken
         */
        public static function scrambleByteArray(byteArray:ByteArray, seed:uint):void{
            seed = seed || Rand._seed;
            
            var rand:Rand = new Rand(seed);
            
            for (var i:uint = 0, l:uint = byteArray.length; i < l; i++){
                byteArray[i] = (byteArray[i] + rand.u(0, 256)) % 256; 
            }
        }
        
        /**
         * Predictively scrambles a string using a preset seed. If no seed is set it uses the seed from
         * Rand class. Doesn't modify Rand's seed
         * @param string String to scramble
         * @param seed Optional seed, if set to 0 (default) Rand.seed is taken
         * @return Scrambled string
         */
        public static function scrambleString(string:String, seed:uint):String{
            seed = seed || Rand._seed;
            
            var rand:Rand = new Rand(seed);
            
            var newString:String = "";
            for (var i:uint = 0, l:uint = string.length; i < l; i++){
                var char:uint = string.charCodeAt(i) + rand.u(0, 128)
                newString += String.fromCharCode(char);
            }
            
            return newString;
        }
        
        /**
         * Predictively unscrambles a ByteArray using a preset seed.
         * If no seed is set an error is thrown. Doesn't modify Rand's seed.
         * @param byteArray ByteArray to unscramble, it is modified
         * @param seed Seed which was previously used to scramble the string
         * @return Unscrambled string
         */
        public static function unscrambleByteArray(byteArray:ByteArray, seed:uint):void{
            seed = seed || Rand._seed;
            
            var rand:Rand = new Rand(seed);
            
            for (var i:uint = 0, l:uint = byteArray.length; i < l; i++){
                byteArray[i] = (byteArray[i] - rand.u(0, 256) + 256) % 256; 
            }
        }
        
        /**
         * Predictively unscrambles a string using a preset seed.
         * If no seed is set an error is thrown. Doesn't modify Rand's seed
         * @param string String to unscramble
         * @param seed Seed which was previously used to scramble the string
         * @return Unscrambled string
         */
        public static function unscrambleString(string:String, seed:uint):String{
            if (seed == 0)
                throw new ArgumentError("Invalid seed");
            
            var rand:Rand = new Rand(seed);
            
            var newString:String = "";
            for (var i:uint = 0, l:uint = string.length; i < l; i++){
                var char:uint = string.charCodeAt(i) - rand.u(0, 128)
                if (char == 0)
                    throw new Error("Wtf");
                newString += String.fromCharCode(char);
            }
            
            return newString;
        }
    }
}