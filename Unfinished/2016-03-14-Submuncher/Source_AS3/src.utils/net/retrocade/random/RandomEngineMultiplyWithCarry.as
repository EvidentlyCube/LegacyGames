/*
 * Copyright (C) 2013 Maurycy Zarzycki
 * Unless stated otherwise in the rest of the source file
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package net.retrocade.random{
    import flash.system.Capabilities;

    import net.retrocade.utils.UtilsSecure;

    public class RandomEngineMultiplyWithCarry implements IRandomEngine{
        public static const RANDOM_CYCLE:uint = 4096;
        public static const MAX_VALUE:Number = 809430660;

        private var _currentCycle:uint;
        private var _seedStore:Array;
        private var _baseSeed:uint;

        public function getUint():uint {
            var x:uint;
            var t:uint;
            var a:uint = 18782; // as Marsaglia recommends
            var r:uint = 0xfffffffe; // as Marsaglia recommends

            _currentCycle = (_currentCycle + 1) & (RANDOM_CYCLE - 1);
            t = a * _seedStore[_currentCycle] + _baseSeed;
            _baseSeed = t >> 32;
            x = t + _baseSeed;
            if (x < _baseSeed)
            {
                x++;
                _baseSeed++;
            }

            return _seedStore[_currentCycle] = r - x;
        }

        public function getInt():int{
            return int(getUint());
        }

        public function getNumber():Number{
            return getUint() / uint.MAX_VALUE;
        }

        public function getChance(chance:Number):Boolean {
            return getNumber() * 100 < chance;
        }

        public function getBool():Boolean {
            return (getUint() & 0x1) === 0x1;
        }

        public function getUintRange(rangeFrom:uint, rangeTo:uint):uint {
            if (rangeTo < rangeFrom){
                var temp:uint = rangeTo;
                rangeTo = rangeFrom;
                rangeFrom = temp;
            }

            return rangeFrom + getNumber() * (rangeTo - rangeFrom);
        }

        public function getIntRange(rangeFrom:int, rangeTo:int):int {
            if (rangeTo < rangeFrom){
                var temp:int = rangeTo;
                rangeTo = rangeFrom;
                rangeFrom = temp;
            }

            return rangeFrom + getNumber() * (rangeTo - rangeFrom);
        }

        public function getNumberRange(rangeFrom:Number, rangeTo:Number):Number {
            if (rangeTo < rangeFrom){
                var temp:Number = rangeTo;
                rangeTo = rangeFrom;
                rangeFrom = temp;
            }

            return rangeFrom + getNumber() * (rangeTo - rangeFrom);
        }

        public function getSeed():String {
            return _baseSeed.toString();
        }

        public function setSeed(seed:String):void {
            var tempSeed:uint = parseInt(seed);

            if (tempSeed === 0){
                throw new Error("Seed cannot be 0!");
            }

            _currentCycle = RANDOM_CYCLE - 1;

            _seedStore = [];
            for (var i:int = 0; i < RANDOM_CYCLE; i++){
                _seedStore[i] = uint(Math.random() * uint.MAX_VALUE);
            }

            _baseSeed = tempSeed % MAX_VALUE;
        }

        public function randomizeSeed():void {
            var date: Date = new Date();
            var capabilitiesJenkins:uint = UtilsSecure.hashStringJenkins(
                String(Capabilities.serverString)
                + date.getTime().toString()
            );
            var millisecs:Number = (new Date()).milliseconds;

            setSeed(Math.max(1, capabilitiesJenkins * millisecs).toString());
        }
    }
}