package starling.extensions.lighting.geometry
{
	import starling.extensions.lighting.core.Edge;
	import starling.extensions.lighting.core.ShadowGeometry;

	public class RectangleShadowGeometry extends ShadowGeometry
	{
		private var _baseX:Number;
		private var _baseY:Number;
		private var _baseWidth:Number;
		private var _baseHeight:Number;

		private function get scaledX():Number{
			return _baseX * _scale;
		}
		private function get scaledY():Number{
			return _baseY * _scale;
		}
		private function get scaledWidth():Number{
			return _baseWidth * _scale;
		}
		private function get scaledHeight():Number{
			return _baseHeight * _scale;
		}

		public function RectangleShadowGeometry(x:int, y:int, width:int, height:int)
		{
			super(null);

			_baseX = x;
			_baseY = y;
			_baseWidth = width;
			_baseHeight = height;

			transform();
		}
		
		override protected function createEdges():Vector.<Edge>
		{
			var edges:Vector.<Edge> = new <Edge>[];

			edges.push(new Edge(scaledX + _offsetX, scaledY + _offsetY, scaledX + _offsetX + scaledWidth, scaledY + _offsetY));
			edges.push(new Edge(scaledX + _offsetX + scaledWidth, scaledY + _offsetY, scaledX + _offsetX + scaledWidth, scaledY + _offsetY + scaledHeight));
			edges.push(new Edge(scaledX + _offsetX + scaledWidth, scaledY + _offsetY + scaledHeight, scaledX + _offsetX, scaledY + _offsetY + scaledHeight));
			edges.push(new Edge(scaledX + _offsetX, scaledY + _offsetY + scaledHeight, scaledX + _offsetX, scaledY + _offsetY));

			return edges;
		}

		override public function transform():void
		{
			_modelEdges = createEdges();

			var length:int = _modelEdges.length;
			var modelEdge:Edge, worldEdge:Edge;

			for (var i:int = length-1; i >=0; i--)
			{
				modelEdge = _modelEdges[i];
				worldEdge = _worldEdges[i];

				worldEdge.startX = modelEdge.startX;
				worldEdge.startY = modelEdge.startY;
				worldEdge.endX   = modelEdge.endX;
				worldEdge.endY   = modelEdge.endY;
			}
		}
	}
}
