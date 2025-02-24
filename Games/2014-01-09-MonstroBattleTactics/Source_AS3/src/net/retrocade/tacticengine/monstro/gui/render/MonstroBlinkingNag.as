
package net.retrocade.tacticengine.monstro.gui.render {
    import flash.events.Event;

    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
    import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;

    import starling.text.TextField;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    public class MonstroBlinkingNag extends TextField{
        public static function get worksUntil():Date{
            return new Date(2014, 10, 15, 12, 0, 0, 0);
        }

        public static function get currentDate():Date{
            return new Date();
        }

        private var timer:int = 0;
        public function MonstroBlinkingNag(text:String) {
            super(500, 80, text, MonstroConsts.FONT_EBORACUM_48, 12, 0xFFFFFF);
            hAlign = HAlign.LEFT;
            vAlign = VAlign.TOP;

            RetrocamelDisplayManager.flashApplication.addEventListener(Event.ENTER_FRAME, onStep);
            touchable = false;
        }

        private function onStep(e:Event):void{
            if (!parent){
                if (RetrocamelStarlingCore.starlingRoot){
                    RetrocamelStarlingCore.starlingRoot.addChild(this);
                }
                return;
            } else {
                parent.setChildIndex(this, parent.numChildren);


                if (timer < 40){
                    timer++;
                } else if (alpha > 0){
                    alpha -= 0.05;
                } else {
                    visible = false;
                    timer++;
                }

                if (timer >= 200){
                    timer = 0;
                    alpha = 1;
                    visible = true;
                }
            }


            if (currentDate.getTime() >= worksUntil.getTime()){
                killApp();
            }
        }

        private function killApp():void{
            while (RetrocamelDisplayManager.flashApplication.numChildren > 0){
                RetrocamelDisplayManager.flashApplication.removeChildAt(0);
            }

            if (RetrocamelStarlingCore.starlingInstance){
                RetrocamelStarlingCore.starlingInstance.dispose();
            }
        }
    }
}
