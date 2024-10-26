package game.windows{
    import flash.geom.Point;
    import flash.utils.setTimeout;
    import game.achievements.Achievements;
    import game.global.CaravelConnect;
    import game.global.Level;
    import game.global.Make;
    import game.global.Progress;
    import game.managers.VODemoRecord;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.Rand;
    import net.retrocade.utils.UString;

    public class TWindowUploadDemos extends rWindow{
        private static var _instance:TWindowUploadDemos = new TWindowUploadDemos;

        public static function show():void{
            _instance.show();
        }



        private var _bg    :Grid9;
        private var _header:Text;
        private var _text  :Text;
        private var _close :Button;

        private var _rooms :Array;

        public function TWindowUploadDemos(){
            super();

            _bg     = Grid9.getGrid("window", true);
            _header = Make.text(22);
            _text   = Make.text(16);
            _close  = Make.buttonColor(onClose, _("close"));

            _header.text = _("uploadAll");
            _header.fitSize();

            _text.autoSizeNone();
            _text.multiline = true;
            _text.wordWrap  = true;

            addChild(_bg);
            addChild(_header);
            addChild(_text);
            addChild(_close);

            _header.y    = 5;

            _text.width  = 400;
            _text.height = 300;
            _text.x      = 5;
            _text.y      = _header.bottom;

            _close.y = _text.bottom + 10;

            _bg.width = 410;
            _bg.height = _close.bottom + 10;

            _header.alignCenterParent();
            _close .alignCenterParent();

            cacheAsBitmap = true;
        }

        override public function show():void {
			graphics.clear();
			
            super.show();

            mouseChildren = false;
            new rEffFade(this, 0, 1, 400, onFadedIn);

            _text.text   = "";

            _close.disable();
            _close.alpha = 0.5;

            _rooms = Level.getAllRooms();

            center();
			
			graphics.beginFill(0, 0.6);
			graphics.drawRect( -x, -y, S.SIZE_SWF_WIDTH, S.SIZE_SWF_HEIGHT);
			
            uploadNextDemo();
            Achievements.uploadCompleted();
        }

        override public function update():void {
            if (_close.enabled && rInput.isKeyHit(Key.ESCAPE) && mouseChildren)
                onClose();
        }

        private function uploadNextDemo():void {
            while (_rooms.length) {
                var room:XML = _rooms.pop();
                var roomID:uint = parseInt(room.@RoomID);

                if (!Level.roomHasMonsters(roomID))
                    continue;

                if (!Progress.wasRoomEverVisited(roomID))
                    continue;

                if (!Progress.wasRoomEverConquered(roomID))
                    continue;

                addText(getRoomName(room));

                addText("...");

                CaravelConnect.submitScore(roomID, onDemoUploaded);
                return;
            }

            addText(_("uploadDone"));

            _close.enable();
            _close.alpha = 1;
        }

        private function getRoomName(room:XML):String {
            var roomPos  :Point = Level.getRoomOffsetInLevel(room.@RoomID);
            var levelName:String = Level.getLevelName(room.@LevelID);

            var name:String = levelName + ": ";

            if (roomPos.x == 0 && roomPos.y == 0)
                name += _("uploadRoomEntrance");

            else {
                if (roomPos.y > 0)
                    name += roomPos.y.toString() + _("roomS");
                else if (roomPos.y < 0)
                    name += ( -roomPos.y).toString() + _("roomN");

                if (roomPos.x > 0)
                    name += roomPos.x.toString() + _("roomE");
                else if (roomPos.x < 0)
                    name += (-roomPos.x).toString() + _("roomW");
            }

            return name;
        }

        private function onDemoUploaded(response:Object):void {
            if (response === null) {
                addText("\n" + _("uploadError"));
                _rooms.length = 0;
                uploadNextDemo();
                return;
            }

            var place:Number = response.place;
            var isTie:Boolean = ((place | 0) != place);

            place |= 0;

            if (place == 0) {
                addText(_("uploadAlreadyHas") + "\n");

            } else {
                var scored:String;

                if (isTie)
                    scored = _("scoreTie", _("score" + place));
                else
                    scored = _("score" + place);

                addText(scored + ".\n");
            }

            uploadNextDemo();
        }

        private function addText(text:String):void {
            _text.text += text;

            if (_text.textHeight > _text.height) {
                var indexN:uint = _text.text.indexOf("\n");
                var indexR:uint = _text.text.indexOf("\r");

                indexN = (indexN < indexR ? indexN : indexR);
                _text.text = _text.text.substr(indexN + 1);
            }
        }

        private function onClose():void {
            mouseChildren = false;

            new rEffFade(this, 1, 0, 400, onFadedOut);
        }

        private function onFadedIn():void {
            mouseChildren = true;
        }

        private function onFadedOut():void {
            close();
        }
    }
}