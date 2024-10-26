package game.objects {
	import flash.display.BitmapData;

	import game.global.Game;
	import game.global.Level;
	import game.global.Score;
	import game.global.Sfx;
	import game.tiles.TTile;

	import net.retrocade.helpers.RetrocamelScrollAssist;
	import net.retrocade.retrocamel.core.RetrocamelBitmapManager;
	import net.retrocade.retrocamel.core.RetrocamelInputManager;
	import net.retrocade.retrocamel.core.RetrocamelSoundManager;
	import net.retrocade.retrocamel.effects.RetrocamelEffectFadeScreen;
	import net.retrocade.retrocamel.effects.RetrocamelEffectMusicFade;
	import net.retrocade.retrocamel.effects.RetrocamelEffectQuake;
	import net.retrocade.utils.UtilsNumber;

	public class TPlayer extends TGameObject {
		public static var lastPlayer:TPlayer;
		public static var cheatGuard: Boolean = false;

		private var _colorID:uint = uint.MAX_VALUE; //1 - Red, 2 - Blue, 3 - Green, 4 - Yellow
		public function get colorID():uint {
			return _colorID;
		}

		public function set colorID(id:uint):void {
			if (id === _colorID)
				return;

			if (_gfx)
				blow(_gfx);

			_colorID = id;
			if (id == 1)
				_gfx = _gfxRed;
			else if (id == 2)
				_gfx = _gfxBlue;
			else if (id == 3)
				_gfx = _gfxGreen;
			else if (id == 4)
				_gfx = _gfxYellow;
			else if (id == 5)
				_gfx = _gfxBlack;
			else if (id == 6)
				_gfx = _gfxWhite;

		}

		private var _gfxRed:BitmapData;
		private var _gfxBlue:BitmapData;
		private var _gfxGreen:BitmapData;
		private var _gfxYellow:BitmapData;
		private var _gfxBlack:BitmapData;
		private var _gfxWhite:BitmapData;

		private var spd:Number = 2;
		private var dir:Number = 1;

		private const SPD_X:Number = 1.5;
		private const SPD_Y_MAX:Number = 4;
		private const SPD_Y_MIN:Number = 0.50;
		private const SPD_Y_ACC:Number = 0.125;

		private var blockHit:Boolean = false;

		public var started:Boolean = false;

		public function forceStop(): void {
			spd = 0;
		}

		public function TPlayer(x:int, y:int, color:uint) {
			Level.player = this;

			_gfxRed = RetrocamelBitmapManager.getBDExt(Game._general_, 96, 224, 16, 16);
			_gfxBlue = RetrocamelBitmapManager.getBDExt(Game._general_, 112, 224, 16, 16);
			_gfxGreen = RetrocamelBitmapManager.getBDExt(Game._general_, 128, 224, 16, 16);
			_gfxYellow = RetrocamelBitmapManager.getBDExt(Game._general_, 144, 224, 16, 16);
			_gfxBlack = RetrocamelBitmapManager.getBDExt(Game._general_, 128, 208, 16, 16);
			_gfxWhite = RetrocamelBitmapManager.getBDExt(Game._general_, 144, 208, 16, 16);

			_width = 12;
			_height = 12;

			_x = x + 3;
			_y = y + 3;

			colorID = color;
			Game.partPixel.clear();

			addAtDefault(0);

			Score.multiplier.set(1);

			lastPlayer = this;
		}

		override public function update():void {
			if (!started) {
				if (RetrocamelInputManager.isKeyHit(Game.keyAccelerate) || RetrocamelInputManager.isKeyHit(Game.keyDecelerate) ||
					RetrocamelInputManager.isKeyHit(Game.keyLeft) || RetrocamelInputManager.isKeyHit(Game.keyRight)) {
					started = true;

				} else {
					RetrocamelScrollAssist.instance.scrollTo(_x, _y);
					RetrocamelScrollAssist.instance.update();
					Game.lGame.scrollX = -RetrocamelScrollAssist.x;
					Game.lGame.scrollY = -RetrocamelScrollAssist.y;
					Game.lBG.scrollX = -RetrocamelScrollAssist.x;
					Game.lBG.scrollY = -RetrocamelScrollAssist.y;
					Game.lPart.scrollX = -RetrocamelScrollAssist.x;
					Game.lPart.scrollY = -RetrocamelScrollAssist.y;
					return;
				}
			}

			if (Score.multiplier.get() > 1)
				Score.multiplier.add(-0.0025);

			// Manipulate speed
			if (RetrocamelInputManager.isKeyDown(Game.keyAccelerate) && spd < SPD_Y_MAX) {
				spd += SPD_Y_ACC;
			}

			if (RetrocamelInputManager.isKeyDown(Game.keyDecelerate) && spd > SPD_Y_MIN) {
				spd -= SPD_Y_ACC;
			}


			// Horizontal movement
			var tile:TTile
			if (RetrocamelInputManager.isKeyDown(Game.keyLeft)) {
				x -= SPD_X;
				if (checkCollision(180)) {
					if (!blockHit)
						burstParticles(x, middle, 0);
					blockHit = true;
				} else {
					blockHit = false;
				}
			} else if (RetrocamelInputManager.isKeyDown(Game.keyRight)) {
				x += SPD_X;
				if (checkCollision(0)) {
					if (!blockHit)
						burstParticles(right, middle, 180);
					blockHit = true;
				} else {
					blockHit = false;
				}
			}

			if (dir == 1) {
				y += spd * dir;
				if (checkCollision(90)) {
					dir *= -1;
					burstParticles(center, bottom, -90);
				}

			} else if (dir == -1) {
				y += spd * dir;
				if (checkCollision(-90)) {
					dir *= -1;
					burstParticles(center, y, 90);
				}
			}

			RetrocamelScrollAssist.instance.scrollTo(_x, _y);
			RetrocamelScrollAssist.instance.update();
			Game.lGame.scrollX = -RetrocamelScrollAssist.x;
			Game.lGame.scrollY = -RetrocamelScrollAssist.y;
			Game.lBG.scrollX = -RetrocamelScrollAssist.x;
			Game.lBG.scrollY = -RetrocamelScrollAssist.y;
			Game.lPart.scrollX = -RetrocamelScrollAssist.x;
			Game.lPart.scrollY = -RetrocamelScrollAssist.y;
		}

		override public function draw():void {
			Game.lGame.draw(_gfx, x - 2, y - 2);

			if (!started) {
				Game.lGame.shapeRect(x, y + 13, 12, 1);
				Game.lGame.shapeRect(x + 1, y + 14, 10, 1);
				Game.lGame.shapeRect(x + 2, y + 15, 8, 1);
				Game.lGame.shapeRect(x + 3, y + 16, 6, 1);
				Game.lGame.shapeRect(x + 4, y + 17, 4, 1);
				Game.lGame.shapeRect(x + 5, y + 18, 2, 1);
			}
		}

		private function checkCollision(dir:Number):Boolean {
			var tile1:TTile, tile2:TTile, func:String;
			switch (dir) {
				case(0):
					tile1 = getTile(right, y);
					tile2 = getTile(right, bottom);
					func = "hitLeft";
					break;
				case(90):
					if ((center / 16 | 0) * 16 - x > (right / 16 | 0) * 16 - center) {
						tile1 = getTile(x, bottom);
						tile2 = getTile(right, bottom);
					} else {
						tile2 = getTile(x, bottom);
						tile1 = getTile(right, bottom);
					}
					func = "hitTop";
					break;
				case(180):
					tile1 = getTile(x, y);
					tile2 = getTile(x, bottom);
					func = "hitRight";
					break;
				case(-90):
					if ((center / 16 | 0) * 16 - x > (right / 16 | 0) * 16 - center) {
						tile1 = getTile(x, y);
						tile2 = getTile(right, y);
					} else {
						tile2 = getTile(x, y);
						tile1 = getTile(right, y);
					}
					func = "hitBottom";
					break;

			}

			var ret:Boolean = false;
			if (tile1) {
				ret = tile1[func](this);

			}

			if (tile2 && tile2 != tile1) {
				ret = tile2[func](this) || ret;
			}

			return ret;
		}

		private function burstParticles(x:Number, y:Number, dir:Number):void {
			var i:int = 2 + Math.random() * 4 | 0;
			var color:uint = (colorID == 1 ? 0xFFFF0000 : colorID == 2 ? 0xFF0000FF : colorID == 3 ? 0xFF00FF00 : 0xFFFFFF00);
			Sfx.sfxPlayerBounce.play();

			var scrollX:Number = 0;
			var scrollY:Number = 0;

			while (i--) {
				var _dir:Number = UtilsNumber.randomWaved(dir, 45) * Math.PI / 180;
				var _spd:Number = UtilsNumber.randomWaved(100, 80);
				Game.partPixel.add(x + scrollX, y + scrollY, color, UtilsNumber.randomWaved(20, 15), Math.cos(_dir) * _spd, Math.sin(_dir) * _spd);
			}
		}

		public function kill():void {
			if (cheatGuard) {
				return;
			}

			Sfx.sfxDeath.play();

			var scrollX:Number = 0;
			var scrollY:Number = 0;

			for (var i:Number = 0; i < _width; i += 0.5) {
				for (var j:Number = 0; j < _height; j += 0.5) {
					Game.partPixel.add(_x + i + scrollX, _y + j + scrollY, _gfx.getPixel32(i, j),
						Math.min(UtilsNumber.randomWaved(85, 20), UtilsNumber.randomWaved(85, 20), UtilsNumber.randomWaved(85, 20)),
						150 * Math.random() / (i - 5), 150 * Math.random() / (j - 5));
				}
			}

			RetrocamelEffectQuake.make().power(20, 20).duration(1200).callback(onKillQuakeFinished).run();
			active = false;

			RetrocamelSoundManager.stopMusic();

			Level.player = null;

			nullifyDefault();

			Score.lives.add(-1);
		}

		public function exitEntered():BitmapData {
			Level.player = null;
			nullifyDefault();
			active = false;
			RetrocamelEffectMusicFade.make(0).duration(500).callback(RetrocamelSoundManager.stopMusic).run();
			return _gfx;
		}

		private function blow(bd:BitmapData):void {
			var scrollX:Number = -RetrocamelScrollAssist.x;
			var scrollY:Number = -RetrocamelScrollAssist.y;

			for (var i:uint = 0; i < _width; i++) {
				for (var j:uint = 0; j < _height; j++) {
					Game.partPixel.add(_x + i + scrollX, _y + j + scrollY, bd.getPixel32(i, j),
						Math.min(UtilsNumber.randomWaved(15, 14), UtilsNumber.randomWaved(15, 14), UtilsNumber.randomWaved(15, 14)),
						200 * Math.random() / (i - 5), 200 * Math.random() / (j - 5));
				}
			}
		}

		private function onKillQuakeFinished():void {
			if (Score.lives.get() == 0)
				Level.gameOver();
			else
				RetrocamelEffectFadeScreen.makeOut().duration(500).callback(onKillFadeFinished).run();
		}

		private function onKillFadeFinished():void {
			Level.restartLevel();
		}

	}
}