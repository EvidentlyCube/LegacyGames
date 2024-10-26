package submuncher.ingame.gameObjects {
    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.GameObjectType;
    import submuncher.core.repositories.LevelGroupsRepository;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.windows.levels.LevelSelectionWindow;

    public class SpecialLevelEntrance extends GameObject{
        private var _linkedGroupId:String;

        override public function get objectType():GameObjectType {
            return GameObjectType.LEVEL_ENTRANCE;
        }

        public function SpecialLevelEntrance(level:Level, x:Number, y:Number, groupId:String, direction:Direction4) {
            super(level, x, y);

            _direction = direction;
            _linkedGroupId = groupId;
        }


        override public function update():void {
            if (player.x === x && player.y === y && !player.isMoving){
                if (LevelGroupsRepository.groupExists(_linkedGroupId)){
                    var window:* = LevelSelectionWindow.showWindow(level.game, LevelGroupsRepository.getGroupById(_linkedGroupId), level.game.save);
                    window.closeAllOnClose = true;
                }
                player.move(direction);
                player.stopAutomaticMovement();
            }
        }

        public function get linkedGroupId():String {
            return _linkedGroupId;
        }
    }
}