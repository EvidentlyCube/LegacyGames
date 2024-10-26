package com.mauft.preloaders{
    import flash.display.DisplayObject;
    import flash.display.LoaderInfo;

    public class PreloaderMask extends Preloader{
        
        private var maskObject    :DisplayObject;
        
        private var startX        :Number;
        private var startY        :Number;
        private var startWidth    :Number;
        private var startHeight   :Number;
        
        private var endX          :Number;
        private var endY          :Number;
        private var endWidth      :Number;
        private var endHeight     :Number;
        
        public function PreloaderMask(loaderInfo:LoaderInfo, finishCallback:Function=null, errorCallback:Function=null){
            super(loaderInfo, finishCallback, errorCallback);
        }
        
        override protected function update():void{
            maskObject.x      = startX      + (endX      - startX)      * _progress;
            maskObject.y      = startY      + (endY      - startY)      * _progress;
            
            maskObject.width  = startWidth  + (endWidth  - startWidth)  * _progress;
            maskObject.height = startHeight + (endHeight - startHeight) * _progress;
        }
        
        public function init(mask:DisplayObject, endX:Number, endY:Number, endWidth:Number, endHeight:Number):void{
            maskObject = mask;
            
            this.startX      = maskObject.x;
            this.startY      = maskObject.y;
            this.startWidth  = maskObject.width;
            this.startHeight = maskObject.height
            
            this.endX        = endX;
            this.endY        = endY;
            this.endWidth    = endWidth;
            this.endHeight   = endHeight;
        }
    }
}