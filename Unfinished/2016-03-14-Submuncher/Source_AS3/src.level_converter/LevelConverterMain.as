package {
    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    public class LevelConverterMain extends Sprite{
        public function LevelConverterMain() {
            var file:File = new File("C:/Projects/Personal/Flash/SubMuncher/src/../assets/levels");
            var oldLevels:File = file.resolvePath("levels_jerzy_old");
            var newLevels:File = file.resolvePath("levels_jerzy_new");

            ASSERT(oldLevels.exists);
            ASSERT(newLevels.exists);

            for each (var levelPath:File in oldLevels.getDirectoryListing()) {
                trace("Level: " + levelPath.nativePath);
                var saveTarget:File = newLevels.resolvePath(levelPath.name);
                trace("Save to: " + saveTarget.nativePath);

                var xml:XML = LevelConverter.convert(levelPath);
                var fs:FileStream = new FileStream();
                fs.open(saveTarget, FileMode.WRITE);
                fs.writeUTFBytes(xml.toXMLString());
                fs.close();
            }

            NativeApplication.nativeApplication.exit();
        }
    }
}
