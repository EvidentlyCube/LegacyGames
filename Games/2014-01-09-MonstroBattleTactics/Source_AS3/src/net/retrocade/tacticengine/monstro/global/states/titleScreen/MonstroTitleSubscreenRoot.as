
package net.retrocade.tacticengine.monstro.global.states.titleScreen {
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.gui.helpers.WindowSliderCounter;
    import net.retrocade.tacticengine.monstro.gui.render.MonstroTextButton;

    import starling.display.Sprite;

    public class MonstroTitleSubscreenRoot extends Sprite implements IDisposable {
        public var callback:Function;

        protected var _sliderCounter:WindowSliderCounter;

        public function MonstroTitleSubscreenRoot(position:Number = 1.2) {
            super();

            _sliderCounter = new WindowSliderCounter(position);
            _sliderCounter.onStartHiding.add(makeUntouchable);
            _sliderCounter.onFinishedShowing.add(makeTouchable);

            makeUntouchable();
        }

        public function update():void {
            if (_sliderCounter.update()) {
                refreshPosition();

                if (isFullyHidden) {
                    visible = false;
                }
            }
        }

        protected function refreshPosition():void {
            var calculatedPosition:Number = _sliderCounter.positionFactor;
            center = MonstroConsts.gameWidth / 2 + calculatedPosition * (MonstroConsts.gameWidth / 2 + width);
            alignMiddle();
        }

        public function hide():void {
            _sliderCounter.hide();
        }

        public function show():void {
            _sliderCounter.show();

            visible = true;

            if (_sliderCounter.position === 1) {
                _sliderCounter.position = 1.2;
            }
        }

        public function get isFullyHidden():Boolean {
            return _sliderCounter.isFullyHidden;
        }

        public function resized():void {
            refreshPosition();
        }

        override public function dispose():void {
            _sliderCounter.dispose();
            _sliderCounter = null;

            callback = null;

            super.dispose();
        }

        public function makeTouchable():void {
            touchable = true;
        }

        public function makeUntouchable():void {
            touchable = false;
        }

        protected function onClick(data:MonstroTextButton):void {
            hide();

            if (callback != null) {
                if (callback.length != 1) {
                    throw new ArgumentError("Callback must take one parameter");
                } else {
                    callback(data);
                }
            }
        }
    }
}
