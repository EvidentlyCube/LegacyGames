

package net.retrocade.utils{

    import net.retrocade.random.IRandomEngine;
    import net.retrocade.random.Random;
    import flash.utils.ByteArray;

    public class UtilsByteArray {
        /**
         * Clones passed ByteArray. Doesn't modify original ByteArray's position
         * and the new ByteArray's position is set to 0.
         * @param  array ByteArray to clone
         * @return Cloned ByteArray
         */
        public static function clone(array:ByteArray):ByteArray {
            var oldPosition:uint = array.position;
            var newArray:ByteArray = new ByteArray;

            array.position = 0;
            newArray.writeBytes(array, 0, array.length);

            array   .position = oldPosition;
            newArray.position = 0;

            return newArray;
        }

        public static function compare(array1:ByteArray, array2:ByteArray):Boolean{
            if (array1.length != array2.length)
                return false;

            for (var i:uint = 0, l:uint = array1.length; i < l; i++){
                if (array1[i] != array2[i])
                    return false;
            }

            return true;
        }

        public static function generateRandomByteArray(length:uint):ByteArray{
            var byteArray:ByteArray = new ByteArray();

            while (length--){
                byteArray.writeByte(Math.random() * 256 | 0);
            }

            return byteArray;
        }

        /**
         * Converts ByteArray to a hex string
         * @param array Byte array
         * @return A Hex String representation of the byte array
         */
        public static function toHexString(array:ByteArray):String{
            var arrayLength:int = array.length;
            var hexString:String = "";
            for (var i:int = 0; i < arrayLength; i++) {
				var arrayValue:int = array[i];
				hexString += (arrayValue < 16 ? "0" : "") + arrayValue.toString(16);
			}

            return hexString;
        }

        public static function fromHexString(hexString:String):ByteArray {
			var bytesCount:uint = hexString.length / 2;
			var byteArray:ByteArray = new ByteArray();
			for (var i:int = 0; i < bytesCount; i++){
				byteArray.writeByte(parseInt(hexString.substr(i * 2, 2), 16));
			}

			byteArray.position = 0;
			return byteArray;
        }

        public static function readWChar(array:ByteArray, offset:uint = 0, length:uint = 0):String {
            var s:String = "";

            var i:uint = offset;
            var l:uint = (length ? length + offset : array.length);

            for (; i < l; i += 2 ) {
                s += String.fromCharCode(array[i]);
            }

            return s;
        }

        public static function writeWChar(array:ByteArray, string:String, offset:int = -1):void {
            if (offset == -1)
                offset = array.position;

            var i:uint = 0;
            var l:uint = string.length;
            for (; i < l; i++) {
               array.writeUTFBytes(string.charAt(i));
               array.writeByte(0);
            }
        }

		public static function traceByteArray(array:ByteArray):void{
			var pos:uint = array.position;
			array.position = 0;
			trace(array.readUTFBytes(array.length));
			array.position = pos
		}
    }
}