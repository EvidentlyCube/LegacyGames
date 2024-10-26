package src.misc{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.display.Sprite;
    
    import src.PlatformerEngine.Scrolling;
    
    public class PaperForeground extends Sprite{
        public static var paperBitmapData:BitmapData;
        
        public static var paper0:Bitmap;
        public static var paper1:Bitmap;
        public static var paper2:Bitmap;
        public static var paper3:Bitmap;
        
        public static var isInit:Boolean = false;
        
        public function PaperForeground():void{
            if (!isInit){
                paperBitmapData = new _GFX_PAPER(500, 500);
                paper0 = new Bitmap(paperBitmapData);
                paper1 = new Bitmap(paperBitmapData);
                paper2 = new Bitmap(paperBitmapData);
                paper3 = new Bitmap(paperBitmapData);
            }
            
            this.blendMode = BlendMode.MULTIPLY;
            
            addChild(paper0);
            addChild(paper1);
            addChild(paper2);
            addChild(paper3);
            
            update();
        }
        
        public function update():void{
            if (parent){
                parent.setChildIndex(this, parent.numChildren - 1);
            }
            
            paper0.x = - ( (Scrolling.x + 2000) % 500 - 500 );
            paper0.y = - ( (Scrolling.y + 2000) % 500 - 500 );
            
            paper1.x = - ( (Scrolling.x + 2000) % 500);
            paper1.y = - ( (Scrolling.y + 2000) % 500 - 500 );
            
            paper2.x = - ( (Scrolling.x + 2000) % 500 - 500 );
            paper2.y = - ( (Scrolling.y + 2000) % 500);
            
            paper3.x = - ( (Scrolling.x + 2000) % 500);
            paper3.y = - ( (Scrolling.y + 2000) % 500);
        }
    }
}