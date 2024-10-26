/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 16.02.13
 * Time: 22:28
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.actions {
    import net.retrocade.camel.layers.rLayerStarling;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.IEvent;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.events.MonstroEventScrollTo;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTap;
    import net.retrocade.utils.UNumber;

    import starling.display.Image;

    import starling.text.TextField;

    public class MonstroActionScrollTo extends MonstroAction{
        private var _scrollToX:int;
        private var _scrollToY:int;

        public function MonstroActionScrollTo(tileX:int, tileY:int) {
            super(null);

            _scrollToX = tileX;
            _scrollToY = tileY;
        }

        override public function update():Boolean{
            var event:IEvent = new MonstroEventScrollTo(
                    (_scrollToX + 0.5) * Monstro.tileWidth,
                    (_scrollToY + 0.5) * Monstro.tileHeight,
                    0.2
            );

            return !event.isDefaultPrevented;
        }
    }
}
