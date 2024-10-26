package submuncher.ingame.levelFactory {
    import S;
    import submuncher.core.repositories.LevelMetadata;
    import submuncher.ingame.core.Game;

    import submuncher.ingame.core.Level;
    import submuncher.ingame.core.LevelAutoTiler;
    import submuncher.ingame.core.LevelTilesArray;
    import submuncher.ingame.gameObjects.ObjectDoor;
    import submuncher.core.constants.LockColor;

    public class LevelLoader {
        public static function loadLevel(metadata:LevelMetadata, game:Game):Level {
            var levelData:XML = metadata.xml;

            var level:Level = new Level(metadata, game);
            var autoTileGroupsBG:LevelTilesArray = new LevelTilesArray(metadata.width, metadata.height);
            var autoTileGroupsFG:LevelTilesArray = new LevelTilesArray(metadata.width, metadata.height);
            autoTileGroupsBG.setAll(0);
            autoTileGroupsFG.setAll(0);

            var item:XML;
            for each(item in levelData.levelBG.children()){
                level.tilesBackground.setTile(item.@x / 16 | 0, item.@y / 16 | 0, (item.@tx / 16 | 0) + (item.@ty / 16 | 0) * S.tilesetWidthInTiles);
            }
            for each(item in levelData.level.children()){
                if (item.@tx == 80 && item.@ty == 0) {
                    level.gameObjectsList.add(new ObjectDoor(level, item.@x, item.@y, LockColor.RED));
                } else if (item.@tx == 96 && item.@ty == 0) {
                    level.gameObjectsList.add(new ObjectDoor(level, item.@x, item.@y, LockColor.GREEN));
                } else if (item.@tx == 112 && item.@ty == 0) {
                    level.gameObjectsList.add(new ObjectDoor(level, item.@x, item.@y, LockColor.BLUE));
                } else if (item.@tx == 128 && item.@ty == 0) {
                    level.gameObjectsList.add(new ObjectDoor(level, item.@x, item.@y, LockColor.ORANGE));
                } else if (item.@tx == 144 && item.@ty == 0) {
                    level.gameObjectsList.add(new ObjectDoor(level, item.@x, item.@y, LockColor.GRAY));
                } else {
                    level.tilesForeground.setTile(item.@x / 16 | 0, item.@y / 16 | 0, (item.@tx / 16 | 0) + (item.@ty / 16 | 0) * S.tilesetWidthInTiles);
                }
            }

            for each (item in levelData.groupsBG.children()) {
                autoTileGroupsBG.setTile(
                        item.@x / 16 | 0,
                        item.@y / 16 | 0,
                        item.@tx / 16 + (item.@ty / 16 / 2) + 1 | 0
                );
            }

            for each (item in levelData.groups.children()) {
                autoTileGroupsFG.setTile(
                        item.@x / 16 | 0,
                        item.@y / 16 | 0,
                        item.@tx / 16 + (item.@ty / 16 / 2) + 1 | 0
                );
            }

            LevelAutoTiler.autoTile(level.tileWidth, level.tileHeight, level.tilesBackground.originalArray, autoTileGroupsBG);
            LevelAutoTiler.autoTile(level.tileWidth, level.tileHeight, level.tilesForeground.originalArray, autoTileGroupsFG);

            for each(item in levelData.actors.children()){
                LevelLoaderObjectFactory.createObject(item, level);
            }

            return level;
        }
    }
}
