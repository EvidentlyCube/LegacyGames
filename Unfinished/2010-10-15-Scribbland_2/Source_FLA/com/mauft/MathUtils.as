package com.mauft{
    public class MathUtils{
        /**
         * Returns 1 for positive n, -1 for negative n and 0 when n is equal to 0
         * @param n The number which sign you want to find
         * @return Sign of the number N 
         */
        public static function sign(n:Number):int{
            if (n > 0){
                return 1;
            } else if (n < 0){
                return -1;
            } else {
                return 0;
            }
        }
        
        /**
         * If n is positive returns its floored value, otherwise ceiled.
         * @param n Number to be rounded towards zero.
         * @return n rounded towards 0 
         */
        public static function roundToZero(n:Number):int{
            if (n > 0){
                return Math.floor(n);
            } else {
                return Math.ceil(n);
            }
        }
        
        /**
         * If n is positive returns its ceiled value, otherwise floored.
         * @param n Number to be rounded away from zero.
         * @return n rounded away from 0 
         */
        public static function roundFromZero(n:Number):int{
            if (n > 0){
                return Math.ceil(n);
            } else {
                return Math.floor(n);
            }
        }
        
        /**
         * Returns largest multiplier of dividor which is smaller or equal to n
         * @param n Number to floor
         * @param dividor Number to floor to
         * @return Largest multiplier of dividor which is smaller or equal to n
         */
        public static function floorTo(n:Number, dividor:uint):Number{
            return Math.floor(n / dividor) * dividor;
        }
    }
}