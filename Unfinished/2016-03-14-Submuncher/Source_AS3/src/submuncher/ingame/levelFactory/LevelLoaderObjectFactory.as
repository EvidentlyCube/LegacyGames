package submuncher.ingame.levelFactory {
    import flash.geom.Point;

    import net.retrocade.enums.Axis;
    import net.retrocade.enums.Clockwisity;
    import net.retrocade.enums.Direction4;

    import submuncher.core.constants.LockColor;
    import submuncher.ingame.core.Level;
    import submuncher.ingame.gameObjects.BonusAmmo;
    import submuncher.ingame.gameObjects.BonusDna;
    import submuncher.ingame.gameObjects.BonusDnaSecret;
    import submuncher.ingame.gameObjects.BonusDocument;
    import submuncher.ingame.gameObjects.BonusKey;
    import submuncher.ingame.gameObjects.BossFish;
    import submuncher.ingame.gameObjects.EnemyBarrel;
    import submuncher.ingame.gameObjects.EnemyBlob;
    import submuncher.ingame.gameObjects.EnemyEye;
    import submuncher.ingame.gameObjects.EnemyFish;
    import submuncher.ingame.gameObjects.EnemyGhostSub;
    import submuncher.ingame.gameObjects.EnemyJellyfish;
    import submuncher.ingame.gameObjects.EnemyShell;
    import submuncher.ingame.gameObjects.EnemySpikes;
    import submuncher.ingame.gameObjects.EnemySpinningBlades;
    import submuncher.ingame.gameObjects.EnemyTurtle;
    import submuncher.ingame.gameObjects.ObjectBarrier;
    import submuncher.ingame.gameObjects.ObjectCrate;
    import submuncher.ingame.gameObjects.ObjectDetector;
    import submuncher.ingame.gameObjects.ObjectDoor;
    import submuncher.ingame.gameObjects.ObjectFakeWall;
    import submuncher.ingame.gameObjects.ObjectFloorTrigger;
    import submuncher.ingame.gameObjects.ObjectPlayer;
    import submuncher.ingame.gameObjects.ObjectSponge;
    import submuncher.ingame.gameObjects.SpecialLevelEntrance;
    import submuncher.ingame.gameObjects.SpecialStatsScreen;

    public class LevelLoaderObjectFactory {
        public static function createObject(item:XML, level:Level):void {
            switch (item.name().toString()) {
                case("player"):
                    var player:ObjectPlayer = new ObjectPlayer(level, item.@x, item.@y, Direction4.RIGHT);
                    level.player = player;
                    level.gameObjectsList.add(player);
                    break;

                case("waste"):
                    level.gameObjectsList.add(new BonusDna(level, item.@x, item.@y));
                    break;

                case("waste_secret"):
                    level.gameObjectsList.add(new BonusDnaSecret(level, item.@x, item.@y));
                    break;

                case("document"):
                    level.gameObjectsList.add(new BonusDocument(level, item.@x, item.@y));
                    break;

                case("fakeWall"):
                    level.gameObjectsList.add(new ObjectFakeWall(level, item.@x, item.@y));
                    break;

                case("keyRed"):
                    level.gameObjectsList.add(new BonusKey(level, item.@x, item.@y, LockColor.RED));
                    break;

                case("keyGreen"):
                    level.gameObjectsList.add(new BonusKey(level, item.@x, item.@y, LockColor.GREEN));
                    break;

                case("keyBlue"):
                    level.gameObjectsList.add(new BonusKey(level, item.@x, item.@y, LockColor.BLUE));
                    break;

                case("keyOrange"):
                    level.gameObjectsList.add(new BonusKey(level, item.@x, item.@y, LockColor.ORANGE));
                    break;

                case("keyGray"):
                    level.gameObjectsList.add(new BonusKey(level, item.@x, item.@y, LockColor.GRAY));
                    break;

                case("spikes"):
                    if (item.@timeTotal > 0) {
                        level.gameObjectsList.add(new EnemySpikes(level, item.@x, item.@y, item.@timeTotal, item.@timeDangerous, item.@timeOffset));
                    } else {
                        level.gameObjectsList.add(new EnemySpikes(level, item.@x, item.@y, item.@timeUp + item.@timeDown, item.@timeUp, item.@timeOffset));
                    }
                    break;

                case("turtleCWRight"):
                    level.gameObjectsList.add(new EnemyTurtle(level, item.@x, item.@y, Direction4.RIGHT, Clockwisity.CLOCKWISE, item.@speed, item.@hp));
                    break;

                case("turtleCWLeft"):
                    level.gameObjectsList.add(new EnemyTurtle(level, item.@x, item.@y, Direction4.LEFT, Clockwisity.CLOCKWISE, item.@speed, item.@hp));
                    break;

                case("turtleCWUp"):
                    level.gameObjectsList.add(new EnemyTurtle(level, item.@x, item.@y, Direction4.UP, Clockwisity.CLOCKWISE, item.@speed, item.@hp));
                    break;

                case("turtleCWDown"):
                    level.gameObjectsList.add(new EnemyTurtle(level, item.@x, item.@y, Direction4.DOWN, Clockwisity.CLOCKWISE, item.@speed, item.@hp));
                    break;

                case("turtleCcWRight"):
                    level.gameObjectsList.add(new EnemyTurtle(level, item.@x, item.@y, Direction4.RIGHT, Clockwisity.COUNTER_CLOCKWISE, item.@speed, item.@hp));
                    break;

                case("turtleCCWLeft"):
                    level.gameObjectsList.add(new EnemyTurtle(level, item.@x, item.@y, Direction4.LEFT, Clockwisity.COUNTER_CLOCKWISE, item.@speed, item.@hp));
                    break;

                case("turtleCCWUp"):
                    level.gameObjectsList.add(new EnemyTurtle(level, item.@x, item.@y, Direction4.UP, Clockwisity.COUNTER_CLOCKWISE, item.@speed, item.@hp));
                    break;

                case("turtleCCWDown"):
                    level.gameObjectsList.add(new EnemyTurtle(level, item.@x, item.@y, Direction4.DOWN, Clockwisity.COUNTER_CLOCKWISE, item.@speed, item.@hp));
                    break;

                case("fishUp"):
                    level.gameObjectsList.add(new EnemyFish(level, item.@x, item.@y, Direction4.UP, item.@speed, item.@hp));
                    break;

                case("fishRight"):
                    level.gameObjectsList.add(new EnemyFish(level, item.@x, item.@y, Direction4.RIGHT, item.@speed, item.@hp));
                    break;

                case("fishDown"):
                    level.gameObjectsList.add(new EnemyFish(level, item.@x, item.@y, Direction4.DOWN, item.@speed, item.@hp));
                    break;

                case("fishLeft"):
                    level.gameObjectsList.add(new EnemyFish(level, item.@x, item.@y, Direction4.LEFT, item.@speed, item.@hp));
                    break;

                case("crate"):
                    level.gameObjectsList.add(new ObjectCrate(level, item.@x, item.@y, false));
                    break;

                case("crateSteel"):
                    level.gameObjectsList.add(new ObjectCrate(level, item.@x, item.@y, true));
                    break;

                case("blob"):
                    level.gameObjectsList.add(new EnemyBlob(level, item.@x, item.@y, item.@speed, item.@hp));
                    break;
                //
                //                    case("ammo1"):
                //                        new TAmmo(item.@x, item.@y, AmmoType.SMALL);
                //                        break;
                //
                //                    case("ammo2"):
                //                        new TAmmo(item.@x, item.@y, AmmoType.BIG);
                //                        break;
                //
                //                    case("ammo3"):
                //                        new TAmmo(item.@x, item.@y, AmmoType.INFINITE);
                //                        break;
                //
                case("eyeUp"):
                    level.gameObjectsList.add(new EnemyEye(level, item.@x, item.@y, Direction4.UP, item.@hp));
                    break;

                case("eyeDown"):
                    level.gameObjectsList.add(new EnemyEye(level, item.@x, item.@y, Direction4.DOWN, item.@hp));
                    break;

                case("eyeLeft"):
                    level.gameObjectsList.add(new EnemyEye(level, item.@x, item.@y, Direction4.LEFT, item.@hp));
                    break;

                case("eyeRight"):
                    level.gameObjectsList.add(new EnemyEye(level, item.@x, item.@y, Direction4.RIGHT, item.@hp));
                    break;

                case("shellUp"):
                    level.gameObjectsList.add(new EnemyShell(level, item.@x, item.@y, Direction4.UP, item.@firePause, item.@bulletSpeed, item.@hp));
                    break;

                case("shellDown"):
                    level.gameObjectsList.add(new EnemyShell(level, item.@x, item.@y, Direction4.DOWN, item.@firePause, item.@bulletSpeed, item.@hp));
                    break;

                case("shellLeft"):
                    level.gameObjectsList.add(new EnemyShell(level, item.@x, item.@y, Direction4.LEFT, item.@firePause, item.@bulletSpeed, item.@hp));
                    break;

                case("shellRight"):
                    level.gameObjectsList.add(new EnemyShell(level, item.@x, item.@y, Direction4.RIGHT, item.@firePause, item.@bulletSpeed, item.@hp));
                    break;

                case("barrel"):
                    level.gameObjectsList.add(new EnemyBarrel(level, item.@x, item.@y));
                    break;

                case("spinBlade"):
                    level.gameObjectsList.add(new EnemySpinningBlades(level, item.@x, item.@y, item.@rotationRadius, item.@rotationAngle, item.@speed, item.@hp));
                    break;

                case("ghostSub"):
                    level.gameObjectsList.add(new EnemyGhostSub(level, item.@x, item.@y, item.@startDelay, item.@hp));
                    break;
                case("sponge"):
                    level.gameObjectsList.add(new ObjectSponge(level, item.@x, item.@y));
                    break;


                case("barrierRedH"):
                    level.gameObjectsList.add(new ObjectBarrier(level, item.@x, item.@y, LockColor.RED, Axis.HORIZONTAL));
                    break;

                case("barrierGreenH"):
                    level.gameObjectsList.add(new ObjectBarrier(level, item.@x, item.@y, LockColor.GREEN, Axis.HORIZONTAL));
                    break;

                case("barrierBlueH"):
                    level.gameObjectsList.add(new ObjectBarrier(level, item.@x, item.@y, LockColor.BLUE, Axis.HORIZONTAL));
                    break;

                case("barrierOrangeH"):
                    level.gameObjectsList.add(new ObjectBarrier(level, item.@x, item.@y, LockColor.ORANGE, Axis.HORIZONTAL));
                    break;

                case("barrierGrayH"):
                    level.gameObjectsList.add(new ObjectBarrier(level, item.@x, item.@y, LockColor.GRAY, Axis.HORIZONTAL));
                    break;

                case("barrierRedV"):
                    level.gameObjectsList.add(new ObjectBarrier(level, item.@x, item.@y, LockColor.RED, Axis.VERTICAL));
                    break;

                case("barrierGreenV"):
                    level.gameObjectsList.add(new ObjectBarrier(level, item.@x, item.@y, LockColor.GREEN, Axis.VERTICAL));
                    break;

                case("barrierBlueV"):
                    level.gameObjectsList.add(new ObjectBarrier(level, item.@x, item.@y, LockColor.BLUE, Axis.VERTICAL));
                    break;

                case("barrierOrangeV"):
                    level.gameObjectsList.add(new ObjectBarrier(level, item.@x, item.@y, LockColor.ORANGE, Axis.VERTICAL));
                    break;

                case("barrierGrayV"):
                    level.gameObjectsList.add(new ObjectBarrier(level, item.@x, item.@y, LockColor.GRAY, Axis.VERTICAL));
                    break;


                case("detectorRed"):
                    level.gameObjectsList.add(new ObjectDetector(level, item.@x, item.@y, LockColor.RED));
                    break;

                case("detectorGreen"):
                    level.gameObjectsList.add(new ObjectDetector(level, item.@x, item.@y, LockColor.GREEN));
                    break;

                case("detectorBlue"):
                    level.gameObjectsList.add(new ObjectDetector(level, item.@x, item.@y, LockColor.BLUE));
                    break;

                case("detectorOrange"):
                    level.gameObjectsList.add(new ObjectDetector(level, item.@x, item.@y, LockColor.ORANGE));
                    break;

                case("detectorGray"):
                    level.gameObjectsList.add(new ObjectDetector(level, item.@x, item.@y, LockColor.GRAY));
                    break;

                case("jellyfish"):
                    level.gameObjectsList.add(new EnemyJellyfish(level, item.@x, item.@y, getEelTailPositions(item.@x, item.@y, item.node), item.@speed, item.@hp));
                    break;

                case("levelScreen"):
                    level.gameObjectsList.add(new SpecialStatsScreen(level, item.@x, item.@y, item.@groupId));
                    break;

                case("entranceUp"):
                    level.gameObjectsList.add(new SpecialLevelEntrance(level, item.@x, item.@y, item.@groupId, Direction4.UP));
                    break;
                case("entranceRight"):
                    level.gameObjectsList.add(new SpecialLevelEntrance(level, item.@x, item.@y, item.@groupId, Direction4.RIGHT));
                    break;
                case("entranceDown"):
                    level.gameObjectsList.add(new SpecialLevelEntrance(level, item.@x, item.@y, item.@groupId, Direction4.DOWN));
                    break;
                case("entranceLeft"):
                    level.gameObjectsList.add(new SpecialLevelEntrance(level, item.@x, item.@y, item.@groupId, Direction4.LEFT));
                    break;

                case("triggerBlue"):
                    level.gameObjectsList.add(new ObjectFloorTrigger(level, item.@x, item.@y, LockColor.BLUE));
                    break;
                case("triggerGray"):
                    level.gameObjectsList.add(new ObjectFloorTrigger(level, item.@x, item.@y, LockColor.GRAY));
                    break;
                case("triggerGreen"):
                    level.gameObjectsList.add(new ObjectFloorTrigger(level, item.@x, item.@y, LockColor.GREEN));
                    break;
                case("triggerOrange"):
                    level.gameObjectsList.add(new ObjectFloorTrigger(level, item.@x, item.@y, LockColor.ORANGE));
                    break;
                case("triggerRed"):
                    level.gameObjectsList.add(new ObjectFloorTrigger(level, item.@x, item.@y, LockColor.RED));
                    break;
                case("fishBoss"):
                    level.gameObjectsList.add(new BossFish(level, item.@x, item.@y));
                    break;
                case("doorBlue"):
                    level.gameObjectsList.add(new ObjectDoor(level, item.@x, item.@y, LockColor.BLUE));
                    break;
                case("doorGray"):
                    level.gameObjectsList.add(new ObjectDoor(level, item.@x, item.@y, LockColor.GRAY));
                    break;
                case("doorGreen"):
                    level.gameObjectsList.add(new ObjectDoor(level, item.@x, item.@y, LockColor.GREEN));
                    break;
                case("doorOrange"):
                    level.gameObjectsList.add(new ObjectDoor(level, item.@x, item.@y, LockColor.ORANGE));
                    break;
                case("doorRed"):
                    level.gameObjectsList.add(new ObjectDoor(level, item.@x, item.@y, LockColor.RED));
                    break;
                case("ammo1"):
                    level.gameObjectsList.add(new BonusAmmo(level, item.@x, item.@y, 1));
                    break;
                case("ammo2"):
                    level.gameObjectsList.add(new BonusAmmo(level, item.@x, item.@y, 5));
                    break;
                case("ammo3"):
                    level.gameObjectsList.add(new BonusAmmo(level, item.@x, item.@y, 100));
                    break;

            }
        }

        private static function getEelTailPositions(x:Number, y:Number, nodes:XMLList):Vector.<Point> {
            A::SSERT{
                ASSERT(nodes.length() > 0);
            }

            var points:Vector.<Point> = new Vector.<Point>();

            for (var i:int = 0; i < nodes.length(); i++) {
                var node:XML = nodes[i];

                var dx:Number = node.@x - x;
                var dy:Number = node.@y - y;

                x += dx;
                y += dy;

                points.push(new Point(x, y));

                A::SSERT{
                    ASSERT(Math.abs(dx) === 16 || Math.abs(dy) === 16);
                }
                A::SSERT{
                    ASSERT(dx !== 0 || dy !== 0);
                }
                A::SSERT{
                    ASSERT(dx === 0 || dy === 0);
                }
            }

            return points;
        }

        private static function getNode(nodes:XMLList):Point {
            A::SSERT{
                ASSERT(nodes.length() === 1);
            }

            return new Point(
                    parseInt(nodes[0].@x),
                    parseInt(nodes[0].@y)
            );
        }
    }
}
