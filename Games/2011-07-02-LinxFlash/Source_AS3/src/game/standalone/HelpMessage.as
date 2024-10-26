package game.standalone {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import game.global.Game;
    import game.global.Make;

    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rTooltip;
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
            _icon = Make().text("?", 0xFFFFFF, 2);
            _icon.x = 5;

            _txt       = Make().text("");
            _txt.align = Bitext.ALIGN_MIDDLE;
            _txt.text  = text;
            _txt.y     = S().gameHeight - _txt.height - 5;


            addChild(_txt);
            addChild(_icon);

            UGraphic.draw(graphics).beginFill(0, 0.5).drawRect(0, _txt.y - 5, S().gameWidth, _txt.height + 10);

            _icon.y =  _txt.y - 5 + (10 + _txt.height - _icon.height) / 2;

            _txt.positionToCenter();

            Game.lMain.add2(this);

            addEventListener(Event.ENTER_FRAME, step, false, 0, true);
            addEventListener(MouseEvent.CLICK, onClick);

            rTooltip.hook(this, "CLICK TO DISMISS");

            buttonMode = true;
        }

        private function step(e:Event):void{
            if (!parent)
                removeEventListener(Event.ENTER_FRAME, step);
        }

        private function onClick(e:Event):void{
            parent.removeChild(this);
            rTooltip.hide();
        }
    }
}