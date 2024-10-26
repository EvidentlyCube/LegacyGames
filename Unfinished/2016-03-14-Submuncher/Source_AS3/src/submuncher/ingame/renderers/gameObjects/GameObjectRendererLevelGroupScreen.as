package submuncher.ingame.renderers.gameObjects {
    import flash.geom.Rectangle;

    import starling.display.BlendMode;
    import starling.display.Image;
    import starling.textures.Texture;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;
    import submuncher.core.repositories.LevelGroupsRepository;
    import submuncher.ingame.gameObjects.SpecialStatsScreen;
    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererLevelGroupScreen extends GameObjectRendererBase {
        private var _numbers:Vector.<Image>;

        public function get screen():SpecialStatsScreen {
            return gameObject as SpecialStatsScreen;
        }

        public function GameObjectRendererLevelGroupScreen(gameObject:SpecialStatsScreen, levelRenderer:LevelFrontend) {
            super(gameObject, levelRenderer);

            _numbers = new Vector.<Image>();
            texture = Gfx.spritesAtlas.getTexture(SpriteNames.LEVEL_GROUP_SCREEN);
            readjustSize();

            if (LevelGroupsRepository.groupExists(screen.linkedGroupId)){
                createNumbers();
            }
        }

        override public function dispose():void {
            for each (var image:Image in _numbers) {
                gameCommunication.onGameObjectImageRemoved.call(image);
                image.dispose();
            }

            _numbers = null;

            super.dispose();
        }

        override public function update():void {
            var alpha:Number = _random.getChance(10) ? _random.getNumberRange(0.7, 1) : 1;

            for each (var image:Image in _numbers) {
                image.alpha = alpha;
            }

            super.update();
        }

        private function createNumbers():void {
            var baseTexture:Texture = this.baseTexture;

            var offsetX:Number = 6;

            if (screen.linkedGroupId.charAt(0) === "1"){
                offsetX -= 1;
            }

            if (screen.linkedGroupId.charAt(2) === "1"){
                offsetX += 1;
            }

            for (var i:int = 0; i < 3; i++) {
                var character:String = screen.linkedGroupId.charAt(i);
                var num:Number;

                if (character.toLowerCase() === "x") {
                    num = 9;
                } else {
                    num = parseInt(character);
                }

                var image:Image = new Image(Texture.fromTexture(baseTexture, new Rectangle(12 * num, 0, 12, 16)));
                image.x = screen.x + offsetX + 12 * i;
                image.y = screen.y + 8;
                image.blendMode = BlendMode.ADD;
                image.z = Number.MAX_VALUE;

                _numbers.push(image);
                gameCommunication.onGameObjectImageCreated.call(image);
            }
        }

        private function get baseTexture():Texture {
            var score:Number = levelFrontend.game.save.progress.getPercentProgressByGroupId(screen.linkedGroupId);

            if (score === 0) {
                return Gfx.spritesAtlas.getTexture(SpriteNames.NUMBERS_BIG_RED);
            } else if (score < 1) {
                return Gfx.spritesAtlas.getTexture(SpriteNames.NUMBERS_BIG_ORANGE);
            } else {
                return Gfx.spritesAtlas.getTexture(SpriteNames.NUMBERS_BIG_GREEN);
            }
        }

    }
}
