package submuncher.ingame.renderers.gameObjects {
    import net.retrocade.enums.Direction4;

    import starling.textures.Texture;

    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.gameObjects.EnemyShell;
    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererShell extends GameObjectRendererBase {
        private var _textures:Vector.<Texture>;
        private var _currentFrame:uint = 0;
        private var _frameWait:uint = 0;

        public function get shell():EnemyShell {
            return gameObject as EnemyShell;
        }

        public function GameObjectRendererShell(shell:EnemyShell, levelFrontend:LevelFrontend) {
            super(shell, levelFrontend);

            switch(shell.direction){
                case(Direction4.UP): _textures = SpriteTextureCollections.shellUp; break;
                case(Direction4.RIGHT): _textures = SpriteTextureCollections.shellRight; break;
                case(Direction4.DOWN): _textures = SpriteTextureCollections.shellDown; break;
                case(Direction4.LEFT): _textures = SpriteTextureCollections.shellLeft; break;
            }

            texture = _textures[0];
            readjustSize();
        }

        override public function dispose():void {
            _textures = null;

            super.dispose();
        }

        override public function update():void {
            super.update();

            if (shell.hasJustFired) {
                _currentFrame = 3;
                _frameWait = 10;

            } else if (_currentFrame <= 2 && shell.isPlayerInAttackablePosition){
                _currentFrame = 2;
                _frameWait = 5;

            } else if (_frameWait > 0){
                _frameWait--;

            } else if (_currentFrame > 0){
                _currentFrame--;
                _frameWait = 5;
            }

            texture = _textures[_currentFrame];
        }
    }
}
