package submuncher.core.repositories {
    public class EditorLevelMetadata extends LevelMetadata{
        override public function get isCustom():Boolean {
            return true;
        }
        override public function get xml():XML {
            return null;
        }

        public function EditorLevelMetadata() {
            super("editor-" + (new Date()).time, "", S.defaultLevelWidthTiles, S.defaultLevelHeightTiles, 0, null);
        }
    }
}
