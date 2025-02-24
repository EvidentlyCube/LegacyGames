package net.retrocade.tacticengine.monstro.ingame.achievements {
	import net.retrocade.signal.Signal;

	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class AchievementImage extends Image{

		private var _achievement:Achievement;

		private var _onMouseOver:Signal;
		private var _onMouseOut:Signal;

		public function AchievementImage(achievement:Achievement, texture:Texture) {
			super(texture);

			_achievement = achievement;

			_onMouseOver = new Signal();
			_onMouseOut = new Signal();

			addEventListener(TouchEvent.TOUCH, onTouch);
		}


		override public function dispose():void {
			removeEventListener(TouchEvent.TOUCH, onTouch);

			_onMouseOver.clear();
			_onMouseOut.clear();

			_onMouseOver = null;
			_onMouseOut = null;

			super.dispose();
		}

		protected function onTouch(e:TouchEvent):void {
			var touch:Touch = e.getTouch(this);

			if (!touch) {
				_onMouseOut.call(this);
			} else if (touch.phase == TouchPhase.HOVER) {
				_onMouseOver.call(this);
			} else if (touch.phase == TouchPhase.BEGAN) {
				if (CF::enableCheats){
					AchievementGrowl.showGrowl(_achievement);
				}
			}
		}

		public function get onMouseOver():Signal {
			return _onMouseOver;
		}

		public function get onMouseOut():Signal {
			return _onMouseOut;
		}

		public function get achievement():Achievement {
			return _achievement;
		}
	}
}
