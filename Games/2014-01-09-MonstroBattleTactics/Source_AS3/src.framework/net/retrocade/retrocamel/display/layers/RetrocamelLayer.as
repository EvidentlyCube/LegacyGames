

package net.retrocade.retrocamel.display.layers{
    import flash.display.DisplayObject;
    import flash.display.Sprite;

    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;

    public class RetrocamelLayer{
        public function clear():void{
            throw new TypeError("rLayer::clear() has to be overriden");
        }

        protected function addLayer(addAt:Number):void{
            if (!isNaN(addAt)){
                if (addAt == -1){
                    RetrocamelDisplayManager.addLayer(this);
                } else {
                    RetrocamelDisplayManager.addLayerAt(this, addAt);
                }
            }
        }

        public function removeLayer():void{
            RetrocamelDisplayManager.removeLayer(this);
        }

        public function set inputEnabled(value:Boolean):void{
            throw new TypeError("rLayer::(set)inputEnabled() has to be overriden");
        }

        public function get inputEnabled():Boolean{
            throw new TypeError("rLayer::(get)inputEnabled() has to be overriden");
        }
    }
}