
package net.retrocade.tacticengine.monstro.gui.helpers {
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityFactory;

    public class RendererHelper {
        public static function unitShakesWhenHit(name:String):Boolean{
            return name != MonstroEntityFactory.NAME_WALL_FAKE;
        }
    }
}
