package submuncher.ingame.gameObjects {
    import submuncher.core.constants.GameObjectType;
    import submuncher.core.constants.LockColor;
    import submuncher.ingame.core.Level;

    public class BonusKey extends GameObject{
        private var _color:LockColor;

        override public function get objectType():GameObjectType {
            return GameObjectType.KEY;
        }

        public function get color():LockColor {
            return _color;
        }

        public function BonusKey(level:Level, x:Number, y:Number, color:LockColor) {
            super(level, x, y);

            _color = color;
        }

        override public function update():void {
            if (level.player && !level.player.isMoving && level.player.x === x && level.player.y === y){
                collect();
            } else {
                super.update();

            }
        }

        protected function collect():void{
            level.score.addKey(_color);
            destroy();
        }
    }
}