package submuncher.ingame.renderers.general {
    import starling.display.DisplayObjectContainer;
    import starling.display.Image;

    import submuncher.core.constants.Gfx;

    /** This custom display objects renders a regular, n-sided polygon. */
    public class RegularBackgroundRenderer extends DisplayObjectContainer {
        private var _leftHalf:Image;
        private var _rightHalf:Image;

        private var _frame:uint;
        private var _frameWaiter:uint;

        public function RegularBackgroundRenderer() {
            _leftHalf = new Image(Gfx.getBackgroundFrameA(0));
            _rightHalf = new Image(Gfx.getBackgroundFrameA(0));
            _rightHalf.x = _leftHalf.width;

            addChild(_leftHalf);
            addChild(_rightHalf);
        }

        public function update():void {
            if (_frameWaiter > 0){
                _frameWaiter--;
            } else {
                _frameWaiter = 3;
                _frame = (_frame + 1) % 40;
                _leftHalf.texture = _rightHalf.texture = Gfx.getBackgroundFrameA(_frame);
            }
        }
    }
}