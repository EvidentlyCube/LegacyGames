package net.retrocade.utils {

    public class UtilsArray {
        public static const SORT_RESULT_LEFT_BEFORE_RIGHT:int = -1;
        public static const SORT_RESULT_LEFT_AFTER_RIGHT:int = 1;
        public static const SORT_RESULT_LEFT_EQUALS_RIGHT:int = 0;

        public static function shuffleArray(array:*):void{
            var arrayLength:uint = array.length;

            while (arrayLength){
                swap(array, array, Math.random() * arrayLength);
                arrayLength--;
            }
        }

        private static function swap(array:*, firstItemIndex:uint, secondItemIndex:uint ):void{
            var temp:Object = array[firstItemIndex];
            array[firstItemIndex] = array[secondItemIndex];
            array[secondItemIndex] = temp;
        }

        public static function mergeArray(arraySource:*, ...arrays):void{
            var bufferPointer:uint = arraySource.length;
            var newArrayLength:uint = bufferPointer;

            var array:*;

            for each(array in arrays){
                var l:int = array.length;
                newArrayLength += array.length;
            }

            arraySource.length = newArrayLength;

            for each(array in arrays){
                for (var i:int = 0; i < l; i++){
                    arraySource[bufferPointer++] = array[i];
                }
            }
        }
    }
}
