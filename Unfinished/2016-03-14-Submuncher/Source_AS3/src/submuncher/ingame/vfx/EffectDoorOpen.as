package submuncher.ingame.vfx {
    import starling.textures.Texture;

    import submuncher.core.constants.GameObjectIndexes;
    import submuncher.core.constants.GameObjectType;

    import submuncher.core.constants.LockColor;

    import submuncher.core.constants.SpriteTextureCollections;

    import submuncher.ingame.renderers.core.LevelFrontend;

    public class EffectDoorOpen extends EffectBase{
        private var _textures:Vector.<Texture>;
        private var _frame:Number;

        public function EffectDoorOpen(frontend:LevelFrontend, color:LockColor, x:Number, y:Number) {
            _textures = SpriteTextureCollections.getDoor(color);
            super(_textures[0]);

            _frame = 0;

            this.x = x;
            this.y = y;
            z = GameObjectIndexes.getDisplayIndex(GameObjectType.DOOR);
        }


        override public function update():void {
            _frame += 0.2;

            texture = _textures[Math.min(_textures.length - 1, _frame | 0)];
        }

        override public function get isFinished():Boolean {
            return _frame >= _textures.length;
        }

        override public function get isDisplayEffect():Boolean {
            return true;
        }

        override public function get isPersistent():Boolean {
            return false;
        }

        override public function get blocksGameplay():Boolean {
            return false;
        }

        override public function get isOnGameObjectLayer():Boolean {
            return true;
        }

        override public function get objectClass():Class {
            return EffectDoorOpen;
        }
    }
}
