package submuncher.core.repositories {
    // import flash.filesystem.File;

    import submuncher.core.submuncher_init;

    public class LevelRepository {
        private static var _levelMetadatas:Vector.<LevelMetadata> = new Vector.<LevelMetadata>();

        public static function getLevelById(id:String):LevelMetadata {
            for each (var metadata:LevelMetadata in _levelMetadatas) {
                if (metadata.id === id){
                    return metadata;
                }
            }

            throw new Error("Level of id " + id + " has not been found.");
        }

        public static function getFirstTextLevel():LevelMetadata {
            for each (var metadata:LevelMetadata in _levelMetadatas) {
                if (metadata.isCustom){
                    return metadata;
                }
            }

            throw new Error("No custom level found");
        }

        submuncher_init static function init():void {
            for each (var data:Class in LevelRepositoryEmbed.getAllLevelData()) {
                addLevel(data);
            }
        }

        public static function addCustomLevel(file:*):void {
            A::SSERT{ASSERT(file.exists);}
            _levelMetadatas.push(new CustomLevelMetadata(file));
        }

        private static function addLevel(data:Class):void {
            var metadata:LevelMetadata = loadLevelData(data);
            _levelMetadatas.push(metadata);
        }

        private static function loadLevelData(data:Class):LevelMetadata{
            var xml:XML = LevelMetadata.classToXml(data);
            return new LevelMetadata(
                xml.@id.toString(),
                xml.@title.toString(),
                parseInt(xml.width.toString()) / 16,
                parseInt(xml.height.toString()) / 16,
                parseInt(xml.@parTime.toString()),
                data
            );
        }
    }
}
