package submuncher.ingame.gameObjects {
    import submuncher.core.constants.GameObjectType;
    import submuncher.ingame.core.Level;

    public class BonusAmmo extends GameObject {
        private var _amount:int;

        override public function get objectType():GameObjectType {
            return GameObjectType.AMMO;
        }

        public function BonusAmmo(level:Level, x:Number, y:Number, amount:int) {
            super(level, x, y);

            _amount = amount;
        }

        override public function update():void {
            if (level.player && !level.player.isMoving && level.player.x === x && level.player.y === y) {
                collect();
            } else {
                super.update();

            }
        }

        protected function collect():void {
            level.score.ammo += _amount;

            destroy();
        }

        public function get amount():int {
            return _amount;
        }
    }
}