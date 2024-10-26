/*
 * Copyright (C) 2013 Maurycy Zarzycki
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package net.retrocade.data {
    import net.retrocade.retrocamel.core.retrocamel_int;

    use namespace retrocamel_int;

    public class RetrocamelBooleanGrid {
        private var _width:uint;
        private var _height:uint;
        private var _total:uint;
        private var _array:Vector.<Boolean>;

        public function RetrocamelBooleanGrid(width:uint, height:uint) {
            _width = width;
            _height = height;
            _total = width * height;

            _array = new Vector.<Boolean>(_total, true);
            clear();
        }

        public function clear():void {
            for(var i:int = 0; i < _total; i++){
                _array[i] = false;
            }
        }

        public function setTile(x:Number, y:Number, value:Boolean):void {
            if (x < 0 || y < 0 || x >= _width || y >= _height) {
                return;
            }

            _array[x + y * _width] = value;
        }

        public function getTile(x:Number, y:Number):Boolean {
            if (x < 0 || y < 0 || x >= _width || y >= _height) {
                return false;
            }

            return _array[x + y * _width];
        }
    }
}