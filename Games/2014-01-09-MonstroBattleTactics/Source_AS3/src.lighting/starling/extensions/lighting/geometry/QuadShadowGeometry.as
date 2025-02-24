package starling.extensions.lighting.geometry
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.extensions.lighting.core.Edge;
	import starling.extensions.lighting.core.ShadowGeometry;
	import starling.utils.VertexData;
	
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	/**
	 * @author Szenia Zadvornykh
	 */
	public class QuadShadowGeometry extends ShadowGeometry
	{
		private const indices:Array = [0, 1, 1, 3, 3, 2, 2, 0];
		private const numEdges:int = 4;

		private var _baseX:Number;
		private var _baseY:Number;

		/**
		 * subclass of ShadowGeometry that creates shadow geometry matching the vertex data (bounding box) of a Quad or Image instance
		 * @param displayObject Quad or Image instance the shadow geometry will be created for
		 */
		public function QuadShadowGeometry(displayObject:Quad)
		{
			super(displayObject);

			_baseX = displayObject.x;
			_baseY = displayObject.y;

			createEdges();
		}
		
		override protected function createEdges():Vector.<Edge>
		{
			var quad:Quad = displayObject as Quad;
			var vertexData:VertexData = new VertexData(4);
			var edges:Vector.<Edge> = new <Edge>[];
			var index:int;

			if (!isNaN(_baseX)){
				quad.x = _baseX * _scale + _offsetX;
				quad.y = _baseY * _scale + _offsetY;
			}

			quad.copyVertexDataTo(vertexData);
			
			for (var i:int = 0; i < numEdges; i++)
			{
				index = i * 2;

				vertexData.getPosition(indices[index], start);
				vertexData.getPosition(indices[index + 1], end);
				
				edges.push(new Edge(start.x, start.y, end.x, end.y));
			}

			edges.length = 0;

			edges.push(new Edge(quad.x, quad.y, quad.x + 32, quad.y));
			edges.push(new Edge(quad.x+ 32, quad.y, quad.x + 32, quad.y + 32));
			edges.push(new Edge(quad.x+ 32, quad.y + 32, quad.x , quad.y + 32));
			edges.push(new Edge(quad.x, quad.y + 32, quad.x, quad.y));

			return edges;
		}


	}
}
