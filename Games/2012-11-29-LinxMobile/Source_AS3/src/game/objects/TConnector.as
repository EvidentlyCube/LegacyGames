package game.objects{
    import starling.textures.Texture;

    public class TConnector extends TGameObject{
        protected var _color:uint = 0;
        
        public var allConnected:Boolean = false;
        protected var _gfx:*;
        
        public function TConnector(texture:Texture, tileX:int, tileY:int){
            super(texture, tileX, tileY);
        }
        
        public function get tileColor():uint{
            return _color;
        }
        
        public function colorMatches(tileColor:uint):Boolean{
            return this.tileColor == tileColor;
        }
        
        public function resetGfx():void{}
        
        public function redrawTransparent():void{}
        
        
        override public function dispose():void{
            if (parent)
                parent.removeChild(this);
            
            super.dispose();
        }
    }
}