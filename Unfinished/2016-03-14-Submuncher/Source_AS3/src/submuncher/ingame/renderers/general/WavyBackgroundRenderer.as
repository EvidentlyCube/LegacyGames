package submuncher.ingame.renderers.general {

    import flash.display3D.*;
    import flash.geom.*;

    import net.retrocade.random.Random;

    import starling.core.RenderSupport;
    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.errors.MissingContextError;
    import starling.events.Event;
    import starling.textures.Texture;
    import starling.utils.VertexData;

    /** This custom display objects renders a regular, n-sided polygon. */
    public class WavyBackgroundRenderer extends DisplayObject {
        private static const PROGRAM_NAME:String = "polygon";

        private var _renderedTexture:Texture;

        private var _vertexData:VertexData;
        private var _vertexBuffer:VertexBuffer3D;

        private var _indexData:Vector.<uint>;
        private var _indexBuffer:IndexBuffer3D;

        private var _waveData:Vector.<Number>;

        private var _animationSwingSpeed:Number;
        private var _animationVerticalFactor:Number;
        private var _animationSwingPower:Number;

        private var _explicitWidth:uint;
        private var _explicitHeight:uint;
        private var _textureOffsetX:Number;
        private var _textureOffsetY:Number;

        private var _invalidateBuffers:Boolean;

        // helper objects (to avoid temporary objects)
        private static var sHelperMatrix:Matrix = new Matrix();
        private static var sRenderAlpha:Vector.<Number> = new <Number>[1.0, 1.0, 1.0, 1.0];

        /** Creates a regular polygon with the specified redius, number of edges, and color. */
        public function WavyBackgroundRenderer(texture:Texture, swingSpeed:Number, verticalFactor:Number, swingPower:Number) {
            _renderedTexture = texture;
            _animationSwingSpeed = swingSpeed;
            _animationVerticalFactor = verticalFactor;
            _animationSwingPower = swingPower;

            _explicitWidth = texture.width;
            _explicitHeight = texture.height;

            _textureOffsetX = Random.defaultEngine.getNumber();
            _textureOffsetY = Random.defaultEngine.getNumber();
            _textureOffsetX = 0;
            _textureOffsetY = 0;

            // setup vertex data and prepare shaders
            setupVertices();
            createBuffers();
            registerPrograms();

            _waveData = new <Number>[0, _animationVerticalFactor, _animationSwingPower, 0];

            // handle lost context
            Starling.current.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
        }

        /** Disposes all resources of the display object. */
        public override function dispose():void {
            Starling.current.removeEventListener(Event.CONTEXT3D_CREATE, onContextCreated);

            if (_vertexBuffer) {
                _vertexBuffer.dispose();
            }
            if (_indexBuffer) {
                _indexBuffer.dispose();
            }


            _vertexData = null;
            _vertexBuffer = null;
            _indexBuffer = null;
            _indexData = null;

            super.dispose();
        }

        private function onContextCreated(event:Event):void {
            // the old context was lost, so we create new buffers and shaders.
            createBuffers();
            registerPrograms();
        }

        /** Returns a rectangle that completely encloses the object as it appears in another
         * coordinate system. */
        public override function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null):Rectangle {
            if (resultRect == null) {
                resultRect = new Rectangle();
            }

            var transformationMatrix:Matrix = targetSpace == this ?
                null : getTransformationMatrix(targetSpace, sHelperMatrix);

            return _vertexData.getBounds(transformationMatrix, 0, -1, resultRect);
        }

        public function handleStageResized():void {
            refreshVertices();
        }

        /** Creates the required vertex- and index data and uploads it to the GPU. */
        private function setupVertices():void {
            _vertexData = new VertexData(4);
            setVertexValues();

            // create indices that span up the triangles

            _indexData = new <uint>[
                0, 1, 2,
                1, 3, 2
            ];
        }

        /** Creates new vertex- and index-buffers and uploads our vertex- and index-data to those
         *  buffers. */
        private function createBuffers():void {
            var context:Context3D = Starling.context;
            if (context == null) {
                throw new MissingContextError();
            }

            if (_vertexBuffer) {
                _vertexBuffer.dispose();
            }

            if (_indexBuffer) {
                _indexBuffer.dispose();
            }

            setVertexValues();

            _vertexBuffer = context.createVertexBuffer(_vertexData.numVertices, VertexData.ELEMENTS_PER_VERTEX);
            _vertexBuffer.uploadFromVector(_vertexData.rawData, 0, _vertexData.numVertices);

            _indexBuffer = context.createIndexBuffer(_indexData.length);
            _indexBuffer.uploadFromVector(_indexData, 0, _indexData.length);
        }

        private function refreshVertices():void {
            setVertexValues();
            if (_vertexBuffer) {
                _vertexBuffer.dispose();
            }

            var context:Context3D = Starling.context;
            _vertexBuffer = context.createVertexBuffer(_vertexData.numVertices, VertexData.ELEMENTS_PER_VERTEX);
            _vertexBuffer.uploadFromVector(_vertexData.rawData, 0, _vertexData.numVertices);
        }

        private function setVertexValues():void {
            var xTextureCoord:Number = _explicitWidth / _renderedTexture.width;
            var yTextureCoord:Number = _explicitHeight / _renderedTexture.height;

            var xTextureOffset:Number = 0;
            var yTextureOffset:Number = 0;
            if (xTextureCoord < 1){
                xTextureOffset = (1 - xTextureCoord) * _textureOffsetX;
            }
            if (yTextureCoord < 1){
                yTextureOffset = (1 - yTextureCoord) * _textureOffsetY;
            }

            _vertexData.setPosition(0, 0, 0);
            _vertexData.setPosition(1, _explicitWidth, 0);
            _vertexData.setPosition(2, 0,              _explicitHeight);
            _vertexData.setPosition(3, _explicitWidth, _explicitHeight);

            _vertexData.setTexCoords(0, xTextureOffset, yTextureOffset);
            _vertexData.setTexCoords(1, xTextureOffset+ xTextureCoord,  yTextureOffset);
            _vertexData.setTexCoords(2, xTextureOffset, yTextureOffset + yTextureCoord);
            _vertexData.setTexCoords(3, xTextureOffset + xTextureCoord,  yTextureOffset + yTextureCoord);
        }

        /** Renders the object with the help of a 'support' object and with the accumulated alpha
         * of its parent object. */
        public override function render(support:RenderSupport, alpha:Number):void {
            if (_invalidateBuffers){
                createBuffers();
                _invalidateBuffers = false;
            }

            _waveData[0] += _animationSwingSpeed;

            support.finishQuadBatch();
            support.raiseDrawCount();

            sRenderAlpha[0] = sRenderAlpha[1] = sRenderAlpha[2] = 1.0;
            sRenderAlpha[3] = alpha * this.alpha;

            var context:Context3D = Starling.context;
            if (context == null) {
                throw new MissingContextError();
            }

            support.applyBlendMode(false);

            context.setProgram(Starling.current.getProgram(PROGRAM_NAME));
            context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 0, sRenderAlpha, 1);
            context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 1, support.mvpMatrix3D, true);
            context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, _waveData, 1);
            context.setVertexBufferAt(0, _vertexBuffer, VertexData.POSITION_OFFSET, Context3DVertexBufferFormat.FLOAT_2);
            context.setTextureAt(0, _renderedTexture.base);
            context.setVertexBufferAt(2, _vertexBuffer, VertexData.TEXCOORD_OFFSET, Context3DVertexBufferFormat.FLOAT_2);

            context.drawTriangles(_indexBuffer, 0, 2);

            context.setVertexBufferAt(0, null);
            context.setVertexBufferAt(1, null);
            context.setVertexBufferAt(2, null); //this
            context.setTextureAt(0, null); //and this too
        }

        /** Creates vertex and fragment programs from assembly. */
        private static function registerPrograms():void {
            var target:Starling = Starling.current;
            if (target.hasProgram(PROGRAM_NAME)) {
                return;
            } // already registered

            // va0 -> position
            // va1 -> color
            // va2 -> texCoords
            // va3 -> sinusPosition
            // vc0 -> alpha
            // vc1 -> mvpMatrix
            // fc0 -> [timeFunction, verticalCompression, swingPower, ?]

            var vertexProgramCode:String =
                "m44 op, va0, vc1 \n" + // 4x4 matrix transform to output clipspace
                "mov v1, va2      \n";  // pass texture coordinates to fragment program

            var fragmentProgramCode:String =
                "mov ft0, v1 \n" +
                "mov ft1, fc0 \n" +
                "mov ft2.x, ft0.y \n" +
                "mul ft2.x, ft2.x, ft1.y \n" +
                "add ft2.x, ft2.x, ft1.x \n" +
                "sin ft2.x, ft2.x \n" +
                "mul ft2.x, ft2.x, ft1.z \n" +
                "add ft0.x, ft0.x, ft2.x \n" +
                "tex oc, ft0, fs0 <2d,clamp> \n";


            target.registerProgramFromSource(PROGRAM_NAME, vertexProgramCode, fragmentProgramCode);
        }

        public function get animationSwingSpeed():Number {
            return _animationSwingSpeed;
        }

        public function set animationSwingSpeed(value:Number):void {
            _animationSwingSpeed = value;
        }

        public function get animationVerticalFactor():Number {
            return _animationVerticalFactor;
        }

        public function set animationVerticalFactor(value:Number):void {
            _animationVerticalFactor = value;
            _waveData[1] = value;
        }

        public function get animationSwingPower():Number {
            return _animationSwingPower;
        }

        public function set animationSwingPower(value:Number):void {
            _animationSwingPower = value;
            _waveData[2] = value;
        }

        override public function get width():Number {
            return _explicitWidth;
        }

        override public function set width(value:Number):void {
            if (_explicitWidth !== value){
                _explicitWidth = value;

                _invalidateBuffers = true;
            }
        }

        override public function get height():Number {
            return _explicitHeight;
        }

        override public function set height(value:Number):void {
            if (_explicitHeight !== value){
                _explicitHeight = value;

                _invalidateBuffers = true;
            }
        }
    }
}