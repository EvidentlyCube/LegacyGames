
package net.retrocade.tacticengine.monstro.ingame.actions.subaction {
    import net.retrocade.retrocamel.display.starling.RetrocamelMovieClipStarling;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;

    import starling.display.DisplayObjectContainer;

    public class MonstroSubactionPoof implements IDisposable {
        public static const TYPE_WHITE:String = "white";
        public static const TYPE_RED:String = "red";

        public static function isValidType(type:String):Boolean {
            return type == TYPE_WHITE || type == TYPE_RED;
        }

        private var _poofMovieClip:RetrocamelMovieClipStarling;

        public function MonstroSubactionPoof() {}

        public function init(centerX:int, centerY:int, type:String, hookTo:DisplayObjectContainer):void{
            if (!isValidType(type)) {
                throw new ArgumentError("Invalid poof type give: " + type);
            }


            _poofMovieClip = MonstroGfx.getPoofClip();
            _poofMovieClip.center = centerX;
            _poofMovieClip.middle = centerY;
            _poofMovieClip.isLooping = false;
            _poofMovieClip.play();

            if (type == TYPE_RED){
                _poofMovieClip.color = 0xFF6666;
            }

            hookTo.addChild(_poofMovieClip);
        }

        public function update(speed:Number = 1):Boolean {
            _poofMovieClip.advanceTime(speed * 50  / 3);
            _poofMovieClip.alpha = 1 - (_poofMovieClip.currentTime - _poofMovieClip.frameDuration * 4) / (_poofMovieClip.totalTime - _poofMovieClip.frameDuration * 4);

            return _poofMovieClip.isPlaying;
        }

        public function dispose():void {
            _poofMovieClip.removeFromParent(true);
            _poofMovieClip = null;
        }

        public function get isPlaying():Boolean {
            return _poofMovieClip.isPlaying;
        }

        public function get currentFrame():int {
            return _poofMovieClip.currentFrame;
        }
    }
}
