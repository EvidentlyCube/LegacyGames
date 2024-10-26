package game.tiles{
    import flash.display.BitmapData;

    import game.global.Game;
    import game.global.Level;
    import game.global.Minimap;
    import game.objects.TGameObject;

    import net.retrocade.camel.global.rGfx;

    import starling.display.Image;
    import starling.textures.Texture;

    public class TTileFloor extends TGameObject{
        [Embed(source="/../assets/gfx/by_cage/tiles/tile_floor.png")] public static var _floor_:Class;

        private static var _bmp:Array;

        private static function drawFloor(x:uint, y:uint):void{
            var image:TTileFloor = new TTileFloor(Gfx.floorTexture, x, y);
            image.x = x * S().tileWidth;
            image.y = y * S().tileHeight;
            image.reposition();

            Game.lStarling.addChildAt(image, 0);

            Minimap.instance.drawFloor(x * S().tileWidth, y * S().tileWidth);
        }

        public static function drawFloors():void{
            for(var i:uint = 0; i < S().tileGridWidth; i++){
                for(var j:uint = 0; j < S().tileGridHeight; j++){
                    var item:* = Level.level.get(i * S().tileWidth, j * S().tileHeight);

                    if (item && item is TTilePit)
                        continue;

                    drawFloor(i, j);
                }
            }
        }

        public function TTileFloor(texture:Texture, tileX:int, tileY:int){
            super(texture, tileX, tileY);
        }
    }
}