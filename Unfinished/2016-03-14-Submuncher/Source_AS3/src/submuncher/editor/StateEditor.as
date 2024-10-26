package submuncher.editor {
    import net.retrocade.retrocamel.components.RetrocamelStateBase;

    import submuncher.core.repositories.EditorLevelMetadata;
    import submuncher.core.save.Save;
    import submuncher.editor.core.Editor;
    import submuncher.editor.core.EditorTouch;
    import submuncher.ingame.core.Game;
    import submuncher.ingame.core.Level;

    public class StateEditor extends RetrocamelStateBase {
        private var _game:Game;
        private var _extSave:Save;

        private var _customLevel:EditorLevelMetadata;
        private var _level:Level;
        private var _editor:Editor;

        override public function create():void {
            super.create();

            _customLevel = new EditorLevelMetadata();
            _game = new Game(new Save());
            _level = new Level(_customLevel, _game);

            _game.startCustomLevel(_level);
            _game.hud.layer.visible = false;

            _editor = new Editor(_game, _level);
        }

        override public function destroy():void {
            _game.dispose();

            super.destroy();
        }

        override public function update():void {
            _editor.update();
            _game.frontend.update();
        }

        override public function resize():void {
            super.resize();
        }

        public function get game():Game {
            return _game;
        }
    }
}
