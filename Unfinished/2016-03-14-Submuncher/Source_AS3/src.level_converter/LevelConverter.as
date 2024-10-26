package {
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    public class LevelConverter {
        private static var _newLevelXml:XML;
        private static var _newLevelXmlTiles:XML;
        private static var _newLevelXmlObjects:XML;

        public static function convert(path:File):XML{
            var oldLevelXml:XML = getXml(path);
            createNewLevelXml();
            initializeBasicProperties(oldLevelXml);

            parseTiles(oldLevelXml);
            parseObjects(oldLevelXml);

            return _newLevelXml;
        }

        private static function parseTiles(oldLevelXml:XML):void {
            var x:uint;
            var y:uint;
            var tileIndex:uint;
            var newTilePosition:Array;
            var xml:XML;

            var mappings:Vector.<Array> = new <Array>[
                [0, 1], [1, 1], [2, 1], [8,14],  [9,14], [10,14], [11,14],  [9,16], [10,16],
                [0, 1], [1, 1], [2, 1], [8,15],  [9,15], [10,15], [11,15],  [8,16], [26, 4],
                [3, 1], [4, 1], [5, 1], [6, 1], [22, 4], [23, 4], [24, 4], [25, 4], [27, 4],
                [3, 1], [4, 1], [5, 1], [6, 1], [22, 5], [23, 5], [24, 5], [25, 5], [27, 5],
                [0, 2], [2, 2], [5, 2], [6, 2],  [1, 2],  [3, 2],  [4, 2],  [4, 3],  [4, 4]
            ];


            for each (var tile:XML in oldLevelXml.level.tile) {
                x = tile.@x;
                y = tile.@y;
                tileIndex = tile.@tx / 16 + (tile.@ty / 16) * 9;
                newTilePosition = mappings[tileIndex];

                xml = <tile/>;
                xml.@tx = newTilePosition[0] * 16;
                xml.@ty = newTilePosition[1] * 16;
                xml.@x = x;
                xml.@y = y;

                _newLevelXmlTiles.appendChild(xml);
            }
        }

        private static function parseObjects(oldLevelXml:XML):void {
            var tileXml:XML;

            for each (var object:XML in oldLevelXml.actors[0].children()) {
                tileXml = <tile />;
                tileXml.@x = object.@x;
                tileXml.@y = object.@y;

                if (object.name().toString() === "arrowLeft"){
                    tileXml.@tx = 4 * 16;
                    tileXml.@ty = 0;
                    _newLevelXmlTiles.appendChild(tileXml);
                } else if (object.name().toString() === "arrowUp"){
                    tileXml.@tx = 1 * 16;
                    tileXml.@ty = 0;
                    _newLevelXmlTiles.appendChild(tileXml);
                } else if (object.name().toString() === "arrowRight"){
                    tileXml.@tx = 2 * 16;
                    tileXml.@ty = 0;
                    _newLevelXmlTiles.appendChild(tileXml);
                } else if (object.name().toString() === "arrowDown"){
                    tileXml.@tx = 3 * 16;
                    tileXml.@ty = 0;
                    _newLevelXmlTiles.appendChild(tileXml);
                } else if (object.name().toString() === "doorRed"){
                    tileXml.@tx = 5 * 16;
                    tileXml.@ty = 0;
                    _newLevelXmlTiles.appendChild(tileXml);
                } else if (object.name().toString() === "doorGreen"){
                    tileXml.@tx = 6 * 16;
                    tileXml.@ty = 0;
                    _newLevelXmlTiles.appendChild(tileXml);
                } else if (object.name().toString() === "doorBlue"){
                    tileXml.@tx = 7 * 16;
                    tileXml.@ty = 0;
                    _newLevelXmlTiles.appendChild(tileXml);
                } else if (object.name().toString() === "doorYellow"){
                    tileXml.@tx = 8 * 16;
                    tileXml.@ty = 0;
                    _newLevelXmlTiles.appendChild(tileXml);
                } else if (object.name().toString() === "doorWhite"){
                    tileXml.@tx = 9 * 16;
                    tileXml.@ty = 0;
                    _newLevelXmlTiles.appendChild(tileXml);
                } else {
                    _newLevelXmlObjects.appendChild(object.copy());
                }
            }
        }

        private static function initializeBasicProperties(oldLevelXml:XML):void {
            _newLevelXml.@title = oldLevelXml.@title;
            _newLevelXml.@time = oldLevelXml.@time;
            _newLevelXml.@wrapsX = oldLevelXml.@wrapsX;
            _newLevelXml.@wrapsY = oldLevelXml.@wrapsY;
            if (_newLevelXml.@wrapsX.toString() === "") {
                _newLevelXml.@wrapsX = "false";
            }
            if (_newLevelXml.@wrapsY.toString() === "") {
                _newLevelXml.@wrapsY = "false";
            }
            _newLevelXml.width = oldLevelXml.width;
            _newLevelXml.height = oldLevelXml.height;
            _newLevelXml.appendChild(<level set="tiles"/>);
            _newLevelXml.appendChild(<actors/>);

            _newLevelXmlTiles = _newLevelXml.level[0];
            _newLevelXmlObjects = _newLevelXml.actors[0];
        }

        private static function createNewLevelXml():void {
            _newLevelXml = <level/>;
        }

        private static function getXml(path:File):XML {
            var stream:FileStream = new FileStream();
            stream.open(path, FileMode.READ);
            var xml:XML = new XML(stream.readUTFBytes(stream.bytesAvailable));
            stream.close();

            return xml;
        }
    }
}
