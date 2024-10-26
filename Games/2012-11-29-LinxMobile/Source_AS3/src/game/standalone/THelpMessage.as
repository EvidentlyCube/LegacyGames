package game.standalone {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TouchEvent;
    
    import game.global.Game;
    import game.global.Make;
    import game.objects.THud;
    
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.objects.rBitmap;
    import net.retrocade.camel.objects.rSprite;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UGraphic;
    
    /**
     * /assets.
     * @author 
     */
    public class THelpMessage extends rSprite {        
		public static var instance:THelpMessage;
			
        private var _txt:Text;
        private var _icon:rBitmap;

        public function THelpMessage(text:String) {
			instance = this;
			
            _icon = rGfx.getB(Game._button_restart);
            _icon.smoothing = true;
            _icon.width     = 40;
            _icon.height    = 40;
            
            _txt       = Make().text("");
            _txt.text  = text;
            _txt.size  = 32 * S().sizeScaler;
            _txt.textAlignCenter();
            _txt.multiline = true;
            _txt.wordWrap = true;
            _txt.lineSpacing = 8 * S().sizeScaler;
            
            
            //addChild(_txt);
            //addChild(_icon);
            
            Game.lMain.add(this);
            
            //addEventListener(MouseEvent.CLICK, onClick);
            //addEventListener(TouchEvent.TOUCH_BEGIN, onClick);
            
            buttonMode = true;
            
            stage.addEventListener(Event.RESIZE, reposition, false, 0, true);
            reposition();
        }
        
        private function reposition(e:Event = null):void{
            graphics.clear();
            return;
            if (Main.isLandscape()){
                _txt.width = S().gameWidth - 50;
                _txt.y     = 30 * S().sizeScaler;
                _txt.alignCenter();
                
                UGraphic.draw(graphics).beginFill(0, 0.65).drawRect(0, 0, S().gameWidth, _txt.height + 60 * S().sizeScaler);
                _icon.right = S().gameWidth - 5
                _icon.y =  _txt.y - 5 + (10 + _txt.height - _icon.height) / 2;
                
                
                //alignMiddleParent(0, S().realTileHeight * S().tileGridHeight);
                bottom = S().gameHeight;
            } else {
                _txt.width = S().gameWidth - 50;
                _txt.alignCenter();
                _txt.y = 30 * S().sizeScaler;
                
                UGraphic.draw(graphics).beginFill(0, 0.65).drawRect(0, 0, S().gameWidth, _txt.height + 60 * S().sizeScaler);
                _icon.right = S().gameWidth - 5
                _icon.y =  _txt.y - 5 + (10 + _txt.height - _icon.height) / 2;
                //alignMiddleParent(0, S().realTileHeight * S().tileGridHeight);
                
                bottom = S().tileGridHeight * S().realTileHeight;
            }
            
            
        }
		
		public function kill():void{
			if (parent)
				parent.removeChild(this);
			
			removeEventListener(MouseEvent.CLICK, onClick);
			removeEventListener(TouchEvent.TOUCH_BEGIN, onClick);
		}
        
        private function onClick(e:Event):void{
            e.preventDefault();
            e.stopImmediatePropagation();
            e.stopPropagation();
            
            removeEventListener(MouseEvent.CLICK, onClick);
            removeEventListener(TouchEvent.TOUCH_BEGIN, onClick);
            
            new rEffFade(this, 1, 0, 500, onFadedOut);
        }
        
        private function onFadedOut():void{
			instance = null;
			
            if (parent)
                parent.removeChild(this);
        }
    }
}