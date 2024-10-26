package game.windows {
    import game.global.CaravelConnect;
    import game.global.Game;
    import game.global.Make;
    import game.global.Progress;
    import game.global.Room;
    import net.retrocade.camel.core.rInput;
	import net.retrocade.camel.core.rWindow;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UString;
	
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TWindowLevelScore extends rWindow {

        private static var _instance:TWindowLevelScore = new TWindowLevelScore();

        public static function show():void {
            _instance.show();
        }



        private var _bg    :Grid9;
        private var _header:Text;
        private var _stats :Text;

        private var _bestScore:Text;
        private var _theScore:Text;

        private var _scoresHeader:Text;
        private var _scores:Text;

        private var _close:Button;

        private var _lastRoomID:uint = uint.MAX_VALUE;
        private var _lastScore :uint = uint.MAX_VALUE;

        public function get room():Room {
            return Game.room;
        }

        public function TWindowLevelScore() {
            // Creation

            _bg           = Grid9.getGrid('window', true);
            _header       = Make.text(28);
            _stats        = Make.text(18);
            _bestScore    = Make.text(28);
            _theScore     = Make.text(24);

            _scoresHeader = Make.text(28);
            _scores       = Make.text(16);
            _close        = Make.buttonColor(onClose, _("close"));


            // Parameters

            _header      .text = _("scrStats");
            _bestScore   .text = _("scrYourBest");
            _scoresHeader.text = _("scrTop");

            _stats.multiline = true;
            _stats.wordWrap  = true;

            _scores.multiline = true;
            _scores.wordWrap  = true;
            _scores.textAlignCenter();

            // Adding

            addChild(_bg);
            addChild(_header);
            addChild(_stats);
            addChild(_bestScore);
            addChild(_theScore);
            addChild(_scores);
            addChild(_close);
            addChild(_scoresHeader);
        }

        override public function show():void {
			graphics.clear();
			
            super.show();

            const WIDTH_L:uint = 270;
            const WIDTH_R:uint = 350;

            var bestScore:int = Progress.getRoomBestScore(Game.room.roomID);

            // Set Text

            _stats   .text  = generateStatsString();

            _theScore.text = (bestScore == -1  || bestScore == uint.MAX_VALUE ? _("scrNoScore") : bestScore.toString());

            // Sizing

            _bestScore.width  = WIDTH_L;
            _theScore .width  = WIDTH_L;
            _stats    .width  = WIDTH_L;
            _stats    .width  = _stats.textWidth + 10;
            _scores   .width  = WIDTH_R;
            _bg       .width  = WIDTH_L + WIDTH_R + 10;

            // Positioning

            _header      .alignCenterParent(0,       WIDTH_L);
            _stats       .alignCenterParent(0,       WIDTH_L);
            _bestScore   .alignCenterParent(0,       WIDTH_L);
            _theScore    .alignCenterParent(0,       WIDTH_L);
            _scoresHeader.alignCenterParent(WIDTH_L, WIDTH_R);
            _scores      .alignCenterParent(WIDTH_L, WIDTH_R);
            _close       .alignCenterParent(0,       WIDTH_L + WIDTH_R);

            _stats    .y = _header.bottom;
            _bestScore.y = _stats.bottom + 12;
            _theScore .y = _bestScore.bottom - 2;

            _scores   .y = _scoresHeader.bottom + 5;
            _close    .bottom = 310 - 10;

            // Final Touches

            _bg       .height = 310;

            center();
			
			graphics.beginFill(0, 0.4);
			graphics.drawRect( -x, -y, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT);

            var reload:Boolean = false;
            if (room.roomID != _lastRoomID)
                reload = true;

            if (_lastScore != Progress.getRoomBestScore(_lastRoomID))
                reload = true;

            if (reload) {
                if (!CaravelConnect.cnetName || !CaravelConnect.cnetPass)
                    _scores.text = _("scrOnlyForCnet");

                else if (CaravelConnect.isBroken)
                    onScoresFetched(null);
                else {
                    _scores.text = _("scrFetching");
                    CaravelConnect.retrieveScores(Game.room.roomID, onScoresFetched);
                }
            }

            _lastRoomID = room.roomID;
            _lastScore  = Progress.getRoomBestScore(_lastRoomID);
        }

        override public function update():void {
            if (rInput.isKeyHit(Key.ENTER) || rInput.isKeyHit(Key.ESCAPE)) {
                rInput.flushKeys();

                close();
            }
        }

        private function onClose():void {
            CaravelConnect.retrieveScoresCancel();
            close();
        }

        private function generateStatsString():String {
            var levelID:uint = Game.room.levelID;

            var deaths:uint = Progress.levelStats.getUint(levelID + "d", 0);
            var moves :uint = Progress.levelStats.getUint(levelID + "m", 0);
            var kills :uint = Progress.levelStats.getUint(levelID + "k", 0);
            var time  :uint = Progress.levelStats.getUint(levelID + "t", 0);

            var statsText:String;

            statsText  = _("scrMovesRoom",  Game.playerTurn) + "\n";
            statsText += _("scrMovesLevel", moves)           + "\n";
            statsText += _("scrDeaths",     deaths)          + "\n";
            statsText += _("scrKills",      kills)           + "\n";
            statsText += _("scrTime",       UString.styleTime(time * 1000, true, true, true, false));

            return statsText;
        }

        private function onScoresFetched(scores:Array):void {
            if (scores == null) {
                _scores.text = _("scrCnetProblems");
                return;
            } else if (scores.length == 0) {
                _scores.text = _("scrNoScores");
                return;
            }

            var i   :uint = 0;
            var text:String = "";

            for each (var score:Object in scores) {
                text += ++i + ". " + score.PlayerName + " (" + score.numMoves + ")\n";
            }

            _scores.text = text;
        }
    }
}