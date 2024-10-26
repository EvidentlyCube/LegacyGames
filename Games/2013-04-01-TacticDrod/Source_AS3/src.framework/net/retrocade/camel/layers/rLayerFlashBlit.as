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

    public class rLayerFlashBlit extends rLayerFlash{
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

        private var _layer:Bitmap;

        override public function get layer():DisplayObject{
            return _layer;
        }

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
        
        
        
        override public function set inputEnabled(value:Boolean):void{}
        
        override public function get inputEnabled():Boolean{
            return false;
        }


        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        public function rLayerFlashBlit(width:uint = 0, height:uint = 0, addAt:Number = -1){
            this.width  = width || rCore.settings.gameWidth;
            this.height = height || rCore.settings.gameHeight;
            
            _bitmapData = new BitmapData(this.width, this.height, true, 0x00000000);
            _layer      = new Bitmap(_bitmapData);
            
            addLayer(addAt);
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Shape drawing
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        override public function clear():void {
            _rect.x      = 0;
            _rect.y      = 0;
            _rect.width  = width;
            _rect.height = height;
            _bitmapData.fillRect(_rect, 0x00000000);
        }
        
        public function clearRect(x:uint, y:uint, width:uint, height:uint):void {
            _rect.x      = x;
            _rect.y      = y;
            _rect.width  = width;
            _rect.height = height;
            _bitmapData.fillRect(_rect, 0x00000000);
        }
        
        public function plot(x:uint, y:uint, color:uint = 0xFFFFFFFF):void{
            _bitmapData.setPixel32(x, y, color);
        }
        
        public function plotARGB(x:uint, y:uint, alpha:uint = 255, red:uint = 255, green:uint = 255, blue:uint = 255):void{
            _bitmapData.setPixel32(x, y, alpha << 24 | red << 16 | green << 8 | blue);
        }

        public function shapeLine(x:Number, y:Number, toX:Number, toY:Number, color:uint = 0xFFFFFF, alpha:Number = 1, thickness:Number = 1):void{
            _sprite.graphics.clear();
            _sprite.graphics.lineStyle(thickness, color, alpha);
            _sprite.graphics.moveTo(x, y);
            _sprite.graphics.lineTo(toX, toY);
            
            _bitmapData.draw(_sprite);
        }

        public function shapeRect(x:int, y:int, width:int, height:int, color:uint = 0xFFFFFFFF):void {
            _rect.x      = x;
            _rect.y      = y;
            _rect.width  = width;
            _rect.height = height;
            
            _bitmapData.fillRect(_rect, color);
        }
        
        
        
        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Blitting
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        public function blit(data:BitmapData, x:int, y:int):void {
            _point.x      = x;
            _point.y      = y;
            
            _bitmapData.copyPixels(data, data.rect, _point, null, null, true);
        }
        
        public function blitFromRect(source:BitmapData, tileRect:Rectangle, x:int, y:int):void{
            _point.x = x;
            _point.y = y;
            
            _bitmapData.copyPixels(source, tileRect, _point, null, null, true);
        }

        public function blitRect(data:BitmapData, targetX:int, targetY:int, sourceX:uint, sourceY:uint, sourceWidth:uint, sourceHeight:uint):void{
            _point.x = targetX;
            _point.y = targetY;
            
            _rectRect.x = sourceX;
            _rectRect.y = sourceY;
            
            _rectRect.width = sourceWidth;
            _rectRect.height = sourceHeight;
            
            _bitmapData.copyPixels(data, _rectRect, _point, null, null, true);

        }



        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Advanced drawing functions
        // ::::::::::::::::::::::::::::::::::::::::::::::::

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
                _matrix.translate(data.width / 2 + x, data.height / 2 + y);
                
                _colorTransform.redMultiplier   = 1;
                _colorTransform.blueMultiplier  = 1;
                _colorTransform.greenMultiplier = 1;
                _colorTransform.alphaMultiplier = alpha;

                _bitmapData.draw(data, _matrix, _colorTransform, blend, null, smoothing);
            }
        }

        public function drawColor(data:*, x:int, y:int, rotation:Number = 0, scaleX:Number = 1, scaleY:Number = 1,
                                    alpha:Number = 1, blend:String = null, smoothing:Boolean = true,
                                    redMultiplier:Number = 1, greenMultiplier:Number = 1, blueMultiplier:Number = 1,
                                    redOffset:Number = 0, greenOffset:Number = 0, blueOffset:Number = 0, alphaOffset:Number = 0):void
        {
            _matrix.identity();
            _matrix.translate(-data.width / 2, -data.height / 2);
            _matrix.rotate(rotation * Math.PI / 180);
            _matrix.scale(scaleX, scaleY);
            _matrix.translate(data.width / 2 + x, data.height / 2 + y);
            
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