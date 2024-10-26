package net.retrocade.camel.easings {        
    public function exponentialOut(currentTime:Number, duration:Number):Number{
        //return Math.sqrt(currentTime / duration);
        return 1 + Math.log(currentTime / duration) / 2
    }
}