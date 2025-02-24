
package net.retrocade.tacticengine.monstro.ingame.actions.subaction {
    import net.retrocade.retrocamel.display.starling.RetrocamelMovieClipStarling;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.global.enum.EnumFxType;

	import starling.display.BlendMode;

	import starling.display.DisplayObjectContainer;

    public class MonstroSubactionWeaponDamage implements IDisposable {
        private var _swingMovieClip:RetrocamelMovieClipStarling;

        public function MonstroSubactionWeaponDamage() {}

        public function init(centerX:int, centerY:int, type:EnumFxType, hookTo:DisplayObjectContainer):void{
            _swingMovieClip = MonstroGfx.getFxClip(type);
            _swingMovieClip.center = centerX;
            _swingMovieClip.middle = centerY;
            _swingMovieClip.isLooping = false;
			_swingMovieClip.blendMode = BlendMode.ADD;
            _swingMovieClip.play();

            hookTo.addChild(_swingMovieClip);
        }

        public function update(speed:Number = 1):Boolean {
            _swingMovieClip.advanceTime(speed * 50  / 3);
//            _poofMovieClip.alpha = 1 - (_poofMovieClip.currentTime - _poofMovieClip.frameDuration * 4) / (_poofMovieClip.totalTime - _poofMovieClip.frameDuration * 4);

            return _swingMovieClip.isPlaying;
        }

        public function dispose():void {
            _swingMovieClip.removeFromParent(true);
            _swingMovieClip = null;
        }

        public function get isPlaying():Boolean {
            return _swingMovieClip.isPlaying;
        }

        public function get currentFrame():int {
            return _swingMovieClip.currentFrame;
        }
    }
}
