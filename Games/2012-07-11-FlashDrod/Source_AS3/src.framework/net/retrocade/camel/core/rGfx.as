package net.retrocade.camel.core{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.PixelSnapping;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;

    import net.retrocade.utils.UBitmapData;
    import flash.display.LoaderInfo;

    import flash.events.Event;

    public class rGfx{
        private static var _graphics     :Dictionary = new Dictionary();

        private static var _rect :Rectangle = new Rectangle();
        private static var _point:Point     = new Point();

		
		
        /**
         * Loads a bitmap stored as ByteArray
         * @param	gfx Class containing the ByteArray
         * @return Loader which will load the graphic
         */
		public static function load(gfx:Class):Loader{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, bitmapLoaded);
			
			_graphics[loader] = gfx;

			loader.loadBytes(new gfx);

            return loader;
		}

		private static function bitmapLoaded(event:Event):void{
			var loader  :Loader = LoaderInfo(event.target).loader;
			var gfxClass:Class  = _graphics[loader];
			
			loader.contentLoaderInfo.removeEventListener(Event.INIT, bitmapLoaded);
			
			_graphics[gfxClass] = Bitmap(loader.content);
		}

        /**
         * Checks if given class is already available in the library
         * @param	gfx Class to check
         * @return True if it was already loaded, otherwise false
         */
        public static function isAvailable(gfx:Class):Boolean {
            return _graphics[gfx] != null;
        }
		
        /**
         * Retrieves the Bitmap of the given asset
         * @param gfx Class of the embedded asset
         * @return Bitmap od the specified class
         */
        public static function getB(gfx:Class):Bitmap{
            if (!_graphics[gfx])
                _graphics[gfx] = new gfx;

            return new Bitmap(Bitmap(_graphics[gfx]).bitmapData);
        }

        /**
         * Retrieves the BitmapData of the given asset
         * @param gfx Class of the embedded asset
         * @return BitmapData of the specified class
         */
        public static function getBD(gfx:Class):BitmapData{
            if (!_graphics[gfx])
                _graphics[gfx] = new gfx;

            return Bitmap(_graphics[gfx]).bitmapData;
        }

        /**
         * Retrieves the Bitmap of the given asset
         * @param gfx Class of the embedded asset
         * @return Bitmap od the specified class
         */
        public static function getBExt(gfx:Class, x:uint, y:uint, width:uint, height:uint):Bitmap{
            var code:String = Object(gfx).toString() + ":" + x + ":" + y + ":" + width + ":" + height;

            if (_graphics[code])
                return Bitmap(_graphics[code]);

            var original:BitmapData = getBD(gfx);

            var bData:BitmapData = new BitmapData(width, height, true, 0);
            _rect.x      = x;
            _rect.y      = y;
            _rect.width  = width;
            _rect.height = height;

            bData.copyPixels(original, _rect, _point, null, null, true);

            _graphics[code] = new Bitmap(bData);

            return _graphics[code];
        }

        /**
         * Copies specified part of gfx to a new BitmapData and returns it
         * @param gfx Class of the embedded asset
         * @param x X position of the top-left corner of the gfx to put into new BitmapData
         * @param y Y position of the top-left corner of the gfx to put into new BitmapData
         * @param width Width of the region to copy
         * @param height Height of the region to copy
         * @return The resulting BitmapData
         */
        public static function getBDExt(gfx:Class, x:uint, y:uint, width:uint, height:uint):BitmapData{
            var code:String = Object(gfx).toString() + ":" + x + ":" + y + ":" + width + ":" + height;

            if (_graphics[code])
                return Bitmap(_graphics[code]).bitmapData;

            var original:BitmapData = getBD(gfx);

            var bData:BitmapData = new BitmapData(width, height, true, 0);
            _rect.x      = x;
            _rect.y      = y;
            _rect.width  = width;
            _rect.height = height;

            bData.copyPixels(original, _rect, _point, null, null, true);

            _graphics[code] = new Bitmap(bData);

            return bData;
        }

        /**
         * Copies specified part of gfx to a new BitmapData with mirroring and returns it
         * @param gfx Class of the embedded asset
         * @param x X position of the top-left corner of the gfx to put into new BitmapData
         * @param y Y position of the top-left corner of the gfx to put into new BitmapData
         * @param width Width of the region to copy
         * @param height Height of the region to copy
         * @return The resulting BitmapData
         */
        public static function getBDExtMirrored(gfx:Class, x:uint, y:uint, width:uint, height:uint):BitmapData{
            var code:String = Object(gfx).toString() + ":M:" + x + ":" + y + ":" + width + ":" + height + ":" + 0;

            if (_graphics[code])
                return Bitmap(_graphics[code]).bitmapData;

            var original:BitmapData = getBD(gfx);

            var bData:BitmapData = new BitmapData(width, height, true, 0);
            _rect.x      = x;
            _rect.y      = y;
            _rect.width  = width;
            _rect.height = height;

            bData.copyPixels(original, _rect, _point, null, null, true);
            bData = UBitmapData.mirror(bData);

            _graphics[code] = new Bitmap(bData);

            return bData;
        }

        public static function getBDSpecial(gfx:Class, x:uint, y:uint, width:uint, height:uint, mirror:Boolean = false, color:uint = 0):BitmapData{
            var code:String = Object(gfx).toString() + ":" + (mirror ? "M:" : "") + x + ":" + y + ":" + width + ":" + height + ":" + color;

            if (_graphics[code])
                return Bitmap(_graphics[code]).bitmapData;

            var original:BitmapData = getBD(gfx);

            var bData:BitmapData = new BitmapData(width, height, true, 0);
            _rect.x      = x;
            _rect.y      = y;
            _rect.width  = width;
            _rect.height = height;

            bData.copyPixels(original, _rect, _point, null, null, true);

            if (mirror)
                bData = UBitmapData.mirror(bData);

            if (color)
                UBitmapData.colorize(bData, 0, 0, 0, Number(color >> 16), Number(color >> 8 & 0xFF), Number(color & 0xFF));

            _graphics[code] = new Bitmap(bData);

            return bData;
        }
    }
}