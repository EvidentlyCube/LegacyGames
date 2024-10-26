package submuncher.editor.layers {
    import submuncher.editor.core.*;
    import net.retrocade.constants.KeyConst;
    import net.retrocade.retrocamel.core.RetrocamelInputManager;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.retrocamel.locale._;

    import submuncher.core.display.SubmuncherTextField;

    public class EditorInfoBox extends RetrocamelLayerStarling{
        private var _currentTool:SubmuncherTextField;
        private var _helpInfo:SubmuncherTextField;
        private var _extEditor:Editor;

        public function EditorInfoBox(editor:Editor) {
            super();

            _extEditor = editor;
            _currentTool = new SubmuncherTextField("Paint (Separate)", 1, 0xFFFFFF, S.gameWidth, 32);
            _helpInfo = new SubmuncherTextField("", 1, 0xFFFFFF, S.gameWidth, 32);

            _currentTool.x = 2;
            _currentTool.y = 2;

            _helpInfo.x = 2;
            _helpInfo.y = S.gameHeight - 12;

            add(_currentTool);
            add(_helpInfo);
        }

        override public function dispose():void {
            super.dispose();
        }

        public function update():void {
            _currentTool.text = _extEditor.tool.name;

            if (RetrocamelInputManager.isKeyDown(KeyConst.F1)) {
                _helpInfo.text = _('editor.info.f1');
                _helpInfo.y = S.gameHeight - 32;
            } else if (RetrocamelInputManager.isCtrlDown){
                _helpInfo.text = _('editor.info.ctrl');
                _helpInfo.y = S.gameHeight - 22;
            } else {
                _helpInfo.text = "";
            }
        }
    }
}
