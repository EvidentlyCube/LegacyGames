package game.global{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.IBitmapDrawable;
    import flash.display.Sprite;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import net.retrocade.standalone.Colorizer;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.retrocamel_int;
    import net.retrocade.camel.layers.rLayer;

    use namespace retrocamel_int;

    public class DrodLayer extends rLayer{
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Helpers
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * HELPER: Matrix used in drawAdvanced()
         */
        private static var _matrix  :Matrix    = new Matrix();

        /**
         * HELPER: Rectangle used in draw()
         */
        private static var _rect    :Rectangle = new Rectangle(0, 0, S.LEVEL_TILE_WIDTH, S.LEVEL_TILE_HEIGHT);

        private static var _rectRect:Rectangle = new Rectangle(0, 0, S.LEVEL_TILE_WIDTH, S.LEVEL_TILE_HEIGHT);

        /**
         * HELPER: Point used in draw();
         */
        private static var _point   :Point     = new Point();

        private static var _colorTransform:ColorTransform = new ColorTransform();




        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Display stuff
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * BitmapData of the layer, the draw-on thing
         */
        public  var bitmapData:BitmapData;

        /**
         * Bitmap, the layer
         */
        private var _layer     :Bitmap;

        /**
         * Used for saturation management
         */
        private var _colorizer :Colorizer;

        /**
         * @inheritdoc
         */
        override public function get displayObject():DisplayObject{
            return _layer;
        }

        public var offsetX:uint;
        public var offsetY:uint;



        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        /**
         * Constructor
         */
        public function DrodLayer(width:uint, height:uint, positionX:uint, positionY:uint) {
            bitmapData = new BitmapData(width, height, true, 0x00000000);
            _layer     = new Bitmap(bitmapData);

            CF::play{
                super(0);
            }
            CF::lib{
                super(int.MAX_VALUE);
            }

            _layer.x = positionX;
            _layer.y = positionY;
        }

        public function set saturation(saturation:Number):void {
            if (!_colorizer) {
                if (saturation == 1)
                    return;

                _colorizer = new Colorizer(_layer);
            }

            _colorizer.saturation = saturation;
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Simple drawing functions
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Clears the bitmapData to transparent black
         */
        override public function clear():void{
            _rect.x      = 0;
            _rect.y      = 0;
            _rect.width  = rCore._settings.SIZE_GAME_WIDTH;
            _rect.height = rCore._settings.SIZE_GAME_HEIGHT;
            bitmapData.fillRect(_rect, 0x00000000);
            _rect.width  = S.LEVEL_TILE_WIDTH;
            _rect.height = S.LEVEL_TILE_HEIGHT;
        }

        /**
         * Draws given BitmapData to the screen
         * @param data BitmapData
         * @param x X position of the drawing
         * @param y Y position of the drawing
         */
        public function blit(data:BitmapData, x:int, y:int):void {
            _point.x = x * S.LEVEL_TILE_WIDTH + offsetX;
            _point.y = y * S.LEVEL_TILE_HEIGHT + offsetY;

            bitmapData.copyPixels(data, data.rect, _point, null, null, true);
        }

        public function blitPrecise(data:BitmapData, x:int, y:int):void {
            _point.x = x + offsetX;
            _point.y = y + offsetY;
            bitmapData.copyPixels(data, data.rect, _point, null, null, true);
        }

        public function blitDirectly(data:BitmapData, x:int, y:int):void {
            _point.x = x;
            _point.y = y;
            bitmapData.copyPixels(data, data.rect, _point, null, null, true);
        }

        public function blitTileRect(gfx:BitmapData, tileID:uint, x:int, y:int):void{
            _point.x = x * S.LEVEL_TILE_WIDTH + offsetX;
            _point.y = y * S.LEVEL_TILE_HEIGHT + offsetY;
            bitmapData.copyPixels(gfx, T.TILES[tileID], _point, null, null, true);
        }

        /**
         * Blits a designated BitmapData's region to another BitmapData
         * @param source Source BitmapData
         * @param target Target BitmapData
         * @param x Target draw position
         * @param y Target draw position
         * @param sourceX X of the top-left corner of the source rectangle
         * @param sourceY Y of the top-left corner of the source rectangle
         * @param sourceWidth Width of the source rectangle
         * @param sourceHeight Height of the source rectangle
         */
        public function blitComplex(source:BitmapData, x:int, y:int, sourceX:int, sourceY:int,
                                        sourceWidth:uint, sourceHeight:uint):void{
            _rect.x      = sourceX;
            _rect.y      = sourceY;
            _rect.width  = sourceWidth;
            _rect.height = sourceHeight;

            _point.x     = x;
            _point.y     = y;

            bitmapData.copyPixels(source, _rect, _point, null, null, true);

            _rect.width  = S.LEVEL_TILE_WIDTH;
            _rect.height = S.LEVEL_TILE_HEIGHT;
        }

        public function blitTileRectPrecise(gfx:BitmapData, tileID:uint, x:int, y:int):void{
            _point.x = x + offsetX;
            _point.y = y + offsetY;
            bitmapData.copyPixels(gfx, T.TILES[tileID], _point, null, null, true);
        }

        public function clearTiles():void{
            _rect.x      = offsetX;
            _rect.y      = offsetY;
            _rect.width  = S.LEVEL_WIDTH_PIXELS;
            _rect.height = S.LEVEL_HEIGHT_PIXELS;
            bitmapData.fillRect(_rect, 0x00000000);
            _rect.width  = S.LEVEL_TILE_WIDTH;
            _rect.height = S.LEVEL_TILE_HEIGHT;
        }

        public function clearBlock(x:int, y:int):void{
            _rect.x = x * S.LEVEL_TILE_WIDTH + offsetX;
            _rect.y = y * S.LEVEL_TILE_HEIGHT + offsetY;
            bitmapData.fillRect(_rect, 0);
        }

        /**
         * Plots pixel
         * @param x X position
         * @param y Y position
         * @param color ARGB value of the pixel
         */
        public function plot(x:uint, y:uint, color:uint = 0xFFFFFFFF):void{
            bitmapData.setPixel32(x, y, color);
        }

        /**
         * Plots pixel
         * @param x X position
         * @param y Y position
         * @param alpha Alpha component of the color
         * @param red Red component of the color
         * @param green Green component of the color
         * @param blue Blue component of the color
         */
        public function plot2(x:uint, y:uint, alpha:uint = 255, red:uint = 255, green:uint = 255, blue:uint = 255):void{
            bitmapData.setPixel32(x, y, alpha << 24 | red << 16 | green << 8 | blue);
        }

        /**
         * Draws a rectangle
         * @param	x X of the top left corner
         * @param	y Y of the top left corner
         * @param	width Width of the rectangle
         * @param	height Height of the rectangle
         * @param	color Color to fill
         */
        public function blitRect(x:int, y:int, width:int, height:int, color:uint):void {
            _rect.x      = x + offsetX;
            _rect.y      = y + offsetY;
            _rect.width  = width;
            _rect.height = height;

            bitmapData.fillRect(_rect, color);

            _rect.width  = S.LEVEL_TILE_WIDTH;
            _rect.height = S.LEVEL_TILE_HEIGHT;
        }

        public function blitRectDirect(x:int, y:int, width:int, height:int, color:uint):void {
            _rect.x      = x;
            _rect.y      = y;
            _rect.width  = width;
            _rect.height = height;

            bitmapData.fillRect(_rect, color);

            _rect.width  = S.LEVEL_TILE_WIDTH;
            _rect.height = S.LEVEL_TILE_HEIGHT;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Advanced drawing functions
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Advanced draw to the layer
         * @param data BitmapData to be drawn
         * @param x X position
         * @param y Y position
         * @param rotation Rotation angle in degrees
         * @param scaleX ScaleX
         * @param scaleY ScalY
         * @param blend Blendmode
         * @param smoothing Smooth the bitmap
         */
        public function draw(data:IBitmapDrawable, x:int, y:int, alpha:Number):void{
            _matrix.identity();
            _matrix.translate(x * S.LEVEL_TILE_WIDTH + offsetX, y * S.LEVEL_TILE_HEIGHT + offsetY);

            _colorTransform.alphaMultiplier = alpha;

            bitmapData.draw(data, _matrix, _colorTransform);
        }

        public function drawPrecise(data:IBitmapDrawable, x:int, y:int, alpha:Number = 1):void{
            _matrix.identity();
            _matrix.translate(x + offsetX, y + offsetY);

            _colorTransform.alphaMultiplier = alpha;

            bitmapData.draw(data, _matrix, _colorTransform);
        }

        public function drawDirect(data:IBitmapDrawable, x:int, y:int, alpha:Number = 1):void{
            _matrix.identity();
            _matrix.translate(x, y);

            _colorTransform.alphaMultiplier = alpha;

            bitmapData.draw(data, _matrix, _colorTransform);
        }

        public function drawComplexDirect(data:IBitmapDrawable, x:int, y:int, alpha:Number, sourceX:uint,
                                          sourceY:uint, sourceWidth:uint, sourceHeight:uint):void{

            _matrix.identity();
            _matrix.translate(x - sourceX, y - sourceY);

            _colorTransform.alphaMultiplier = alpha;

            _rectRect.x      = x;
            _rectRect.y      = y;
            _rectRect.width  = sourceWidth;
            _rectRect.height = sourceHeight;

            bitmapData.draw(data, _matrix, _colorTransform, null, _rectRect);
        }

        public function drawTileRect(data:IBitmapDrawable, tileID:uint, x:uint, y:uint, alpha:Number):void {
            var rect:Rectangle = T.TILES[tileID];

            _matrix.identity();
            _matrix.translate(x * S.LEVEL_TILE_WIDTH  - rect.x + offsetX,
                              y * S.LEVEL_TILE_HEIGHT - rect.y + offsetY);

            _colorTransform.alphaMultiplier = alpha;

            _rectRect.x      = x * S.LEVEL_TILE_WIDTH  + offsetX;
            _rectRect.y      = y * S.LEVEL_TILE_HEIGHT + offsetY;
            _rectRect.width  = rect.width;
            _rectRect.height = rect.height;

            bitmapData.draw(data, _matrix, _colorTransform, null, _rectRect);
        }
		
		public function drawTileRectPrecise(data:IBitmapDrawable, tileID:uint, x:uint, y:uint, alpha:Number):void {
            var rect:Rectangle = T.TILES[tileID];

            _matrix.identity();
            _matrix.translate(x - rect.x + offsetX,
                              y - rect.y + offsetY);

            _colorTransform.alphaMultiplier = alpha;

            _rectRect.x      = x + offsetX;
            _rectRect.y      = y + offsetY;
            _rectRect.width  = rect.width;
            _rectRect.height = rect.height;

            bitmapData.draw(data, _matrix, _colorTransform, null, _rectRect);
        }

        private static var _sprite:Sprite      = new Sprite();
        public function drawLine(x:Number, y:Number, toX:Number, toY:Number, color:uint = 0xFFFFFF, alpha:Number = 1, thickness:Number = 1):void{
            _sprite.graphics.clear();
            _sprite.graphics.lineStyle(thickness, color, alpha);
            _sprite.graphics.moveTo(x, y);
            _sprite.graphics.lineTo(toX, toY);

            bitmapData.draw(_sprite);
        }
    }
}