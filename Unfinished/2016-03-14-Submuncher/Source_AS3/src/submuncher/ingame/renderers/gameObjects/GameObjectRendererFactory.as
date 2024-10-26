package submuncher.ingame.renderers.gameObjects {
    import starling.textures.Texture;

    import submuncher.core.constants.GameObjectType;
    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.SpriteNames;
    import submuncher.core.constants.SpriteTextureCollections;
    import submuncher.ingame.gameObjects.BonusAmmo;
    import submuncher.ingame.gameObjects.BonusKey;
    import submuncher.ingame.gameObjects.BossFish;
    import submuncher.ingame.gameObjects.BulletPenetratingLaser;
    import submuncher.ingame.gameObjects.BulletShellAcid;
    import submuncher.ingame.gameObjects.BulletTorpedo;
    import submuncher.ingame.gameObjects.EnemyBlob;
    import submuncher.ingame.gameObjects.EnemyEel;
    import submuncher.ingame.gameObjects.EnemyEelSegment;
    import submuncher.ingame.gameObjects.EnemyEye;
    import submuncher.ingame.gameObjects.EnemyFish;
    import submuncher.ingame.gameObjects.EnemyGhostSub;
    import submuncher.ingame.gameObjects.EnemyJellyfish;
    import submuncher.ingame.gameObjects.EnemyJellyfishSegment;
    import submuncher.ingame.gameObjects.EnemyShell;
    import submuncher.ingame.gameObjects.EnemySpikes;
    import submuncher.ingame.gameObjects.EnemySpinningBlades;
    import submuncher.ingame.gameObjects.ObjectDoor;
    import submuncher.ingame.gameObjects.ObjectSponge;
    import submuncher.ingame.gameObjects.EnemyTurtle;
    import submuncher.ingame.gameObjects.GameObject;
    import submuncher.ingame.gameObjects.ObjectBarrier;
    import submuncher.ingame.gameObjects.ObjectDetector;
    import submuncher.ingame.gameObjects.ObjectFakeWall;
    import submuncher.ingame.gameObjects.ObjectFloorTrigger;
    import submuncher.ingame.gameObjects.ObjectPlayer;
    import submuncher.ingame.gameObjects.SpecialLevelEntrance;
    import submuncher.ingame.gameObjects.SpecialStatsScreen;
    import submuncher.ingame.renderers.core.LevelFrontend;

    public class GameObjectRendererFactory {
        public static function createRenderer(gameObject:GameObject, frontend:LevelFrontend):GameObjectRendererBase {
            switch (gameObject.objectType) {
                case(GameObjectType.PLAYER):
                    return createPlayerRenderer(gameObject as ObjectPlayer, frontend);

                case(GameObjectType.DNA_STRAND):
                    return createAnimatedRenderer(gameObject, SpriteTextureCollections.dna, 0.02, frontend);

                case(GameObjectType.DNA_SECRET_STRAND):
                    return createAnimatedRenderer(gameObject, SpriteTextureCollections.dnaSecret, 0.02, frontend);

                case(GameObjectType.DOCUMENT):
                    return createUnanimatedRenderer(gameObject, SpriteNames.DOCUMENT, frontend);

                case(GameObjectType.FISH):
                    return createFishRenderer(gameObject as EnemyFish, frontend);

                case(GameObjectType.BOSS_FISH):
                    return new GameObjectRendererBossFish(gameObject as BossFish, frontend);

                case(GameObjectType.TURTLE):
                    return createTurtleRenderer(gameObject as EnemyTurtle, frontend);

                case(GameObjectType.BLOB):
                    return createBlobRenderer(gameObject as EnemyBlob, frontend);

                case(GameObjectType.EYE):
                    return createEyeRenderer(gameObject as EnemyEye, frontend);

                case(GameObjectType.SHELL):
                    return new GameObjectRendererShell(gameObject as EnemyShell, frontend);

                case(GameObjectType.CRATE_WEAK):
                    return createUnanimatedRenderer(gameObject, SpriteNames.CRATE_WEAK, frontend);

                case(GameObjectType.CRATE_STRONG):
                    return createUnanimatedRenderer(gameObject, SpriteNames.CRATE_STRONG, frontend);

                case(GameObjectType.SPIKES):
                    return new GameObjectRendererSpikes(gameObject as EnemySpikes, frontend);

                case(GameObjectType.KEY):
                    return createUnanimatedRenderer(gameObject, SpriteNames.getKeySpriteName(gameObject as BonusKey), frontend);

                case(GameObjectType.BARRIER):
                    return new GameObjectRendererBarrier(gameObject as ObjectBarrier, frontend);

                case(GameObjectType.DETECTOR):
                    return new GameObjectRendererDetector(gameObject as ObjectDetector, frontend);

                case(GameObjectType.BARREL):
                    return createUnanimatedRenderer(gameObject, SpriteNames.BARREL, frontend);

                case(GameObjectType.SPINNING_BLADES):
                    return new GameObjectRendererSpinningBlades(gameObject as EnemySpinningBlades, frontend);

                case(GameObjectType.GHOST_SUB):
                    return new GameObjectRendererGhostSub(gameObject as EnemyGhostSub, frontend);

                case(GameObjectType.TORPEDO):
                    return new GameObjectRendererTorpedo(gameObject as BulletTorpedo, frontend);

                case(GameObjectType.BULLET_SHELL):
                    return new GameObjectRendererShellAcid(gameObject as BulletShellAcid, frontend);

                case(GameObjectType.FAKE_WALL):
                    return new GameObjectRendererFakeWall(gameObject as ObjectFakeWall, frontend);

                case(GameObjectType.SPONGE):
                    return new GameObjectRendererSponge(gameObject as ObjectSponge, frontend);

                case(GameObjectType.EEL):
                    return new GameObjectRendererEelHead(gameObject as EnemyEel, frontend);

                case(GameObjectType.EEL_SEGMENT):
                    return new GameObjectRendererEelSegment(gameObject as EnemyEelSegment, frontend);

                case(GameObjectType.JELLYFISH):
                    return new GameObjectRendererJellyfishHead(gameObject as EnemyJellyfish, frontend);

                case(GameObjectType.JELLYFISH_SEGMENT):
                    return new GameObjectRendererJellyfishSegment(gameObject as EnemyJellyfishSegment, frontend);

                case(GameObjectType.SCREEN):
                    return new GameObjectRendererLevelGroupScreen(gameObject as SpecialStatsScreen, frontend);

                case(GameObjectType.LEVEL_ENTRANCE):
                    return createLevelEntranceRenderer(gameObject as SpecialLevelEntrance, frontend);

                case(GameObjectType.FLOOR_TRIGGER):
                    return new GameObjectRendererTrigger(gameObject as ObjectFloorTrigger, frontend);

                case(GameObjectType.BULLET_PENETRATING_LASER):
                    return new GameObjectRendererPenetratingLaser(gameObject as BulletPenetratingLaser, frontend);

                case(GameObjectType.DOOR):
                    return new GameObjectRendererDoor(gameObject as ObjectDoor, frontend);

                case(GameObjectType.AMMO):
                    return createAmmoRenderer(gameObject as BonusAmmo, frontend);

                default:
                    throw new ArgumentError("Invalid game object given: " + gameObject);
            }
        }

        private static function createAnimatedRenderer(object:GameObject, textures:Vector.<Texture>, animationSpeed:Number, levelRenderer:LevelFrontend):GameObjectRendererBase {
            var renderer:GameObjectRendererAnimated = new GameObjectRendererAnimated(object, animationSpeed, levelRenderer);
            renderer.setTextures(textures);

            renderer.update();

            return renderer;
        }

        private static function createAmmoRenderer(object:BonusAmmo, levelRenderer:LevelFrontend):GameObjectRendererBase {
            var spriteName:String;
            switch(object.amount){
                case(1): spriteName = SpriteNames.AMMO_1; break;
                case(5): spriteName = SpriteNames.AMMO_5; break;
                case(100): spriteName = SpriteNames.AMMO_INFINITE; break;
                default: throw new Error("Invalid ammo amount: " + object.amount);
            }
            var renderer:GameObjectRendererUnanimated = new GameObjectRendererUnanimated(spriteName, object, levelRenderer);

            return renderer;
        }

        private static function createUnanimatedRenderer(object:GameObject, sprite:String, levelRenderer:LevelFrontend):GameObjectRendererBase {
            return new GameObjectRendererUnanimated(sprite, object, levelRenderer);
        }

        private static function createPlayerRenderer(player:ObjectPlayer, levelRenderer:LevelFrontend):GameObjectRendererBase {
            var renderer:GameObjectRendererPlayer = new GameObjectRendererPlayer(player, levelRenderer);

            renderer.update();

            return renderer;
        }

        private static function createFishRenderer(fish:EnemyFish, levelRenderer:LevelFrontend):GameObjectRendererBase {
            var renderer:GameObjectRendererAnimatedDirectional = new GameObjectRendererAnimatedDirectional(fish, levelRenderer);
            renderer.setTextures(
                SpriteTextureCollections.fishUp,
                SpriteTextureCollections.fishRight,
                SpriteTextureCollections.fishDown,
                SpriteTextureCollections.fishLeft
            );

            renderer.update();

            return renderer;
        }

        private static function createLevelEntranceRenderer(entrance:SpecialLevelEntrance, levelRenderer:LevelFrontend):GameObjectRendererBase {
            var renderer:GameObjectRendererUnanimatedDirectional = new GameObjectRendererUnanimatedDirectional(entrance, levelRenderer);
            renderer.setTextures(
                Gfx.spritesAtlas.getTexture(SpriteNames.ENTRANCE_UP),
                Gfx.spritesAtlas.getTexture(SpriteNames.ENTRANCE_RIGHT),
                Gfx.spritesAtlas.getTexture(SpriteNames.ENTRANCE_DOWN),
                Gfx.spritesAtlas.getTexture(SpriteNames.ENTRANCE_LEFT)
            );

            renderer.update();

            return renderer;
        }

        private static function createBlobRenderer(blob:EnemyBlob, levelRenderer:LevelFrontend):GameObjectRendererBase {
            var renderer:GameObjectRendererAnimated = new GameObjectRendererAnimated(blob, 0.5 / blob.getSpeed(), levelRenderer);
            renderer.setTextures(new <Texture>[
                Gfx.spritesAtlas.getTexture(SpriteNames.BLOB_1),
                Gfx.spritesAtlas.getTexture(SpriteNames.BLOB_2),
                Gfx.spritesAtlas.getTexture(SpriteNames.BLOB_3),
                Gfx.spritesAtlas.getTexture(SpriteNames.BLOB_2)
            ]);

            renderer.update();

            return renderer;
        }

        private static function createEyeRenderer(eye:EnemyEye, levelRenderer:LevelFrontend):GameObjectRendererBase {
            var renderer:GameObjectRendererUnanimatedDirectional = new GameObjectRendererUnanimatedDirectional(eye, levelRenderer);
            renderer.setTextures(
                Gfx.spritesAtlas.getTexture(SpriteNames.EYE_UP),
                Gfx.spritesAtlas.getTexture(SpriteNames.EYE_RIGHT),
                Gfx.spritesAtlas.getTexture(SpriteNames.EYE_DOWN),
                Gfx.spritesAtlas.getTexture(SpriteNames.EYE_LEFT)
            );

            renderer.update();

            return renderer;
        }

        private static function createTurtleRenderer(turtle:EnemyTurtle, levelRenderer:LevelFrontend):GameObjectRendererBase {
            var renderer:GameObjectRendererEnemyTurtle = new GameObjectRendererEnemyTurtle(turtle, levelRenderer);
            if (turtle.clockwisity.isCW) {
                renderer.setTextures(
                    SpriteTextureCollections.turtleClockwiseUp,
                    SpriteTextureCollections.turtleClockwiseRight,
                    SpriteTextureCollections.turtleClockwiseDown,
                    SpriteTextureCollections.turtleClockwiseLeft
                );
            } else {
                renderer.setTextures(
                    SpriteTextureCollections.turtleCounterClockwiseUp,
                    SpriteTextureCollections.turtleCounterClockwiseRight,
                    SpriteTextureCollections.turtleCounterClockwiseDown,
                    SpriteTextureCollections.turtleCounterClockwiseLeft
                );
            }

            renderer.update();

            return renderer;
        }

    }
}
