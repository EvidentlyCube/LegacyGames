package net.retrocade.tacticengine.monstro.core{
    import flash.utils.ByteArray;

    import net.retrocade.utils.UString;

    public class MonstroLevels{
        [Embed(source="/../assets/levels/level1.oel",mimeType="application/octet-stream")] public static var level_000:Class;
        [Embed(source="/../assets/levels/level2.oel",mimeType="application/octet-stream")] public static var level_001:Class;
        [Embed(source="/../assets/levels/level3.oel",mimeType="application/octet-stream")] public static var level_002:Class;
        [Embed(source="/../assets/levels/OldLevel1.oel",mimeType="application/octet-stream")] public static var level_003:Class;
        [Embed(source="/../assets/levels/OldLevel2.oel",mimeType="application/octet-stream")] public static var level_004:Class;
        [Embed(source="/../assets/levels/OldLevel3.oel",mimeType="application/octet-stream")] public static var level_005:Class;
        [Embed(source="/../assets/levels/OldLevel4.oel",mimeType="application/octet-stream")] public static var level_006:Class;
        [Embed(source="/../assets/levels/OldLevel5.oel",mimeType="application/octet-stream")] public static var level_007:Class;

        private static var levelNames:Vector.<String> = new <String>[
            "Small Spaces",
            "Circular Emotions",
            "Blasted Corridors",
            "First Frontier (Original Lvl 1)",
            "Spacial Spiders (Original Lvl 2)",
            "Horizontal Tar (Original Lvl 3)",
            "The Army (Original Lvl 4)",
            "The Slayer (Original Lvl 5)"
        ];

        public static function getLevel(id:int):XML{
            var name:String = "level_" + UString.padLeft(id, 3);

            var level:ByteArray = new (MonstroLevels[name]);
            level.position = 0;

            return new XML(level.readUTFBytes(level.length));
        }

        public static function getLevelName(id:int):String{
            return levelNames[id];
        }

        public static function getLevelCount():int{
            return levelNames.length;
        }
    }
}