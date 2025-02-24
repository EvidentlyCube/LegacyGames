
package net.retrocade.tacticengine.monstro.ingame.actions {
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.IEvent;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventScrollTo;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTap;
    import net.retrocade.utils.UtilsNumber;

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
            var event:IEvent = new MonstroEventScrollTo(_scrollToX, _scrollToY, 0.2);

            return !event.isDefaultPrevented;
        }
    }
}
