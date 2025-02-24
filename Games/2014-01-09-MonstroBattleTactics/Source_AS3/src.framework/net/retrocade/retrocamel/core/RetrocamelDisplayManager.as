

package net.retrocade.retrocamel.core{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
    import flash.events.EventDispatcher;

    import net.retrocade.retrocamel.display.global.RetrocamelTooltip;

    import net.retrocade.retrocamel.events.RetrocamelEvent;

    import net.retrocade.retrocamel.display.layers.RetrocamelLayer;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlash;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
	import net.retrocade.retrocamel.core.RetrocamelStarlingCore;
	import net.retrocade.signal.Signal;

	import starling.display.Stage;

    use namespace retrocamel_int;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class RetrocamelDisplayManager{
        private static const _eventDispatcher:EventDispatcher = new EventDispatcher();
        retrocamel_int static var _starlingStage:starling.display.Stage;
        retrocamel_int static var _flashStage:flash.display.Stage;

        retrocamel_int static var _starlingLayers:Vector.<RetrocamelLayerStarling>;
        retrocamel_int static var _flashLayers:Vector.<RetrocamelLayerFlash>;

        private static var _offsetX:Number = 0;
        private static var _offsetY:Number = 0;

        private static var _scaleX:Number = 1;
        private static var _scaleY:Number = 1;

        retrocamel_int static var _tooltip:RetrocamelTooltip;

        retrocamel_int static var _smoothing:Boolean;

		public static var onStageResized:Signal = new Signal();
		public static var onEnterFrame:Signal = new Signal();
		public static var onFullScreenToggled:Signal = new Signal();

        public static function get starlingStage():starling.display.Stage{
            return _starlingStage;
        }

        public static function get flashStage():flash.display.Stage{
            return _flashStage;
        }


        /**
         * Shortcut to the instance of the main application
         */
        retrocamel_int static var _flashApplication:DisplayObjectContainer;

        public static function get flashApplication():DisplayObjectContainer{
            return _flashApplication;
        }

        retrocamel_int static function initializeFlash(main:DisplayObjectContainer, stage:flash.display.Stage):void{
            _flashStage    = stage;
            _flashApplication = main;

            _starlingLayers = new Vector.<RetrocamelLayerStarling>();
            _flashLayers = new Vector.<RetrocamelLayerFlash>();

			_flashStage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			_flashStage.addEventListener(Event.RESIZE, stageResizeHandler, false, -999);
        }

        retrocamel_int static function initializeStarling(stage:starling.display.Stage):void{
            _starlingStage = stage;
        }


        /**
         * Adds layer to the game display
         * @param layer Layer to be added
         */
        public static function addLayer(layer:RetrocamelLayer):void{
            if (layer is RetrocamelLayerFlash){
                addLayerAt(layer, _flashApplication.numChildren);
            } else if (layer is RetrocamelLayerStarling){
                addLayerAt(layer, RetrocamelStarlingCore._starlingRoot.numChildren);
            }
        }

        /**
         * Adds layer to the game display
         * @param layer Layer to be added
         * @param index Index at which the layer should be added
         */
        public static function addLayerAt(layer:RetrocamelLayer, index:int = 0):void{
            if (layer is RetrocamelLayerFlash){
                _flashApplication.addChildAt(RetrocamelLayerFlash(layer).layer, index);
                _flashLayers.push(layer as RetrocamelLayerFlash);
            } else if (layer is RetrocamelLayerStarling){
                RetrocamelStarlingCore._starlingRoot.addChildAt(RetrocamelLayerStarling(layer).layer, index);
                _starlingLayers.push(layer as RetrocamelLayerStarling);
            }

            RetrocamelWindowsManager.pushLayersToFront();

            if (_tooltip){
                _flashApplication.setChildIndex(_tooltip, _flashApplication.numChildren - 1);
            }
        }

        /**
         * Removes layer from the display
         * @param layer Layer to be removed from the game's display
         */
        public static function removeLayer(layer:RetrocamelLayer):void{
            if (layer is RetrocamelLayerFlash){
                _flashApplication.removeChild(RetrocamelLayerFlash(layer).layer);
            } else if (layer is RetrocamelLayerStarling){
                RetrocamelStarlingCore._starlingRoot.removeChild(RetrocamelLayerStarling(layer).layer);
            }
        }

        public static function moveLayerToFront(layer:RetrocamelLayer):void{
            if (layer is RetrocamelLayerFlash){
                _flashApplication.setChildIndex(RetrocamelLayerFlash(layer).layer, _flashApplication.numChildren - 1);
            } else if (layer is RetrocamelLayerStarling){
                RetrocamelStarlingCore._starlingRoot.setChildIndex(RetrocamelLayerStarling(layer).layer, RetrocamelStarlingCore._starlingRoot.numChildren - 1);
            }
        }

        /**
         * Blocks all input on the game layers, primarily used by rWindows
         */
        retrocamel_int static function block():void {
            for each(var flashLayer:RetrocamelLayerFlash in _flashLayers){
                flashLayer.inputEnabled = false;
            }

            for each(var starlingLayer:RetrocamelLayerStarling in _starlingLayers){
                starlingLayer.inputEnabled = false;
            }
        }

        /**
         * Enables the input on the game layers, primarily used by rWindows
         */
        retrocamel_int static function unblock():void {
            for each(var flashLayer:RetrocamelLayerFlash in _flashLayers){
                flashLayer.inputEnabled = true;
            }

            for each(var starlingLayer:RetrocamelLayerStarling in _starlingLayers){
                starlingLayer.inputEnabled = true;
            }
        }

        public static function setOffset(x:Number, y:Number):void{
            _offsetX = x;
            _offsetY = y;

            _flashApplication.x = _offsetX;
            _flashApplication.y = _offsetY;
        }

        public static function setScale(scaleX:Number, scaleY:Number):void{
            _scaleX = scaleX;
            _scaleY = scaleY;

            _flashApplication.scaleX = _scaleX;
            _flashApplication.scaleY = _scaleY;
        }

        public static function setSmoothing(smoothing:Boolean):void{
            if (_smoothing != smoothing){
                _smoothing = smoothing;

                _eventDispatcher.dispatchEvent(new RetrocamelEvent(RetrocamelEvent.SMOOTHING_CHANGED));
            }
         }

        public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void{
            _eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference)
        }

        public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void{
            _eventDispatcher.removeEventListener(type, listener, useCapture);
        }

        public static function get offsetX():Number {
            return _offsetX;
        }

        public static function get offsetY():Number {
            return _offsetY;
        }

        public static function get scaleX():Number {
            return _scaleX;
        }

        public static function get scaleY():Number {
            return _scaleY;
        }

		public static function get stageWidth():Number{
			return _flashStage.stageWidth;
		}

		public static function get stageHeight():Number{
			return _flashStage.stageHeight;
		}

		public static function get isFullscreen():Boolean{
			return _flashStage.displayState === StageDisplayState.FULL_SCREEN_INTERACTIVE || _flashStage.displayState === StageDisplayState.FULL_SCREEN;
		}

		public static function set isFullscreen(value:Boolean):void{
			if (value !== isFullscreen){
				_flashStage.displayState = value ? StageDisplayState.FULL_SCREEN_INTERACTIVE : _flashStage.displayState = StageDisplayState.NORMAL;
				stageResizeHandler(null);
				onFullScreenToggled.call();
			}
		}

		retrocamel_int static function enterFrameHandler(e:Event):void{
			onEnterFrame.call();
		}

		retrocamel_int static function stageResizeHandler(e:Event):void{
			RetrocamelCore.onStageResized();
			RetrocamelWindowsManager.onStageResize();

			onStageResized.call(stageWidth, stageHeight);
		}
    }
}