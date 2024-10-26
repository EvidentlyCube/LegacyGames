package net.retrocade.camel.global{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
    import flash.events.Event;

    import net.retrocade.camel.layers.rLayer;
    import net.retrocade.camel.layers.rLayerFlash;
    import net.retrocade.camel.layers.rLayerFlash;
    import net.retrocade.camel.layers.rLayerStarling;
    import net.retrocade.camel.layers.rLayerStarling;
	import net.retrocade.starling.rStarling;
	
	import starling.display.Sprite;
	import starling.display.Stage;

    use namespace retrocamel_int;
    
    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class rDisplay{
        
        retrocamel_int static var _starlingStage:starling.display.Stage;
        retrocamel_int static var _flashStage:flash.display.Stage;
        
        retrocamel_int static var _starlingLayers:Vector.<rLayerStarling>;
        retrocamel_int static var _flashLayers:Vector.<rLayerFlash>;
        
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
            
            _starlingLayers = new Vector.<rLayerStarling>();
            _flashLayers = new Vector.<rLayerFlash>();

            _flashStage.addEventListener(Event.RESIZE, onStageResize);
        }

        retrocamel_int static function initializeStarling(stage:starling.display.Stage):void{
            _starlingStage = stage;
        }
        
        
        /**
         * Adds layer to the game display
         * @param layer Layer to be added 
         */
        public static function addLayer(layer:rLayer):void{
            if (layer is rLayerFlash){
                addLayerAt(layer, _flashApplication.numChildren);
            } else if (layer is rLayerStarling){
                addLayerAt(layer, rStarling._starlingRoot.numChildren);
            }
        }
        
        /**
         * Adds layer to the game display
         * @param layer Layer to be added
         * @param index Index at which the layer should be added
         */
        public static function addLayerAt(layer:rLayer, index:int = 0):void{
            if (layer is rLayerFlash){
                _flashApplication.addChildAt(rLayerFlash(layer).layer, index);
                _flashLayers.push(layer as rLayerFlash);
            } else if (layer is rLayerStarling){
                rStarling._starlingRoot.addChildAt(rLayerStarling(layer).layer, index);
                _starlingLayers.push(layer as rLayerStarling);
            }

            rWindows.pushLayersToFront();
        }
        
        /**
         * Removes layer from the display
         * @param layer Layer to be removed from the game's display 
         */        
        public static function removeLayer(layer:rLayer):void{
            if (layer is rLayerFlash){
                _flashApplication.removeChild(rLayerFlash(layer).layer);
            } else if (layer is rLayerStarling){
                rStarling._starlingRoot.removeChild(rLayerStarling(layer).layer);
            }
        }

        retrocamel_int static function pullLayerToFront(layer:rLayer):void{
            if (layer is rLayerFlash){
                _flashApplication.setChildIndex(rLayerFlash(layer).layer, _flashApplication.numChildren);
            } else if (layer is rLayerStarling){
                rStarling._starlingRoot.setChildIndex(rLayerStarling(layer).layer, rStarling._starlingRoot.numChildren);
            }
        }
        
        /**
         * Blocks all input on the game layers, primarily used by rWindows
         */
        retrocamel_int static function block():void {
            for each(var flashLayer:rLayerFlash in _flashLayers){
                flashLayer.inputEnabled = false;
            }
            
            for each(var starlingLayer:rLayerStarling in _starlingLayers){
                starlingLayer.inputEnabled = false;
            }
        }
        
        /**
         * Enables the input on the game layers, primarily used by rWindows
         */
        retrocamel_int static function unblock():void {
            for each(var flashLayer:rLayerFlash in _flashLayers){
                flashLayer.inputEnabled = true;
            }
            
            for each(var starlingLayer:rLayerStarling in _starlingLayers){
                starlingLayer.inputEnabled = true;
            }
        }

        retrocamel_int static function onStageResize(e:Event):void{
            rCore.onStageResized();
            rWindows.onStageResize();
        }
    }
}