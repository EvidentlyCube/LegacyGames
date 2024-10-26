package com.mauft{
    import flash.display.DisplayObject;
    import flash.filters.ColorMatrixFilter;
    
    public class ColorAdjuster{
        private var displayObject:DisplayObject;
        private var saturation   :Number;
        private var contrast     :Number;
        
        private var matrixArray  :Array;
        public function ColorAdjuster(displayObject:DisplayObject, saturation:Number = 1, contrast:Number = 1){
            this.displayObject = displayObject;
            this.saturation    = saturation;
            this.contrast      = contrast;
            
            matrixArray        = [ 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
            
            var filterArray:Array = displayObject.filters;
            
            filterArray.push( new ColorMatrixFilter(matrixArray) );
            
            displayObject.filters = filterArray;
        }
        
        public function setSaturation(n:Number):void{
            saturation = n;
            
            update();
        }
        
        public function setContrast(n:Number):void{
            contrast = n;
            
            update();
        }
        
        private function update():void{
            matrixArray[0]  = ((1.0-saturation)*0.3086 + saturation)*contrast;
            matrixArray[1]  =  (1.0-saturation)*0.6094*contrast;
            matrixArray[2]  =  (1.0-saturation)*0.0820*contrast;
          //matrixArray[3]  = 0;
            matrixArray[4]  = 63.5*(1 - contrast);
             
            matrixArray[5]  =  (1.0-saturation)*0.3086*contrast;
            matrixArray[6]  = ((1.0-saturation)*0.6094 + saturation)*contrast;
            matrixArray[7]  =  (1.0-saturation)*0.0820*contrast;
          //matrixArray[8]  = 0;
            matrixArray[9]  = 63.5*(1 - contrast);
            
            matrixArray[10] =  (1.0-saturation)*0.3086*contrast;
            matrixArray[11] =  (1.0-saturation)*0.6094*contrast;
            matrixArray[12] = ((1.0-saturation)*0.0820 + saturation)*contrast;
          //matrixArray[13] = 0;
            matrixArray[14] = 63.5*(1 - contrast);
            
            var filterArray:Array = displayObject.filters
            
            for each ( var f:ColorMatrixFilter in filterArray){
                f.matrix = matrixArray;
                break;
            }
            
            displayObject.filters = filterArray;
        }
    }
}