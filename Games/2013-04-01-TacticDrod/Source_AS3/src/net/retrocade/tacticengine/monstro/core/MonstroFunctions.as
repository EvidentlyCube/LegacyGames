/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 28.03.13
 * Time: 11:41
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.core {
    import net.retrocade.tacticengine.monstro.entities.MonstroEntityFactory;

    public class MonstroFunctions {
        /** Orientation from x and y **/
        public static function getOrientation(ox:int, oy:int):uint{
            if (ox > 1){
                ox = 1;
            } else if (ox < -1){
                ox = -1;
            }

            if (oy > 1){
                oy = 1;
            } else if (oy < -1){
                oy = -1;
            }

            return ((oy + 1) * 3) + (ox + 1);
        }

        /** Orientation from x and y **/
        public static function getOrientationTowards(x1:int, y1:int, x2:int, y2:int):uint{
            return getOrientation(x2 - x1, y2 - y1);
        }

        /** X from orientation **/
        public static function getDeltaXFromOrientation(o:int):int{
            return (o % 3) - 1;
        }

        /** Y from orientation **/
        public static function getDeltaYFromOrientation(o:int):int{
            return ((o / 3) | 0) - 1;
        }

        public static function unitIsHuman(unitName:String):Boolean{
            return unitName == MonstroEntityFactory.NAME_BEETHRO || unitName == MonstroEntityFactory.NAME_CITIZEN
                || unitName == MonstroEntityFactory.NAME_STALWART;
        }

        public static function nextOrientationCW(o:uint):uint{
            switch (o){
                case MonstroConst.NW: case MonstroConst.N:  return o+1;
                case MonstroConst.NE: case MonstroConst.E:  return o+3;
                case MonstroConst.S:  case MonstroConst.SE: return o-1;
                case MonstroConst.W:  case MonstroConst.SW: return o-3;
                default: return MonstroConst.NO_ORIENTATION;
            }
        }

        /** Next counter clockwise orientation **/
        public static function nextOrientationCCW(o:uint):uint{
            switch (o){
                case MonstroConst.NW: case MonstroConst.W:  return o+3;
                case MonstroConst.E:  case MonstroConst.SE: return o-3;
                case MonstroConst.SW: case MonstroConst.S:  return o+1;
                case MonstroConst.N:  case MonstroConst.NE: return o-1;
                default: return MonstroConst.NO_ORIENTATION;
            }
        }
    }
}
