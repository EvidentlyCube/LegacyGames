package net.retrocade.camel.layers{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    
    import net.retrocade.camel.global.rDisplay;

    public class rLayer{
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        /**
         * Can this layer be scrolled?
         */
        public var canScroll:Boolean = true;

        /**
         * Returns the display object of this layer
         */
        public function get displayObject():DisplayObject{
            return null;
        }

        /******************************************************************************************************/
        /**                                                                                        FUNCTIONS  */
        /******************************************************************************************************/

        /**
         * Creates a new layer instance
         * @param	addAt If -1 adds at the end of the layers list.
         *  If NaN does not add to the layers list.
         *  If any number it tried to add the layer to that position in the list.
         */
        public function rLayer(addAt:Number = -1) {
            if (!isNaN(addAt)){
                if (addAt == -1)
                    rDisplay.addLayer(this);
                else
                    rDisplay.addLayerAt(this, addAt | 0);
            }
        }

        /**
         * Removes all graphics from the layer
         */
        public function clear():void{}

        /**
         * Scrolls layer to the specified coordinates
         * @param x X position of scroll
         * @param y Y position of scroll
         */
        public function scrollTo(x:Number, y:Number):void{
            if (!canScroll)
                return;

            displayObject.x = x;
            displayObject.y = y;
        }

        /**
         * Removes this layer from the display list
         */
        public function removeLayer():void{
            rDisplay.removeLayer(this);
        }

        public function setScale(x:Number, y:Number):void{
            displayObject.scaleX = x;
            displayObject.scaleY = y;
        }
    }
}