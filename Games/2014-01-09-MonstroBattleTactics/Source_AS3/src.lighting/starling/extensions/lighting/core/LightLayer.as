package starling.extensions.lighting.core
{
	import com.adobe.utils.PerspectiveMatrix3D;

	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DClearMask;
	import flash.display3D.Context3DCompareMode;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DStencilAction;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DTriangleFace;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.geom.Rectangle;

	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.extensions.lighting.lights.PointLight;
	import starling.extensions.lighting.shaders.GaussianBlurShader;
	import starling.extensions.lighting.shaders.LightMapShader;
	import starling.extensions.lighting.shaders.PointLightShader;
	import starling.extensions.lighting.shaders.PositionalLightShadowShader;
	import starling.utils.getNextPowerOfTwo;

	/**
	 * @author Szenia Zadvornykh
	 *
	 * original setup by Ryan Speets @ ryanspeets.com
	 */
	public class LightLayer extends DisplayObject
	{
		public static var Program:String = "";

		private static const VERTICES_PER_EDGE:uint = 4;
		private static const INDICES_PER_EDGE:uint = 6;

		private var geometry:Vector.<ShadowGeometry>;
		private var geometryVertexBuffer:VertexBuffer3D;
		private var geometryIndexBuffer:IndexBuffer3D;
		private var geometryVertexCount:uint;

		private var vertices:Vector.<Number> = new <Number>[];
		private var indices:Vector.<uint> = new <uint>[];

		private var lights:Vector.<LightBase>;

		private var pointLightShader:PointLightShader;
		private var pointLightShadowShader:PositionalLightShadowShader;
		private var sceneShader:LightMapShader;
		private var blurShader:GaussianBlurShader;

		private var sceneVertexBuffer:VertexBuffer3D;
		private var sceneUVBuffer:VertexBuffer3D;
		private var sceneIndexBuffer:IndexBuffer3D;

		private var lightMapIn:Texture;
		private var lightMapOut:Texture;

		private var _width:int;
		private var _height:int;
		private var legalWidth:uint;
		private var legalHeight:uint;
		private var _shadowSoftness:Number;
		private var _boundsRect:Rectangle = new Rectangle();
		private var _scissorRectangle:Rectangle = new Rectangle();

		private var _projectionMatrix:PerspectiveMatrix3D;
		private var _contextVertexVector:Vector.<Number> = new <Number>[0, 1, 10000, 0];
		private var _contextFragmentVector:Vector.<Number> = new <Number>[1, 1, 1, 1];

		private var _offsetX:Number = 0;
		private var _offsetY:Number = 0;
		private var _scale:Number = 1;

		private var _isBroken:Boolean;

		public var shadowsEnabled:Boolean;

		public function LightLayer(width:int, height:int, ambientColor:uint = 0x000000, ambientColorIntensity:Number = 1, shadowSoftness:Number = 1)
		{
			_width = width;
			_height = height;
			_shadowSoftness = shadowSoftness;
			_scissorRectangle.setTo(0, 0, _width, _height);

			lights = new <LightBase>[];
			geometry = new <ShadowGeometry>[];

			createScene();
			createShaders();

			setAmbientLightColor(ambientColor, ambientColorIntensity);

			touchable = false;
		}

		private function createScene():void
		{
			var context:Context3D = Starling.context;

			sceneVertexBuffer = context.createVertexBuffer(4, 2);
			sceneVertexBuffer.uploadFromVector(Vector.<Number>([-1, -1, 1, -1, 1, 1, -1, 1]), 0, 4);
			sceneUVBuffer = context.createVertexBuffer(4, 2);
			sceneUVBuffer.uploadFromVector(Vector.<Number>([0, 1, 1, 1, 1, 0, 0, 0]), 0, 4);
			sceneIndexBuffer = context.createIndexBuffer(6);
			sceneIndexBuffer.uploadFromVector(Vector.<uint>([0, 2, 1, 0, 3, 2]), 0, 6);

			legalWidth = getNextPowerOfTwo(_width);
			legalHeight = getNextPowerOfTwo(_height);

			if (legalWidth > 2048 || legalHeight > 2048){
				_isBroken = true;
				return;
			}

			lightMapIn = context.createTexture(legalWidth, legalHeight, Context3DTextureFormat.BGRA, true);
			lightMapOut = context.createTexture(legalWidth, legalHeight, Context3DTextureFormat.BGRA, true);

			_projectionMatrix = new PerspectiveMatrix3D();
			_projectionMatrix.orthoOffCenterLH(0, legalWidth, -legalHeight, 0, -1, 1);
		}

		private function createShaders():void
		{
			if (_isBroken){
				return;
			}

			pointLightShader = new PointLightShader(legalWidth, legalHeight);
			pointLightShader.setDependencies(sceneVertexBuffer, sceneUVBuffer);

			pointLightShadowShader = new PositionalLightShadowShader();

			blurShader = new GaussianBlurShader(legalWidth, legalHeight, _shadowSoftness >= 1 ? _shadowSoftness : 0);
			blurShader.setDependencies(lightMapIn, lightMapOut, sceneVertexBuffer, sceneUVBuffer);

			sceneShader = new LightMapShader(_width / legalWidth, _height / legalHeight);
			sceneShader.setDependencies(lightMapOut, sceneVertexBuffer, sceneUVBuffer);
		}

		public function set shadowSoftness(value:Number):void{
			if (_isBroken){
				return;
			}

			if (_shadowSoftness !== value){
				_shadowSoftness = value;

				if (blurShader){
					blurShader.dispose();
				}

				blurShader = new GaussianBlurShader(legalWidth, legalHeight, value >= 1 ? value : 0);
				blurShader.setDependencies(lightMapIn, lightMapOut, sceneVertexBuffer, sceneUVBuffer);
			}
		}

		public function addShadowGeometry(geometry:ShadowGeometry):void
		{
			if (geometry && shadowsEnabled){
				this.geometry.push(geometry);
			}
		}

		public function addLight(light:LightBase):void
		{
			lights.push(light);
		}

		public function clearLights():void{
			lights.length = 0;
		}

		public function setAmbientLightColor(color:uint, intensity:Number = 0):void
		{
			if (_isBroken){
				return;
			}

			sceneShader.setAmbientColor(color, intensity);
		}

		public function get scissorRectangle():Rectangle
		{
			return _scissorRectangle;
		}

		override public function render(support:RenderSupport, parentAlpha:Number):void
		{
			if (_isBroken){
				return;
			}

			var context:Context3D = Starling.context;

			support.finishQuadBatch();

			if (geometry.length > 0 && shadowsEnabled) {
				projectGeometry();
			}

			context.setRenderToTexture(lightMapIn, true);
			context.setScissorRectangle(_scissorRectangle);
			context.clear(0, 0, 0, 1, 1, 0, Context3DClearMask.ALL);

			context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 0, _contextVertexVector);
			context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 2, _projectionMatrix, true);
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, _contextFragmentVector);

			var l:LightBase;
			var length:int = lights.length - 1;

			for (var i:int = length; i >= 0; i--) {
				l = lights[i];

				if (l && l.brightness) {
					renderLight(support, l, context);
				}
			}

			renderLightMap(support, context);

			context.setBlendFactors(Context3DBlendFactor.ZERO, Context3DBlendFactor.ZERO);
			context.setVertexBufferAt(0, null);
			context.setVertexBufferAt(1, null);
			context.setTextureAt(0, null);
		}

		private function projectGeometry():void {
			var context:Context3D = Starling.context;
			var localEdgeCount:uint = 0;

			var edges:Vector.<Edge>, edge:Edge;
			var indexOffset:uint = 0, index:uint;
			var needsNewBuffer:Boolean;

			var verticesCount:int = 0;
			var indicesCount:int = 0;

			var totalEdgeCount:uint = 0;

			var shadowGeometry:ShadowGeometry;
			var length:int = geometry.length - 1;

			for (var i:int = length; i >= 0; i--) {
				shadowGeometry = geometry[i];

				if (shadowGeometry) {
					shadowGeometry.offsetX = offsetX;
					shadowGeometry.offsetY = offsetY;
					shadowGeometry.scale = scale;

					shadowGeometry.transform();

					edges = shadowGeometry.worldEdges;
					localEdgeCount = edges.length;
					totalEdgeCount += localEdgeCount;

					for (var j:int = localEdgeCount - 1; j >= 0; j--) {
						index = j * VERTICES_PER_EDGE + indexOffset;
						edge = edges[j];

						vertices[verticesCount++] = edge.startX;
						vertices[verticesCount++] = edge.startY;
						vertices[verticesCount++] = 0.1;
						vertices[verticesCount++] = edge.endX;
						vertices[verticesCount++] = edge.endY;
						vertices[verticesCount++] = 0.1;
						vertices[verticesCount++] = edge.endX;
						vertices[verticesCount++] = edge.endY;
						vertices[verticesCount++] = 0;
						vertices[verticesCount++] = edge.startX;
						vertices[verticesCount++] = edge.startY;
						vertices[verticesCount++] = 0;

						indices[indicesCount++] = index;
						indices[indicesCount++] = index + 2;
						indices[indicesCount++] = index + 1;
						indices[indicesCount++] = index;
						indices[indicesCount++] = index + 3;
						indices[indicesCount++] = index + 2;
					}

					indexOffset += (localEdgeCount * VERTICES_PER_EDGE);
				}
			}
			needsNewBuffer = !(geometryVertexCount == totalEdgeCount * VERTICES_PER_EDGE);

			geometryVertexCount = totalEdgeCount * VERTICES_PER_EDGE;

			if (needsNewBuffer) {
				if (geometryVertexBuffer) {
					geometryVertexBuffer.dispose();
				}
				geometryVertexBuffer = context.createVertexBuffer(geometryVertexCount, 3);

				if (geometryIndexBuffer) {
					geometryIndexBuffer.dispose();
				}
				geometryIndexBuffer = context.createIndexBuffer(totalEdgeCount * INDICES_PER_EDGE);
			}

			vertices.length = verticesCount;
			indices.length = indicesCount;

			geometryVertexBuffer.uploadFromVector(vertices, 0, geometryVertexCount);
			geometryIndexBuffer.uploadFromVector(indices, 0, indicesCount);
		}

		private function renderLight(support:RenderSupport, light:LightBase, context:Context3D):void
		{
			if (shadowsEnabled){
				context.setDepthTest(false, Context3DCompareMode.ALWAYS);

				if (geometry.length > 0) {
					shadowPass(support, light, context);
				}
			}


			lightPass(support, light, context);

			context.clear(0, 0, 0, 1, 1, 0, Context3DClearMask.STENCIL);
			context.setBlendFactors(Context3DBlendFactor.ONE, Context3DBlendFactor.ZERO);
			context.setVertexBufferAt(0, null);
			context.setVertexBufferAt(1, null);

			if (shadowsEnabled){
				context.setDepthTest(true, Context3DCompareMode.LESS);
			}
		}

		private function shadowPass(support:RenderSupport, light:LightBase, context:Context3D):void
		{
			switch (true) {
				case light is PointLight:
					pointLightShadowShader.setDependencies(geometryVertexBuffer, PointLight(light).x, PointLight(light).y);
					pointLightShadowShader.activate(context);
					break;
				default:
					throw new ArgumentError("unsupported light type");
			}

			context.setStencilReferenceValue(1);
			context.setStencilActions(Context3DTriangleFace.FRONT, Context3DCompareMode.ALWAYS, Context3DStencilAction.SET);
			context.setColorMask(false, false, false, false);

			context.drawTriangles(geometryIndexBuffer);
			support.raiseDrawCount(1);
		}

		private function lightPass(support:RenderSupport, light:LightBase, context:Context3D):void
		{
			switch (true) {
				case light is PointLight:
					pointLightShader.setLight(light as PointLight);
					pointLightShader.activate(context);
					break;
				default:
					throw new ArgumentError("unsupported light type");
			}

			context.setStencilReferenceValue(0);
			context.setStencilActions(Context3DTriangleFace.FRONT, Context3DCompareMode.EQUAL, Context3DStencilAction.KEEP);
			context.setColorMask(true, true, true, true);
			context.setBlendFactors(Context3DBlendFactor.ONE, Context3DBlendFactor.ONE);

			context.drawTriangles(sceneIndexBuffer);
			support.raiseDrawCount(1);
		}

		private function renderLightMap(support:RenderSupport, context:Context3D):void
		{
			context.setScissorRectangle(null);

			blurShader.activate(context);
			context.drawTriangles(sceneIndexBuffer);

			blurShader.activateSecondPass(context);
			context.drawTriangles(sceneIndexBuffer);


			context.setRenderToBackBuffer();
			context.setDepthTest(false, Context3DCompareMode.ALWAYS);


			sceneShader.activate(context);
			context.setBlendFactors(Context3DBlendFactor.DESTINATION_COLOR, Context3DBlendFactor.ZERO);
			context.drawTriangles(sceneIndexBuffer);


			support.raiseDrawCount(3);
		}

		override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null):Rectangle
		{
			_boundsRect.setTo(0, 0, _width, _height);

			return _boundsRect;
		}

		public override function dispose():void
		{
			lights.length = 0;
			geometry.length = 0;

			if (sceneVertexBuffer){
				sceneVertexBuffer.dispose();
			}

			if (sceneUVBuffer){
				sceneUVBuffer.dispose();
			}

			if (sceneIndexBuffer){
				sceneIndexBuffer.dispose();
			}

			if (geometryVertexBuffer) {
				geometryVertexBuffer.dispose();
			}
			if (geometryIndexBuffer) {
				geometryIndexBuffer.dispose();
			}

			if (blurShader){
				blurShader.dispose();
			}

			if (pointLightShader){
				pointLightShader.dispose();
			}

			if (pointLightShadowShader){
				pointLightShadowShader.dispose();
			}

			if (sceneShader){
				sceneShader.dispose();
			}

			if (lightMapIn){
				lightMapIn.dispose();
			}

			if (lightMapOut){
				lightMapOut.dispose();
			}
		}

		override public function set width(value:Number):void
		{
			super.width = value;
		}


		public function get offsetX():Number
		{
			return _offsetX;
		}

		public function set offsetX(value:Number):void
		{
			_offsetX = value;

			for	each(var light:PointLight in lights){
				light.offsetX = value;
			}
		}

		public function get offsetY():Number
		{
			return _offsetY;
		}

		public function set offsetY(value:Number):void
		{
			_offsetY = value;


			for	each(var light:PointLight in lights){
				light.offsetY = value;
			}
		}

		public function get scale():Number
		{
			return _scale;
		}

		public function set scale(value:Number):void
		{
			_scale = value;


			for	each(var light:PointLight in lights){
				light.scale = value;
			}
		}
	}
}
