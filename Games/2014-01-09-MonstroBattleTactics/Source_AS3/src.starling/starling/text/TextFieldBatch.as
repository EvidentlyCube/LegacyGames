
package starling.text {
    public class TextFieldBatch {
        public var text:String;
        public var x:int = 0;
        public var y:int = 0;
        public var width:int = 0;
        public var height:int = 0;
        public var size:int = 0;
        public var color:int = -1;

        public function TextFieldBatch(text:String, x:int = 0, y:int = 0, color:int = -1, size:int = 0, width:int = 0, height:int = 0){
            this.text = text;
            this.x = x;
            this.width = width;
            this.height = height;
            this.size = size;
            this.color = color;
        }
    }
}
