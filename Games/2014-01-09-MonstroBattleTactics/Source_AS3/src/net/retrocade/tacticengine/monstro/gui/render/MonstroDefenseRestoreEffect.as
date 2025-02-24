package net.retrocade.tacticengine.monstro.gui.render
{
	import net.retrocade.retrocamel.display.starling.RetrocamelMovieClipStarling;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;

	import starling.display.BlendMode;

	import starling.textures.TextureSmoothing;

	public class MonstroDefenseRestoreEffect extends RetrocamelMovieClipStarling
	{
		public function MonstroDefenseRestoreEffect(parent:MonstroUnitClip)
		{
			super(MonstroGfx.getDefenseRecoveryFrames(), 8);

			//alpha = 0.7;
			isLooping = false;

			smoothing = TextureSmoothing.NONE;

			center = parent.unitImage.center - 3;
			bottom = parent.unitImage.bottom + 15;

			if (parent.unitImage.scaleX < 0){
				x -= parent.unitImage.width;
			}
		}

		public function update():Boolean{
			advanceTime(1000/30);

			alpha = calculatedAlpha;

			if (!isPlaying) {
				parent.removeChild(this);
				dispose();
				return true;
			}

			return false;
		}

		private function get calculatedAlpha():Number {
			var threshold:Number = 8;

			if (currentFrame < threshold){
				return currentFrame / threshold;
			} else if (currentFrame > numFrames - threshold){
				return 1 - (currentFrame - numFrames + threshold) / threshold;
			} else {
				return 1;
			}
		}
	}
}
