package net.retrocade.tacticengine.monstro.ingame.actions{
    import net.retrocade.tacticengine.monstro.global.core.MonstroGameplayDefinition;
    import net.retrocade.tacticengine.monstro.global.core.SmartTouch;

    import starling.display.DisplayObject;

    import starling.filters.ColorMatrixFilter;
    import starling.filters.FragmentFilter;

    public class MonstroActionTrapWebActivated extends MonstroAction{
        [Inject]
        public var gameplayDefinition:MonstroGameplayDefinition;

        private static var _filter:ColorMatrixFilter = new ColorMatrixFilter();
        private var _unitGraphic:DisplayObject;
        private var _counter:int;

        private var _previousUnitFilter:FragmentFilter;

        public function MonstroActionTrapWebActivated(){
            super(null);
        }

        public function init(unitGraphic:DisplayObject):void{
            _unitGraphic = unitGraphic;
            _counter = 80;
            _previousUnitFilter = _unitGraphic.filter;
        }

        final override public function update():Boolean{
            _filter.reset();
            _filter.adjustBrightness(_counter / 80);

            _unitGraphic.filter = _filter;

            _counter -= animationSpeed;

            return _counter <= 0;
        }

        private function get animationSpeed():Number{
            if (SmartTouch.isRightButtonDown){
                return 10;
            } else {
                return Math.max(1, gameplayDefinition.gameSpeed * 8);
            }
        }

        override public function dispose():void {
            super.dispose();

            _unitGraphic.filter = _previousUnitFilter;
            _unitGraphic = null;
        }
    }
}