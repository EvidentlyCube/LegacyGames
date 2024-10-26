package net.retrocade.tacticengine.monstro.render {
import net.retrocade.tacticengine.core.Eventer;
import net.retrocade.tacticengine.core.IDestruct;
import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.data.MonstroAttackSimulation;
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;
import net.retrocade.tacticengine.monstro.events.MonstroEventResize;
import net.retrocade.utils.UNumber;
    import net.retrocade.utils.UString;

    import starling.display.Image;

    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.text.TextFieldBatch;
    import starling.utils.HAlign;

    public class MonstroHudAttackResults extends Sprite implements IDestruct{
        private static const COLOR_HP:uint = 0xFFDEDE;
        private static const COLOR_DAMAGE_DONE:uint = 0xFFAA66;
        private static const COLOR_ALL_DRAINED:uint = 0xFF0000;

        private var _bg:MonstroGrid9;

        private var _attackText:TextField;
        private var _hpText:TextField;
        private var _tapNotificationText:TextField;

        private var _isHidden:Boolean = false;

        public function MonstroHudAttackResults() {
            _bg = MonstroGfx.getGrid9Window();


            _attackText = new TextField(80, 30, "0", Monstro.FONT_MEDIUM, -1);
            _hpText = new TextField(130, 30, "0", Monstro.FONT_MEDIUM, -1);
            _tapNotificationText = new TextField(80 + 32 + Monstro.hudSpacer, 32, "Tap screen", Monstro.FONT_MEDIUM, 18);

            _attackText.color = 0xFFFFFF;
            _hpText.color = COLOR_HP;
            _tapNotificationText.color = 0xFFFFFF;

            _attackText.hAlign = HAlign.LEFT;
            _hpText.hAlign = HAlign.LEFT;
            _tapNotificationText.hAlign = HAlign.CENTER;

            addChild(_bg);
            addChild(_attackText);
            addChild(_hpText);
            addChild(_tapNotificationText);

            recalculate(false);

            Eventer.listen(MonstroEventResize.NAME, onResize);
        }

        public function setUnit(attacker:MonstroEntity, defender:MonstroEntity):void {
            var result:MonstroAttackSimulation = new MonstroAttackSimulation(attacker, defender);

            _attackText.customBatches = new <TextFieldBatch>[
                    new TextFieldBatch("ATK:"),
                    new TextFieldBatch(attacker.attack.toString(), 60, 0, 0x88FF88)
            ];
            _hpText.customBatches = new <TextFieldBatch>[
                    new TextFieldBatch("HP:"),
                    new TextFieldBatch(defender.hp.toString(), 60),
                    new TextFieldBatch("->", 20+60),
                    new TextFieldBatch(result.resultHP.toString(), 45+60, 0, textGetColor(result.resultHP, result.hpDamage))
            ];
        }

        public function recalculate(showTapNotification:Boolean):void {
            _attackText.x = Monstro.hudSpacer;
            _hpText.x = Monstro.hudSpacer;

            _attackText.y = Monstro.hudSpacer;
            _hpText.y = _attackText.bottom + Monstro.hudSpacer;

            _tapNotificationText.y = _hpText.bottom + Monstro.hudSpacer;
            _tapNotificationText.x = Monstro.hudSpacer;

            _tapNotificationText.visible = showTapNotification;

            _bg.width = _hpText.right + Monstro.hudSpacer;
            _bg.height = showTapNotification ? _tapNotificationText.y + _tapNotificationText.height + Monstro.hudSpacer : _hpText.bottom + Monstro.hudSpacer;
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

        public function update():void{
            reposition(false);
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

        private function onResize():void{
            reposition(true);
        }

        private function textGetColor(result:int, damage:int):uint{
            if (result == 0){
                return COLOR_ALL_DRAINED;
            } else if (damage > 0){
                return COLOR_DAMAGE_DONE;
            } else {
                return 0xFFFFFF;
            }
        }

        public function destruct():void{
            Eventer.release(MonstroEventResize.NAME, onResize);

            removeChildren();

            _bg.destruct();
            _bg = null;
            _attackText = null;
            _hpText = null;
            _tapNotificationText = null;
        }
    }
}