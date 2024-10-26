package submuncher.ingame {
    import net.retrocade.constants.KeyConst;
    import net.retrocade.retrocamel.components.RetrocamelStateBase;
    import net.retrocade.retrocamel.core.RetrocamelDisplayManager;
    import net.retrocade.retrocamel.core.RetrocamelInputManager;

    import submuncher.core.repositories.LevelRepository;
    import submuncher.core.save.Save;
    import submuncher.core.save.SaveLoader;

    import submuncher.ingame.core.Game;

    public class StateIngame extends RetrocamelStateBase{
        private var _game:Game;
        private var _extSave:Save;

        override public function create():void {
            super.create();

            _extSave = SaveLoader.restoreFromFile();
            _game = new Game(_extSave);
//            _game.startLevel(LevelRepository.getLevelById('hub-001'));
//            _game.startLevel(LevelRepository.getLevelById('001-001'));
            _game.startLevel(LevelRepository.getLevelById('002-001'));
//            _game.startLevel(LevelGroupsRepository.getGroupByIndex(1).getLevelByIndex(0).level);
//            _game.startLevel(LevelRepository.getLevelById('boss-001'));
        }

        override public function destroy():void {
            _game.dispose();

            super.destroy();
        }

        override public function update():void {
            if (RetrocamelInputManager.isKeyDown(KeyConst.NUMBER_1)){
                RetrocamelDisplayManager.flashStage.frameRate = 2;
            } else if (RetrocamelInputManager.isKeyDown(KeyConst.NUMBER_2)){
                RetrocamelDisplayManager.flashStage.frameRate = 5;
            } else if (RetrocamelInputManager.isKeyDown(KeyConst.NUMBER_3)){
                RetrocamelDisplayManager.flashStage.frameRate = 10;
            } else if (RetrocamelInputManager.isKeyDown(KeyConst.NUMBER_4)){
                RetrocamelDisplayManager.flashStage.frameRate = 30;
            } else if (RetrocamelInputManager.isKeyDown(KeyConst.NUMBER_5)){
                RetrocamelDisplayManager.flashStage.frameRate = 60;
            }
            _game.update();

            super.update();
        }

        override public function resize():void {
            super.resize();
        }

        public function get game():Game {
            return _game;
        }
    }
}
