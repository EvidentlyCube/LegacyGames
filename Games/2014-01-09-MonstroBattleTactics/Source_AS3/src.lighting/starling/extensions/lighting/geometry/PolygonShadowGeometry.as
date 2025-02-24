package starling.extensions.lighting.geometry
{
	import flash.geom.Point;

	import starling.extensions.lighting.core.Edge;
	import starling.extensions.lighting.core.ShadowGeometry;

	public class PolygonShadowGeometry extends ShadowGeometry
	{
		private var _points:Vector.<Point>;

		public function PolygonShadowGeometry()
		{
			_points = new Vector.<Point>();

			super(null);
		}

		public function addPoint(x:Number, y:Number):void{
			_points.push(new Point(x, y));
			_worldEdges.push(new Edge());
		}
		
		override protected function createEdges():Vector.<Edge>
		{
			var edges:Vector.<Edge> = new <Edge>[];

			var lastPoint:Point;
			var currentPoint:Point;

			if (_points.length > 0){
				for(var i:int = 0, l:int = _points.length; i < l; i++){
					currentPoint = _points[i];

					if (lastPoint){
						edges.push(new Edge(lastPoint.x * _scale + _offsetX, lastPoint.y * _scale + _offsetY, currentPoint.x * _scale + _offsetX, currentPoint.y * _scale + _offsetY));
					}

					lastPoint = currentPoint;
				}

				currentPoint = _points[0];
				edges.push(new Edge(lastPoint.x * _scale + _offsetX, lastPoint.y * _scale + _offsetY, currentPoint.x * _scale + _offsetX, currentPoint.y * _scale + _offsetY));
			}

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
