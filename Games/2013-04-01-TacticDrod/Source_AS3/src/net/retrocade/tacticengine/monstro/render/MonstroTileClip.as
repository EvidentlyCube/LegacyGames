/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 30.01.13
 * Time: 22:06
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.render {
    import net.retrocade.starling.rStarlingMovieClip;

    import starling.textures.Texture;

    public class MonstroTileClip extends rStarlingMovieClip{
        private var _speedOffset:Number = 0;
        private var _speedLimit:Number = 10;
        public function MonstroTileClip(animationTextures:Vector.<Texture>){
            super(animationTextures, 1);

            stop();

            smoothing = "none";
        }

        override public function advanceTime(passedTime:Number):void{
            _speedOffset++;

            if (_speedOffset > _speedLimit){
                currentFrame++;
                _speedOffset -= _speedLimit;
                if (_currentFrame == 0){
                    _speedOffset -= _speedLimit * 2;
                }
            }
        }
    }
}
