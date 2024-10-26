package net.retrocade.camel.easings {        
    public function exponentialIn(currentTime:Number, duration:Number):Number{
        return (currentTime * currentTime) / (duration * duration);
    }
}