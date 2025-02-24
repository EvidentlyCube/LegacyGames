
package net.retrocade.tacticengine.monstro.gui.render {
    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;
    import net.retrocade.retrocamel.display.starling.RetrocamelMovieClipStarling;

    import starling.textures.Texture;

    public class MonstroTileClip extends RetrocamelMovieClipStarling implements IRetrocamelUpdatable{
        private var _speedOffset:Number = 0;
        private var _speedLimit:Number = 10;

        public function MonstroTileClip(animationTextures:Vector.<Texture>){
            super(animationTextures, 1);

            stop();

            smoothing = "none";
        }

        override public function advanceTime(passedTime:Number):void{
            _speedOffset += 1;

            if (_speedOffset > _speedLimit){
                currentFrame++;
                _speedOffset -= _speedLimit;
                if (_currentFrame == 0){
                    _speedOffset -= _speedLimit * 2;
                }
            }
        }

        public function update():void {
            advanceTime(50 / 3);
        }
    }
}
