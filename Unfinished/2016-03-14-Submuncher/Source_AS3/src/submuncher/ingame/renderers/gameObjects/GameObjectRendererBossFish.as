package submuncher.ingame.renderers.gameObjects {
    import starling.filters.ColorMatrixFilter;

    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.gameObjects.BossFish;
    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererBossFish extends GameObjectRendererAnimatedDirectional {
        private var _filter:ColorMatrixFilter;

        public function get boss():BossFish {
            return gameObject as BossFish;
        }

        public function GameObjectRendererBossFish(boss:BossFish, frontend:LevelFrontend) {
            super(boss, frontend);

            _filter = new ColorMatrixFilter();
            filter = _filter;

            setTextures(
                SpriteTextureCollections.bossFishUp,
                SpriteTextureCollections.bossFishRight,
                SpriteTextureCollections.bossFishDown,
                SpriteTextureCollections.bossFishLeft
            );
        }

        override public function dispose():void {
            _filter.dispose();
            _filter = null;
            filter = null;

            super.dispose();
        }

        override public function update():void {
            _filter.reset();
            _filter.adjustBrightness(boss.shieldTimeout / boss.SHIELD_TIMEOUT_MAX);

            super.update();
        }
    }
}
