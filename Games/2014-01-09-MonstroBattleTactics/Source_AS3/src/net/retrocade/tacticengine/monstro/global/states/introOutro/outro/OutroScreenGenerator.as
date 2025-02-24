
package net.retrocade.tacticengine.monstro.global.states.introOutro.outro {

    import net.retrocade.retrocamel.interfaces.IRetrocamelSound;
    import net.retrocade.retrocamel.locale._;
    import net.retrocade.retrocamel.sound.RetrocamelSound;
    import net.retrocade.retrocamel.sound.RetrocamelSoundNull;
    import net.retrocade.tacticengine.monstro.global.core.MonstroData;
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
    import net.retrocade.tacticengine.monstro.global.states.introOutro.screens.MonstroOutroScreen;
    import net.retrocade.functions.printf;

    import starling.display.Image;
    import starling.textures.Texture;

    public class OutroScreenGenerator {
        [Embed(source="/../assets/gfx/scenes/end_hum_1.png")]
        private static var _ending_image_human_class:Class;
        [Embed(source="/../assets/gfx/scenes/end_hum_2.png")]
        private static var _ending_image_human_hard_class:Class;
        [Embed(source="/../assets/gfx/scenes/end_mon_1.png")]
        private static var _ending_image_monsters_class:Class;
        [Embed(source="/../assets/gfx/scenes/end_mon_2.png")]
        private static var _ending_image_monsters_hard_class:Class;
        [Embed(source="/../assets/sfx/outro/human_1.mp3")]
        private static var _outro_dub_human_1:Class;
        [Embed(source="/../assets/sfx/outro/human_2.mp3")]
        private static var _outro_dub_human_2:Class;
        [Embed(source="/../assets/sfx/outro/human_hard_1.mp3")]
        private static var _outro_dub_human_hard_1:Class;
        [Embed(source="/../assets/sfx/outro/human_hard_2.mp3")]
        private static var _outro_dub_human_hard_2:Class;
        [Embed(source="/../assets/sfx/outro/monster_1.mp3")]
        private static var _outro_dub_monster_1:Class;
        [Embed(source="/../assets/sfx/outro/monster_2.mp3")]
        private static var _outro_dub_monster_2:Class;
        [Embed(source="/../assets/sfx/outro/monster_3.mp3")]
        private static var _outro_dub_monster_3:Class;
        [Embed(source="/../assets/sfx/outro/monster_hard_1.mp3")]
        private static var _outro_dub_monster_hard_1:Class;
        [Embed(source="/../assets/sfx/outro/monster_hard_2.mp3")]
        private static var _outro_dub_monster_hard_2:Class;
        [Embed(source="/../assets/sfx/outro/monster_hard_3.mp3")]
        private static var _outro_dub_monster_hard_3:Class;

        public static function getMonstroScreen(campaignType:EnumCampaignType):MonstroOutroScreen {
            var texts:Vector.<String> = getTexts(campaignType);

            var dubbings:Vector.<IRetrocamelSound> = getDubbings(campaignType, texts.length);

            return new MonstroOutroScreen(
                    getBackgroundImage(campaignType),
                    texts,
                    dubbings
            );
        }

        private static function getTexts(campaignType:EnumCampaignType):Vector.<String>{
            var texts:Vector.<String> = new Vector.<String>();

			if (campaignType === EnumCampaignType.HUMAN) {
				texts.push(getText(campaignType, 0));
				texts.push(getText(campaignType, 1));

				if (isHumanHardCompleted && isMonsterCompleted){
					texts.push(_("outro.human_2.text_c"));
				} else if (isMonsterCompleted){
					texts.push(_("outro.human_2.text_b"));
				} else {
					texts.push(_("outro.human_2.text_a"));
				}

			} else if (campaignType === EnumCampaignType.HUMAN_HARD) {
                texts.push(getText(campaignType, 0));
                texts.push(getText(campaignType, 1));

				if (isHumanCompleted && isMonsterCompleted){
					texts.push(_("outro.human_hard_2.text_c"));
				} else if (isMonsterCompleted){
					texts.push(_("outro.human_hard_2.text_b"));
				} else if (isHumanCompleted){
					texts.push(_("outro.human_hard_2.text_a"));
				}

            } else if (campaignType === EnumCampaignType.MONSTER){
                texts.push(getText(campaignType, 0));
                texts.push(getText(campaignType, 1));
                texts.push(getText(campaignType, 2));

				if (isHumanCompleted && isHumanHardCompleted){
					texts.push(_("outro.monster_3.text_c"));
				} else if (isHumanCompleted){
					texts.push(_("outro.monster_3.text_b"));
				} else {
					texts.push(_("outro.monster_3.text_a"));
				}

            } else if (campaignType === EnumCampaignType.MONSTER_HARD){
                texts.push(getText(campaignType, 0));
                texts.push(getText(campaignType, 1));
                texts.push(getText(campaignType, 2));
            }

			if (isHumanCompleted && isHumanHardCompleted && isMonsterCompleted && isMonsterHardCompleted && isIntroductionCompleted)
			{
				texts.push(_("outro.finale_0"));
				texts.push(_("outro.finale_1"));
				texts.push(_("outro.finale_2"));
				texts.push(_("outro.finale_3"));
				texts.push(_("outro.finale_4"));
				texts.push(_("outro.finale_5"));
				texts.push(_("outro.finale_6"));
				texts.push(_("outro.finale_7"));
				texts.push(_("outro.finale_8"));
				texts.push(_("outro.finale_9"));
				texts.push(_("outro.finale_10"));
				texts.push(_("outro.finale_11"));
				texts.push(_("outro.finale_12"));
				texts.push(_("outro.finale_13"));
			}

            return texts;
        }

		private static function get isIntroductionCompleted():Boolean {
			return MonstroData.getCampaignCompleted(EnumCampaignType.INTRODUCTION);
		}

		private static function get isMonsterHardCompleted():Boolean {
			return MonstroData.getCampaignCompleted(EnumCampaignType.MONSTER_HARD);
		}

		private static function get isMonsterCompleted():Boolean {
			return MonstroData.getCampaignCompleted(EnumCampaignType.MONSTER);
		}

		private static function get isHumanHardCompleted():Boolean {
			return MonstroData.getCampaignCompleted(EnumCampaignType.HUMAN_HARD);
		}

		private static function get isHumanCompleted():Boolean {
			return MonstroData.getCampaignCompleted(EnumCampaignType.HUMAN);
		}

        private static function getDubbings(campaignType:EnumCampaignType, dubbingsCount:uint):Vector.<IRetrocamelSound>{
            var dubbings:Vector.<IRetrocamelSound> = new Vector.<IRetrocamelSound>();

            for (var i:int = 0; i < dubbingsCount; i++){
                dubbings.push(getSound(campaignType, i));
            }

            return dubbings;
        }

        private static function getBackgroundImage(campaignType:EnumCampaignType):Image {
            var textureClass:Class;

            switch (campaignType) {
                case(EnumCampaignType.HUMAN):
                    textureClass = _ending_image_human_class;
                    break;
                case(EnumCampaignType.HUMAN_HARD):
                    textureClass = _ending_image_human_hard_class;
                    break;
                case(EnumCampaignType.MONSTER):
                    textureClass = _ending_image_monsters_class;
                    break;
                case(EnumCampaignType.MONSTER_HARD):
                    textureClass = _ending_image_monsters_hard_class;
                    break;
                default:
                    throw new ArgumentError("Invalid campaign type");
            }

            return new Image(Texture.fromEmbeddedAsset(textureClass, false));
        }

        public static function getText(campaignType:EnumCampaignType, screenIndex:int):String {
            var textName:String  = "outro.%%_%%.text";

            return _(printf(textName, campaignType.name, screenIndex));
        }

        private static function getSound(campaignType:EnumCampaignType, screenIndex:int):IRetrocamelSound {
            if (screenIndex < (campaignType.isHuman ? 2 : 3)){
                return getSoundFromSoundMap(campaignType, screenIndex);
            } else {
                return getSoundMock(60000);
            }
        }

        private static function getSoundFromSoundMap(campaignType:EnumCampaignType, screenIndex:int):IRetrocamelSound{
            var soundMap:Vector.<Vector.<Class>> = new Vector.<Vector.<Class>>();
            soundMap.length = 4;

            soundMap[EnumCampaignType.HUMAN.id] = new <Class>[_outro_dub_human_1, _outro_dub_human_2];
            soundMap[EnumCampaignType.HUMAN_HARD.id] = new <Class>[_outro_dub_human_hard_1, _outro_dub_human_hard_2];
            soundMap[EnumCampaignType.MONSTER.id] = new <Class>[_outro_dub_monster_1, _outro_dub_monster_2, _outro_dub_monster_3];
            soundMap[EnumCampaignType.MONSTER_HARD.id] = new <Class>[_outro_dub_monster_hard_1, _outro_dub_monster_hard_2, _outro_dub_monster_hard_3];

            var soundClass:Class = soundMap[campaignType.id][screenIndex];

            if (soundClass === null) {
                throw new ArgumentError("No dub for given combination!");
            }

            return new RetrocamelSound(soundClass);
        }

        private static function getSoundMock(duration:Number):IRetrocamelSound{
            return new RetrocamelSoundNull(duration);
        }
    }
}
