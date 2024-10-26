/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 17.02.13
 * Time: 09:20
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.core {
    import flash.media.Sound;
    import flash.utils.ByteArray;

    import net.retrocade.camel.global.rSfx;
    import net.retrocade.camel.objects.rSound;
    import net.retrocade.camel.objects.rSound;
    import net.retrocade.camel.objects.rSound;
    import net.retrocade.tacticengine.core.Eventer;
    import net.retrocade.tacticengine.monstro.ais.MonstroPlayerTurnProcess;
    import net.retrocade.tacticengine.monstro.events.MonstroEventTurnProcessChange;
    import net.retrocade.utils.Rand;

    public class MonstroSfx {
        [Embed(source="/../assets/music/musicMonsterTurn.mp3")] private static const _monsterTurn_class:Class;
        [Embed(source="/../assets/music/musicHumanTurn.mp3")] private static const _humanTurn_class:Class;

        [Embed(source="/../assets/sfx/beethroDie1.mp3")] private static const _beethro_die_1_class:Class;
        [Embed(source="/../assets/sfx/beethroDie2.mp3")] private static const _beethro_die_2_class:Class;
        [Embed(source="/../assets/sfx/beethroHit1.mp3")] private static const _beethro_hit_1_class:Class;
        [Embed(source="/../assets/sfx/beethroHit2.mp3")] private static const _beethro_hit_2_class:Class;
        [Embed(source="/../assets/sfx/beethroHit3.mp3")] private static const _beethro_hit_3_class:Class;
        [Embed(source="/../assets/sfx/beethroStart1.mp3")] private static const _beethro_start_1_class:Class;
        [Embed(source="/../assets/sfx/beethroStart2.mp3")] private static const _beethro_start_2_class:Class;
        [Embed(source="/../assets/sfx/beethroStart3.mp3")] private static const _beethro_start_3_class:Class;
        [Embed(source="/../assets/sfx/citizenDie1.mp3")] private static const _citizen_die_1_class:Class;
        [Embed(source="/../assets/sfx/citizenDie2.mp3")] private static const _citizen_die_2_class:Class;
        [Embed(source="/../assets/sfx/citizenHit1.mp3")] private static const _citizen_hit_1_class:Class;
        [Embed(source="/../assets/sfx/citizenHit2.mp3")] private static const _citizen_hit_2_class:Class;
        [Embed(source="/../assets/sfx/citizenStart1.mp3")] private static const _citizen_start_1_class:Class;
        [Embed(source="/../assets/sfx/citizenStart2.mp3")] private static const _citizen_start_2_class:Class;
        [Embed(source="/../assets/sfx/citizenStart3.mp3")] private static const _citizen_start_3_class:Class;
        [Embed(source="/../assets/sfx/goblinDie1.mp3")] private static const _goblin_die_1_class:Class;
        [Embed(source="/../assets/sfx/goblinDie2.mp3")] private static const _goblin_die_2_class:Class;
        [Embed(source="/../assets/sfx/goblinHit1.mp3")] private static const _goblin_hit_1_class:Class;
        [Embed(source="/../assets/sfx/goblinHit2.mp3")] private static const _goblin_hit_2_class:Class;
        [Embed(source="/../assets/sfx/humanStep1.mp3")] private static const _human_step_1_class:Class;
        [Embed(source="/../assets/sfx/humanStep2.mp3")] private static const _human_step_2_class:Class;
        [Embed(source="/../assets/sfx/monsterDie1.mp3")] private static const _monster_die_1_class:Class;
        [Embed(source="/../assets/sfx/monsterDie2.mp3")] private static const _monster_die_2_class:Class;
        [Embed(source="/../assets/sfx/monsterDie3.mp3")] private static const _monster_die_3_class:Class;
        [Embed(source="/../assets/sfx/monsterHit1.mp3")] private static const _monster_hit_1_class:Class;
        [Embed(source="/../assets/sfx/monsterHit2.mp3")] private static const _monster_hit_2_class:Class;
        [Embed(source="/../assets/sfx/monsterHit3.mp3")] private static const _monster_hit_3_class:Class;
        [Embed(source="/../assets/sfx/monsterStep1.mp3")] private static const _monster_step_1_class:Class;
        [Embed(source="/../assets/sfx/monsterStep2.mp3")] private static const _monster_step_2_class:Class;
        [Embed(source="/../assets/sfx/slayerDie1.mp3")] private static const _slayer_die_1_class:Class;
        [Embed(source="/../assets/sfx/slayerAttacks1.mp3")] private static const _slayer_attacks_1_class:Class;
        [Embed(source="/../assets/sfx/slayerAttacks2.mp3")] private static const _slayer_attacks_2_class:Class;
        [Embed(source="/../assets/sfx/slayerAttacks3.mp3")] private static const _slayer_attacks_3_class:Class;
        [Embed(source="/../assets/sfx/slayerHit1.mp3")] private static const _slayer_hit_1_class:Class;
        [Embed(source="/../assets/sfx/slayerHit2.mp3")] private static const _slayer_hit_2_class:Class;
        [Embed(source="/../assets/sfx/slayerHit3.mp3")] private static const _slayer_hit_3_class:Class;
        [Embed(source="/../assets/sfx/slayerMoves1.mp3")] private static const _slayer_moves_1_class:Class;
        [Embed(source="/../assets/sfx/slayerMoves2.mp3")] private static const _slayer_moves_2_class:Class;
        [Embed(source="/../assets/sfx/slayerMoves3.mp3")] private static const _slayer_moves_3_class:Class;
        [Embed(source="/../assets/sfx/slayerMoves4.mp3")] private static const _slayer_moves_4_class:Class;
        [Embed(source="/../assets/sfx/slayerMoves5.mp3")] private static const _slayer_moves_5_class:Class;
        [Embed(source="/../assets/sfx/slayerMoves6.mp3")] private static const _slayer_moves_6_class:Class;
        [Embed(source="/../assets/sfx/stalwartDie1.mp3")] private static const _stalwart_die_1_class:Class;
        [Embed(source="/../assets/sfx/stalwartDie2.mp3")] private static const _stalwart_die_2_class:Class;
        [Embed(source="/../assets/sfx/stalwartHit1.mp3")] private static const _stalwart_hit_1_class:Class;
        [Embed(source="/../assets/sfx/stalwartHit2.mp3")] private static const _stalwart_hit_2_class:Class;
        [Embed(source="/../assets/sfx/stalwartStart1.mp3")] private static const _stalwart_start_1_class:Class;
        [Embed(source="/../assets/sfx/stalwartStart2.mp3")] private static const _stalwart_start_2_class:Class;
        [Embed(source="/../assets/sfx/stalwartStart3.mp3")] private static const _stalwart_start_3_class:Class;
        [Embed(source="/../assets/sfx/tarBabyDie1.mp3")] private static const _tar_baby_die_1_class:Class;
        [Embed(source="/../assets/sfx/tarBabyDie2.mp3")] private static const _tar_baby_die_2_class:Class;


        public static function playBeethroDie():void{ playSound("beethro_die", 2); }
        public static function playBeethroHit():void{ playSound("beethro_hit", 3); }
        public static function playBeethroStart():void{ playSound("beethro_start", 3, false); }
        public static function playCitizenDie():void{ playSound("citizen_die", 2); }
        public static function playCitizenHit():void{ playSound("citizen_hit", 2); }
        public static function playCitizenStart():void{ playSound("citizen_start", 3, false); }
        public static function playGoblinDie():void{ playSound("goblin_die", 2); }
        public static function playGoblinHit():void{ playSound("goblin_hit", 2); }
        public static function playHumanStep():void{ playSound("human_step", 2); }
        public static function playMonsterDie():void{ playSound("monster_die", 3); }
        public static function playMonserHit():void{ playSound("monster_hit", 3); }
        public static function playMonsterStep():void{ playSound("monster_step", 2); }
        public static function playSlayerAttack():void{ playSound("slayer_attacks", 3); }
        public static function playSlayerDie():void{ playSound("slayer_die", 1); }
        public static function playSlayerHit():void{ playSound("slayer_hit", 2); }
        public static function playSlayerMove():void{ playSound("slayer_moves", 6); }
        public static function playStalwartDie():void{ playSound("stalwart_die", 2); }
        public static function playStalwartHit():void{ playSound("stalwart_hit", 2); }
        public static function playStalwartStart():void{ playSound("stalwart_start", 3, false); }
        public static function playTarBabyDie():void{ playSound("tar_baby_die", 2); }

        public static function getMusicMonsterTurn():Sound{
            return rSfx.getS(_monsterTurn_class);
        }

        public static function getMusicHumanTurn():Sound{
            return rSfx.getS(_humanTurn_class);
        }

        private static var _sounds:Array = [];

        private static function playSound(initialName:String, count:int = 0, canSimultaneous:Boolean = true):void{
            var name:String = "_" + initialName;
            if (count){
                name += "_" + Rand.u(1, count + 1).toString();
            }
            name += "_class";

            var cls:Class = MonstroSfx[name];

            if (!canSimultaneous){
                var sound:rSound = _sounds[initialName];
                if (sound){
                    sound.stop();
                }

                sound = new rSound(cls);
                sound.registerAsSFX();
                _sounds[initialName] = sound;
                sound.play();
            } else {
                rSfx.playSound(cls, 0);
            }
        }

    }
}
