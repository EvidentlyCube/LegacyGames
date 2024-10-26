package game.states {
    import game.global.Game;
    import game.global.Make;
    import game.global.Score;
    import game.objects.TRibbon;
    import game.tiles.TTileBlock;
    import game.tiles.TTileWall;

    import net.retrocade.camel.core.RetrocamelBitmapManager;
    import net.retrocade.camel.core.RetrocamelSoundManager;
    import net.retrocade.camel.core.RetrocamelStateBase;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.standalone.RetrocamelBitmapText;
    import net.retrocade.standalone.Text;

	/**
     * ...
     * @author
     */
    public class TStateScores extends RetrocamelStateBase {
        private static var _instance:TStateScores = new TStateScores;
        public static function get instance():TStateScores {
            return _instance;
        }



        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        private var _text:RetrocamelBitmapText;




        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        public function TStateScores() {
            _text = Make().text("", 0xFFFFFF, 2);
        }

        public function viewScores():void{
            set();

            onFinish();

            _text.text = _("scoreView");
            _text.positionToCenterScreen();
            _text.y = (S().gameHeight - _text.height) / 2;

            Game.lMain.add(_text);
        }

        public function sendScores():void{
            set();

            onFinish();

            _text.text = _("scoreSend");
            _text.positionToCenterScreen();
            _text.y = (S().gameHeight - _text.height) / 2;

            Game.lMain.add(_text);
        }

        override public function create():void {
            Game.lBG.clear();
            Game.lGame.clear();
            Game.lMain.clear();

            if (RetrocamelSoundManager.musicIsPaused())
                RetrocamelSoundManager.resumeMusic();

            else if (!RetrocamelSoundManager.musicIsPlaying())
                RetrocamelSoundManager.playMusic(Game.music);

            var r:TRibbon = makeRibbon(1.3, 30);

            r.moveAll(S().levelWidth);

            r.swayPower = 25;
            r.swayOffset = Math.PI / 75;
            r.swaySpeed = Math.PI / 60;

            r = makeRibbon(-1.3, 180);

            r.moveAll(-S().levelWidth);
            r.swayPower = 25;
            r.swayOffset = -Math.PI / 75;
            r.swaySpeed = Math.PI / 60;

            new rEffFadeScreen(0, 1, 0, 1000);
        }

        override public function update():void{
            Game.lGame.clear();
            _defaultGroup.update();
        }

        private function onFinish():void{
            Game.lMain.clear();
            new rEffVolumeFade(false, 1200, RetrocamelSoundManager.stopMusic);
            new rEffFadeScreen(1, 0, 0, 1250, onFinishFade);
        }

        private function onFinishFade():void{
            TStateTitle.instance.set();
        }

        private function makeRibbon(spd:Number, y:Number):TRibbon {
            var r:TRibbon = new TRibbon(y, spd, Game.lGame);
            r.addItem(RetrocamelBitmapManager.getBD(TTileBlock._gfx_block_1_), 1);
            r.addItem(RetrocamelBitmapManager.getBD(TTileBlock._gfx_block_2_), 1);
            r.addItem(RetrocamelBitmapManager.getBD(TTileBlock._gfx_block_3_), 1);
            r.addItem(RetrocamelBitmapManager.getBD(TTileBlock._gfx_block_4_), 1);
            /*r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_1_), 0.05);
            r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_3_), 0.05);
            r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_4_), 0.05);
            r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_7_), 0.05);
            r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_8_), 0.05);
            r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_9_), 0.05);
            r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_15_), 0.05);
            r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_16_), 0.05);
            r.addItem(RetrocamelBitmapManager.getBD(TTileWall._gfx_tile_17_), 0.05);*/
            r.farthestEdge = S().levelWidth;
            r.addMany(20);
            return r;
        }
    }
}