/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 30.03.13
 * Time: 13:32
 * To change this template use File | Settings | File Templates.
 */
package {
    import net.retrocade.tacticengine.monstro.core.*;
    import flash.display.Sprite;
    import flash.events.Event;

    import net.retrocade.camel.global.rCore;
    import net.retrocade.starling.rStarling;
    import net.retrocade.tacticengine.monstro.events.MonstroEventLoadLevel;
    import net.retrocade.tacticengine.monstro.events.MonstroEventResize;
    import net.retrocade.tacticengine.monstro.states.MonstroStateIngame;
    import net.retrocade.tacticengine.monstro.states.MonstroStateOutloader;
    import net.retrocade.tacticengine.monstro.states.MonstroStateTitle;

    [Frame(factoryClass="Preloader")]

    public class CoreStarter extends Sprite{
        public function CoreStarter() {
            CoreInit.init(this);
            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        public function onEnterFrame(e:Event):void{
            if (stage && rStarling.isInitialized){
                removeEventListener(Event.ENTER_FRAME, onEnterFrame);

                MonstroGfx.init();

                rStarling.starlingRoot.stage.addEventListener(Event.RESIZE, onResize);

                //rCore.setState(new MonstroStateIngame(true));
                //new MonstroEventLoadLevel(MonstroData.currentLevel.get());

                rCore.setState(new MonstroStateTitle());
                //rCore.setState(new MonstroStateOutloader());
            }
        }

        private function onResize(event:*):void{
            // rStarling.starlingInstance.viewPort.width = S().gameWidth;
            // rStarling.starlingInstance.viewPort.height = S().gameHeight;
            // rStarling.starlingRoot.stage.stageWidth = S().gameWidth;
            // rStarling.starlingRoot.stage.stageHeight = S().gameHeight;

            new MonstroEventResize();
        }
    }
}
