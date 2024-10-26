package net.retrocade.camel.layers{
    import flash.display.DisplayObject;
    
    import net.retrocade.camel.global.retrocamel_int;
    import net.retrocade.starling.rStarling;
    
    import starling.display.DisplayObject;
    import starling.display.Sprite;

    use namespace retrocamel_int;
    
    public class rLayerStarling extends rLayer{
        
        retrocamel_int var _starlingSprite:Sprite;
        
        public function get starlingSprite():Sprite{
            return _starlingSprite;
        }
        
        override public function get displayObject():flash.display.DisplayObject{
            return null;
        }
        
        public function rLayerStarling(addAt:Number=-1, spriteClass:Class = null){
            super(NaN);
            
            _starlingSprite = (spriteClass ? new spriteClass() : new Sprite());
            
            if (!isNaN(addAt)){
                if (addAt == -1)
                    rStarling._starlingRoot.addChild(_starlingSprite);
                else
                    rStarling._starlingRoot.addChildAt(_starlingSprite, addAt);
            }
        }
        
        public function set alpha(value:Number):void{
            _starlingSprite.alpha = value;
        }
        
        public function get alpha():Number{
            return _starlingSprite.alpha;
        }
        
        override public function clear():void{
            _starlingSprite.removeChildren();
        }
        
        public function addChild(child:starling.display.DisplayObject):void{
            _starlingSprite.addChild(child);
        }
        
        public function addChildAt(child:starling.display.DisplayObject, index:int):void{
            _starlingSprite.addChildAt(child, index);
        }
        
        public function removeChild(child:starling.display.DisplayObject):void{
            _starlingSprite.removeChild(child);
        }
        
        public function getChildAt(index:int):starling.display.DisplayObject{
            return _starlingSprite.getChildAt(index);
        }
        
        public function numChildren():int{
            return _starlingSprite.numChildren;
        }
    }
}