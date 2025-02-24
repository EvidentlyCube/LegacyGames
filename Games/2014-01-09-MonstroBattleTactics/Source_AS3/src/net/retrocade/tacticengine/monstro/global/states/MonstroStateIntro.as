
package net.retrocade.tacticengine.monstro.global.states {

    import net.retrocade.retrocamel.effects.RetrocamelEffectMusicFade;
    import net.retrocade.retrocamel.core.RetrocamelSoundManager;
    import net.retrocade.retrocamel.components.RetrocamelStateBase;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.retrocamel.locale._;
    import net.retrocade.retrocamel.sound.RetrocamelSound;
    import net.retrocade.tacticengine.core.log;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroData;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
    import net.retrocade.tacticengine.monstro.global.enum.EnumUnitFaction;
    import net.retrocade.tacticengine.monstro.global.states.introOutro.screens.MonstroIntroScreen;
    import net.retrocade.tacticengine.monstro.ingame.events.MonstroEventLoadLevel;

    import starling.display.Image;
    import starling.events.Event;
    import starling.textures.Texture;

    public class MonstroStateIntro extends RetrocamelStateBase {
        [Embed(source="/../assets/gfx/scenes/intro_1.png")]
        private static var _intro_image_1:Class;
        [Embed(source="/../assets/gfx/scenes/intro_2.png")]
        private static var _intro_image_2:Class;
        [Embed(source="/../assets/gfx/scenes/intro_3.png")]
        private static var _intro_image_3:Class;
        [Embed(source="/../assets/gfx/scenes/intro_4.png")]
        private static var _intro_image_4:Class;
        [Embed(source="/../assets/sfx/intro/intro_1.mp3")]
        private static var _intro_dub_1:Class;
        [Embed(source="/../assets/sfx/intro/intro_2.mp3")]
        private static var _intro_dub_2:Class;
        [Embed(source="/../assets/sfx/intro/intro_3.mp3")]
        private static var _intro_dub_3:Class;
        [Embed(source="/../assets/sfx/intro/intro_4.mp3")]
        private static var _intro_dub_4:Class;

        public static function set():void {
            var instance:MonstroStateIntro = new MonstroStateIntro();

            instance.setToMe();
        }

        private var _screens:Vector.<MonstroIntroScreen>;
        private var _currentScreen:MonstroIntroScreen;
        private var _currentScreenIndex:int = -1;
        private var _introLayer:RetrocamelLayerStarling;

        public function MonstroStateIntro() {
        }

        private var background:Image;

        override public function create():void {
            _l("Initializing Intro state");
            _screens = new Vector.<MonstroIntroScreen>();

            _screens.push(new MonstroIntroScreen(new Image(Texture.fromBitmap(new _intro_image_1, false)),
                    _('plot_text_1'), new RetrocamelSound(_intro_dub_1)));

            _screens.push(new MonstroIntroScreen(new Image(Texture.fromBitmap(new _intro_image_2, false)),
                    _('plot_text_2'), new RetrocamelSound(_intro_dub_2)));

            _screens.push(new MonstroIntroScreen(new Image(Texture.fromBitmap(new _intro_image_3, false)),
                    _('plot_text_3'), new RetrocamelSound(_intro_dub_3)));

            _screens.push(new MonstroIntroScreen(new Image(Texture.fromBitmap(new _intro_image_4, false)),
                    _('plot_text_4'), new RetrocamelSound(_intro_dub_4)));


            _l("Creating intro layer");
            _introLayer = new RetrocamelLayerStarling();

            for each(var screen:MonstroIntroScreen in _screens) {
                screen.addEventListener(Event.COMPLETE, onScreenCompleted);
            }

            setNextScreen();

            background = MonstroGfx.getBlackColor();
            _introLayer.addAt(background, 0);

            updateBackground();

            RetrocamelSoundManager.playMusic(MonstroSfx.getMusicIntro(), 9999);
            RetrocamelEffectMusicFade.make(1).fadeFrom(0).duration(1000).run();
        }

        override public function destroy():void {
            super.destroy();
        }

        override public function update():void {
            if (_currentScreen) {
                _currentScreen.update();
            }

            updateBackground();
        }

        private function updateBackground():void {
            background.x = 0;
            background.y = 0;
            background.width = MonstroConsts.gameWidth;
            background.height = MonstroConsts.gameHeight;
        }

        override public function resize():void {
            super.resize();

            if (_currentScreen) {
                _currentScreen.resize();
            }
        }

        private function setNextScreen():void {
            _l("Switching to next intro screen");
            if (_currentScreen) {
                _introLayer.remove(_currentScreen);
            }

            _currentScreenIndex++;

            if (_currentScreenIndex == _screens.length) {
                RetrocamelEffectMusicFade.make(0).fadeFrom(1).duration(500).callback(onIntroEnded).run();
            } else {
                _currentScreen = _screens[_currentScreenIndex];
                _introLayer.add(_currentScreen);

                _currentScreen.resize();
            }
        }

        private function onIntroEnded():void{
            _l("On intro ended");
            RetrocamelSoundManager.stopMusic();

			if (MonstroData.getSawIntro(false)){
				MonstroStateTitle.show();
			} else {
				MonstroStateIngame.show(EnumUnitFaction.HUMAN);
				new MonstroEventLoadLevel(0, EnumCampaignType.INTRODUCTION);
			}

            RetrocamelSoundManager.resetMusicFadeVolume();

            MonstroData.setSawIntro(true);
        }

        //noinspection JSUnusedLocalSymbols
        private function onScreenCompleted(event:Event):void {
            setNextScreen();
        }
    }
}
