package net.retrocade.tacticengine.monstro.gui.render {

    import flash.display.DisplayObject;

    import net.retrocade.random.IRandomEngine;
    import net.retrocade.random.Random;
    import net.retrocade.random.RandomEngineType;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.core.IDisposable;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.global.enum.EnumTileset;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventResize;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventTilesetChanged;
    import net.retrocade.utils.UtilsNumber;

    import starling.display.Image;

    import starling.utils.Color;

    public class MonstroBackgroundManager implements IDisposable{
        public static const CLOUD_LIMIT:uint = 20;

        private var _scrollDirection:Number;
        private var _directionDeviation:Number;
        private var _scrollSpeed:Number;
        private var _speedDeviation:Number;

        private var _scrollDirectionWait:uint;
        private var _directionDeviationWait:uint;
        private var _scrollSpeedWait:uint;
        private var _speedDeviationWait:uint;

        private var _scrollDirectionTo:Number;
        private var _directionDeviationTo:Number;
        private var _scrollSpeedTo:Number;
        private var _speedDeviationTo:Number;

        private var _scrollDirectionChange:Number;
        private var _directionDeviationChange:Number;
        private var _scrollSpeedChange:Number;
        private var _speedDeviationChange:Number;

        private var _backgroundBottom:MonstroBackground;

        private var _targetColorClouds:uint = 0;
        private var _targetColorBottom:uint = 0;

        private var _random:IRandomEngine;

        private var _backgroundLayer:RetrocamelLayerStarling;
        private var _clouds:Vector.<MonstroCloudImage>;

        private var _lastScreenWidth:uint;
        private var _lastScreenHeight:uint;

        private var _approachCloudLayer:Boolean = false;

        public function MonstroBackgroundManager(){
            _random = Random.createEngine(RandomEngineType.KISS);

            _scrollSpeed = 2;

            _scrollDirection = _random.getNumberRange(0, Math.PI * 2);
            _scrollDirectionWait = 0;
            _scrollDirectionTo = _scrollDirection;
            _scrollDirectionChange = 1;

            _directionDeviation = _random.getNumberRange(Math.PI * -0.2, Math.PI * 0.2);
            _directionDeviationWait = 0;
            _directionDeviationTo = _directionDeviation;
            _directionDeviationChange = 1;

            _scrollSpeed = _random.getNumberRange(0.3, 2);
            _scrollSpeedWait = 0;
            _scrollSpeedTo = _scrollSpeed;
            _scrollSpeedChange = 1;

            _speedDeviation = _random.getNumberRange(0, 0.5);
            _speedDeviationWait = 0;
            _speedDeviationTo = _speedDeviation;
            _speedDeviationChange = 1;

            Eventer.listen(MonstroEventTilesetChanged.NAME, onTilesetChanged, this);
            Eventer.listen(MonstroEventResize.NAME, onResize, this);

            _clouds = new Vector.<MonstroCloudImage>();

            _lastScreenWidth = MonstroConsts.gameWidth;
            _lastScreenHeight= MonstroConsts.gameHeight;
        }

		public function dispose():void{
			Eventer.releaseContext(this);

			if (_backgroundBottom){
				_backgroundBottom.removeFromParent();
				_backgroundBottom.dispose();
				_backgroundBottom = null;
			}

			for each(var cloud:MonstroCloudImage in _clouds){
				cloud.dispose();
			}

			_clouds.length = 0;
			_clouds = null;
		}

        public function setBackgrounds(bottomBackground:MonstroBackground):void{
            _backgroundBottom = bottomBackground;
        }

        public function setBackgroundLayer(layer:RetrocamelLayerStarling):void{
            _backgroundLayer = layer;

            if (_backgroundBottom){
                _backgroundLayer.add(_backgroundBottom);
            }

            createClouds();
        }

        public function createClouds():void{
            while (_clouds.length < CLOUD_LIMIT){
                var cloud:Image = MonstroGfx.getBackgroundCloud(_clouds.length % 5);
                cloud.x = _random.getNumberRange(-cloud.width, MonstroConsts.gameWidth);
                cloud.y = _random.getNumberRange(-cloud.height, MonstroConsts.gameHeight);

                _backgroundLayer.add(cloud);
                _clouds.push(cloud);
            }
        }

        public function update():void{
            if (_scrollDirectionWait == 0){
                if (_scrollDirectionTo != _scrollDirection){
                    _scrollDirection = UtilsNumber.approach(_scrollDirection, _scrollDirectionTo,
                            _scrollDirectionChange, 0.05, _scrollDirectionChange)
                } else {
                    _scrollDirectionWait = _random.getUintRange(1, 3600);
                    _scrollDirectionTo = _scrollDirection + _random.getNumberRange(-Math.PI, 0);
                    _scrollDirectionChange = _random.getNumberRange(0.003, 0.01);
                }
            } else {
                _scrollDirectionWait--;
            }

            if (_directionDeviationWait == 0){
                if (_directionDeviationTo != _directionDeviation){
                    _directionDeviation = UtilsNumber.approach(_directionDeviation, _directionDeviationTo,
                            _directionDeviationChange, 0.05, _directionDeviationChange)
                } else {
                    _scrollDirectionWait = _random.getUintRange(1, 3600);
                    _directionDeviationTo = _random.getNumberRange(-0.2 * Math.PI, 0);
                    _directionDeviationChange = _random.getNumberRange(0.003, 0.01);
                }
            } else {
                _directionDeviationWait--;
            }

            if (_scrollSpeedWait == 0){
                if (_scrollSpeedTo != _scrollSpeed){
                    _scrollSpeed = UtilsNumber.approach(_scrollSpeed, _scrollSpeedTo,
                            _scrollSpeedChange, 0.05, _scrollSpeedChange)
                } else {
                    _scrollSpeedWait = _random.getUintRange(1, 3600);
                    _scrollSpeedTo = _random.getNumberRange(0.3, 2);
                    _scrollSpeedChange = _random.getNumberRange(0.003, 0.01);
                }
            } else {
                _scrollSpeedWait--;
            }

            if (_speedDeviationWait == 0){
                if (_speedDeviationTo != _scrollSpeed){
                    _speedDeviation = UtilsNumber.approach(_speedDeviation, _speedDeviationTo,
                            _speedDeviationChange, 0.05, _speedDeviationChange)
                } else {
                    _speedDeviationWait = _random.getUintRange(1, 3600);
                    _speedDeviationTo = _random.getNumberRange(0, 0.5);
                    _speedDeviationChange = _random.getNumberRange(0.003, 0.01);
                }
            } else {
                _scrollSpeedWait--;
            }

            _backgroundBottom.x += Math.cos(_scrollDirection) * _scrollSpeed * 512;
            _backgroundBottom.y += Math.sin(_scrollDirection) * _scrollSpeed * 512;

            for each(var cloud:MonstroCloudImage in _clouds){
                if (cloud.edgeSleep > 0){
                    cloud.edgeSleep--;
                    continue;
                }

                cloud.x -= Math.cos(_scrollDirection + _directionDeviation + cloud.angleFraction) * (_scrollSpeed + _speedDeviation) * cloud.speedFraction * 0.5;
                cloud.y -= Math.sin(_scrollDirection + _directionDeviation + cloud.angleFraction) * (_scrollSpeed + _speedDeviation) * cloud.speedFraction * 0.5;

                if (cloud.x < -cloud.width - 10){
                    cloud.x += MonstroConsts.gameWidth + cloud.width;
                    cloud.y = _random.getNumberRange(-cloud.height, MonstroConsts.gameHeight);
                    cloud.rerollCloud();
                }

                if (cloud.x > MonstroConsts.gameWidth + 10){
                    cloud.x -= MonstroConsts.gameWidth + cloud.width;
                    cloud.y = _random.getNumberRange(-cloud.height, MonstroConsts.gameHeight);
                    cloud.rerollCloud();
                }

                if (cloud.y < -cloud.height - 10){
                    cloud.y += MonstroConsts.gameHeight + cloud.height;
                    cloud.x = _random.getNumberRange(-cloud.width, MonstroConsts.gameWidth);
                    cloud.rerollCloud();
                }

                if (cloud.y > MonstroConsts.gameHeight + 10){
                    cloud.y -= MonstroConsts.gameHeight + cloud.height;
                    cloud.x = _random.getNumberRange(-cloud.width, MonstroConsts.gameWidth);
                    cloud.rerollCloud();
                }
            }

            if (_targetColorBottom !== _backgroundBottom.color){
                _backgroundBottom.color = Color.approachColor(_backgroundBottom.color, _targetColorBottom, 1);
            }

            if (_approachCloudLayer){
                for each(cloud in _clouds){
                    cloud.color = Color.approachColor(cloud.color, _targetColorClouds, 1);

                    if (cloud.color === _targetColorClouds){
                        _approachCloudLayer = false;
                    }
                }
            }
        }

        private function onTilesetChanged(event:MonstroEventTilesetChanged):void{
            var colorToClouds:uint;
            var colorToBottom:uint;

            switch(event.tileset){
                case(EnumTileset.GREENLAND):
                    colorToBottom = 0xFFFFFF;
                    colorToClouds = 0xFFFFFF;
                    break;
                case(EnumTileset.LAVA):
                    colorToBottom = 0xFF4422;
                    colorToClouds = 0xFF5626;
                    break;
                case(EnumTileset.ICE):
                    colorToBottom = 0xFFFF82;
                    colorToClouds = 0xFFFFA6;
                    break;
            }

            if (_targetColorBottom == 0){
                _backgroundBottom.color = colorToBottom;
            }

            if (_targetColorClouds == 0){
                for each(var cloud:Image in _clouds){
                    cloud.color = colorToClouds;
                }
            }

            _approachCloudLayer = true;

            _targetColorBottom = colorToBottom;
            _targetColorClouds = colorToClouds;
        }

        private function onResize():void{
            for each(var cloud:MonstroCloudImage in _clouds){
                var oldFactorX:Number = cloud.x / _lastScreenWidth;
                var oldFactorY:Number = cloud.y / _lastScreenHeight;

                cloud.x = MonstroConsts.gameWidth * oldFactorX;
                cloud.y = MonstroConsts.gameHeight * oldFactorY;
            }

            _lastScreenWidth = MonstroConsts.gameWidth;
            _lastScreenHeight = MonstroConsts.gameHeight;
        }
    }
}
