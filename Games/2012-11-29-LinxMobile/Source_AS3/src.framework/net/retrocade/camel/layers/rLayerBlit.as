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
    
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.global.retrocamel_int;

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

        public function set scale(value:Number):void{
            _layer.scaleX = _layer.scaleY = value;
        }




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

        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Offset
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        /**
         * Amount of Horizontal scroll to offset all drawing functions
         */
        public var scrollX:int = 0;

        /**
         * Amount of Horizontal scroll to offset all drawing functions
         */
        public var scrollY:int = 0;

        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Dimensions
        // ::::::::::::::::::::::::::::::::::::::::::::::
        
        /**
         * Width of the layer 
         */
        private var width:uint;
        
        /**
         * Height of the layer 
         */
        private var height:uint;


        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        /**
         * Constructor
         */
        public function rLayerBlit(width:uint = 0, height:uint = 0){
            this.width  = width || rCore.settings.gameWidth;
            this.height = height || rCore.settings.gameHeight;
            
            _bitmapData = new BitmapData(this.width, this.height, true, 0x00000000);
            _layer      = new Bitmap(_bitmapData);
            super();
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Shape drawing
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Clears the bitmapData to transparent black
         */
        override public function clear():void {
            _rect.x      = 0;
            _rect.y      = 0;
            _rect.width  = width;
            _rect.height = height;
            _bitmapData.fillRect(_rect, 0x00000000);
        }
        
        /**
         * Clears the bitmapData to transparent black
         */
        public function clearRect(x:uint, y:uint, width:uint, height:uint):void {
            _rect.x      = x;
            _rect.y      = y;
            _rect.width  = width;
            _rect.height = height;
            _bitmapData.fillRect(_rect, 0x00000000);
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
        public function plotARGB(x:uint, y:uint, alpha:uint = 255, red:uint = 255, green:uint = 255, blue:uint = 255):void{
            _bitmapData.setPixel32(x + scrollX, y + scrollY, alpha << 24 | red << 16 | green << 8 | blue);
        }

        /**
         * Draws a line in a Shape and then draws the shape to the layer 
         * @param x X of where the line should be drawn from
         * @param y Y of where the line should be drawn from
         * @param toX X of where the line should be drawn to
         * @param toY Y of where the lien should be drawn to
         * @param color Color of the line to draw
         * @param alpha Alpha of the line to draw
         * @param thickness Thickness of the line to draw
         * 
         */
        public function shapeLine(x:Number, y:Number, toX:Number, toY:Number, color:uint = 0xFFFFFF, alpha:Number = 1, thickness:Number = 1):void{
            _sprite.graphics.clear();
            _sprite.graphics.lineStyle(thickness, color, alpha);
            _sprite.graphics.moveTo(x + scrollX, y + scrollY);
            _sprite.graphics.lineTo(toX + scrollX, toY + scrollY);
            
            _bitmapData.draw(_sprite);
        }

        /**
         * Draws a rectangle
         * @param    x X of the top left corner
         * @param    y Y of the top left corner
         * @param    width Width of the rectangle
         * @param    height Height of the rectangle
         * @param    color Color to fill
         */
        public function shapeRect(x:int, y:int, width:int, height:int, color:uint = 0xFFFFFFFF):void {
            _rect.x      = x + scrollX;
            _rect.y      = y + scrollY;
            _rect.width  = width;
            _rect.height = height;
            
            _bitmapData.fillRect(_rect, color);
        }
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Blitting
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Draws given BitmapData to the layer
         * @param data BitmapData
         * @param x X position of the drawing
         * @param y Y position of the drawing
         */
        public function blit(data:BitmapData, x:int, y:int):void {
            _point.x      = x + scrollX;
            _point.y      = y + scrollY;
            
            _bitmapData.copyPixels(data, data.rect, _point, null, null, true);
        }
        
        /**
         * Blits a part of the given BitmapData to the layer using the part stored in a passed rectangle
         * @param source Source BitmapData
         * @param tileRect Rectangle designating the area of the Source which has to be drawn
         * @param x X position of the drawing
         * @param y Y position of the drawing
         */
        public function blitFromRect(source:BitmapData, tileRect:Rectangle, x:int, y:int):void{
            _point.x = x + scrollX;
            _point.y = y + scrollY;
            
            _bitmapData.copyPixels(source, tileRect, _point, null, null, true);
        }

        /**
         * Blits a part of the given BitmapData to the layer 
         * @param data Source BitmapData
         * @param targetX Target X position of where the image should be drawn on the layer
         * @param targetY Target Y position of where the image should be drawn on the layer
         * @param sourceX Position of the left edge of the rectangle which will designate which part of the source BitmapData to blit
         * @param sourceY Position of the right edge of the rectangle which will designate which part of the source BitmapData to blit
         * @param sourceWidth Width of the rectangle which will designate which part of the source BitmapData to blit
         * @param sourceHeight Height of the rectangle which will designate which part of the source BitmapData to blit
         * 
         */
        public function blitRect(data:BitmapData, targetX:int, targetY:int, sourceX:uint, sourceY:uint, sourceWidth:uint, sourceHeight:uint):void{
            _point.x = targetX + scrollX;
            _point.y = targetY + scrollY;
            
            _rectRect.x = sourceX;
            _rectRect.y = sourceY;
            
            _rectRect.width = sourceWidth;
            _rectRect.height = sourceHeight;
            
            _bitmapData.copyPixels(data, _rectRect, _point, null, null, true);

        }



        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Advanced drawing functions
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Draws to the layer using specified settings. This function is optimized in such a way, that if rotation, alpha, scale and blending are default, and the
         * drawn image is either Bitmap or BitmapData, the image will be blitted instead.
         * @param data DisplayObject or BitmapData to be drawn
         * @param x X position
         * @param y Y position
         * @param alpha Transparency
         * @param rotation Rotation angle in degrees
         * @param scaleX ScaleX
         * @param scaleY ScalY
         * @param blend Blendmode
         * @param smoothing Smooth the bitmap
         */
        public function draw(data:*, x:Number, y:Number, alpha:Number = 1, rotation:Number = 0, 
                                     scaleX:Number = 1, scaleY:Number = 1, blend:String = null, smoothing:Boolean = false):void
        {
            
            if (alpha == 1 && rotation == 0 && scaleX == 1 && scaleY == 1 && blend == null && (data is Bitmap || data is BitmapData)){
                if (data is Bitmap)
                    blit(Bitmap(data).bitmapData, x, y);
                else
                    blit(BitmapData(data), x, y);

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
         * Draws to the layer using specified settings.
         * @param data
         * @param x
         * @param y
         * @param rotation
         * @param scaleX
         * @param scaleY
         * @param alpha
         * @param blend
         * @param smoothing
         * @param redMultiplier
         * @param greenMultiplier
         * @param blueMultiplier
         * @param redOffset
         * @param greenOffset
         * @param blueOffset
         * @param alphaOffset
         * 
         */
        public function drawColor(data:*, x:int, y:int, rotation:Number = 0, scaleX:Number = 1, scaleY:Number = 1,
                                    alpha:Number = 1, blend:String = null, smoothing:Boolean = true,
                                    redMultiplier:Number = 1, greenMultiplier:Number = 1, blueMultiplier:Number = 1,
                                    redOffset:Number = 0, greenOffset:Number = 0, blueOffset:Number = 0, alphaOffset:Number = 0):void
        {
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
        
        public function drawFromRect(data:IBitmapDrawable, x:int, y:int, source:Rectangle, alpha:Number,
                                 blend:String = null, smoothing:Boolean = false):void{
            _matrix.identity();
            _matrix.translate(x - source.x, y - source.y);
            
            _colorTransform.alphaMultiplier = alpha;
            
            _rectRect.x      = x;
            _rectRect.y      = y;
            _rectRect.width  = source.width;
            _rectRect.height = source.height;
            
            _bitmapData.draw(data, _matrix, _colorTransform, blend, _rectRect, smoothing);
        }
        
        public function drawRect(data:IBitmapDrawable, x:int, y:int, sourceX:Number, sourceY:Number, sourceWidth:Number, sourceHeight:Number, alpha:Number,
                                 blend:String = null, smoothing:Boolean = false):void{
            
            _matrix.identity();
            _matrix.translate(x - sourceX, y - sourceY);
            
            _colorTransform.alphaMultiplier = alpha;
            
            _rectRect.x      = x;
            _rectRect.y      = y;
            _rectRect.width  = sourceWidth;
            _rectRect.height = sourceHeight;
            
            _bitmapData.draw(data, _matrix, _colorTransform, blend, _rectRect, smoothing);
        }
    }
}