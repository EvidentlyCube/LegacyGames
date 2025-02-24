package net.retrocade.tacticengine.monstro.gui.render
{
	import flash.geom.Point;

	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;

	import net.retrocade.tacticengine.monstro.global.enum.EnumTileset;

	import starling.extensions.lighting.core.LightLayer;

	import starling.extensions.lighting.geometry.PolygonShadowGeometry;

	import starling.extensions.lighting.geometry.RectangleShadowGeometry;

	public class MonstroTileShadowGeometry
	{
		public static function isSkippableSetOfTiles(checkedTile:Point, floors:Vector.<Point>):Boolean{
			if (checkedTile.x === 22 * MonstroConsts.tileWidth && checkedTile.y === 0){
				return false;
			}

			for each(var floor:Point in floors){
				if (floor.x === 22 * MonstroConsts.tileWidth && floor.y === 0){
					return true;
				}
			}

			return false;
		}

		public static function addGeometryForTile(lightLayer:LightLayer, tileset:EnumTileset, tile:Point, x:int, y:int):void{
			var tileX:int = tile.x / MonstroConsts.tileWidth;
			var tileY:int = tile.y / MonstroConsts.tileHeight;

			var polygon:PolygonShadowGeometry;
			
			x = x * MonstroConsts.tileWidth;
			y = y * MonstroConsts.tileHeight;

			if (tileY === 0){
				if (tileX === 16){
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x + 6, y, 20, 32));
				} else if (tileX === 17){
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x + 6, y, 26, 16));
				} else if (tileX === 18){
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x, y, 32, 16));
				} else if (tileX === 19){
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x, y, 26, 16));
				} else if (tileX === 20){
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x + 6, y, 20, 16));
				} else if (tileX === 21){
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x+6, y, 20, 6));
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x+14, y, 20, 18));
				} else if (tileX === 22){
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x, y, 12, 16));
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x+20, y, 16, 16));
				} else if (tileX === 23) {
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x, y, 12, 16));
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x+20, y, 12, 16));
				} else if (tileX === 24) {
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x+6,  y, 6, 16));
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x+20, y, 12, 16));
				} else if (tileX === 25) {
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x,  y, 12, 16));
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x+20, y, 6, 16));
				} else if (tileX === 26) {
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x+6,  y, 6, 16));
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x+20, y, 6, 16));
				} else if (tileX === 27) {
					polygon = new PolygonShadowGeometry();
					polygon.addPoint(x + 16, y);
					polygon.addPoint(x + 28, y + 8);
					polygon.addPoint(x + 21, y + 15);
					polygon.addPoint(x + 12, y + 17);
					polygon.addPoint(x + 5, y + 3);
					lightLayer.addShadowGeometry(polygon);
				}
			} else if (tileY === 1){
				if (tileX === 16){
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x + 6, y, 20, 32));
				} else if (tileX === 17){
					polygon = new PolygonShadowGeometry();
					polygon.addPoint(x + 6, y);
					polygon.addPoint(x + 32, y);
					polygon.addPoint(x + 32, y+16);
					polygon.addPoint(x + 26, y+16);
					polygon.addPoint(x + 26, y+32);
					polygon.addPoint(x + 6, y+32);
					lightLayer.addShadowGeometry(polygon);
				} else if (tileX === 18){
					polygon = new PolygonShadowGeometry();
					polygon.addPoint(x, y);
					polygon.addPoint(x+26, y);
					polygon.addPoint(x+26, y+32);
					polygon.addPoint(x+6, y+32);
					polygon.addPoint(x+6, y+16);
					polygon.addPoint(x, y+16);
					lightLayer.addShadowGeometry(polygon);
				} else if (tileX === 19){
					polygon = new PolygonShadowGeometry();
					polygon.addPoint(x+6, y);
					polygon.addPoint(x+32, y);
					polygon.addPoint(x+32, y+16);
					polygon.addPoint(x+26, y+16);
					polygon.addPoint(x+26, y+32);
					polygon.addPoint(x+6, y+32);
					lightLayer.addShadowGeometry(polygon);
				} else if (tileX === 20) {
					polygon = new PolygonShadowGeometry();
					polygon.addPoint(x, y);
					polygon.addPoint(x + 32, y);
					polygon.addPoint(x + 32, y + 16);
					polygon.addPoint(x + 26, y + 16);
					polygon.addPoint(x + 26, y + 32);
					polygon.addPoint(x + 6, y + 32);
					polygon.addPoint(x + 6, y + 16);
					polygon.addPoint(x, y + 16);
					lightLayer.addShadowGeometry(polygon);
				} else if (tileX === 21) {
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x, y, 32, 16));
				} else if (tileX === 26) {
					polygon = new PolygonShadowGeometry();
					polygon.addPoint(x + 18, y + 2);
					polygon.addPoint(x + 26, y + 2);
					polygon.addPoint(x + 26, y + 6);
					polygon.addPoint(x + 8, y + 16);
					polygon.addPoint(x + 5, y + 14);
					polygon.addPoint(x + 6, y + 9);
					polygon.addPoint(x + 14, y + 8);
					lightLayer.addShadowGeometry(polygon);
				} else if (tileX === 27) {
					polygon = new PolygonShadowGeometry();
					polygon.addPoint(x + 10, y + 1);
					polygon.addPoint(x + 17, y + 1);
					polygon.addPoint(x + 25, y + 6);
					polygon.addPoint(x + 25, y + 9);
					polygon.addPoint(x + 20, y + 14);
					polygon.addPoint(x + 17, y + 14);
					polygon.addPoint(x + 8, y + 6);
					lightLayer.addShadowGeometry(polygon);

				}
			} else if (tileY === 2){
				if (tileX === 16){
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x + 6, y, 20, 16));
				} else if (tileX === 17) {
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x + 6, y, 26, 16));
				} else if (tileX === 18) {
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x, y, 26, 16));
				} else if (tileX === 19) {
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x, y, 32, 16));
				} else if (tileX === 20) {
					polygon = new PolygonShadowGeometry();
					polygon.addPoint(x, y);
					polygon.addPoint(x + 26, y);
					polygon.addPoint(x + 26, y + 32);
					polygon.addPoint(x + 6, y + 32);
					polygon.addPoint(x + 6, y + 16);
					polygon.addPoint(x, y + 16);
					lightLayer.addShadowGeometry(polygon);
				} else if (tileX === 21) {
					lightLayer.addShadowGeometry(new RectangleShadowGeometry(x + 6, y, 20, 32));
				} else if (tileX === 26) {
					polygon = new PolygonShadowGeometry();
					polygon.addPoint(x + 17, y + 1);
					polygon.addPoint(x + 20, y + 6);
					polygon.addPoint(x + 28, y + 7);
					polygon.addPoint(x + 26, y + 13);
					polygon.addPoint(x + 15, y + 19);
					polygon.addPoint(x + 3, y + 12);
					polygon.addPoint(x + 5, y + 6);
					polygon.addPoint(x + 12, y + 4);
					polygon.addPoint(x + 13, y + 1);
					lightLayer.addShadowGeometry(polygon);
				} else if (tileX === 27) {
					polygon = new PolygonShadowGeometry();
					polygon.addPoint(x + 21, y + 1);
					polygon.addPoint(x + 28, y + 11);
					polygon.addPoint(x + 7, y + 8);
					lightLayer.addShadowGeometry(polygon);
				}
			}
		}
	}
}
