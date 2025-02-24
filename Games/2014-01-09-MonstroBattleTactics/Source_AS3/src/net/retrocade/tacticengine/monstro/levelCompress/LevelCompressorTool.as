
package net.retrocade.tacticengine.monstro.levelCompress {

    import flash.utils.ByteArray;

    public class LevelCompressorTool {
        private static const TILE_WIDTH:int = 32;
        private static const TILE_HEIGHT:int = 32;

        public static function decompress(levelByteArray:ByteArray):XML {
            var title:String = levelByteArray.readUTF();
            var victoryCondition:String = levelByteArray.readUTF();
            var loseCondition:String = levelByteArray.readUTF();
            var surviveTurns:int = levelByteArray.readUnsignedByte();
            var stallTurns:int = levelByteArray.readUnsignedByte();
            var levelWidth:int = levelByteArray.readUnsignedByte() * TILE_WIDTH;
            var levelHeight:int = levelByteArray.readUnsignedByte() * TILE_HEIGHT;

            var xml:XML = <level title={title}
            victoryCondition={victoryCondition}
            surviveTurns={surviveTurns}
            lossCondition={loseCondition}
            stallTurns={stallTurns}/>;

            xml.appendChild(<width>{levelWidth}</width>);
            xml.appendChild(<height>{levelHeight}</height>);


            xml.appendChild(readLayer(levelByteArray, <layer0 set="tiles"/>));
            xml.appendChild(readLayer(levelByteArray, <layer1 set="tiles"/>));
            xml.appendChild(readLayer(levelByteArray, <layer2 set="tiles"/>));

            var actorLayer:XML = <actors />;
            var actorCount:int = levelByteArray.readUnsignedByte();
            while (actorCount--) {
                actorLayer.appendChild(readActorXml(levelByteArray));
            }
            xml.appendChild(actorLayer);

            return xml;
        }

        public static function compress(save:String):ByteArray {
            save = TestSave.get();

            var xml:XML = new XML(save);

            var level:ByteArray = new ByteArray();
            level.writeUTF(xml.@title.toString());
            level.writeUTF(xml.@victoryCondition.toString());
            level.writeUTF(xml.@lossCondition.toString());
            level.writeByte(parseInt(xml.@surviveTurns.toString()));
            level.writeByte(parseInt(xml.@stallTurns.toString()));

            level.writeByte(parseInt(xml.width.text()) / TILE_WIDTH);
            level.writeByte(parseInt(xml.height.text()) / TILE_HEIGHT);

            writeLayer(xml.layer0[0], level);
            writeLayer(xml.layer1[0], level);
            writeLayer(xml.layer2[0], level);

            var actors:XMLList = xml.actors.children();
            var count:int = actors.length();
            level.writeByte(count);
            for (var i:int = 0; i < count; i++) {
                var actor:XML = actors[i];

                xmlActorWrite(actor, level);
            }

            level.position = 0;

            level.position = 0;
            return level;
        }

        public static function getTestSave():XML {
            return new XML(TestSave.get());
        }

        private static function readLayer(byteArray:ByteArray, layer:XML):XML {
            var tileCount:int = byteArray.readInt();
            while (tileCount--) {
                var tileX:int = byteArray.readUnsignedByte() * TILE_WIDTH;
                var tileY:int = byteArray.readUnsignedByte() * TILE_HEIGHT;
                var tileTX:int = byteArray.readUnsignedByte() * TILE_WIDTH;
                var tileTY:int = byteArray.readUnsignedByte() * TILE_HEIGHT;

                layer.appendChild(<tile tx={tileTX} ty={tileTY} x={tileX} y={tileY} />);
            }

            return layer;
        }

        private static function writeLayer(layer:XML, byteArray:ByteArray):void {
            var tiles:XMLList = layer.children();
            var count:int = tiles.length();

            byteArray.writeInt(count);
            for (var i:int = 0; i < count; i++) {
                var tile:XML = tiles[i];

                byteArray.writeByte(parseInt(tile.@x.toString()) / TILE_WIDTH);
                byteArray.writeByte(parseInt(tile.@y.toString()) / TILE_HEIGHT);
                byteArray.writeByte(parseInt(tile.@tx.toString()) / TILE_WIDTH);
                byteArray.writeByte(parseInt(tile.@ty.toString()) / TILE_HEIGHT);
            }
        }

        private static function readActorXml(byteArray:ByteArray):XML {
            var actor:XML = actorIntToXml(byteArray.readUnsignedByte());
            actor.@x = byteArray.readUnsignedByte() * TILE_WIDTH;
            actor.@y = byteArray.readUnsignedByte() * TILE_HEIGHT;

            var hp:int = 2;
            var attack:int = 2;
            var defense:int = 2;
            var movement:int = 4;
            var attackRangeMin:int = 1;
            var attackRangeMax:int = 1;

            var specializations:Array = ["arrow", "shield", "skull", "sword", "heart", "foot"];
            var specializationValues:Array = [0, 0, 0, 0, 0, 0];

            var specializationCount:int = byteArray.readUnsignedByte();
            if (specializationCount == 255) {
                hp = byteArray.readUnsignedByte();
                attack = byteArray.readUnsignedByte();
                defense = byteArray.readUnsignedByte();
                movement = byteArray.readUnsignedByte();
                attackRangeMin = byteArray.readUnsignedByte();
                attackRangeMax = byteArray.readUnsignedByte();

            } else if (specializationCount > 0) {

                while (specializationCount--) {
                    specializationValues[byteArray.readUnsignedByte()]++;
                }
            }

            actor.@arrow = specializationValues[specializations.indexOf("arrow")];
            actor.@shield = specializationValues[specializations.indexOf("shield")];
            actor.@skull = specializationValues[specializations.indexOf("skull")];
            actor.@sword = specializationValues[specializations.indexOf("sword")];
            actor.@heart = specializationValues[specializations.indexOf("heart")];
            actor.@foot = specializationValues[specializations.indexOf("foot")];
            actor.@customStats = (specializationCount == 255 ? "true" : "false");
            actor.@hp = hp;
            actor.@attack = attack;
            actor.@defense = defense;
            actor.@movement = movement;
            actor.@attackRangeMin = attackRangeMin;
            actor.@attackRangeMax = attackRangeMax;

            return actor;
        }

        private static function xmlActorWrite(xml:XML, byteArray:ByteArray):void {
            byteArray.writeByte(actorNameToInt(xml.name().toString()));
            byteArray.writeByte(parseInt(xml.@x.toString()) / TILE_WIDTH);
            byteArray.writeByte(parseInt(xml.@y.toString()) / TILE_HEIGHT);

            var specializationCount:int = xmlActorCountSpecialization(xml);

            if (specializationCount > 0) {
                byteArray.writeByte(specializationCount);
                xmlActorWriteSpecializations(xml, byteArray);
            } else if (xml.@customStats.toString() == "true") {
                byteArray.writeByte(255);
                byteArray.writeByte(parseInt(xml.@hp.toString()));
                byteArray.writeByte(parseInt(xml.@attack.toString()));
                byteArray.writeByte(parseInt(xml.@defense.toString()));
                byteArray.writeByte(parseInt(xml.@movement.toString()));
                byteArray.writeByte(parseInt(xml.@attackRangeMin.toString()));
                byteArray.writeByte(parseInt(xml.@attackRangeMax.toString()));
            } else {
                byteArray.writeByte(0);
            }
        }

        private static function xmlActorWriteSpecializations(xml:XML, byteArray:ByteArray):void {
            var specialization:Array = ["arrow", "shield", "skull", "sword", "heart", "foot"];

            for (var i:int = 0; i < 6; i++) {
                var type:String = specialization[i];
                var count:int = parseInt(xml.attribute(type).toString());

                while (count--) {
                    byteArray.writeByte(i);
                }
            }
        }

        private static function xmlActorCountSpecialization(xml:XML):int {
            return parseInt(xml.@arrow.toString()) + parseInt(xml.@shield.toString()) + parseInt(xml.@skull.toString()) + parseInt(xml.@sword.toString()) + parseInt(xml.@heart.toString()) + parseInt(xml.@foot.toString());
        }

        private static function actorNameToInt(name:String):int {
            switch (name) {
                case("soldier"):
                    return 0;
                case("pikeman"):
                    return 1;
                case("archer"):
                    return 2;
                case("knight"):
                    return 3;
                case("cavalry"):
                    return 4;
                case("slime"):
                    return 5;
                case("shroom"):
                    return 6;
                case("gargoyle"):
                    return 7;
                case("minotaur"):
                    return 8;
                case("manticore"):
                    return 9;
                case("trapLazy"):
                    return 10;
                case("trapSpikes0"):
                    return 11;
                case("trapSpikes1"):
                    return 12;
                case("trapSpikes2"):
                    return 13;
                case("wallMovable"):
                    return 14;
                case("wallFake"):
                    return 15;
                case("flagHumans"):
                    return 16;
                case("flagMonsters"):
                    return 17;
                default:
                    throw new Error("Invalid name");
            }
        }

        private static function actorIntToXml(type:int):XML {
            switch (type) {
                case(0):
                    return <soldier />;
                case(1):
                    return <pikeman />;
                case(2):
                    return <archer />;
                case(3):
                    return <knight />;
                case(4):
                    return <cavalry />;
                case(5):
                    return <slime />;
                case(6):
                    return <shroom />;
                case(7):
                    return <gargoyle />;
                case(8):
                    return <minotaur />;
                case(9):
                    return <manticore />;
                case(10):
                    return <trapLazy />;
                case(11):
                    return <trapSpikes0 />;
                case(12):
                    return <trapSpikes1 />;
                case(13):
                    return <trapSpikes2 />;
                case(14):
                    return <wallMovable />;
                case(15):
                    return <wallFake />;
                case(16):
                    return <flagHumans />;
                case(17):
                    return <flagMonsters />;
                default:
                    throw new Error("Invalid type");
            }
        }
    }
}


class TestSave {
    public static function get():XML {
            return <level title="Rotten Labyrinth" victoryCondition="destroyAll" surviveTurns="0" lossCondition="loseAll" stallTurns="0">
                <width>544</width>
                <height>544</height>
                <layer0 set="tiles">
                    <tile tx="832" ty="96" x="0" y="0"/>
                    <tile tx="832" ty="128" x="0" y="32"/>
                    <tile tx="832" ty="128" x="0" y="64"/>
                    <tile tx="832" ty="128" x="0" y="96"/>
                    <tile tx="832" ty="128" x="0" y="128"/>
                    <tile tx="832" ty="128" x="0" y="160"/>
                    <tile tx="832" ty="128" x="0" y="192"/>
                    <tile tx="832" ty="128" x="0" y="224"/>
                    <tile tx="832" ty="128" x="0" y="256"/>
                    <tile tx="832" ty="128" x="0" y="288"/>
                    <tile tx="832" ty="128" x="0" y="320"/>
                    <tile tx="832" ty="128" x="0" y="352"/>
                    <tile tx="832" ty="128" x="0" y="384"/>
                    <tile tx="832" ty="128" x="0" y="416"/>
                    <tile tx="832" ty="128" x="0" y="448"/>
                    <tile tx="832" ty="128" x="0" y="480"/>
                    <tile tx="832" ty="160" x="0" y="512"/>
                    <tile tx="864" ty="96" x="32" y="0"/>
                    <tile tx="192" ty="288" x="32" y="32"/>
                    <tile tx="64" ty="320" x="32" y="64"/>
                    <tile tx="64" ty="320" x="32" y="96"/>
                    <tile tx="32" ty="320" x="32" y="128"/>
                    <tile tx="32" ty="320" x="32" y="160"/>
                    <tile tx="32" ty="288" x="32" y="192"/>
                    <tile tx="32" ty="320" x="32" y="224"/>
                    <tile tx="32" ty="288" x="32" y="256"/>
                    <tile tx="32" ty="320" x="32" y="288"/>
                    <tile tx="192" ty="288" x="32" y="320"/>
                    <tile tx="32" ty="320" x="32" y="352"/>
                    <tile tx="192" ty="288" x="32" y="384"/>
                    <tile tx="32" ty="320" x="32" y="416"/>
                    <tile tx="32" ty="320" x="32" y="448"/>
                    <tile tx="32" ty="288" x="32" y="480"/>
                    <tile tx="864" ty="160" x="32" y="512"/>
                    <tile tx="864" ty="96" x="64" y="0"/>
                    <tile tx="32" ty="320" x="64" y="32"/>
                    <tile tx="32" ty="320" x="64" y="64"/>
                    <tile tx="32" ty="320" x="64" y="96"/>
                    <tile tx="32" ty="288" x="64" y="128"/>
                    <tile tx="32" ty="320" x="64" y="160"/>
                    <tile tx="64" ty="288" x="64" y="192"/>
                    <tile tx="160" ty="320" x="64" y="224"/>
                    <tile tx="64" ty="320" x="64" y="256"/>
                    <tile tx="32" ty="320" x="64" y="288"/>
                    <tile tx="32" ty="320" x="64" y="320"/>
                    <tile tx="32" ty="288" x="64" y="352"/>
                    <tile tx="32" ty="320" x="64" y="384"/>
                    <tile tx="64" ty="288" x="64" y="416"/>
                    <tile tx="160" ty="288" x="64" y="448"/>
                    <tile tx="192" ty="288" x="64" y="480"/>
                    <tile tx="864" ty="160" x="64" y="512"/>
                    <tile tx="864" ty="96" x="96" y="0"/>
                    <tile tx="128" ty="352" x="96" y="32"/>
                    <tile tx="0" ty="320" x="96" y="64"/>
                    <tile tx="32" ty="320" x="96" y="96"/>
                    <tile tx="32" ty="288" x="96" y="128"/>
                    <tile tx="32" ty="320" x="96" y="160"/>
                    <tile tx="32" ty="320" x="96" y="192"/>
                    <tile tx="32" ty="320" x="96" y="224"/>
                    <tile tx="32" ty="320" x="96" y="256"/>
                    <tile tx="32" ty="288" x="96" y="288"/>
                    <tile tx="32" ty="320" x="96" y="320"/>
                    <tile tx="32" ty="288" x="96" y="352"/>
                    <tile tx="32" ty="320" x="96" y="384"/>
                    <tile tx="32" ty="320" x="96" y="416"/>
                    <tile tx="32" ty="288" x="96" y="448"/>
                    <tile tx="32" ty="320" x="96" y="480"/>
                    <tile tx="864" ty="160" x="96" y="512"/>
                    <tile tx="864" ty="96" x="128" y="0"/>
                    <tile tx="32" ty="320" x="128" y="32"/>
                    <tile tx="32" ty="288" x="128" y="64"/>
                    <tile tx="128" ty="352" x="128" y="96"/>
                    <tile tx="32" ty="320" x="128" y="128"/>
                    <tile tx="192" ty="320" x="128" y="160"/>
                    <tile tx="0" ty="320" x="128" y="192"/>
                    <tile tx="192" ty="320" x="128" y="224"/>
                    <tile tx="96" ty="288" x="128" y="256"/>
                    <tile tx="64" ty="320" x="128" y="288"/>
                    <tile tx="32" ty="320" x="128" y="320"/>
                    <tile tx="64" ty="288" x="128" y="352"/>
                    <tile tx="160" ty="288" x="128" y="384"/>
                    <tile tx="32" ty="320" x="128" y="416"/>
                    <tile tx="32" ty="288" x="128" y="448"/>
                    <tile tx="32" ty="320" x="128" y="480"/>
                    <tile tx="864" ty="160" x="128" y="512"/>
                    <tile tx="864" ty="96" x="160" y="0"/>
                    <tile tx="128" ty="352" x="160" y="32"/>
                    <tile tx="32" ty="320" x="160" y="64"/>
                    <tile tx="32" ty="320" x="160" y="96"/>
                    <tile tx="64" ty="288" x="160" y="128"/>
                    <tile tx="32" ty="320" x="160" y="160"/>
                    <tile tx="32" ty="288" x="160" y="192"/>
                    <tile tx="32" ty="320" x="160" y="224"/>
                    <tile tx="32" ty="320" x="160" y="256"/>
                    <tile tx="32" ty="320" x="160" y="288"/>
                    <tile tx="32" ty="320" x="160" y="320"/>
                    <tile tx="32" ty="320" x="160" y="352"/>
                    <tile tx="32" ty="288" x="160" y="384"/>
                    <tile tx="32" ty="320" x="160" y="416"/>
                    <tile tx="64" ty="288" x="160" y="448"/>
                    <tile tx="160" ty="288" x="160" y="480"/>
                    <tile tx="864" ty="160" x="160" y="512"/>
                    <tile tx="864" ty="96" x="192" y="0"/>
                    <tile tx="32" ty="320" x="192" y="32"/>
                    <tile tx="32" ty="288" x="192" y="64"/>
                    <tile tx="32" ty="320" x="192" y="96"/>
                    <tile tx="32" ty="320" x="192" y="128"/>
                    <tile tx="32" ty="320" x="192" y="160"/>
                    <tile tx="32" ty="288" x="192" y="192"/>
                    <tile tx="32" ty="320" x="192" y="224"/>
                    <tile tx="0" ty="288" x="192" y="256"/>
                    <tile tx="32" ty="320" x="192" y="288"/>
                    <tile tx="0" ty="288" x="192" y="320"/>
                    <tile tx="192" ty="320" x="192" y="352"/>
                    <tile tx="32" ty="320" x="192" y="384"/>
                    <tile tx="32" ty="320" x="192" y="416"/>
                    <tile tx="32" ty="320" x="192" y="448"/>
                    <tile tx="32" ty="288" x="192" y="480"/>
                    <tile tx="864" ty="160" x="192" y="512"/>
                    <tile tx="864" ty="96" x="224" y="0"/>
                    <tile tx="160" ty="288" x="224" y="32"/>
                    <tile tx="192" ty="288" x="224" y="64"/>
                    <tile tx="160" ty="320" x="224" y="96"/>
                    <tile tx="96" ty="288" x="224" y="128"/>
                    <tile tx="96" ty="288" x="224" y="160"/>
                    <tile tx="32" ty="320" x="224" y="192"/>
                    <tile tx="128" ty="352" x="224" y="224"/>
                    <tile tx="32" ty="320" x="224" y="256"/>
                    <tile tx="32" ty="320" x="224" y="288"/>
                    <tile tx="32" ty="288" x="224" y="320"/>
                    <tile tx="32" ty="320" x="224" y="352"/>
                    <tile tx="32" ty="288" x="224" y="384"/>
                    <tile tx="128" ty="352" x="224" y="416"/>
                    <tile tx="32" ty="320" x="224" y="448"/>
                    <tile tx="32" ty="288" x="224" y="480"/>
                    <tile tx="864" ty="160" x="224" y="512"/>
                    <tile tx="864" ty="96" x="256" y="0"/>
                    <tile tx="32" ty="320" x="256" y="32"/>
                    <tile tx="32" ty="320" x="256" y="64"/>
                    <tile tx="32" ty="320" x="256" y="96"/>
                    <tile tx="32" ty="320" x="256" y="128"/>
                    <tile tx="32" ty="320" x="256" y="160"/>
                    <tile tx="64" ty="288" x="256" y="192"/>
                    <tile tx="32" ty="320" x="256" y="224"/>
                    <tile tx="64" ty="288" x="256" y="256"/>
                    <tile tx="160" ty="320" x="256" y="288"/>
                    <tile tx="32" ty="320" x="256" y="320"/>
                    <tile tx="32" ty="320" x="256" y="352"/>
                    <tile tx="32" ty="288" x="256" y="384"/>
                    <tile tx="32" ty="320" x="256" y="416"/>
                    <tile tx="32" ty="320" x="256" y="448"/>
                    <tile tx="32" ty="288" x="256" y="480"/>
                    <tile tx="864" ty="160" x="256" y="512"/>
                    <tile tx="864" ty="96" x="288" y="0"/>
                    <tile tx="32" ty="320" x="288" y="32"/>
                    <tile tx="160" ty="320" x="288" y="64"/>
                    <tile tx="96" ty="288" x="288" y="96"/>
                    <tile tx="0" ty="320" x="288" y="128"/>
                    <tile tx="32" ty="320" x="288" y="160"/>
                    <tile tx="32" ty="320" x="288" y="192"/>
                    <tile tx="32" ty="320" x="288" y="224"/>
                    <tile tx="32" ty="320" x="288" y="256"/>
                    <tile tx="32" ty="320" x="288" y="288"/>
                    <tile tx="32" ty="288" x="288" y="320"/>
                    <tile tx="32" ty="320" x="288" y="352"/>
                    <tile tx="32" ty="288" x="288" y="384"/>
                    <tile tx="32" ty="320" x="288" y="416"/>
                    <tile tx="0" ty="288" x="288" y="448"/>
                    <tile tx="192" ty="288" x="288" y="480"/>
                    <tile tx="864" ty="160" x="288" y="512"/>
                    <tile tx="864" ty="96" x="320" y="0"/>
                    <tile tx="32" ty="320" x="320" y="32"/>
                    <tile tx="32" ty="320" x="320" y="64"/>
                    <tile tx="32" ty="320" x="320" y="96"/>
                    <tile tx="32" ty="288" x="320" y="128"/>
                    <tile tx="128" ty="352" x="320" y="160"/>
                    <tile tx="96" ty="288" x="320" y="192"/>
                    <tile tx="96" ty="288" x="320" y="224"/>
                    <tile tx="96" ty="288" x="320" y="256"/>
                    <tile tx="96" ty="288" x="320" y="288"/>
                    <tile tx="64" ty="320" x="320" y="320"/>
                    <tile tx="32" ty="320" x="320" y="352"/>
                    <tile tx="32" ty="288" x="320" y="384"/>
                    <tile tx="32" ty="320" x="320" y="416"/>
                    <tile tx="32" ty="288" x="320" y="448"/>
                    <tile tx="32" ty="320" x="320" y="480"/>
                    <tile tx="864" ty="160" x="320" y="512"/>
                    <tile tx="864" ty="96" x="352" y="0"/>
                    <tile tx="160" ty="288" x="352" y="32"/>
                    <tile tx="192" ty="320" x="352" y="64"/>
                    <tile tx="32" ty="320" x="352" y="96"/>
                    <tile tx="32" ty="288" x="352" y="128"/>
                    <tile tx="32" ty="320" x="352" y="160"/>
                    <tile tx="32" ty="320" x="352" y="192"/>
                    <tile tx="32" ty="320" x="352" y="224"/>
                    <tile tx="32" ty="320" x="352" y="256"/>
                    <tile tx="32" ty="320" x="352" y="288"/>
                    <tile tx="32" ty="320" x="352" y="320"/>
                    <tile tx="32" ty="320" x="352" y="352"/>
                    <tile tx="32" ty="288" x="352" y="384"/>
                    <tile tx="128" ty="352" x="352" y="416"/>
                    <tile tx="64" ty="320" x="352" y="448"/>
                    <tile tx="32" ty="320" x="352" y="480"/>
                    <tile tx="864" ty="160" x="352" y="512"/>
                    <tile tx="864" ty="96" x="384" y="0"/>
                    <tile tx="32" ty="320" x="384" y="32"/>
                    <tile tx="32" ty="320" x="384" y="64"/>
                    <tile tx="32" ty="320" x="384" y="96"/>
                    <tile tx="32" ty="288" x="384" y="128"/>
                    <tile tx="128" ty="352" x="384" y="160"/>
                    <tile tx="32" ty="320" x="384" y="192"/>
                    <tile tx="128" ty="288" x="384" y="224"/>
                    <tile tx="96" ty="288" x="384" y="256"/>
                    <tile tx="0" ty="320" x="384" y="288"/>
                    <tile tx="192" ty="320" x="384" y="320"/>
                    <tile tx="96" ty="288" x="384" y="352"/>
                    <tile tx="32" ty="320" x="384" y="384"/>
                    <tile tx="32" ty="320" x="384" y="416"/>
                    <tile tx="32" ty="320" x="384" y="448"/>
                    <tile tx="32" ty="320" x="384" y="480"/>
                    <tile tx="864" ty="160" x="384" y="512"/>
                    <tile tx="864" ty="96" x="416" y="0"/>
                    <tile tx="32" ty="320" x="416" y="32"/>
                    <tile tx="32" ty="320" x="416" y="64"/>
                    <tile tx="128" ty="288" x="416" y="96"/>
                    <tile tx="32" ty="320" x="416" y="128"/>
                    <tile tx="32" ty="320" x="416" y="160"/>
                    <tile tx="32" ty="320" x="416" y="192"/>
                    <tile tx="32" ty="320" x="416" y="224"/>
                    <tile tx="32" ty="320" x="416" y="256"/>
                    <tile tx="32" ty="288" x="416" y="288"/>
                    <tile tx="32" ty="320" x="416" y="320"/>
                    <tile tx="32" ty="320" x="416" y="352"/>
                    <tile tx="64" ty="288" x="416" y="384"/>
                    <tile tx="160" ty="320" x="416" y="416"/>
                    <tile tx="96" ty="288" x="416" y="448"/>
                    <tile tx="32" ty="320" x="416" y="480"/>
                    <tile tx="864" ty="160" x="416" y="512"/>
                    <tile tx="864" ty="96" x="448" y="0"/>
                    <tile tx="32" ty="320" x="448" y="32"/>
                    <tile tx="32" ty="320" x="448" y="64"/>
                    <tile tx="32" ty="320" x="448" y="96"/>
                    <tile tx="32" ty="288" x="448" y="128"/>
                    <tile tx="32" ty="320" x="448" y="160"/>
                    <tile tx="0" ty="288" x="448" y="192"/>
                    <tile tx="192" ty="320" x="448" y="224"/>
                    <tile tx="0" ty="320" x="448" y="256"/>
                    <tile tx="192" ty="288" x="448" y="288"/>
                    <tile tx="160" ty="288" x="448" y="320"/>
                    <tile tx="32" ty="320" x="448" y="352"/>
                    <tile tx="32" ty="320" x="448" y="384"/>
                    <tile tx="32" ty="320" x="448" y="416"/>
                    <tile tx="32" ty="320" x="448" y="448"/>
                    <tile tx="32" ty="320" x="448" y="480"/>
                    <tile tx="864" ty="160" x="448" y="512"/>
                    <tile tx="864" ty="96" x="480" y="0"/>
                    <tile tx="32" ty="320" x="480" y="32"/>
                    <tile tx="160" ty="288" x="480" y="64"/>
                    <tile tx="0" ty="320" x="480" y="96"/>
                    <tile tx="32" ty="320" x="480" y="128"/>
                    <tile tx="160" ty="288" x="480" y="160"/>
                    <tile tx="32" ty="320" x="480" y="192"/>
                    <tile tx="32" ty="320" x="480" y="224"/>
                    <tile tx="32" ty="288" x="480" y="256"/>
                    <tile tx="32" ty="320" x="480" y="288"/>
                    <tile tx="32" ty="288" x="480" y="320"/>
                    <tile tx="160" ty="288" x="480" y="352"/>
                    <tile tx="0" ty="320" x="480" y="384"/>
                    <tile tx="0" ty="320" x="480" y="416"/>
                    <tile tx="0" ty="320" x="480" y="448"/>
                    <tile tx="0" ty="320" x="480" y="480"/>
                    <tile tx="864" ty="160" x="480" y="512"/>
                    <tile tx="896" ty="96" x="512" y="0"/>
                    <tile tx="896" ty="128" x="512" y="32"/>
                    <tile tx="896" ty="128" x="512" y="64"/>
                    <tile tx="896" ty="128" x="512" y="96"/>
                    <tile tx="896" ty="128" x="512" y="128"/>
                    <tile tx="896" ty="128" x="512" y="160"/>
                    <tile tx="896" ty="128" x="512" y="192"/>
                    <tile tx="896" ty="128" x="512" y="224"/>
                    <tile tx="896" ty="128" x="512" y="256"/>
                    <tile tx="896" ty="128" x="512" y="288"/>
                    <tile tx="896" ty="128" x="512" y="320"/>
                    <tile tx="896" ty="128" x="512" y="352"/>
                    <tile tx="896" ty="128" x="512" y="384"/>
                    <tile tx="896" ty="128" x="512" y="416"/>
                    <tile tx="896" ty="128" x="512" y="448"/>
                    <tile tx="896" ty="128" x="512" y="480"/>
                    <tile tx="896" ty="160" x="512" y="512"/>
                </layer0>
                <layer1 set="tiles">
                    <tile tx="256" ty="320" x="0" y="160"/>
                    <tile tx="256" ty="320" x="0" y="224"/>
                    <tile tx="256" ty="320" x="0" y="448"/>
                    <tile tx="352" ty="288" x="32" y="32"/>
                    <tile tx="256" ty="288" x="32" y="64"/>
                    <tile tx="384" ty="288" x="32" y="96"/>
                    <tile tx="544" ty="0" x="32" y="160"/>
                    <tile tx="640" ty="0" x="32" y="224"/>
                    <tile tx="384" ty="288" x="32" y="256"/>
                    <tile tx="320" ty="288" x="32" y="288"/>
                    <tile tx="320" ty="288" x="32" y="384"/>
                    <tile tx="832" ty="0" x="32" y="448"/>
                    <tile tx="448" ty="288" x="32" y="480"/>
                    <tile tx="512" ty="0" x="64" y="32"/>
                    <tile tx="512" ty="32" x="64" y="64"/>
                    <tile tx="544" ty="64" x="64" y="96"/>
                    <tile tx="384" ty="288" x="64" y="128"/>
                    <tile tx="736" ty="0" x="64" y="160"/>
                    <tile tx="256" ty="288" x="64" y="192"/>
                    <tile tx="416" ty="288" x="64" y="224"/>
                    <tile tx="384" ty="288" x="64" y="256"/>
                    <tile tx="544" ty="0" x="64" y="320"/>
                    <tile tx="448" ty="288" x="64" y="352"/>
                    <tile tx="768" ty="0" x="64" y="384"/>
                    <tile tx="448" ty="288" x="64" y="416"/>
                    <tile tx="416" ty="288" x="64" y="448"/>
                    <tile tx="320" ty="288" x="96" y="32"/>
                    <tile tx="352" ty="288" x="96" y="64"/>
                    <tile tx="608" ty="0" x="96" y="96"/>
                    <tile tx="416" ty="288" x="96" y="128"/>
                    <tile tx="576" ty="32" x="96" y="160"/>
                    <tile tx="512" ty="32" x="96" y="192"/>
                    <tile tx="512" ty="32" x="96" y="224"/>
                    <tile tx="512" ty="64" x="96" y="256"/>
                    <tile tx="576" ty="0" x="96" y="320"/>
                    <tile tx="576" ty="32" x="96" y="384"/>
                    <tile tx="544" ty="64" x="96" y="416"/>
                    <tile tx="288" ty="288" x="96" y="448"/>
                    <tile tx="544" ty="0" x="96" y="480"/>
                    <tile tx="288" ty="320" x="96" y="512"/>
                    <tile tx="640" ty="0" x="128" y="32"/>
                    <tile tx="320" ty="288" x="128" y="64"/>
                    <tile tx="288" ty="288" x="128" y="128"/>
                    <tile tx="320" ty="288" x="128" y="160"/>
                    <tile tx="384" ty="288" x="128" y="224"/>
                    <tile tx="448" ty="288" x="128" y="256"/>
                    <tile tx="256" ty="288" x="128" y="288"/>
                    <tile tx="576" ty="0" x="128" y="320"/>
                    <tile tx="288" ty="288" x="128" y="384"/>
                    <tile tx="576" ty="0" x="128" y="416"/>
                    <tile tx="608" ty="0" x="128" y="480"/>
                    <tile tx="288" ty="320" x="128" y="512"/>
                    <tile tx="384" ty="288" x="160" y="32"/>
                    <tile tx="544" ty="0" x="160" y="96"/>
                    <tile tx="352" ty="288" x="160" y="128"/>
                    <tile tx="544" ty="0" x="160" y="160"/>
                    <tile tx="544" ty="32" x="160" y="224"/>
                    <tile tx="512" ty="32" x="160" y="256"/>
                    <tile tx="608" ty="32" x="160" y="288"/>
                    <tile tx="640" ty="64" x="160" y="320"/>
                    <tile tx="512" ty="64" x="160" y="352"/>
                    <tile tx="416" ty="288" x="160" y="384"/>
                    <tile tx="736" ty="0" x="160" y="416"/>
                    <tile tx="384" ty="288" x="160" y="448"/>
                    <tile tx="256" ty="288" x="160" y="480"/>
                    <tile tx="640" ty="0" x="192" y="32"/>
                    <tile tx="256" ty="288" x="192" y="64"/>
                    <tile tx="576" ty="32" x="192" y="96"/>
                    <tile tx="512" ty="32" x="192" y="128"/>
                    <tile tx="576" ty="64" x="192" y="160"/>
                    <tile tx="448" ty="288" x="192" y="192"/>
                    <tile tx="608" ty="0" x="192" y="224"/>
                    <tile tx="480" ty="288" x="192" y="256"/>
                    <tile tx="672" ty="32" x="192" y="288"/>
                    <tile tx="480" ty="288" x="192" y="320"/>
                    <tile tx="576" ty="32" x="192" y="416"/>
                    <tile tx="544" ty="64" x="192" y="448"/>
                    <tile tx="448" ty="288" x="192" y="480"/>
                    <tile tx="256" ty="288" x="224" y="64"/>
                    <tile tx="480" ty="288" x="224" y="128"/>
                    <tile tx="320" ty="288" x="224" y="160"/>
                    <tile tx="288" ty="288" x="224" y="192"/>
                    <tile tx="384" ty="288" x="224" y="256"/>
                    <tile tx="608" ty="0" x="224" y="288"/>
                    <tile tx="448" ty="288" x="224" y="320"/>
                    <tile tx="544" ty="0" x="224" y="352"/>
                    <tile tx="416" ty="288" x="224" y="384"/>
                    <tile tx="480" ty="288" x="224" y="416"/>
                    <tile tx="576" ty="0" x="224" y="448"/>
                    <tile tx="352" ty="288" x="224" y="480"/>
                    <tile tx="416" ty="288" x="256" y="32"/>
                    <tile tx="512" ty="0" x="256" y="64"/>
                    <tile tx="512" ty="32" x="256" y="96"/>
                    <tile tx="512" ty="32" x="256" y="128"/>
                    <tile tx="544" ty="64" x="256" y="160"/>
                    <tile tx="544" ty="0" x="256" y="224"/>
                    <tile tx="352" ty="288" x="256" y="320"/>
                    <tile tx="576" ty="0" x="256" y="352"/>
                    <tile tx="352" ty="288" x="256" y="384"/>
                    <tile tx="544" ty="32" x="256" y="416"/>
                    <tile tx="576" ty="64" x="256" y="448"/>
                    <tile tx="384" ty="288" x="256" y="480"/>
                    <tile tx="320" ty="288" x="288" y="32"/>
                    <tile tx="480" ty="288" x="288" y="64"/>
                    <tile tx="416" ty="288" x="288" y="96"/>
                    <tile tx="480" ty="288" x="288" y="128"/>
                    <tile tx="576" ty="32" x="288" y="160"/>
                    <tile tx="672" ty="64" x="288" y="192"/>
                    <tile tx="640" ty="64" x="288" y="224"/>
                    <tile tx="512" ty="32" x="288" y="256"/>
                    <tile tx="512" ty="64" x="288" y="288"/>
                    <tile tx="288" ty="288" x="288" y="320"/>
                    <tile tx="672" ty="32" x="288" y="352"/>
                    <tile tx="576" ty="0" x="288" y="416"/>
                    <tile tx="288" ty="288" x="288" y="448"/>
                    <tile tx="512" ty="0" x="320" y="32"/>
                    <tile tx="672" ty="64" x="320" y="64"/>
                    <tile tx="544" ty="64" x="320" y="96"/>
                    <tile tx="352" ty="288" x="320" y="128"/>
                    <tile tx="416" ty="288" x="320" y="160"/>
                    <tile tx="288" ty="288" x="320" y="192"/>
                    <tile tx="416" ty="288" x="320" y="224"/>
                    <tile tx="448" ty="288" x="320" y="256"/>
                    <tile tx="320" ty="288" x="320" y="288"/>
                    <tile tx="352" ty="288" x="320" y="320"/>
                    <tile tx="576" ty="0" x="320" y="352"/>
                    <tile tx="608" ty="0" x="320" y="416"/>
                    <tile tx="448" ty="288" x="320" y="448"/>
                    <tile tx="544" ty="0" x="320" y="480"/>
                    <tile tx="288" ty="320" x="320" y="512"/>
                    <tile tx="384" ty="288" x="352" y="32"/>
                    <tile tx="320" ty="288" x="352" y="64"/>
                    <tile tx="736" ty="0" x="352" y="96"/>
                    <tile tx="512" ty="0" x="352" y="160"/>
                    <tile tx="608" ty="32" x="352" y="192"/>
                    <tile tx="512" ty="32" x="352" y="224"/>
                    <tile tx="512" ty="32" x="352" y="256"/>
                    <tile tx="512" ty="32" x="352" y="288"/>
                    <tile tx="512" ty="32" x="352" y="320"/>
                    <tile tx="576" ty="64" x="352" y="352"/>
                    <tile tx="448" ty="288" x="352" y="384"/>
                    <tile tx="672" ty="32" x="352" y="480"/>
                    <tile tx="288" ty="320" x="352" y="512"/>
                    <tile tx="544" ty="32" x="384" y="64"/>
                    <tile tx="576" ty="64" x="384" y="96"/>
                    <tile tx="320" ty="288" x="384" y="128"/>
                    <tile tx="288" ty="288" x="384" y="160"/>
                    <tile tx="736" ty="0" x="384" y="192"/>
                    <tile tx="448" ty="288" x="384" y="224"/>
                    <tile tx="256" ty="288" x="384" y="256"/>
                    <tile tx="288" ty="288" x="384" y="320"/>
                    <tile tx="480" ty="288" x="384" y="352"/>
                    <tile tx="352" ty="288" x="384" y="384"/>
                    <tile tx="512" ty="0" x="384" y="416"/>
                    <tile tx="512" ty="32" x="384" y="448"/>
                    <tile tx="608" ty="64" x="384" y="480"/>
                    <tile tx="288" ty="320" x="384" y="512"/>
                    <tile tx="320" ty="288" x="416" y="32"/>
                    <tile tx="576" ty="0" x="416" y="64"/>
                    <tile tx="256" ty="288" x="416" y="96"/>
                    <tile tx="544" ty="32" x="416" y="160"/>
                    <tile tx="640" ty="64" x="416" y="192"/>
                    <tile tx="512" ty="32" x="416" y="224"/>
                    <tile tx="512" ty="64" x="416" y="256"/>
                    <tile tx="512" ty="0" x="416" y="320"/>
                    <tile tx="544" ty="64" x="416" y="352"/>
                    <tile tx="352" ty="288" x="416" y="384"/>
                    <tile tx="256" ty="288" x="416" y="416"/>
                    <tile tx="576" ty="0" x="416" y="480"/>
                    <tile tx="288" ty="320" x="416" y="512"/>
                    <tile tx="352" ty="288" x="448" y="32"/>
                    <tile tx="576" ty="32" x="448" y="64"/>
                    <tile tx="512" ty="64" x="448" y="96"/>
                    <tile tx="608" ty="0" x="448" y="160"/>
                    <tile tx="480" ty="288" x="448" y="192"/>
                    <tile tx="256" ty="288" x="448" y="224"/>
                    <tile tx="416" ty="288" x="448" y="256"/>
                    <tile tx="480" ty="288" x="448" y="288"/>
                    <tile tx="576" ty="32" x="448" y="352"/>
                    <tile tx="512" ty="32" x="448" y="384"/>
                    <tile tx="512" ty="32" x="448" y="416"/>
                    <tile tx="672" ty="64" x="448" y="448"/>
                    <tile tx="576" ty="64" x="448" y="480"/>
                    <tile tx="288" ty="320" x="448" y="512"/>
                    <tile tx="288" ty="288" x="480" y="32"/>
                    <tile tx="288" ty="288" x="480" y="64"/>
                    <tile tx="384" ty="288" x="480" y="96"/>
                    <tile tx="256" ty="288" x="480" y="128"/>
                    <tile tx="416" ty="288" x="480" y="192"/>
                    <tile tx="640" ty="0" x="480" y="224"/>
                    <tile tx="480" ty="288" x="480" y="256"/>
                    <tile tx="640" ty="0" x="480" y="288"/>
                    <tile tx="352" ty="288" x="480" y="320"/>
                    <tile tx="480" ty="288" x="480" y="416"/>
                    <tile tx="224" ty="320" x="512" y="224"/>
                    <tile tx="224" ty="320" x="512" y="288"/>
                </layer1>
                <layer2 set="tiles">
                    <tile tx="736" ty="32" x="32" y="160"/>
                    <tile tx="704" ty="0" x="64" y="64"/>
                    <tile tx="736" ty="32" x="64" y="96"/>
                    <tile tx="704" ty="0" x="96" y="224"/>
                    <tile tx="736" ty="64" x="96" y="256"/>
                    <tile tx="704" ty="64" x="96" y="320"/>
                    <tile tx="736" ty="32" x="128" y="480"/>
                    <tile tx="736" ty="64" x="160" y="160"/>
                    <tile tx="704" ty="0" x="160" y="256"/>
                    <tile tx="704" ty="32" x="160" y="352"/>
                    <tile tx="704" ty="64" x="192" y="32"/>
                    <tile tx="736" ty="32" x="192" y="224"/>
                    <tile tx="704" ty="64" x="224" y="448"/>
                    <tile tx="704" ty="32" x="256" y="224"/>
                    <tile tx="704" ty="0" x="320" y="64"/>
                    <tile tx="736" ty="32" x="320" y="96"/>
                    <tile tx="736" ty="32" x="320" y="416"/>
                    <tile tx="736" ty="64" x="352" y="352"/>
                    <tile tx="704" ty="0" x="384" y="448"/>
                    <tile tx="704" ty="64" x="416" y="64"/>
                    <tile tx="736" ty="32" x="416" y="256"/>
                    <tile tx="736" ty="64" x="416" y="480"/>
                    <tile tx="704" ty="32" x="480" y="224"/>
                </layer2>
                <actors>
                    <shroom x="352" y="64" arrow="1" shield="2" skull="3" sword="4" heart="5" foot="6" customStats="false" hp="2" attack="2" defense="2" movement="4" attackRangeMin="1" attackRangeMax="1"/>
                    <shroom x="192" y="256" arrow="0" shield="0" skull="0" sword="0" heart="0" foot="0" customStats="false" hp="2" attack="2" defense="2" movement="4" attackRangeMin="1" attackRangeMax="1"/>
                    <shroom x="416" y="448" arrow="0" shield="0" skull="0" sword="0" heart="0" foot="0" customStats="false" hp="2" attack="2" defense="2" movement="4" attackRangeMin="1" attackRangeMax="1"/>
                    <shroom x="32" y="192" arrow="0" shield="0" skull="0" sword="0" heart="0" foot="0" customStats="false" hp="2" attack="2" defense="2" movement="4" attackRangeMin="1" attackRangeMax="1"/>
                    <soldier x="224" y="416" arrow="0" shield="0" skull="0" sword="0" heart="0" foot="0" customStats="false" hp="2" attack="2" defense="2" movement="4" attackRangeMin="1" attackRangeMax="1"/>
                    <soldier x="128" y="352" arrow="0" shield="0" skull="0" sword="0" heart="0" foot="0" customStats="false" hp="2" attack="2" defense="2" movement="4" attackRangeMin="1" attackRangeMax="1"/>
                    <soldier x="384" y="160" arrow="0" shield="0" skull="0" sword="0" heart="0" foot="0" customStats="false" hp="2" attack="2" defense="2" movement="4" attackRangeMin="1" attackRangeMax="1"/>
                    <soldier x="160" y="32" arrow="0" shield="0" skull="0" sword="0" heart="0" foot="0" customStats="false" hp="2" attack="2" defense="2" movement="4" attackRangeMin="1" attackRangeMax="1"/>
                    <soldier x="448" y="320" arrow="0" shield="0" skull="0" sword="0" heart="0" foot="0" customStats="false" hp="2" attack="2" defense="2" movement="4" attackRangeMin="1" attackRangeMax="1"/>
                    <soldier x="352" y="448" arrow="0" shield="0" skull="1" sword="2" heart="0" foot="0" customStats="false" hp="2" attack="2"  defense="2" movement="4" attackRangeMin="1" attackRangeMax="1"/>
                    <soldier x="448" y="192" arrow="0" shield="0" skull="0" sword="0" heart="0" foot="0" customStats="true" hp="5" attack="5" defense="6" movement="7" attackRangeMin="8" attackRangeMax="9"/>
                </actors>
            </level>;
    }
}