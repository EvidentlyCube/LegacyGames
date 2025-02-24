

package net.retrocade.retrocamel.display.layers{
    import net.retrocade.retrocamel.core.retrocamel_int;
    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;

    import starling.display.DisplayObject;
    import starling.display.Sprite;

    use namespace retrocamel_int;

    public class RetrocamelLayerStarling extends RetrocamelLayer{

        retrocamel_int var _starlingSprite:Sprite;

        public function get layer():Sprite{
            return _starlingSprite;
        }

        public function RetrocamelLayerStarling(addAt:Number=-1){
            _starlingSprite = new Sprite();

            addLayer(addAt);
        }

        override public function get inputEnabled():Boolean{
            return layer.touchable;
        }

        override public function set inputEnabled(value:Boolean):void{
            layer.touchable = value;
        }

        override public function clear():void{
            _starlingSprite.removeChildren();
        }

        public function add(child:DisplayObject):void{
            _starlingSprite.addChild(child);
        }

        public function addAt(child:DisplayObject, index:int):void{
            _starlingSprite.addChildAt(child, index);
        }

        public function remove(child:DisplayObject):void{
            _starlingSprite.removeChild(child);
        }

        public function moveToFront():void{
            if (_starlingSprite.parent){
                _starlingSprite.parent.setChildIndex(_starlingSprite, _starlingSprite.parent.numChildren - 1);
            }
        }

        public function dispose():void{
            clear();
            removeLayer();
            _starlingSprite.dispose();
        }
    }
}