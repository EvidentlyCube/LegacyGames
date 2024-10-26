/*
 * Copyright (C) 2013 Maurycy Zarzycki
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package net.retrocade.retrocamel.effects {
    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
    import net.retrocade.retrocamel.core.retrocamel_int;

    use namespace retrocamel_int;

    public class RetrocamelEffectQuakeStarling extends RetrocamelEffectBase {
        public static const MODE_SINUS:uint = 0;
        public static const MODE_RANDOM:uint = 1;

        private var _mode:uint = MODE_RANDOM;
        private var _vPower:Number = 10;
        private var _hPower:Number = 10;
        private var _hSpeed:Number = 1;
        private var _vSpeed:Number = 1;
        private var _toQuake:Object;

        private var _viewportX:Number;
        private var _viewportY:Number;

        public static function make():RetrocamelEffectQuakeStarling {
            return new RetrocamelEffectQuakeStarling();
        }

        public function RetrocamelEffectQuakeStarling() {
            super();

            _duration = 0;

            _toQuake = RetrocamelStarlingCore._starlingInstance.viewPort;
            _viewportX = _toQuake.x;
            _viewportY = _toQuake.y;
            RetrocamelDisplayManager.onStageResized.add(stageResizedHandler);
        }

        override public function update():void {
            if (_blocked) {
                return blockUpdate();
            }

            var intervalCache:Number = interval;

            if (_mode == MODE_SINUS) {
                _toQuake.x = _viewportX + Math.sin(timeFromStart * _hSpeed) * _hPower * (1 - intervalCache) | 0;
                _toQuake.y = _viewportY + Math.sin(timeFromStart * _vSpeed) * _vPower * (1 - intervalCache) | 0;

            } else {
                _toQuake.x = _viewportX + (Math.random() * 2 - 1) * _hPower * (1 - intervalCache) | 0;
                _toQuake.y = _viewportY + (Math.random() * 2 - 1) * _vPower * (1 - intervalCache) | 0;
            }

            super.update();
        }

        public function power(powerH:Number, poverV:Number):RetrocamelEffectQuakeStarling {
            return hPower(powerH).vPower(poverV);
        }

        public function hPower(value:Number):RetrocamelEffectQuakeStarling {
            _hPower = value;

            return this;
        }

        public function vPower(value:Number):RetrocamelEffectQuakeStarling {
            _vPower = value;

            return this;
        }

        public function hSpeed(value:Number):RetrocamelEffectQuakeStarling {
            _hSpeed = value;

            return this;
        }

        public function vSpeed(value:Number):RetrocamelEffectQuakeStarling {
            _vSpeed = value;

            return this;
        }

        public function mode(value:uint):RetrocamelEffectQuakeStarling {
            _mode = value;

            return this;
        }

        public function toQuake(object:Object):RetrocamelEffectQuakeStarling {
            if (!object) {
                throw new ArgumentError("Cannot quake null object");
            } else if (!object.hasOwnProperty('x')) {
                throw new ArgumentError("Cannot throw object which has no x property");
            } else if (!object.hasOwnProperty('y')) {
                throw new ArgumentError("Cannot throw object which has no y property");
            }

            // Testing if get or set for X and Y don't throw an automatic error due to not being public variables or public properties
            //noinspection SillyAssignmentJS
            object.x = object.x;

            //noinspection SillyAssignmentJS
            object.y = object.y;

            _toQuake = object;

            return this;
        }

        override protected function finish():void {
            _toQuake.x = _viewportX;
            _toQuake.y = _viewportY;

            _toQuake = null;

            RetrocamelDisplayManager.onStageResized.remove(stageResizedHandler);

            super.finish();
        }

        private function stageResizedHandler():void {
            _viewportX = _toQuake.x;
            _viewportY = _toQuake.y;
        }
    }
}