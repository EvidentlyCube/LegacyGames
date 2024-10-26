package submuncher.ingame.renderers.gameObjects {
    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;
    import submuncher.ingame.gameObjects.ObjectDoor;
    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererDoor extends GameObjectRendererBase {
        private function get door():ObjectDoor {
            return gameObject as ObjectDoor;
        }

        public function GameObjectRendererDoor(gameObject:ObjectDoor, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            texture = Gfx.spritesAtlas.getTexture(SpriteNames.getDoorSpriteName(door.color));
        }


        override public function dispose():void {
            super.dispose();
        }
    }
}
