package game.global{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import game.data.TBase;
    import game.data.TPath;
    import game.objects.TConnector;
    import game.objects.THud;
    import game.tiles.TTileFloor;
    import game.tiles.TTilePit;

    import net.retrocade.camel.engines.tilegrid.rTileGrid;
    import net.retrocade.starling.rTextureAtlas;
    import net.retrocade.utils.UBitmapData;

    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    public class Minimap extends Sprite{
        private static const COLORS:int = 9;
        private static const COLORS_RGB:Array = [0xFFFFFF, 0xA3A3A3, 0xFF0000, 0xFF8100, 0xFFFF00, 0x00FF00, 0x00FFFF, 0x0065FF, 0xFF00FF];
        private static const TEXTURE_COLUMNS:int = 16;

        private static var _instance:Minimap = new Minimap();
        public static function get instance():Minimap{
            return _instance;
        }

        private var tileEdge:int;
        private var tilePathCoreEdge:int;
        private var tilePathBorder:int;

        public function get minimapWidth():int{
            return tileEdge * S().tileGridWidth;
        }

        private var minimapTexture:Texture;
        private var minimapTextureAtlas:rTextureAtlas;
        private var minimapTextureBitmapData:BitmapData;

        private var imagesFloors:rTileGrid;
        private var imagesTiles :rTileGrid;

        private var backgroundFiller:BitmapData;
        private var backgroundFillerTexture:Texture;
        private var backgroundFillerImage:Image;

        private var currentViewBitmapData:BitmapData;
        private var currentViewTexture:Texture;
        private var currentViewImage:Image;

        public function Minimap(){
            _instance = this;

            super();

            imagesFloors = new rTileGrid(S().tileGridWidth, S().tileGridHeight, 1, 1);
            imagesTiles  = new rTileGrid(S().tileGridWidth, S().tileGridHeight, 1, 1);

            backgroundFiller = new BitmapData(1, 1, false, 0xFF000000);
            backgroundFillerTexture = Texture.fromBitmapData(backgroundFiller);
            backgroundFillerImage = new Image(backgroundFillerTexture);

            currentViewBitmapData = new BitmapData(1, 1, true, 0x44FFFFFF);
            currentViewTexture = Texture.fromBitmapData(currentViewBitmapData);
            currentViewImage = new Image(currentViewTexture);

            addChild(backgroundFillerImage);
            addChild(currentViewImage);

            recalculate();
            generateMinimapTexture();
            generateTextureAtlas();

            Game.lMinimap.addChild(this);

            this.y = THud.instance.pathsN.y + THud.instance.pathsN.height + 10;
        }

        public function reset():void{
            recalculate();
            generateMinimapTexture();
            generateTextureAtlas();
            redraw();

            this.y = THud.instance.pathsN.y + THud.instance.pathsN.height + 10;
        }

        public function redraw():void{
            removeChildren();

            imagesFloors.clear();
            imagesTiles.clear();

            var tileWidth:int = S().tileWidth;
            var tileHeight:int = S().tileHeight;

            var l:int = S().tileGridWidth;
            var k:int = S().tileGridHeight;

            for (var i:int = 0; i < l; i++){
                for (var j:int = 0; j < k; j++){
                    var item:* = Level.level.getTile(i, j);

                    if (item && item is TTilePit){
                        continue;
                    }

                    drawFloor(i * tileWidth, j * tileHeight);

                    if (item && item is TBase){
                        drawBase(i, j, TConnector(item).tileColor);
                    } else if (item && item is TPath){
                        drawPath(i, j, TPath(item).tileColor, TPath(item).getTileString());
                    }
                }
            }
        }

        public function minimapScrolled():void{
            var topLeft    :Point = Game.lStarling.starlingSprite.globalToLocal(new Point(S().playfieldOffsetX, 0));
            var bottomRight:Point = Game.lStarling.starlingSprite.globalToLocal(new Point(S().gameWidth, S().gameHeight));

            var xFraction:Number = topLeft.x / (Game.lStarling.starlingSprite.width / Game.lStarling.starlingSprite.scaleX)
            var yFraction:Number = topLeft.y / (Game.lStarling.starlingSprite.height / Game.lStarling.starlingSprite.scaleY);
            var widthFraction:Number = (bottomRight.x - topLeft.x) / (Game.lStarling.starlingSprite.width / Game.lStarling.starlingSprite.scaleX);
            var heightFraction:Number = (bottomRight.y - topLeft.y) / (Game.lStarling.starlingSprite.height / Game.lStarling.starlingSprite.scaleY);

            currentViewImage.x = minimapWidth * Math.max(0, Math.min(1, xFraction));
            currentViewImage.y = minimapWidth * Math.max(0, Math.min(1, yFraction));
            currentViewImage.width = minimapWidth * Math.min(1, widthFraction);
            currentViewImage.height = minimapWidth * Math.min(1, heightFraction);

            if (widthFraction >= 0.94 && heightFraction >= 0.94)
                currentViewImage.visible = false;
            else
                currentViewImage.visible = true;
        }

        public function isTouchOnMinimap(touch:Touch):Boolean{
            if (Main.isLandscape()){
                return touch.globalX < backgroundFillerImage.width && touch.globalY < backgroundFillerImage.height;
            }

            return false;
        }

        public function touchedMinimap(touch:Touch):void{
            var xFactor:Number;
            var yFactor:Number;

            if (Main.isLandscape()){
                xFactor = (touch.globalX - x) / (minimapWidth);
                yFactor = (touch.globalY - x) / (minimapWidth);
            }

            SmartTouch.setXYFactor(xFactor, yFactor);
        }

        public function clear():void{
            for each (var image:Image in imagesFloors.getArray()){
                removeChild(image);
            }

            for each (image in imagesTiles.getArray()){
                removeChild(image);
            }

            imagesFloors.clear();
            imagesTiles .clear();
        }

        public function drawFloor(x:int, y:int):void{
            x /= S().tileWidth;
            y /= S().tileHeight;

            if (imagesFloors.getTile(x, y)){
                return;
            }

            var altFloor:int = (x + y) % 2 ? 1 : 0;
            var image:Image = new Image(minimapTextureAtlas.getTexture('floor_' + altFloor));

            image.x = x * tileEdge;
            image.y = y * tileEdge;

            addChild(image);
            imagesFloors.setTile(x, y, image);
        }

        public function drawBase(tileX:int, tileY:int, color:int):void{
            var texture:Texture = minimapTextureAtlas.getTexture('base_' + color);
            var image:Image = imagesTiles.getTile(tileX, tileY);

            if (!image){
                image = new Image(texture);

                image.x = tileX * tileEdge;
                image.y = tileY * tileEdge;

                addChild(image);
                imagesFloors.setTile(tileX, tileY, image);
            } else {
                image.texture = texture;
            }
        }

        public function drawPath(x:int, y:int, color:int, sidesString:String):void{
            x /= S().tileWidth;
            y /= S().tileHeight;

            var texture:Texture = minimapTextureAtlas.getTexture('path_' + color + '_' + sidesString);
            var image:Image = imagesTiles.getTile(x, y);

            if (!image){
                image = new Image(texture);

                image.x = x * tileEdge;
                image.y = y * tileEdge;

                addChild(image);
                imagesTiles.setTile(x, y, image);
            } else {
                image.texture = texture;
            }
        }

        public function clearPath(tileX:int, tileY:int):void{
            var image:Image = imagesTiles.getTile(tileX, tileY);

            if (image){
                removeChild(image);
                imagesTiles.setTile(tileX, tileY, null);
                image.dispose();
            }
        }

        override public function addChild(child:DisplayObject):DisplayObject{
            var result:DisplayObject = super.addChild(child);

            if (currentViewImage && currentViewImage.parent)
                setChildIndex(currentViewImage, numChildren - 1);

            return result;
        }

        private function recalculate():void{
            if (Main.isLandscape()){
                tileEdge = (S().playfieldOffsetX / S().tileGridWidth) | 0;
                tilePathBorder = tileEdge * 0.25 | 0;
                tilePathCoreEdge = tileEdge - tilePathBorder * 2;

                y = x = (S().playfieldOffsetX - minimapWidth) / 2 | 0;

                backgroundFillerImage.x = -x;
                backgroundFillerImage.y = -y;
                backgroundFillerImage.width = S().playfieldOffsetX;
                backgroundFillerImage.height = S().playfieldOffsetX;
            } else {
                tileEdge = (S().portraitHudHeight / S().tileGridWidth) | 0;
                tilePathBorder = tileEdge * 0.25 | 0;
                tilePathCoreEdge = tileEdge - tilePathBorder * 2;


                x = (S().portraitHudHeight - minimapWidth) / 2 | 0;
                y = x + S().gameHeight - S().portraitHudHeight;

                backgroundFillerImage.x = -x;
                backgroundFillerImage.y = -x;
                backgroundFillerImage.width = S().portraitHudHeight;
                backgroundFillerImage.height = S().portraitHudHeight;
            }
        }

        private function generateTextureAtlas():void{
            minimapTextureAtlas = new rTextureAtlas(minimapTexture);

            for (var i:int = 0; i < COLORS; i++){
                for (var j:int = 0; j < TEXTURE_COLUMNS; j++){
                    var name:String = '';
                    name += (j & 0x1 ? '1' : '0');
                    name += (j & 0x2 ? '1' : '0');
                    name += (j & 0x4 ? '1' : '0');
                    name += (j & 0x8 ? '1' : '0');
                    minimapTextureAtlas.addRegion('path_' + i + '_' + name, new Rectangle(j * tileEdge, i * tileEdge, tileEdge, tileEdge));
                }
                minimapTextureAtlas.addRegion('base_' + i, new Rectangle(j * tileEdge, i * tileEdge, tileEdge, tileEdge));
            }

            minimapTextureAtlas.addRegion('floor_0', new Rectangle(0, i * tileEdge, tileEdge, tileEdge));
            minimapTextureAtlas.addRegion('floor_1', new Rectangle(tileEdge, i * tileEdge, tileEdge, tileEdge));
        }

        private function generateMinimapTexture():void{
            removeChildren();

            if (minimapTextureAtlas){
                minimapTextureAtlas.dispose();
            }

            if (minimapTexture){
                minimapTexture.dispose();
            }

            if (minimapTextureBitmapData){
                minimapTextureBitmapData.dispose();
            }

            minimapTextureBitmapData = new BitmapData((TEXTURE_COLUMNS + 1) * tileEdge, (COLORS + 1)* tileEdge, true, 0);

            for (var i:int = 0; i < COLORS; i++){
                for (var j:int = 0; j < TEXTURE_COLUMNS; j++){
                    drawToTexture(i, j);
                }

                UBitmapData.shapeRectangle(minimapTextureBitmapData, j * tileEdge, i * tileEdge, tileEdge, tileEdge, COLORS_RGB[i], 1);
            }

            UBitmapData.shapeRectangle(minimapTextureBitmapData, 0, i * tileEdge, tileEdge, tileEdge, 0x404040, 1);
            UBitmapData.shapeRectangle(minimapTextureBitmapData, tileEdge, i * tileEdge, tileEdge, tileEdge, 0x383838, 1);

            minimapTexture = Texture.fromBitmapData(minimapTextureBitmapData);
        }

        private function drawToTexture(color:int, textureID:int):void{
            var colorRGB:int = COLORS_RGB[color];

            var x:int = textureID * tileEdge;
            var y:int = color * tileEdge;

            // Draw base
            UBitmapData.shapeRectangle(minimapTextureBitmapData, x + tilePathBorder, y + tilePathBorder, tilePathCoreEdge, tilePathCoreEdge, colorRGB, 1);

            // Draw four edges
            if (textureID & 0x1)
                UBitmapData.shapeRectangle(minimapTextureBitmapData, x + tilePathBorder + tilePathCoreEdge, y + tilePathBorder, tilePathBorder, tilePathCoreEdge, colorRGB, 1);
            if (textureID & 0x2)
                UBitmapData.shapeRectangle(minimapTextureBitmapData, x + tilePathBorder, y + tilePathBorder + tilePathCoreEdge, tilePathCoreEdge, tilePathBorder, colorRGB, 1);
            if (textureID & 0x4)
                UBitmapData.shapeRectangle(minimapTextureBitmapData, x, y + tilePathBorder, tilePathBorder, tilePathCoreEdge, colorRGB, 1);
            if (textureID & 0x8)
                UBitmapData.shapeRectangle(minimapTextureBitmapData, x + tilePathBorder, y, tilePathCoreEdge, tilePathBorder, colorRGB, 1);
        }
    }
}