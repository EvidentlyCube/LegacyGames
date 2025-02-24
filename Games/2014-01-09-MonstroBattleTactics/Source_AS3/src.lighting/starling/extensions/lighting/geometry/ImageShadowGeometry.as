package starling.extensions.lighting.geometry
{
	import net.retrocade.tacticengine.monstro.gui.render.MonstroFieldRenderer;

	import starling.display.Image;

	import starling.extensions.lighting.core.Edge;
	import starling.extensions.lighting.core.ShadowGeometry;

	/**
	 * @author Szenia Zadvornykh
	 */
	public class ImageShadowGeometry extends ShadowGeometry
	{
		private var _x:int;
		private var _y:int;

		public function ImageShadowGeometry(displayObject:Image)
		{
			super(displayObject);
		}
		
		override protected function createEdges():Vector.<Edge>
		{
			var sprite:Image = displayObject as Image;
			var edges:Vector.<Edge> = new <Edge>[];

			edges.push(new Edge(sprite.x, sprite.y, sprite.x + 32, sprite.y));
			edges.push(new Edge(sprite.x + 32, sprite.y, sprite.x + 32, sprite.y + 32));
			edges.push(new Edge(sprite.x + 32, sprite.y + 32, sprite.x, sprite.y + 32));
			edges.push(new Edge(sprite.x, sprite.y + 32, sprite.x, sprite.y));

			return edges;
		}
	}
}
