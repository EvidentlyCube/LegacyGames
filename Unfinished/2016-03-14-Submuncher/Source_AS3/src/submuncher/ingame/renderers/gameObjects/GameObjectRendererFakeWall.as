package submuncher.ingame.renderers.gameObjects {
    import submuncher.core.constants.Gfx;
    import submuncher.ingame.gameObjects.ObjectFakeWall;

    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererFakeWall extends GameObjectRendererBase{
        private function get fakeWall():ObjectFakeWall {
            return gameObject as ObjectFakeWall;
        }

        public function GameObjectRendererFakeWall(gameObject:ObjectFakeWall, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            texture = Gfx.getSingleTileTextureFg(fakeWall.tileIndex);
        }


        override public function update():void{
            if (fakeWall.isDiscovered && alpha > 0){
                alpha -= 0.05;
            } else if (alpha < 1){
                alpha += 0.05;
            }
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}
