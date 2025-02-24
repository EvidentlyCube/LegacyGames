
package net.retrocade.tacticengine.monstro.global.states {
    import net.retrocade.retrocamel.effects.RetrocamelEffectMusicFade;
    import net.retrocade.retrocamel.core.RetrocamelSoundManager;
    import net.retrocade.retrocamel.components.RetrocamelStateBase;
    import net.retrocade.retrocamel.display.layers.RetrocamelLayerStarling;
    import net.retrocade.tacticengine.monstro.global.core.MonstroConsts;
    import net.retrocade.tacticengine.monstro.global.core.MonstroGfx;
    import net.retrocade.tacticengine.monstro.global.core.MonstroSfx;
    import net.retrocade.tacticengine.monstro.global.enum.EnumCampaignType;
    import net.retrocade.tacticengine.monstro.global.states.introOutro.outro.OutroScreenGenerator;
    import net.retrocade.tacticengine.monstro.global.states.introOutro.screens.MonstroOutroScreen;

    import starling.display.Image;
    import starling.events.Event;

    public class MonstroStateOutro extends RetrocamelStateBase {

        public static function show(campaignType:EnumCampaignType):void {
            var outro:MonstroStateOutro = new MonstroStateOutro(campaignType);

            outro.setToMe();
        }

        private var _screen:MonstroOutroScreen;
        private var _outroLayer:RetrocamelLayerStarling;
        private var _background:Image;

        public function MonstroStateOutro(campaignType:EnumCampaignType) {
            _screen = OutroScreenGenerator.getMonstroScreen(campaignType);
            _background = MonstroGfx.getBlackColor();

            _outroLayer = new RetrocamelLayerStarling();
            _screen.addEventListener(Event.COMPLETE, onScreenCompleted);

            _outroLayer.add(_background);
            _outroLayer.add(_screen);

            RetrocamelEffectMusicFade.make(1).fadeFrom(0).duration(800).run();
            RetrocamelSoundManager.playMusic(MonstroSfx.getMusicOutro(), 9999);
        }

        override public function destroy():void {
            super.destroy();

            _screen.dispose();

            _outroLayer.dispose();
            _screen.dispose();
            _background.dispose();

            _outroLayer = null;
            _screen = null;
            _background = null;
        }

        override public function update():void {
            if (_screen) {
                _screen.update();
            }
        }

        override public function resize():void {
            super.resize();

            _background.width = MonstroConsts.gameWidth;
            _background.height = MonstroConsts.gameHeight;

            if (_screen) {
                _screen.resize();
            }
        }

        //noinspection JSUnusedLocalSymbols
        private static function onScreenCompleted(event:Event):void {
            RetrocamelEffectMusicFade.make(0).fadeFrom(1).duration(1000).callback(onMusicFadedOut).run();
        }

        private static function onMusicFadedOut():void{
            RetrocamelSoundManager.stopMusic();
            RetrocamelSoundManager.resetMusicFadeVolume();
            MonstroStateTitle.show()
        }
    }
}
