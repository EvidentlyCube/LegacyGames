
package net.retrocade.tacticengine.monstro.global.core {
    import flash.media.Sound;

    import net.retrocade.random.Random;

    import net.retrocade.retrocamel.core.RetrocamelSoundManager;
    import net.retrocade.retrocamel.sound.RetrocamelSound;
    import net.retrocade.tacticengine.monstro.global.resources.ResourceManager;

    public class MonstroSfx {
        [Embed(source="/../assets/music/musicTitleScreen.mp3")] private static const _titleScreen_class:Class;

        [Embed(source="/../assets/sfx/sounds/button_click.mp3")]              private static const _button_click_class:Class;
        [Embed(source="/../assets/sfx/sounds/human_attacks.mp3")]             private static const _human_attacks_class:Class;
        [Embed(source="/../assets/sfx/sounds/human_attacks_bowman.mp3")]      private static const _human_attacks_bowman_class:Class;
        [Embed(source="/../assets/sfx/sounds/human_hit_1.mp3")]               private static const _human_hit_1_class:Class;
        [Embed(source="/../assets/sfx/sounds/human_hit_2.mp3")]               private static const _human_hit_2_class:Class;
        [Embed(source="/../assets/sfx/sounds/human_hit_king.mp3")]            private static const _human_hit_king_class:Class;
        [Embed(source="/../assets/sfx/sounds/human_killed_1.mp3")]            private static const _human_killed_1_class:Class;
        [Embed(source="/../assets/sfx/sounds/human_killed_2.mp3")]            private static const _human_killed_2_class:Class;
        [Embed(source="/../assets/sfx/sounds/human_killed_3.mp3")]            private static const _human_killed_3_class:Class;
        [Embed(source="/../assets/sfx/sounds/human_killed_4.mp3")]            private static const _human_killed_4_class:Class;
        [Embed(source="/../assets/sfx/sounds/human_killed_5.mp3")]            private static const _human_killed_5_class:Class;
        [Embed(source="/../assets/sfx/sounds/human_killed_6.mp3")]            private static const _human_killed_6_class:Class;
        [Embed(source="/../assets/sfx/sounds/human_killed_king.mp3")]         private static const _human_killed_king_class:Class;
        [Embed(source="/../assets/sfx/sounds/monster_attacks_claws.mp3")]     private static const _monster_attacks_1_class:Class;
        [Embed(source="/../assets/sfx/sounds/monster_attacks_fangs.mp3")]     private static const _monster_attacks_2_class:Class;
        [Embed(source="/../assets/sfx/sounds/monster_attacks_slime.mp3")]     private static const _monster_attacks_slime_class:Class;
        [Embed(source="/../assets/sfx/sounds/monster_attacks_thud.mp3")]      private static const _monster_attacks_thud_class:Class;
        [Embed(source="/../assets/sfx/sounds/monster_hit.mp3")]               private static const _monster_hit_class:Class;
        [Embed(source="/../assets/sfx/sounds/monster_hit_brain.mp3")]         private static const _monster_hit_brain_class:Class;
        [Embed(source="/../assets/sfx/sounds/monster_hit_mushroom.mp3")]      private static const _monster_hit_mushroom_class:Class;
        [Embed(source="/../assets/sfx/sounds/monster_hit_slime.mp3")]         private static const _monster_hit_slime_class:Class;
        [Embed(source="/../assets/sfx/sounds/monster_killed.mp3")]            private static const _monster_killed_class:Class;
        [Embed(source="/../assets/sfx/sounds/monster_killed_brain.mp3")]      private static const _monster_killed_brain_class:Class;
        [Embed(source="/../assets/sfx/sounds/monster_killed_mushroom.mp3")]   private static const _monster_killed_mushroom_class:Class;
        [Embed(source="/../assets/sfx/sounds/monster_killed_slime.mp3")]      private static const _monster_killed_slime_class:Class;
        [Embed(source="/../assets/sfx/sounds/step_flying.mp3")]               private static const _step_flying_class:Class;
        [Embed(source="/../assets/sfx/sounds/step_grass.mp3")]                private static const _step_grass_class:Class;
        [Embed(source="/../assets/sfx/sounds/step_ground.mp3")]               private static const _step_ground_class:Class;
        [Embed(source="/../assets/sfx/sounds/step_sidewalk.mp3")]             private static const _step_sidewalk_class:Class;
        [Embed(source="/../assets/sfx/sounds/step_mobile_wall.mp3")]          private static const _step_mobile_wall_class:Class;
        [Embed(source="/../assets/sfx/sounds/title_growl.mp3")]               private static const _title_growl_class:Class;
        [Embed(source="/../assets/sfx/sounds/trap_spike.mp3")]                private static const _trap_spike_class:Class;
        [Embed(source="/../assets/sfx/sounds/trap_web.mp3")]                  private static const _trap_web_class:Class;
        [Embed(source="/../assets/sfx/sounds/wall_crumble.mp3")]              private static const _wall_crumble_class:Class;

        public static function playButtonClick():void{ playSound("button_click", 0, 25); }
        public static function playHumanAttacksGeneric():void{ playSound("human_attacks", 0); }
        public static function playHumanAttacksBowman():void{ playSound("human_attacks_bowman", 0); }
        public static function playHumanHitGeneric():void{ playSound("human_hit", 2); }
        public static function playHumanHitKing():void{ playSound("human_hit_king", 0); }
        public static function playHumanKilledGeneric():void{ playSound("human_killed", 6); }
        public static function playHumanKilledKing():void{ playSound("human_killed_king", 0); }
        public static function playMonsterAttacksGeneric():void{ playSound("monster_attacks", 2); }
        public static function playMonsterAttacksSlime():void{ playSound("monster_attacks_slime", 0); }
        public static function playMonsterAttacksMushroom():void{ playSound("monster_attacks_thud", 0); }
        public static function playMonsterHitBrain():void{ playSound("monster_hit_brain", 0); }
        public static function playMonsterHitGeneric():void{ playSound("monster_hit", 0); }
        public static function playMonsterHitMushroom():void{ playSound("monster_hit_mushroom", 0); }
        public static function playMonsterHitSlime():void{ playSound("monster_hit_slime", 0); }
        public static function playMonsterKilledBrain():void{ playSound("monster_killed_brain", 0); }
        public static function playMonsterKilledGeneric():void{ playSound("monster_killed", 0); }
        public static function playMonsterKilledMushroom():void{ playSound("monster_killed_mushroom", 0); }
        public static function playMonsterKilledSlime():void{ playSound("monster_killed_slime", 0); }
        public static function playStepFlying():void{ playSound("step_flying", 0); }
        public static function playStepGrass():void{ playSound("step_grass", 0); }
        public static function playStepGround():void{ playSound("step_ground", 0); }
        public static function playStepSidewalk():void{ playSound("step_sidewalk", 0); }
        public static function playStepMobileWall():void{ playSound("step_mobile_wall", 0); }
        public static function playTitleGrowl():void{ playSound("title_growl", 0); }
        public static function playTrapSpike():void{ playSound("trap_spike", 0); }
        public static function playTrapWeb():void{ playSound("trap_web", 0); }
        public static function playFakeWallCrumble():void{ playSound("wall_crumble", 0); }

        public static function playJingleDefeatHumans():void{
            ResourceManager.instance.playJingleDefeatHumans();
        }

        public static function playJingleDefeatMonsters():void{
            ResourceManager.instance.playJingleDefeatMonsters();
        }

        public static function playJingleVictoryHumans():void{
            ResourceManager.instance.playJingleVictoryHumans();
        }
        public static function playJingleVictoryMonsters():void{
            ResourceManager.instance.playJingleVictoryMonsters();
        }

        public static function getMusicIngameGreenlandMonster():RetrocamelSound{
            return ResourceManager.instance.getGreenlandMonsterMusic();
        }

        public static function getMusicIngameGreenlandHuman():RetrocamelSound{
            return ResourceManager.instance.getGreenlandHumanMusic();
        }

        public static function getMusicIngameIceMonster():RetrocamelSound{
            return ResourceManager.instance.getIceMonsterMusic();
        }

        public static function getMusicIngameIceHuman():RetrocamelSound{
            return ResourceManager.instance.getIceHumanMusic();
        }

        public static function getMusicIngameLavaMonster():RetrocamelSound{
            return ResourceManager.instance.getLavaMonsterMusic();
        }

        public static function getMusicIngameLavaHuman():RetrocamelSound{
            return ResourceManager.instance.getLavaHumanMusic();
        }

        public static function getMusicTitleScreen():RetrocamelSound{
            return new RetrocamelSound(_titleScreen_class);
        }

        public static function getMusicIntro():Class{
            return ResourceManager.instance.getIntroMusic();
        }

        public static function getMusicOutro():Class{
            return ResourceManager.instance.getOutroMusic();
        }

		private static var _testSoundId:uint = 0;
		public static function playSoundTest():void {
			switch(_testSoundId++ % 4){
				case(0): playFakeWallCrumble(); break;
				case(1): playStepMobileWall(); break;
				case(2): playTrapSpike(); break;
				case(3): playMonsterAttacksMushroom(); break;
			}
		}

        private static function playSound(initialName:String, count:int = 0, offset:Number = 0):void{
            var name:String = "_" + initialName;
            if (count){
                name += "_" + Random.defaultEngine.getUintRange(1, count + 1).toString();
            }
            name += "_class";

            var cls:Class = MonstroSfx[name];

            RetrocamelSoundManager.playSound(cls, offset);
        }

    }
}
