package net.retrocade.tacticengine.monstro.ingame.achievements {
	import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
	import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
	import net.retrocade.retrocamel.locale._;
	import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
	import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroDisplayGroup;
	import net.retrocade.tacticengine.monstro.gui.render.MonstroStatsWindowGrid9;

	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.VAlign;

	public class AchievementGrowl extends Sprite{
		private static var _layer:RetrocamelLayerStarling;
		private static var _growls:Vector.<AchievementGrowl>;

		public static function showGrowl(achievement:Achievement):void {
			if (!_layer){
				_layer = new RetrocamelLayerStarling();
				_growls = new <AchievementGrowl>[];
				RetrocamelDisplayManager.onEnterFrame.add(update);
			}

			_growls.push(new AchievementGrowl(achievement));
		}

		private static function update():void {
			RetrocamelDisplayManager.moveLayerToFront(_layer)
			if (_growls.length > 0){
				var growl:AchievementGrowl = _growls[0];

				if (!growl.isStarted){
					growl.start();
				}

				_growls[0].update();

				if (_growls[0].isFinished){
					_growls[0].dispose();
					_growls.splice(0, 1);
				}
			}
		}

		private var _achievement:Achievement;
		private var _background:MonstroStatsWindowGrid9;
		private var _icon:AchievementImage;
		private var _message:TextField;

		private var _isStarted:Boolean = false;
		private var _isFinished:Boolean = false;
		private var _isHiding:Boolean = false;
		private var _timer:int = 120;

		public function AchievementGrowl(achievement:Achievement) {
			_achievement = achievement;
		}

		public function start():void {
			_isStarted = true;

			_layer.add(this);

			_background = new MonstroStatsWindowGrid9();
			_icon = MonstroGfx.createAchievementImage(_achievement);
			_message = new TextField(300, 100, _("achievement.unlocked", _("achievement.title_" + _achievement.index)), MonstroConsts.FONT_NATIVE, 12, 0xFFFFFF);
			_message.htmlText = true;

			var insidesGroup:MonstroDisplayGroup = new MonstroDisplayGroup();
			insidesGroup.addElement(_icon);
			insidesGroup.addElement(_message);

			_message.x = _icon.right + MonstroConsts.hudSpacer;
			_message.width = _message.textWidth + 10;
			_message.height = _icon.height;
			_message.vAlign = VAlign.CENTER;

			_background.wrapAround(insidesGroup);

			addChild(_background);
			addChild(_icon);
			addChild(_message);

			insidesGroup.dispose();

			alpha = 0;
		}

		override public function dispose():void {
			_layer.remove(this);

			removeChildren();

			_background.dispose();
			_icon.dispose();
			_message.dispose();

			super.dispose();
		}

		public function update():void {
			right = MonstroConsts.gameWidth - MonstroConsts.hudSpacer;
			bottom = MonstroConsts.gameHeight - MonstroConsts.hudSpacer;

			if (_isHiding){
				alpha -= 0.05;

				if (alpha <= 0){
					_isFinished = true;
				}
			} else {
				if (alpha <= 1){
					alpha += 0.05;
				}

				if (_timer-- <= 0){
					_isHiding = true;
				}
			}
		}

		public function get isStarted():Boolean {
			return _isStarted;
		}

		public function get isFinished():Boolean {
			return _isFinished;
		}
	}
}
