/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 26.01.13
 * Time: 22:47
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.render {
import net.retrocade.tacticengine.core.Eventer;
import net.retrocade.tacticengine.core.IDestruct;
import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
import net.retrocade.tacticengine.monstro.events.MonstroEventResize;
import net.retrocade.utils.UNumber;

    import starling.display.Image;

    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.utils.HAlign;

    public class MonstroHudStatsWindow extends Sprite implements IDestruct{

        private var _bg:MonstroGrid9;

        private var _healthText:TextField;
        private var _attackText:TextField;
        private var _movementText:TextField;

        private var _headerText:TextField;

        private var _isHidden:Boolean = false;

        public function MonstroHudStatsWindow() {
            const iconSpaceHorizontal:int = 32 + 50 + Monstro.hudSpacer * 2;
            const headerOffset:int = 32;

            _bg = MonstroGfx.getGrid9WindowHeader();

            _healthText = new TextField(70, 30, "7", Monstro.FONT_MEDIUM, -1, 0xFFFFFF);
            _movementText = new TextField(160, 30, "5", Monstro.FONT_MEDIUM, -1, 0xFFFFFF);
            _attackText = new TextField(90, 30, "3", Monstro.FONT_MEDIUM, -1, 0xFFFFFF);
            _headerText = new TextField(160, 30, "UnitName", Monstro.FONT_MEDIUM, -1, 0xFFFFFF);

            _healthText.hAlign = HAlign.LEFT;
            _attackText.hAlign = HAlign.LEFT;

            _healthText.x = Monstro.hudSpacer;
            _movementText.x = Monstro.hudSpacer;
            _attackText.x =  _healthText.right + Monstro.hudSpacer;

            _healthText.y = headerOffset;
            _movementText.y = _healthText.bottom + Monstro.hudSpacer;
            _attackText.y = headerOffset;

            _bg.width = _attackText.width + _attackText.x + Monstro.hudSpacer;
            _bg.height = _movementText.bottom + Monstro.hudSpacer + 2;

            _headerText.width = _bg.width;

            addChild(_bg);
            addChild(_healthText);
            addChild(_attackText);
            addChild(_movementText);
            addChild(_headerText);

            Eventer.listen(MonstroEventResize.NAME, onResize);
        }

        public function hide(immediately:Boolean = false):void{
            _isHidden = true;

            if (immediately){
                reposition(true);
            }
        }

        public function show(immediately:Boolean = false):void{
            _isHidden = false;

            if (immediately){
                reposition(true);
            }
        }

        public function setUnit(unit:MonstroEntity):void{
            _healthText.text = "HP: " + unit.hp.toString();
            _attackText.text = "ATK: " + unit.attack.toString();
            _movementText.text = "Move: " + unit.movesLeft.toString();

            _headerText.text = unit.prettyName;
        }

        public function update():void{
            reposition(false);
        }

        private function onResize():void{
            reposition(true);
        }

        private function reposition(immediately:Boolean = false):void{
            var toX:Number = (_isHidden ? Monstro.gameWidth + Monstro.hudSpacer : Monstro.gameWidth - Monstro.hudSpacer - _bg.width);

            if (immediately){
                x = toX;
            } else {
                x = UNumber.approach(x, toX, 0.3, 2, 30);
            }

            visible = x < Monstro.gameWidth;
        }

        public function destruct():void{
            Eventer.release(MonstroEventResize.NAME, onResize);
        }
    }
}
