/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 06.04.13
 * Time: 19:12
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.undo {
    import net.retrocade.tacticengine.monstro.render.MonstroUnitClip;

    import starling.display.Image;

    public class UndoBitUnitClip implements IUndoBit{
        private var _unitClip:MonstroUnitClip;

        private var _x:int;
        private var _y:int;
        private var _direction:int;
        private var _visible:Boolean;
        private var _alpha:Number;
        private var _disabled:Boolean;

        public function UndoBitUnitClip(unitClip:MonstroUnitClip){
            _unitClip = unitClip;

            _x = _unitClip.x;
            _y = _unitClip.y;
            _direction = _unitClip.direction;
            _visible = _unitClip.visible;
            _alpha = _unitClip.alpha;
            _disabled = _unitClip.disabled;
        }

        public function undo():void {
            _unitClip.x = _x;
            _unitClip.y = _y;
            _unitClip.direction = _direction;
            _unitClip.visible = _visible;
            _unitClip.alpha = _alpha;
            _unitClip.disabled = _disabled;
        }

        public function destruct():void {
            _unitClip = null;
        }
    }
}
