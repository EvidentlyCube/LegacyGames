/*
 * Copyright (C) 2013 Maurycy Zarzycki
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package net.retrocade.retrocamel.core{
    import flash.display.MovieClip;
    import flash.display.Stage;
    import flash.display.StageDisplayState;
    import flash.events.Event;
    import flash.events.EventDispatcher;

    import net.retrocade.retrocamel.display.global.RetrocamelTooltip;

    import net.retrocade.retrocamel.display.layers.RetrocamelLayer;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerFlash;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
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
        
        retrocamel_int static var _tooltip:RetrocamelTooltip;

        public static var onStageScaleChanged:Signal = new Signal();
        public static var onStageResized:Signal = new Signal();
        public static var onEnterFrame:Signal = new Signal();

        public static function get starlingStage():starling.display.Stage{
            return _starlingStage;
        }

        public static function get flashStage():flash.display.Stage{
            return _flashStage;
        }
        
        
        /**
         * Shortcut to the instance of the main application 
         */
        retrocamel_int static var _flashApplication:MovieClip;
        
        public static function get flashApplication():MovieClip{
            return _flashApplication;
        }
        
        retrocamel_int static function initializeFlash(main:MovieClip, stage:flash.display.Stage):void{
            _flashStage    = stage;
            _flashApplication = main;
            
            _starlingLayers = new Vector.<RetrocamelLayerStarling>();
            _flashLayers = new Vector.<RetrocamelLayerFlash>();

            _flashStage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            _flashStage.addEventListener(Event.RESIZE, stageResizeHandler);
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

        retrocamel_int static function pullLayerToFront(layer:RetrocamelLayer):void{
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

        retrocamel_int static function enterFrameHandler(e:Event):void{
            onEnterFrame.call();
        }

        retrocamel_int static function stageResizeHandler(e:Event):void{
            RetrocamelCore.onStageResized();
            RetrocamelWindowsManager.onStageResize();

            onStageResized.call(stageWidth, stageHeight);
        }

        public static function addEventListener(eventType:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void{
            _eventDispatcher.addEventListener(eventType, listener, useCapture, priority, useWeakReference)
        }

        public static function removeEventListener(eventType:String, listener:Function, useCapture:Boolean = false):void{
            _eventDispatcher.removeEventListener(eventType, listener, useCapture);
        }
        
        public static function get stageWidth():Number{
            return _flashStage.stageWidth;
        }

        public static function get stageHeight():Number{
            return _flashStage.stageHeight;
        }

        public static function get applicationWidth():Number{
            return stageWidth;
        }

        public static function get applicationHeight():Number{
            return stageHeight;
        }

        public static function get fullScreen():Boolean{
            return _flashStage.displayState === StageDisplayState.FULL_SCREEN_INTERACTIVE || _flashStage.displayState === StageDisplayState.FULL_SCREEN;
        }

        public static function set fullScreen(value:Boolean):void{
            if (value !== fullScreen){
                _flashStage.displayState = value ? StageDisplayState.FULL_SCREEN_INTERACTIVE : _flashStage.displayState = StageDisplayState.NORMAL;
            }
        }

        public static function get viewportOffsetX():Number {
            return RetrocamelStarlingCore.starlingInstance.viewPort.x;
        }

        public static function get viewportOffsetY():Number {
            return RetrocamelStarlingCore.starlingInstance.viewPort.y;
        }

        public static function get viewportScaleX():Number {
            return RetrocamelDisplayManager.stageWidth / RetrocamelStarlingCore.starlingInstance.viewPort.width;
        }

        public static function get viewportScaleY():Number {
            return RetrocamelDisplayManager.stageHeight / RetrocamelStarlingCore.starlingInstance.viewPort.height;
        }
    }
}