
package net.retrocade.tacticengine.monstro.global.core {
	public class MonstroFunctions {
        /** Orientation from x and y **/
        public static function getOrientation(ox:int, oy:int):uint{
            if (ox > 0){
                return MonstroConsts.E;
            } else if (ox < 0){
                return MonstroConsts.W;
            }

            if (oy > 0){
                return MonstroConsts.S;
            } else if (oy < 0){
                return MonstroConsts.N;
            }

            return MonstroConsts.NO_ORIENTATION;
        }

        /** Orientation from x and y **/
        public static function getOrientationTowards(x1:int, y1:int, x2:int, y2:int):uint{
            return getOrientation(x2 - x1, y2 - y1);
        }

        /** X from orientation **/
        public static function getDeltaXFromOrientation(o:int):int{
            switch (o){
                case(MonstroConsts.E):
                    return 1;
                case(MonstroConsts.W):
                    return -1;
                default:
                    return 0;
            }
        }

        /** Y from orientation **/
        public static function getDeltaYFromOrientation(o:int):int{
            switch (o){
                case(MonstroConsts.S):
                    return 1;
                case(MonstroConsts.N):
                    return -1;
                default:
                    return 0;
            }
        }

        public static function nextOrientationCW(o:uint):uint{
            switch (o){
                case MonstroConsts.N:  return MonstroConsts.E;
                case MonstroConsts.E:  return MonstroConsts.S;
                case MonstroConsts.S:  return MonstroConsts.W;
                case MonstroConsts.W:  return MonstroConsts.N;
                default: return MonstroConsts.NO_ORIENTATION;
            }
        }

        /** Next counter clockwise orientation **/
        public static function nextOrientationCCW(o:uint):uint{
            switch (o){
                case MonstroConsts.N:  return MonstroConsts.W;
                case MonstroConsts.E:  return MonstroConsts.N;
                case MonstroConsts.S:  return MonstroConsts.E;
                case MonstroConsts.W:  return MonstroConsts.S;
                default: return MonstroConsts.NO_ORIENTATION;
            }
        }
    }
}
