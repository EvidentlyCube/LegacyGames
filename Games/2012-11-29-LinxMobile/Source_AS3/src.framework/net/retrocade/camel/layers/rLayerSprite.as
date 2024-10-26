package net.retrocade.camel.layers{
    import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.display.Sprite;
    
    import net.retrocade.camel.objects.rObjectDisplay;

    /**
     * A Layer which consists of Sprite object, classical display list
     */
    public class rLayerSprite extends rLayer{

        /**
         * The Sprite which makes this layer
         */
        private var _layer:Sprite;

        /**
         * Returns the display object of this layer
         */
        override public function get displayObject():DisplayObject{
            return _layer;
        }

        /**
         * Creates a new Sprite Layer and attaches it to the top of the Display tree
         */
        public function rLayerSprite(){
            _layer = new Sprite;
            super();
        }




        /****************************************************************************************************************/
        /**                                                                                           PROPERTIES STUFF  */
        /****************************************************************************************************************/

        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Alpha
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Accesses the alpha of this layer
         */
        public function get alpha():Number{
            return _layer.alpha;
        }

        /**
         * @private
         */
        public function set alpha(value:Number):void{
            _layer.alpha = value;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Graphics
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Returns the Graphics object of this Layer's Sprite
         */
        public function get graphics():Graphics{
            return _layer.graphics;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Layer
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Directly accesses the layer's Sprite instance
         */
        public function get layer():Sprite{
            return _layer;
        }



        // ::::::::::::::::::::::::::::::::::::::::::::::
        // :: Mouse Children
        // ::::::::::::::::::::::::::::::::::::::::::::::

        /**
         * Accesses mouseChildren property of this layer
         */
        public function set mouseChildren(value:Boolean):void{
            _layer.mouseChildren = value;
        }

        /**
         * @private
         */
        public function get mouseChildren():Boolean{
            return _layer.mouseChildren;
        }




        /****************************************************************************************************************/
        /**                                                                                         DISPLAY LIST STUFF  */
        /****************************************************************************************************************/

        /**
         * Adds a DisplayObject to this layer
         * @param d DisplayObject to be added
         */
        public function add(d:DisplayObject):void{
            _layer.addChild(d);
        }

        /**
         * Adds an rObjectDisplay to this layer
         * @param d rObjectDisplay to be added
         */
        public function addAt(d:DisplayObject, index:uint):void{
            _layer.addChildAt(d, index);
        }
        
        /**
         * Removes all children from this layer
         */
        override public function clear():void{
            var i:uint = _layer.numChildren;
            while(i--)
                _layer.removeChildAt(i);

            graphics.clear();
        }

        /**
        * Checks if given DisplayObject is added to this layer
        * @param d The DisplayObject to be checked
        * @return True if this layer contains d
        */
        public function contains(d:DisplayObject):Boolean{
            return _layer.contains(d);
        }

        /**
         * Removes an DisplayObject from this layer
         * @param d The DisplayObject to be removed
         */
        public function remove(d:DisplayObject):void{
            _layer.removeChild(d);
        }
    }
}