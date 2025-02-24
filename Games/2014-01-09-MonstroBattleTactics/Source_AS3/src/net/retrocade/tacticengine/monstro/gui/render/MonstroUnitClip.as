
package net.retrocade.tacticengine.monstro.gui.render {
    import net.retrocade.retrocamel.interfaces.IRetrocamelUpdatable;
    import net.retrocade.retrocamel.display.starling.RetrocamelMovieClipStarling;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntity;
    import net.retrocade.tacticengine.monstro.ingame.entities.MonstroEntityStatistics;

    import starling.display.Image;
    import starling.display.Sprite;
	import starling.extensions.lighting.lights.PointLight;
	import starling.filters.ColorMatrixFilter;
    import starling.textures.Texture;
    import starling.textures.TextureSmoothing;

    public class MonstroUnitClip extends Sprite implements IRetrocamelUpdatable {
		public static const LIGHT_BRIGHTNESS:Number = 1;
        private static var _colorMatrixFilter:ColorMatrixFilter = new ColorMatrixFilter();

        public var isGhost:Boolean = false;
        public var isSpeeding:Boolean = false;
        private var _stoppedTexture:Texture;
        private var _disabledTexture:Texture;
        private var _destroyedTexture:Texture;
        private var _speedingOffset:int;
        private var _speedingTime:int = 3;
        private var _isMirrored:Boolean = false;
        private var _isDisabled:Boolean = false;
        private var _isDestroyed:Boolean = false;
        private var _stun:RetrocamelMovieClipStarling;
        private var _image:RetrocamelMovieClipStarling;
        private var _specialtyIcons:Vector.<Image>;
		private var _light:PointLight;
		private var _defenseRestoreEffect:MonstroDefenseRestoreEffect;

        private var _healthDefenseIcons:Vector.<Image>;
        private var _isUnitBlinking:Boolean;
        private var _blinkTimer:int = 0;

		private var _isOptimizingLight:Boolean = false;

        private var _isAlwaysAnimated:Boolean = false;

        public var isAlwaysHiddenUnder:Boolean = false;
		public var emitsLight:Boolean = false;

        public function MonstroUnitClip(
                animationTextures:Vector.<Texture>,
                stoppedTexture:Texture,
                disabledTexture:Texture,
                destroyedTexture:Texture,
                fps:Number,
                offsetX:int,
                offsetY:int
        ){
            super();

            _image = new RetrocamelMovieClipStarling(animationTextures, fps);
            _image.smoothing = "none";
            _image.x = offsetX;
            _image.y = offsetY;

			_light = new PointLight(0, 0, 90, 0xFFFFC0, 1);

            addChild(_image);

            _stoppedTexture = stoppedTexture;
            _disabledTexture = disabledTexture;
            _destroyedTexture = destroyedTexture;

            _healthDefenseIcons = new Vector.<Image>();

            stop();
        }

		public function addDefenseRestoreEffect():void{
			_defenseRestoreEffect = new MonstroDefenseRestoreEffect(this);
			addChild(_defenseRestoreEffect);
		}

        public function addSpecialtyIcon(texture:Texture):void {
            var icon:Image = new Image(texture);
            icon.smoothing = TextureSmoothing.NONE;

            if (!_specialtyIcons) {
                _specialtyIcons = new Vector.<Image>();
            }

            addChild(icon);
            _specialtyIcons.push(icon);

            var l:int = _specialtyIcons.length;
            var offset:int = 0;

            for (var i:int = 0; i < l; i++) {
                icon = _specialtyIcons[i];

                icon.bottom = MonstroConsts.tileHeight - 6;
                icon.x = offset;

                offset += (icon.width + 1) / 2 | 0;
            }

            if (_specialtyIcons.length > 1) {
                _specialtyIcons[1].moveToFront();
            }
            if (_specialtyIcons.length > 2) {
                _specialtyIcons[2].moveToFront();
            }
        }

        public function setStats(unit:MonstroEntity):void{
			var unitStats:MonstroEntityStatistics = unit.getStatistics();

            for each(var image:Image in _healthDefenseIcons){
                removeChild(image);
                image.dispose();
            }

            _healthDefenseIcons.length = 0;

            if (unitStats.hp == 0){
				_light.brightness = 0;
                return;
            } else {
				_light.brightness = _light.brightness = _isOptimizingLight ? 0 : LIGHT_BRIGHTNESS;
			}

			if (_stun){
				_stun.moveToFront();
			}

			if (unitStats.isDamaged()) {
				updateUnitHpDefenseDisplay(unitStats);
			}
        }

		private function updateUnitHpDefenseDisplay(unitStats:MonstroEntityStatistics):void{
			var hpBar:Image;
			var defBar:Image;

			const HAS_DEFENSE:Boolean = unitStats.defense > 0;
			const TOP:int = _image.absoluteY;

			hpBar = MonstroGfx.getHealthBar(unitStats.hp);
			hpBar.smoothing = TextureSmoothing.NONE;
			addChild(hpBar);

			_healthDefenseIcons.push(hpBar);
			hpBar.alignCenterParent(0, MonstroConsts.tileWidth);
			if (HAS_DEFENSE) {
				defBar = MonstroGfx.getDefenseBar(unitStats.defense);
				defBar.smoothing = TextureSmoothing.NONE;
				addChild(defBar);

				_healthDefenseIcons.push(defBar);
				defBar.alignCenterParent(0, MonstroConsts.tileWidth);

				defBar.bottom = TOP;
				hpBar.bottom = defBar.y + 1;
				defBar.moveToFront();
				hpBar.moveToFront();
			} else {
				hpBar.bottom = TOP;
				hpBar.moveToFront();
			}
		}

		public function play():void {
			updateForcedTexture();

			if (!_isDisabled){
				_image.play();
			}
		}

		public function stop():void {
            if (!_isAlwaysAnimated){
                _image.stop();
                updateForcedTexture();
            }
        }

        public function update():void {
			if (_defenseRestoreEffect){
				if (_defenseRestoreEffect.update()){
					_defenseRestoreEffect = null;
				}
			}

            if (_isUnitBlinking && !isGhost){
                _blinkTimer = (_blinkTimer + 1) % 40;

                _colorMatrixFilter.reset();
                _colorMatrixFilter.adjustBrightness(0.5 - _blinkTimer / 80);

                _image.filter = _colorMatrixFilter;
            }

            if (isSpeeding) {
                if (--_speedingOffset <= 0) {
                    _image.currentFrame++;
                    _speedingOffset = _speedingTime;
                }

            } else {
                _image.advanceTime(50 / 3);
            }

            if (_stun) {
                _stun.advanceTime(50 / 3);
            }
        }

        public function get mirror():Boolean {
            return _isMirrored;
        }

        public function set mirror(value:Boolean):void {
            if (_isMirrored != value) {
                _isMirrored = value;

                var oldX:int = x;

                if (value) {
                    _image.scaleX = -1;
                    _image.x += _image.width;
                } else {
                    _image.scaleX = 1;
                    _image.x -= _image.width;
                }

                x = oldX;
            }
        }

        public function get disabled():Boolean {
            return _isDisabled;
        }

        public function set disabled(value:Boolean):void {
            if (_isDisabled != value) {
                _isDisabled = value;

                if (value) {
                    stop();
                }

                updateForcedTexture();
            }
        }

        public function get isStunned():Boolean {
            return _stun != null;
        }

        public function set isStunned(value:Boolean):void {
            if (isStunned != value) {
                if (value) {
                    _stun = MonstroGfx.getStunClip();
                    _stun.center = MonstroConsts.tileWidth / 2;
                    _stun.middle = _image.y;
                    addChild(_stun);
                } else {
                    removeChild(_stun);
                    _stun.dispose();
                    _stun = null;
                }
            }
        }

        public function get isPlaying():Boolean {
            return _image.isPlaying;
        }

        public function get isDestroyed():Boolean {
            return _isDestroyed;
        }

        public function set isDestroyed(value:Boolean):void {
            if (_isDestroyed != value){
                _isDestroyed = value;
                updateForcedTexture();
            }
        }

        private function updateForcedTexture():void{
            var textureTo:Texture;

            if (_isDestroyed){
                textureTo = _destroyedTexture;
            } else if (_isDisabled){
                textureTo = _disabledTexture;
            } else if (!isPlaying){
                textureTo = _stoppedTexture;
            } else {
                textureTo = _image.getFrameTexture(0);
            }

            if (textureTo && !_isAlwaysAnimated){
                _image.stop();
                _image.texture = textureTo;
            }
        }

        public function set isAlwaysAnimated(value:Boolean):void {
            if (value != _isAlwaysAnimated){
                _isAlwaysAnimated = value;
                if (_isAlwaysAnimated){
                    play();
                }
            }
        }

        public function clone():MonstroUnitClip{
            var cacheMirrored:Boolean = this.mirror;
            mirror = false;

            var newClip:MonstroUnitClip = new MonstroUnitClip(
                    _image.textures,
                    _stoppedTexture,
                    _disabledTexture,
                    _destroyedTexture,
                    _image.fps,
                    _image.x,
                    _image.y
            );
            newClip.isAlwaysHiddenUnder = isAlwaysHiddenUnder;
            newClip.isAlwaysAnimated = _isAlwaysAnimated;
            mirror = cacheMirrored;

            newClip.x = x;
            newClip.y = y;
            newClip.mirror = this.mirror;

            return newClip;

        }

        public function set isUnitBlinking(value:Boolean):void {
            if (value != _isUnitBlinking){
                _isUnitBlinking = value;
                _blinkTimer = 0;

                if (!_isUnitBlinking){
                    _image.filter = null;
                }
            }
        }

        public function set color(value:uint):void{
            _image.color = value;
        }


		public function get light():PointLight
		{
			return _light;
		}


		override public function set x(value:Number):void
		{
			super.x = value;

			if (_image.scaleX < 0){
				_light.x = value + _image.x - _image.width / 2;
			} else {
				_light.x = value + _image.x + _image.width / 2;
			}
		}

		override public function set y(value:Number):void
		{
			super.y = value;

			_light.y = value + _image.y + _image.height / 2;
		}

		public function get unitImage():Image{
			return _image;
		}

		public function get isOptimizingLight():Boolean {
			return _isOptimizingLight;
		}

		public function set isOptimizingLight(value:Boolean):void {
			_isOptimizingLight = value;

			_light.brightness = _isOptimizingLight ? 0 : LIGHT_BRIGHTNESS;
		}


		public function get hasDeadTexture():Boolean {
		 	return _destroyedTexture !== null;
		}
	}
}
