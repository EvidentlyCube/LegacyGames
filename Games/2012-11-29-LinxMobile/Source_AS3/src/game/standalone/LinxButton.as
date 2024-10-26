package game.standalone{
    import game.global.Make;
    import game.mobiles.MobileButton;
    
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    
    public class LinxButton extends MobileButton{
        
        public var textField:Text;
        public var grid9normal:Grid9;
        public var grid9lit:Grid9;
        
        public function set fontSize(value:int):void{
            _fontSize = value;
            resize();
        }
        
        private var _fontSize:int = 32;
        private var _staticWidth:Number = NaN;
        
        public function LinxButton(clickCallback:Function, text:String, staticWidth:Number = NaN){
            super(clickCallback, true);
            
            this._staticWidth = staticWidth;
            
            textField = Make().text(text, 0xFFFFFF, 32);
            grid9normal = Grid9.getGrid('buttonBG');
            grid9lit = Grid9.getGrid('buttonLitBG');
            
            data = {};
            
            data.txt = textField;
            data.grid9 = grid9normal;
            data.lit = grid9lit;
            
            textField.text = text;
            
            addChild(textField);
            addChildAt(grid9normal, 0);
            addChildAt(grid9lit, 1);
            
            grid9lit.visible = false;
            
            resize();
        }
        
        public function resize():void{
            textField.size = _fontSize * S().sizeScaler;
            
            textField.x = 16 * S().sizeScaler;
            textField.y = 2 * S().sizeScaler;
            textField.width = 1024;
            textField.fitSize();
            
            var width:Number = _staticWidth;
            
            if (isNaN(width)){
                width = textField.width + 32 * S().sizeScaler;
            } else {
                width *= S().sizeScaler;
                textField.alignCenterParent(0, width);
            }
            
            grid9normal.width  = width | 0;
            grid9normal.height = 50 * S().sizeScaler;
            
            grid9lit.width  = width | 0;
            grid9lit.height = 50 * S().sizeScaler;
            
            
            textField.y = (grid9normal.height - textField.textHeight) / 2 - 7 ;
        }
    }
}