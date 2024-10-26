package game.global{
    import starling.display.Sprite;
    
    public class LinxBoardSprite extends Sprite{
        public function LinxBoardSprite(){
            super();
        }
        
        override public function get width():Number{
            return S().tileGridWidth * S().tileWidth * S().gameScale;
        }
        
        override public function get height():Number{
            return S().tileGridHeight * S().tileHeight * S().gameScale;
        }
    }
}