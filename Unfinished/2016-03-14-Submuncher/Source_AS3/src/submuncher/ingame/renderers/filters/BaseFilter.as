package submuncher.ingame.renderers.filters {
    import flash.display3D.Context3D;
    import flash.display3D.Program3D;

    import starling.filters.FragmentFilter;
    import starling.textures.Texture;

    /**
     *  Base Filter class for FragmentFilters in OneByOneDesign Starling Filters Package.
     *  Do not instantiate directly.
     */
    public class BaseFilter extends FragmentFilter {
        // Shaders

        protected var FRAGMENT_SHADER:String;
        protected var VERTEX_SHADER:String;

        /** Program 3D */
        protected var program:Program3D

        /** @private */
        public function BaseFilter() {
            super(1, 1.0);
        }

        /** Dispose */
        override public function dispose():void {
            if (this.program != null) {
                this.program.dispose();
            }

            super.dispose();
        }

        /** Create Programs */
        override protected function createPrograms():void {
            setAgal();
            this.program = assembleAgal(FRAGMENT_SHADER, VERTEX_SHADER);
        }

        /** Set AGAL */
        protected function setAgal():void {
            // Override this to assign values to FRAGMENT_SHADER and VERTEX_SHADER
        }

        /** Activate */
        override protected function activate(pass:int, context:Context3D, texture:Texture):void {
            context.setProgram(this.program);
        }
    }


}