package submuncher.ingame.renderers.filters {
        import flash.display3D.Context3D;
        import flash.display3D.Context3DProgramType;
        import starling.textures.Texture;

        /**
         * Creates a sine wave effect in horizontal or vertical direction. Use the ticker value to animate.
         * @author Devon O.
         */

        public class SineFilter extends BaseFilter
        {
            private var vars:Vector.<Number> = new <Number>[1, 1, 1, 1];
            private var booleans:Vector.<Number> = new <Number>[1, 1, 1, 1];

            private var _amplitude:Number;
            private var _ticker:Number;
            private var _frequency:Number;
            private var _isHorizontal:Boolean=true;

            /**
             * Creates a new SineFilter
             * @param   amplitude   wave amplitude
             * @param   frequency   wave frequency
             * @param   ticker      position of effect (use to animate)
             */
            public function SineFilter(amplitude:Number=0.0, frequency:Number=0.0, ticker:Number=0.0)
            {
                this._amplitude  = amplitude;
                this._ticker     = ticker;
                this._frequency  = frequency;
            }

            /** Set AGAL */
            override protected function setAgal():void
            {
                FRAGMENT_SHADER = "" +
                    "mov ft0, v0\n"+
                    "sub ft1.x, v0.y, fc0.z\n"+
                "mul ft1.x, ft1.x, fc0.w\n"+
                "sin ft1.x, ft1.x\n"+
                "mul ft1.x, ft1.x, fc0.y\n"+

                // horizontal
                "mul ft1.y, ft1.x, fc1.x\n"+
                "add ft0.x, ft0.x, ft1.y\n"+

                // vertical
                "mul ft1.z, ft1.x, fc1.y\n"+
                "add ft0.y, ft0.y, ft1.z\n"+

                "tex oc, ft0, fs0<2d, wrap, nearest, mipnone>";
            }

            /** Activate */
            protected override function activate(pass:int, context:Context3D, texture:Texture):void
            {
                this.vars[1] = this._amplitude / texture.height;
                this.vars[2] = this._ticker;
                this.vars[3] = this._frequency ;

                this.booleans[0] = int(this._isHorizontal);
                this.booleans[1] = int(!this._isHorizontal);

                context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, this.vars,      1);
                context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1, this.booleans,  1);

                super.activate(pass, context, texture);
            }

            /** Amplitude */
            public function get amplitude():Number { return this._amplitude; }
            public function set amplitude(value:Number):void { this._amplitude = value; }

            /** Ticker */
            public function get ticker():Number { return this._ticker; }
            public function set ticker(value:Number):void { this._ticker = value; }

            /** Frequency */
            public function get frequency():Number { return this._frequency; }
            public function set frequency(value:Number):void { this._frequency = value; }

            /** Is Horizontal */
            public function get isHorizontal():Boolean { return this._isHorizontal; }
            public function set isHorizontal(value:Boolean):void { this._isHorizontal = value; }
        }
    }