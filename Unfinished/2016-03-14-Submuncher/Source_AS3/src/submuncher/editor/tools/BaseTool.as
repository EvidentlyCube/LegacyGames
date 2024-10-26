package submuncher.editor.tools {
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;

    import starling.display.Sprite;

    import submuncher.editor.core.Editor;

    public class BaseTool extends Sprite{
        private var _extEditor:Editor;
        private var _extToolLayer:RetrocamelLayerStarling;

        public function BaseTool(extEditor:Editor, extToolLayer:RetrocamelLayerStarling) {
            _extEditor = extEditor;
            _extToolLayer = extToolLayer;

            _extToolLayer.add(this);

            x = mouseX * S.tileEdge;
            y = mouseY * S.tileEdge;
        }

        override public function dispose():void {
            _extEditor = null;
            _extToolLayer = null;

            super.dispose();
        }

        public function update():void {
            x = mouseX * S.tileEdge;
            y = mouseY * S.tileEdge;
        }

        override public function get name():String {
            return "--null--";
        }

        public function get editor():Editor {
            return _extEditor;
        }

        public function get toolLayer():RetrocamelLayerStarling {
            return _extToolLayer;
        }
        
        public function get mouseX():int{
            return _extEditor.mouseX;
        }

        public function get mouseY():int{
            return _extEditor.mouseY;
        }

        public function get isMouseDown():Boolean {
            return _extEditor.isMouseDown;
        }

        public function get isRightMouseDown():Boolean {
            return _extEditor.isRightMouseDown;
        }


        public function set index(index:int):void {
            
        }

        public function get index():int {
            return -1;
        }

    }
}
