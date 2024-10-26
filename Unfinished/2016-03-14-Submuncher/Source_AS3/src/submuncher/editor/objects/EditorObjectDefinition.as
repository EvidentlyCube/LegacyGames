package submuncher.editor.objects {
    public class EditorObjectDefinition {
        private var _id:String;
        private var _name:String;
        private var _hasDirections:Boolean;


        public function EditorObjectDefinition(id:String, name:String, hasDirections:Boolean) {
            _id = id;
            _name = name;
            _hasDirections = hasDirections;
        }
    }
}
