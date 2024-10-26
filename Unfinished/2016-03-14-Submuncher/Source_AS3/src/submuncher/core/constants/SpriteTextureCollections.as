package submuncher.core.constants {
    import net.retrocade.enums.Axis;

    import starling.textures.Texture;

    public class SpriteTextureCollections {
        private static var _cache:Object = {};

        public static function get explosionA():Vector.<Texture>{
            if (!_cache.hasOwnProperty('explosionA')){
                _cache['explosionA'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_A_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_A_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_A_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_A_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_A_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_A_5),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_A_6),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_A_7),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_A_8),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_A_9),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_A_10)
                ];
            }

            return _cache['explosionA'];
        }

        public static function get explosionB():Vector.<Texture>{
            if (!_cache.hasOwnProperty('explosionB')){
                _cache['explosionB'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_5),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_6),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_7),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_8),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_9),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_10),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_11),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_B_12)
                ];
            }

            return _cache['explosionB'];
        }

        public static function get explosionC():Vector.<Texture>{
            if (!_cache.hasOwnProperty('explosionC')){
                _cache['explosionC'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_5),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_6),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_7),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_8),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_9),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_10),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_11),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_12),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_13),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_C_14)
                ];
            }

            return _cache['explosionC'];
        }
        
        public static function get explosionD():Vector.<Texture>{
            if (!_cache.hasOwnProperty('explosionD')){
                _cache['explosionD'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_5),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_6),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_7),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_8),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_9),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_10),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_11),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_12),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_13),
                    Gfx.spritesAtlas.getTexture(SpriteNames.PARTICLE_EXPLOSION_D_14)
                ];
            }

            return _cache['explosionD'];
        }

        public static function get shellBulletExplosion():Vector.<Texture>{
            if (!_cache.hasOwnProperty('shellBulletExplosion')){
                _cache['shellBulletExplosion'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_BULLET_EXPLOSION_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_BULLET_EXPLOSION_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_BULLET_EXPLOSION_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_BULLET_EXPLOSION_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_BULLET_EXPLOSION_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_BULLET_EXPLOSION_5)
                ];
            }

            return _cache['shellBulletExplosion'];
        }

        public static function get spikes():Vector.<Texture>{
            if (!_cache.hasOwnProperty('spikes')){
                _cache['spikes'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPIKES_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPIKES_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPIKES_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPIKES_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPIKES_4)
                ];
            }

            return _cache['spikes'];
        }

        public static function get dna():Vector.<Texture>{
            if (!_cache.hasOwnProperty('dna')){
                _cache['dna'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_5),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_6),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_7),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_8),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_9)
                ];
            }

            return _cache['dna'];
        }

        public static function get dnaSecret():Vector.<Texture>{
            if (!_cache.hasOwnProperty('dnaSecret')){
                _cache['dnaSecret'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_SECRET_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_SECRET_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_SECRET_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_SECRET_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_SECRET_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_SECRET_5),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_SECRET_6),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_SECRET_7),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_SECRET_8),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DNA_SECRET_9)
                ];
            }

            return _cache['dnaSecret'];
        }

        public static function get turtleClockwiseUp():Vector.<Texture>{
            if (!_cache.hasOwnProperty('turtleClockwiseUp')){
                _cache['turtleClockwiseUp'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_UP_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_UP_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_UP_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_UP_1)
                ];
            }

            return _cache['turtleClockwiseUp'];
        }

        public static function get turtleClockwiseRight():Vector.<Texture>{
            if (!_cache.hasOwnProperty('turtleClockwiseRight')){
                _cache['turtleClockwiseRight'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_RIGHT_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_RIGHT_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_RIGHT_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_RIGHT_1)
                ];
            }

            return _cache['turtleClockwiseRight'];
        }

        public static function get turtleClockwiseDown():Vector.<Texture>{
            if (!_cache.hasOwnProperty('turtleClockwiseDown')){
                _cache['turtleClockwiseDown'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_DOWN_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_DOWN_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_DOWN_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_DOWN_1)
                ];
            }

            return _cache['turtleClockwiseDown'];
        }

        public static function get turtleClockwiseLeft():Vector.<Texture>{
            if (!_cache.hasOwnProperty('turtleClockwiseLeft')){
                _cache['turtleClockwiseLeft'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_LEFT_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_LEFT_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_LEFT_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CW_LEFT_1)
                ];
            }

            return _cache['turtleClockwiseLeft'];
        }

        public static function get turtleCounterClockwiseUp():Vector.<Texture>{
            if (!_cache.hasOwnProperty('turtleCounterClockwiseUp')){
                _cache['turtleCounterClockwiseUp'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_UP_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_UP_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_UP_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_UP_1)
                ];
            }

            return _cache['turtleCounterClockwiseUp'];
        }

        public static function get turtleCounterClockwiseRight():Vector.<Texture>{
            if (!_cache.hasOwnProperty('turtleCounterClockwiseRight')){
                _cache['turtleCounterClockwiseRight'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_RIGHT_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_RIGHT_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_RIGHT_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_RIGHT_1)
                ];
            }

            return _cache['turtleCounterClockwiseRight'];
        }

        public static function get turtleCounterClockwiseDown():Vector.<Texture>{
            if (!_cache.hasOwnProperty('turtleCounterClockwiseDown')){
                _cache['turtleCounterClockwiseDown'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_DOWN_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_DOWN_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_DOWN_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_DOWN_1)
                ];
            }

            return _cache['turtleCounterClockwiseDown'];
        }

        public static function get turtleCounterClockwiseLeft():Vector.<Texture>{
            if (!_cache.hasOwnProperty('turtleCounterClockwiseLeft')){
                _cache['turtleCounterClockwiseLeft'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_LEFT_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_LEFT_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_LEFT_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TURTLE_CCW_LEFT_1)
                ];
            }

            return _cache['turtleCounterClockwiseLeft'];
        }

        public static function get fishUp():Vector.<Texture>{
            if (!_cache.hasOwnProperty('fishUp')){
                _cache['fishUp'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_UP_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_UP_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_UP_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_UP_1)
                ];
            }

            return _cache['fishUp'];
        }

        public static function get fishRight():Vector.<Texture>{
            if (!_cache.hasOwnProperty('fishRight')){
                _cache['fishRight'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_RIGHT_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_RIGHT_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_RIGHT_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_RIGHT_1)
                ];
            }

            return _cache['fishRight'];
        }
        public static function get fishDown():Vector.<Texture>{
            if (!_cache.hasOwnProperty('fishDown')){
                _cache['fishDown'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_DOWN_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_DOWN_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_DOWN_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_DOWN_1)
                ];
            }

            return _cache['fishDown'];
        }
        public static function get fishLeft():Vector.<Texture>{
            if (!_cache.hasOwnProperty('fishLeft')){
                _cache['fishLeft'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_LEFT_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_LEFT_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_LEFT_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.FISH_LEFT_1)
                ];
            }

            return _cache['fishLeft'];
        }
        public static function get bossFishUp():Vector.<Texture>{
            if (!_cache.hasOwnProperty('bossFishUp')){
                _cache['bossFishUp'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_UP_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_UP_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_UP_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_UP_1)
                ];
            }

            return _cache['bossFishUp'];
        }

        public static function get bossFishRight():Vector.<Texture>{
            if (!_cache.hasOwnProperty('bossFishRight')){
                _cache['bossFishRight'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_RIGHT_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_RIGHT_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_RIGHT_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_RIGHT_1)
                ];
            }

            return _cache['bossFishRight'];
        }
        public static function get bossFishDown():Vector.<Texture>{
            if (!_cache.hasOwnProperty('bossFishDown')){
                _cache['bossFishDown'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_DOWN_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_DOWN_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_DOWN_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_DOWN_1)
                ];
            }

            return _cache['bossFishDown'];
        }
        public static function get bossFishLeft():Vector.<Texture>{
            if (!_cache.hasOwnProperty('bossFishLeft')){
                _cache['bossFishLeft'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_LEFT_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_LEFT_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_LEFT_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BOSS_FISH_LEFT_1)
                ];
            }

            return _cache['bossFishLeft'];
        }
        public static function get shellUp():Vector.<Texture>{
            if (!_cache.hasOwnProperty('shellUp')){
                _cache['shellUp'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_UP_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_UP_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_UP_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_UP_3)
                ];
            }

            return _cache['shellUp'];
        }

        public static function get shellRight():Vector.<Texture>{
            if (!_cache.hasOwnProperty('shellRight')){
                _cache['shellRight'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_RIGHT_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_RIGHT_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_RIGHT_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_RIGHT_3)
                ];
            }

            return _cache['shellRight'];
        }
        public static function get shellDown():Vector.<Texture>{
            if (!_cache.hasOwnProperty('shellDown')){
                _cache['shellDown'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_DOWN_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_DOWN_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_DOWN_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_DOWN_3)
                ];
            }

            return _cache['shellDown'];
        }

        public static function get shellLeft():Vector.<Texture>{
            if (!_cache.hasOwnProperty('shellLeft')){
                _cache['shellLeft'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_LEFT_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_LEFT_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_LEFT_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SHELL_LEFT_3)
                ];
            }

            return _cache['shellLeft'];
        }

        public static function get sponge():Vector.<Texture>{
            if (!_cache.hasOwnProperty('sponge')){
                _cache['sponge'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPONGE_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPONGE_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPONGE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPONGE_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPONGE_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPONGE_5)
                ];
            }

            return _cache['sponge'];
        }

        public static function get spongeDead():Vector.<Texture>{
            if (!_cache.hasOwnProperty('spongeDead')){
                _cache['spongeDead'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPONGE_DEAD_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPONGE_DEAD_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPONGE_DEAD_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPONGE_DEAD_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPONGE_DEAD_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.SPONGE_DEAD_5)
                ];
            }

            return _cache['spongeDead'];
        }

        public static function get detectorGray():Vector.<Texture>{
            if (!_cache.hasOwnProperty('detectorGray')){
                _cache['detectorGray'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_GRAY_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_GRAY_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_GRAY_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_GRAY_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_GRAY_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_GRAY_1)
                ];
            }

            return _cache['detectorGray'];
        }

        public static function get detectorOrange():Vector.<Texture>{
            if (!_cache.hasOwnProperty('detectorOrange')){
                _cache['detectorOrange'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_ORANGE_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_ORANGE_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_ORANGE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_ORANGE_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_ORANGE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_ORANGE_1)
                ];
            }

            return _cache['detectorOrange'];
        }

        public static function get detectorGreen():Vector.<Texture>{
            if (!_cache.hasOwnProperty('detectorGreen')){
                _cache['detectorGreen'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_GREEN_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_GREEN_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_GREEN_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_GREEN_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_GREEN_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_GREEN_1)
                ];
            }

            return _cache['detectorGreen'];
        }

        public static function get detectorRed():Vector.<Texture>{
            if (!_cache.hasOwnProperty('detectorRed')){
                _cache['detectorRed'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_RED_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_RED_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_RED_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_RED_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_RED_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_RED_1)
                ];
            }

            return _cache['detectorRed'];
        }

        public static function get detectorBlue():Vector.<Texture>{
            if (!_cache.hasOwnProperty('detectorBlue')){
                _cache['detectorBlue'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_BLUE_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_BLUE_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_BLUE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_BLUE_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_BLUE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DETECTOR_BLUE_1)
                ];
            }

            return _cache['detectorBlue'];
        }

        public static function get barrierHorizontalBlue():Vector.<Texture>{
            if (!_cache.hasOwnProperty('barrierHorizontalBlue')){
                _cache['barrierHorizontalBlue'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_BLUE_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_BLUE_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_BLUE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_BLUE_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_BLUE_4)
                ];
            }

            return _cache['barrierHorizontalBlue'];
        }
        
        public static function get barrierHorizontalGray():Vector.<Texture>{
            if (!_cache.hasOwnProperty('barrierHorizontalGray')){
                _cache['barrierHorizontalGray'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_GRAY_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_GRAY_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_GRAY_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_GRAY_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_GRAY_4)
                ];
            }

            return _cache['barrierHorizontalGray'];
        }

        public static function get barrierHorizontalGreen():Vector.<Texture>{
            if (!_cache.hasOwnProperty('barrierHorizontalGreen')){
                _cache['barrierHorizontalGreen'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_GREEN_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_GREEN_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_GREEN_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_GREEN_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_GREEN_4)
                ];
            }

            return _cache['barrierHorizontalGreen'];
        }

        public static function get barrierHorizontalOrange():Vector.<Texture>{
            if (!_cache.hasOwnProperty('barrierHorizontalOrange')){
                _cache['barrierHorizontalOrange'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_ORANGE_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_ORANGE_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_ORANGE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_ORANGE_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_ORANGE_4)
                ];
            }

            return _cache['barrierHorizontalOrange'];
        }

        public static function get barrierHorizontalRed():Vector.<Texture>{
            if (!_cache.hasOwnProperty('barrierHorizontalRed')){
                _cache['barrierHorizontalRed'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_RED_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_RED_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_RED_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_RED_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_HORIZONTAL_RED_4)
                ];
            }

            return _cache['barrierHorizontalRed'];
        }
        

        public static function get barrierVerticalBlue():Vector.<Texture>{
            if (!_cache.hasOwnProperty('barrierVerticalBlue')){
                _cache['barrierVerticalBlue'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_BLUE_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_BLUE_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_BLUE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_BLUE_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_BLUE_4)
                ];
            }

            return _cache['barrierVerticalBlue'];
        }
        
        public static function get barrierVerticalGray():Vector.<Texture>{
            if (!_cache.hasOwnProperty('barrierVerticalGray')){
                _cache['barrierVerticalGray'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_GRAY_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_GRAY_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_GRAY_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_GRAY_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_GRAY_4)
                ];
            }

            return _cache['barrierVerticalGray'];
        }

        public static function get barrierVerticalGreen():Vector.<Texture>{
            if (!_cache.hasOwnProperty('barrierVerticalGreen')){
                _cache['barrierVerticalGreen'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_GREEN_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_GREEN_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_GREEN_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_GREEN_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_GREEN_4)
                ];
            }

            return _cache['barrierVerticalGreen'];
        }

        public static function get barrierVerticalOrange():Vector.<Texture>{
            if (!_cache.hasOwnProperty('barrierVerticalOrange')){
                _cache['barrierVerticalOrange'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_ORANGE_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_ORANGE_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_ORANGE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_ORANGE_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_ORANGE_4)
                ];
            }

            return _cache['barrierVerticalOrange'];
        }

        public static function get barrierVerticalRed():Vector.<Texture>{
            if (!_cache.hasOwnProperty('barrierVerticalRed')){
                _cache['barrierVerticalRed'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_RED_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_RED_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_RED_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_RED_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BARRIER_VERTICAL_RED_4)
                ];
            }

            return _cache['barrierVerticalRed'];
        }

        public static function get triggerBlue():Vector.<Texture>{
            if (!_cache.hasOwnProperty('triggerBlue')){
                _cache['triggerBlue'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_BLUE_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_BLUE_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_BLUE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_BLUE_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_BLUE_4)
                ];
            }

            return _cache['triggerBlue'];
        }

        public static function get triggerGray():Vector.<Texture>{
            if (!_cache.hasOwnProperty('triggerGray')){
                _cache['triggerGray'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_GRAY_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_GRAY_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_GRAY_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_GRAY_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_GRAY_4)
                ];
            }

            return _cache['triggerGray'];
        }

        public static function get triggerGreen():Vector.<Texture>{
            if (!_cache.hasOwnProperty('triggerGreen')){
                _cache['triggerGreen'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_GREEN_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_GREEN_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_GREEN_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_GREEN_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_GREEN_4)
                ];
            }

            return _cache['triggerGreen'];
        }

        public static function get triggerOrange():Vector.<Texture>{
            if (!_cache.hasOwnProperty('triggerOrange')){
                _cache['triggerOrange'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_ORANGE_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_ORANGE_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_ORANGE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_ORANGE_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_ORANGE_4)
                ];
            }

            return _cache['triggerOrange'];
        }
        
        public static function get triggerRed():Vector.<Texture>{
            if (!_cache.hasOwnProperty('triggerRed')){
                _cache['triggerRed'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_RED_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_RED_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_RED_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_RED_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.TRIGGER_RED_4)
                ];
            }

            return _cache['triggerRed'];
        }
        
        public static function get jellyfish():Vector.<Texture>{
            if (!_cache.hasOwnProperty('jellyfish')){
                _cache['jellyfish'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_1)
                ];
            }

            return _cache['jellyfish'];
        }
        public static function get jellyfishBaby():Vector.<Texture>{
            if (!_cache.hasOwnProperty('jellyfishBaby')){
                _cache['jellyfishBaby'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_BABY_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_BABY_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_BABY_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_BABY_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_BABY_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_BABY_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_BABY_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_BABY_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_BABY_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.JELLYFISH_BABY_1)
                ];
            }

            return _cache['jellyfishBaby'];
        }
        public static function get bulletPenetratingLaser():Vector.<Texture>{
            if (!_cache.hasOwnProperty('bulletPenetratingLaser')){
                _cache['bulletPenetratingLaser'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.BULLET_PENETRATING_LASER_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BULLET_PENETRATING_LASER_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BULLET_PENETRATING_LASER_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BULLET_PENETRATING_LASER_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BULLET_PENETRATING_LASER_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.BULLET_PENETRATING_LASER_5)
                ];
            }

            return _cache['bulletPenetratingLaser'];
        }
        public static function get doorBlue():Vector.<Texture>{
            if (!_cache.hasOwnProperty('doorBlue')){
                _cache['doorBlue'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_BLUE_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_BLUE_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_BLUE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_BLUE_3)
                ];
            }

            return _cache['doorBlue'];
        }
        public static function get doorGray():Vector.<Texture>{
            if (!_cache.hasOwnProperty('doorGray')){
                _cache['doorGray'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_GRAY_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_GRAY_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_GRAY_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_GRAY_3)
                ];
            }

            return _cache['doorGray'];
        }
        public static function get doorGreen():Vector.<Texture>{
            if (!_cache.hasOwnProperty('doorGreen')){
                _cache['doorGreen'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_GREEN_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_GREEN_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_GREEN_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_GREEN_3)
                ];
            }

            return _cache['doorGreen'];
        }
        public static function get doorOrange():Vector.<Texture>{
            if (!_cache.hasOwnProperty('doorOrange')){
                _cache['doorOrange'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_ORANGE_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_ORANGE_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_ORANGE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_ORANGE_3)
                ];
            }

            return _cache['doorOrange'];
        }
        public static function get doorRed():Vector.<Texture>{
            if (!_cache.hasOwnProperty('doorRed')){
                _cache['doorRed'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_RED_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_RED_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_RED_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.DOOR_RED_3)
                ];
            }

            return _cache['doorRed'];
        }

        public static function get mine():Vector.<Texture>{
            if (!_cache.hasOwnProperty('mine')){
                _cache['mine'] = new <Texture>[
                    Gfx.spritesAtlas.getTexture(SpriteNames.MINE_0),
                    Gfx.spritesAtlas.getTexture(SpriteNames.MINE_1),
                    Gfx.spritesAtlas.getTexture(SpriteNames.MINE_2),
                    Gfx.spritesAtlas.getTexture(SpriteNames.MINE_3),
                    Gfx.spritesAtlas.getTexture(SpriteNames.MINE_4),
                    Gfx.spritesAtlas.getTexture(SpriteNames.MINE_5),
                    Gfx.spritesAtlas.getTexture(SpriteNames.MINE_6),
                    Gfx.spritesAtlas.getTexture(SpriteNames.MINE_7),
                    Gfx.spritesAtlas.getTexture(SpriteNames.MINE_8),
                    Gfx.spritesAtlas.getTexture(SpriteNames.MINE_9),
                    Gfx.spritesAtlas.getTexture(SpriteNames.MINE_10)
                ];
            }

            return _cache['mine'];
        }

        public static function getDoor(color:LockColor):Vector.<Texture> {
            switch(color){
                case(LockColor.RED): return doorRed;
                case(LockColor.GREEN): return doorGreen;
                case(LockColor.BLUE): return doorBlue;
                case(LockColor.ORANGE): return doorOrange;
                case(LockColor.GRAY): return doorGray;
                default: throw new ArgumentError("Invalid door color");
            }
        }
        public static function getDetector(color:LockColor):Vector.<Texture> {
            switch(color){
                case(LockColor.RED): return detectorRed;
                case(LockColor.GREEN): return detectorGreen;
                case(LockColor.BLUE): return detectorBlue;
                case(LockColor.ORANGE): return detectorOrange;
                case(LockColor.GRAY): return detectorGray;
                default: throw new ArgumentError("Invalid detector color");
            }
        }
        
        public static function getBarrier(color:LockColor, axis:Axis):Vector.<Texture> {
            if (axis === Axis.HORIZONTAL){
                switch(color){
                    case(LockColor.RED): return barrierHorizontalRed;
                    case(LockColor.GREEN): return barrierHorizontalGreen;
                    case(LockColor.BLUE): return barrierHorizontalBlue;
                    case(LockColor.ORANGE): return barrierHorizontalOrange;
                    case(LockColor.GRAY): return barrierHorizontalGray;
                    default: throw new ArgumentError("Invalid barrier color");
                }
            } else if (axis === Axis.VERTICAL){
                switch(color){
                    case(LockColor.RED): return barrierVerticalRed;
                    case(LockColor.GREEN): return barrierVerticalGreen;
                    case(LockColor.BLUE): return barrierVerticalBlue;
                    case(LockColor.ORANGE): return barrierVerticalOrange;
                    case(LockColor.GRAY): return barrierVerticalGray;
                    default: throw new ArgumentError("Invalid barrier color");
                }
            } else {
                throw new ArgumentError("Invalid axis");
            }
        }

        public static function getTrigger(color:LockColor):Vector.<Texture> {
            switch(color){
                case(LockColor.RED): return triggerRed;
                case(LockColor.GREEN): return triggerGreen;
                case(LockColor.BLUE): return triggerBlue;
                case(LockColor.ORANGE): return triggerOrange;
                case(LockColor.GRAY): return triggerGray;
                default: throw new ArgumentError("Invalid trigger color");
            }
        }

    }
}
