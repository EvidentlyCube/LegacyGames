package game.objects.actives{
    import game.global.Game;
    import game.managers.VOSwordDraw;

    public class TPlayerDouble extends TMonster{
        public var swordX:uint;
        public var swordY:uint;
        public var swordMovement:uint;

        public var safeToPlayer:Boolean = true;

        public var swordSheathed    :Boolean = false;

        public var swordVO  :VOSwordDraw = new VOSwordDraw();

        override public function doesSquareContainObstacle(x:uint, y:uint):Boolean{
            if (super.doesSquareContainObstacle(x, y))
                return true;

            return (Game.player.x == x && Game.player.y == y && safeToPlayer);
        }

        public function updateSwordChangedSheathing(isSheathed:Boolean):void {
            if (swordX < S.LEVEL_WIDTH && swordY < S.LEVEL_HEIGHT) {
                if (isSheathed)
                    room.tilesSwords[swordX + swordY * S.LEVEL_WIDTH]--;

                else
                    room.tilesSwords[swordX + swordY * S.LEVEL_WIDTH]++;
            }

            swordX = x + F.getOX(o);
			swordY = y + F.getOY(o);
        }

        override public function isTileObstacle(tile:uint):Boolean{
            return (!F.isPotion(tile) && super.isTileObstacle(tile));
        }

        override public function getSnapshot():Object {
            var object:Object = super.getSnapshot();

            object.safeToPlayer  = safeToPlayer;
            object.swordSheathed = swordSheathed;

            return object;
        }
    }
}