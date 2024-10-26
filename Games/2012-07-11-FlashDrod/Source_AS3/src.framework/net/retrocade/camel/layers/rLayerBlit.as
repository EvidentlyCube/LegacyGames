package net.retrocade.camel.layers{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.display.IBitmapDrawable;
    import flash.display.Sprite;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.retrocamel_int;

    use namespace retrocamel_int;

    public class rLayerBlit extends rLayer{
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
        private static var _rect    :Rectangle = new Rectangle();

        /**
         * HELPER: Rectangle used in drawImageRect()
         */
        private static var _rectRect:Rectangle = new Rectangle();

        /**
         * HELPER: Point used in draw();
         */
        private static var _point   :Point     = new Point();

        private static var _colorTransform:ColorTransform = new ColorTransform();

        private static var _sprite:Sprite      = new Sprite();




        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Display stuff
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * BitmapData of the layer, the draw-on thing
         */
        private var _bitmapData:BitmapData;

        /**
         * Bitmap, the layer
         */
        private var _layer     :Bitmap;

        /**
         * @inheritdoc
         */
        override public function get displayObject():DisplayObject{
            return _layer;
        }

        /**
         * Amount of Horizontal scroll offsets all drawing functions
         */
        public var scrollX:int = 0;

        /**
         * Amount of Vertical scroll
         */
        public var scrollY:int = 0;



        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        /**
         * Constructor
         */
        public function rLayerBlit(){
            _bitmapData = new BitmapData(rCore._settings.SIZE_GAME_WIDTH, rCore._settings.SIZE_GAME_HEIGHT, true, 0x00000000);
            _layer      = new Bitmap(_bitmapData);
            super();
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Simple drawing functions
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Clears the bitmapData to transparent black
         */
        override public function clear():void {
            _rect.x      = 0;
            _rect.y      = 0;
            _rect.width  = rCore._settings.SIZE_GAME_WIDTH;
            _rect.height = rCore._settings.SIZE_GAME_HEIGHT;
            _bitmapData.fillRect(_rect, 0x00000000);
        }

        /**
         * Draws given BitmapData to the screen
         * @param data BitmapData
         * @param x X position of the drawing
         * @param y Y position of the drawing
         */
        public function draw(data:BitmapData, x:int, y:int):void {
            _point.x      = x + scrollX;
            _point.y      = y + scrollY;
            _bitmapData.copyPixels(data, data.rect, _point, null, null, true);
        }

        public function drawImageRect(data:BitmapData, x:int, y:int, rx:uint, ry:uint, width:uint, height:uint):void{
            _point.x = x + scrollX;
            _point.y = y + scrollY;
            _rectRect.x = rx;
            _rectRect.y = ry;
            _rectRect.width = width;
            _rectRect.height = height;
            _bitmapData.copyPixels(data, _rectRect, _point, null, null, true);

        }

        /**
         * Plots pixel
         * @param x X position
         * @param y Y position
         * @param color ARGB value of the pixel
         */
        public function plot(x:uint, y:uint, color:uint = 0xFFFFFFFF):void{
            _bitmapData.setPixel32(x + scrollX, y + scrollY, color);
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
            _bitmapData.setPixel32(x + scrollX, y + scrollY, alpha << 24 | red << 16 | green << 8 | blue);
        }

        /**
         * Draws a rectangle
         * @param    x X of the top left corner
         * @param    y Y of the top left corner
         * @param    width Width of the rectangle
         * @param    height Height of the rectangle
         * @param    color Color to fill
         */
        public function drawRect(x:int, y:int, width:int, height:int, color:uint = 0xFFFFFFFF):void {
            _rect.x      = x + scrollX;
            _rect.y      = y + scrollY;
            _rect.width  = width;
            _rect.height = height;

            _bitmapData.fillRect(_rect, color);
        }

        public function drawLine(x:Number, y:Number, toX:Number, toY:Number, color:uint = 0xFFFFFF, alpha:Number = 1, thickness:Number = 1):void{
            _sprite.graphics.clear();
            _sprite.graphics.lineStyle(thickness, color, alpha);
            _sprite.graphics.moveTo(x + scrollX, y + scrollY);
            _sprite.graphics.lineTo(toX + scrollX, toY + scrollY);

            _bitmapData.draw(_sprite);
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Advanced drawing functions
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Advanced draw to the layer
         * @param data DisplayObject or BitmapData to be drawn
         * @param x X position
         * @param y Y position
         * @param rotation Rotation angle in degrees
         * @param scaleX ScaleX
         * @param scaleY ScalY
         * @param blend Blendmode
         * @param smoothing Smooth the bitmap
         */
        public function drawAdvanced(data:*, x:int, y:int, rotation:Number = 0, scaleX:Number = 1, scaleY:Number = 1, blend:String = null, smoothing:Boolean = false, alpha:Number = 1):void{
            if (rotation == 0 && scaleX == 1 && scaleY == 1 && blend == null && (data is Bitmap || data is BitmapData) && alpha == 1){
                if (data is Bitmap)
                    draw(Bitmap(data).bitmapData, x + scrollX, y + scrollY);
                else
                    draw(data, x + scrollX, y + scrollY);

            } else {
                _matrix.identity();
                _matrix.translate(-data.width / 2, -data.height / 2);
                _matrix.rotate(rotation * Math.PI / 180);
                _matrix.scale(scaleX, scaleY);
                _matrix.translate(data.width / 2 + x + scrollX, data.height / 2 + y + scrollY);
                _colorTransform.redMultiplier   = 1;
                _colorTransform.blueMultiplier  = 1;
                _colorTransform.greenMultiplier = 1;
                _colorTransform.alphaMultiplier = alpha;

                _bitmapData.draw(data, _matrix, _colorTransform, blend, null, smoothing);
            }
        }

        /**
         * Advanced draw to the layer
         * @param data Display object to be drawn
         * @param x X position to draw
         * @param y Y position to draw
         * @param color ARGB value to modify the color by
         *
         */
        public function drawColor(data:*, x:int, y:int, color:uint = 0xFFFFFFFF):void{
            if (color == 0xFFFFFFFF && (data is Bitmap || data is BitmapData)){
                if (data is Bitmap)
                    draw(Bitmap(data).bitmapData, x + scrollX, y + scrollY);
                else
                    draw(data, x + scrollX, y + scrollY);
            } else {
                _colorTransform.redMultiplier   = Number((color >> 16) & 0xFF) / 0xFF;
                _colorTransform.greenMultiplier = Number((color >> 8)  & 0xFF) / 0xFF;
                _colorTransform.blueMultiplier  = Number( color        & 0xFF) / 0xFF;
                _colorTransform.alphaMultiplier = Number((color >> 24) & 0xFF) / 0xFF;

                _matrix.identity();
                _matrix.translate(x, y);

                _bitmapData.draw(data, _matrix, _colorTransform);
            }
        }

        /**
         * Advanced draw to the layer
         * @param data Display object to be drawn
         * @param x X position to draw
         * @param y Y position to draw
         * @param color ARGB value to modify the color by
         *
         */
        public function drawSpecial(data:*, x:int, y:int, rotation:Number = 0, scaleX:Number = 1, scaleY:Number = 1,
                                    alpha:Number = 1, blend:String = null, smoothing:Boolean = true,
                                    redMultiplier:Number = 1, greenMultiplier:Number = 1, blueMultiplier:Number = 1,
                                    redOffset:Number = 0, greenOffset:Number = 0, blueOffset:Number = 0, alphaOffset:Number = 0):void{
            _matrix.identity();
            _matrix.translate(-data.width / 2, -data.height / 2);
            _matrix.rotate(rotation * Math.PI / 180);
            _matrix.scale(scaleX, scaleY);
            _matrix.translate(data.width / 2 + x + scrollX, data.height / 2 + y + scrollY);
            _colorTransform.redMultiplier   = redMultiplier;
            _colorTransform.blueMultiplier  = blueMultiplier;
            _colorTransform.greenMultiplier = greenMultiplier;
            _colorTransform.alphaMultiplier = alpha;
            _colorTransform.redOffset       = redOffset;
            _colorTransform.greenOffset     = greenOffset;
            _colorTransform.blueOffset      = blueOffset;
            _colorTransform.alphaOffset     = alphaOffset;

            _bitmapData.draw(data, _matrix, _colorTransform, blend, null, smoothing);

            _colorTransform.redOffset       = 0;
            _colorTransform.greenOffset     = 0;
            _colorTransform.blueOffset      = 0;
            _colorTransform.alphaOffset     = 0;
        }


    }
}