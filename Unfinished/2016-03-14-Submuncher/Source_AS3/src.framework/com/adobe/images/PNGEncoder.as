/*
 * Copyright (C) 2013 Maurycy Zarzycki
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
package com.adobe.images
{
    import flash.geom.*;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.utils.ByteArray;

    /**
     * Class that converts BitmapData into a valid PNG
     */
    public class PNGEncoder
    {
        /**
         * Created a PNG image from the specified BitmapData
         *
         * @param image The BitmapData that will be converted into the PNG format.
         * @return a ByteArray representing the PNG encoded image data.
         * @langversion ActionScript 3.0
         * @playerversion Flash 9.0
         * @tiptext
         */
        public static function encode(img:BitmapData):ByteArray {
            // Create output byte array
            var png:ByteArray = new ByteArray();
            // Write PNG signature
            png.writeUnsignedInt(0x89504e47);
            png.writeUnsignedInt(0x0D0A1A0A);
            // Build IHDR chunk
            var IHDR:ByteArray = new ByteArray();
            IHDR.writeInt(img.width);
            IHDR.writeInt(img.height);
            IHDR.writeUnsignedInt(0x08060000); // 32bit RGBA
            IHDR.writeByte(0);
            writeChunk(png,0x49484452,IHDR);
            // Build IDAT chunk
            var IDAT:ByteArray= new ByteArray();
            for(var i:int=0;i < img.height;i++) {
                // no filter
                IDAT.writeByte(0);
                var p:uint;
                var j:int;
                if ( !img.transparent ) {
                    for(j=0;j < img.width;j++) {
                        p = img.getPixel(j,i);
                        IDAT.writeUnsignedInt(
                            uint(((p&0xFFFFFF) << 8)|0xFF));
                    }
                } else {
                    for(j=0;j < img.width;j++) {
                        p = img.getPixel32(j,i);
                        IDAT.writeUnsignedInt(
                            uint(((p&0xFFFFFF) << 8)|
                            (p>>>24)));
                    }
                }
            }
            IDAT.compress();
            writeChunk(png,0x49444154,IDAT);
            // Build IEND chunk
            writeChunk(png,0x49454E44,null);
            // return PNG
            return png;
        }

        private static var crcTable:Array;
        private static var crcTableComputed:Boolean = false;

        private static function writeChunk(png:ByteArray,
                type:uint, data:ByteArray):void {
            if (!crcTableComputed) {
                crcTableComputed = true;
                crcTable = [];
                var c:uint;
                for (var n:uint = 0; n < 256; n++) {
                    c = n;
                    for (var k:uint = 0; k < 8; k++) {
                        if ((c & 1) == 1) {
                            c = uint(uint(0xedb88320) ^ uint(c >>> 1));
                        } else {
                            c = uint(c >>> 1);
                        }
                    }
                    crcTable[n] = c;
                }
            }
            var len:uint = 0;
            if (data != null) {
                len = data.length;
            }
            png.writeUnsignedInt(len);
            var p:uint = png.position;
            png.writeUnsignedInt(type);
            if ( data != null ) {
                png.writeBytes(data);
            }
            var e:uint = png.position;
            png.position = p;
            c = 0xffffffff;
            for (var i:int = 0; i < (e-p); i++) {
                c = uint(crcTable[
                    (c ^ png.readUnsignedByte()) &
                    uint(0xff)] ^ uint(c >>> 8));
            }
            c = uint(c^uint(0xffffffff));
            png.position = e;
            png.writeUnsignedInt(c);
        }
    }
}