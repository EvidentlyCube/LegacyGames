package net.retrocade.camel.layers{
    import flash.display.DisplayObject;

    public class rLayerFlash extends rLayer{
        public function get layer():DisplayObject{
            throw new TypeError("rLayerFlash::layer() has to be overriden");
        }
    }
}