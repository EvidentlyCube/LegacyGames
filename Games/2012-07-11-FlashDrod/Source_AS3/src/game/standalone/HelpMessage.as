package game.standalone {
	import flash.display.Sprite;
	
	import game.global.Game;
	import game.global.Make;
	
	import net.retrocade.standalone.Bitext;
	import net.retrocade.standalone.Text;
	import net.retrocade.utils.UGraphic;
	
	/**
     * ...
     * @author 
     */
    public class HelpMessage extends Sprite {        
        private var _txt:Bitext;
        private var _icon:Bitext;
        public function HelpMessage(text:String) {
            _icon = Make.text("?", 0xFFFFFF, 2);
            _icon.x = 5;
            
            _txt       = Make.text("");
            _txt.align = Bitext.ALIGN_MIDDLE;
            _txt.text  = text;
            _txt.y     = S.SIZE_GAME_HEIGHT - _txt.height - 5;
            
            
            addChild(_txt);
            addChild(_icon);
            
            UGraphic.draw(graphics).beginFill(0, 0.75).drawRect(0, _txt.y - 5, S.SIZE_GAME_WIDTH, _txt.height + 10);
            
            _icon.y =  _txt.y - 5 + (10 + _txt.height - _icon.height) / 2;
            
            _txt.positionToCenter();
            
            Game.lMain.add2(this);
        }
    }
}