/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 16.03.13
 * Time: 10:35
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.render {
    import flash.events.Event;

    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.starling.rStarling;
    import net.retrocade.tacticengine.monstro.core.Monstro;

    import starling.text.TextField;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    public class MonstroBlinkingNag extends TextField{
        public static function get worksUntil():Date{
            return new Date(2013, 4, 1, 12, 0, 0, 0);
        }

        public static function get currentDate():Date{
            return new Date();
        }

        private var timer:int = 0;
        public function MonstroBlinkingNag() {
            super(500, 80, "Test version for Andrew Dorscht\n\"Monstro: Battle Tactics\" by Retrocade.net", Monstro.FONT_MEDIUM, 14, 0xFFFFFF);
            hAlign = HAlign.LEFT;
            vAlign = VAlign.TOP;

            rDisplay.flashApplication.addEventListener(Event.ENTER_FRAME, onStep);
            touchable = false;
        }

        private function onStep(e:Event):void{
            if (!parent){
                if (rStarling.starlingRoot){
                    rStarling.starlingRoot.addChild(this);
                }
                return;
            } else {
                parent.setChildIndex(this, parent.numChildren);

                timer++;

                if (timer >= 40){
                    timer = 0;
                    visible = !visible;
                }
            }


            if (currentDate.getTime() >= worksUntil.getTime()){
                killApp();
            }
        }

        private function killApp():void{
            while (rDisplay.flashApplication.numChildren > 0){
                rDisplay.flashApplication.removeChildAt(0);
            }

            if (rStarling.starlingInstance){
                rStarling.starlingInstance.dispose();
            }
        }
    }
}
