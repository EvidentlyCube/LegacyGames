package game.windows{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.display.Shape;
    import flash.events.MouseEvent;
    import flash.filters.DropShadowFilter;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;

    import game.achievements.Achievement;
    import game.global.Game;
    import game.global.Make;

    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rWindow;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffect;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Key;
    import net.retrocade.utils.UGraphic;

    public class TGrowlAchievement extends rWindow{
        private static var _displayedGrowls:Array = [];

        private var _bg         :Grid9;

        private var _header         :Text;
        private var _headerLine     :Shape;

        private var _iconBitmap     :Bitmap;
        private var _iconBitmapData :BitmapData;

        private var _achievementName:Text;

        private var _dismiss:Text;

        private var _achievement:Achievement;

        private var _timerID    :int = -1;

        public function TGrowlAchievement(achievement:Achievement){
            super();

            _blockUnder = false;
            _pauseGame  = false;

            x = S.LEVEL_OFFSET_X + 5;
            y = S.LEVEL_OFFSET_Y + 5;

            _bg              = Grid9.getGrid("window", true);
            _achievement     = achievement;
            _header          = Make.text(22);
            _headerLine      = new Shape;
            _achievementName = Make.text();
            _iconBitmapData  = new BitmapData(44, 44);
            _iconBitmap      = new Bitmap(_iconBitmapData);
            _dismiss         = Make.text(12);

            _achievement.drawTo(_iconBitmapData, 0, 0);

            _header.text = _("achievementHeader");
			
			while (_header.textWidth > 140)
				_header.size--;

            _achievementName.text = _achievement.name;
            _achievementName.wordWrap = true;
            _achievementName.width = 90;

            _dismiss.text = _("achievementDismiss");


            addChild(_bg);
            addChild(_iconBitmap);
            addChild(_header);
            addChild(_achievementName);
            addChild(_headerLine);
            addChild(_dismiss);

            _bg.innerWidth = 150;
            _bg.innerHeight = _dismiss.bottom;

            _iconBitmap     .x = 10;
            _iconBitmap     .y = 34;
            _achievementName.x = 60;
            _achievementName.y = 34;
            _header         .y = -2;
            _dismiss.alignCenterParent();
            _dismiss.y = Math.max(_achievementName.y + _achievementName.textHeight, _iconBitmap.y + _iconBitmap.height) + 5;

            _bg.innerHeight = _dismiss.y + _dismiss.height -5;

            _header.alignCenterParent();

            UGraphic.draw(_headerLine).rectFill(10, _header.y + _header.textHeight, _bg.width - 20, 1, 0, 0.75);

            _iconBitmap.filters = [ new DropShadowFilter(4, 45, 0, 0.5, 6, 6, 1) ];

            addEventListener(MouseEvent.CLICK, onClicked, false, 0, true);

            show();
        }

        override public function update():void{
            var index:int = _displayedGrowls.indexOf(this);
            if (index == -1)
                index = 0;

            if (index == 0)
                y = S.LEVEL_OFFSET_Y + 5;

            else {
                y = S.LEVEL_OFFSET_Y + 5 + (5 + height) * index;
            }

            if (Game.player.x < S.LEVEL_WIDTH / 2)
                x = S.LEVEL_OFFSET_X + S.LEVEL_WIDTH_PIXELS - width - 5;
            else
                x = S.LEVEL_OFFSET_X + 5;

            if (mouseEnabled && rInput.isKeyHit(Key.SPACE))
                hide();
        }

        override public function show():void{
            super.show();

            mouseEnabled = false;

            new rEffFade(this, 0, 1, 250, waitAndHide);

            _displayedGrowls.push(this);
        }

        override public function close():void{
            var index:uint = _displayedGrowls.indexOf(this);
            _displayedGrowls.splice(index, 1);

            super.close();
        }

        private function waitAndHide():void{
            mouseEnabled = true;

            _timerID = setTimeout(hide, 3000);
        }

        private function onClicked(e:MouseEvent):void{
            hide();
        }

        private function hide():void{
            mouseEnabled = false;

            removeEventListener(MouseEvent.CLICK, onClicked);

            if (_timerID != -1)
                clearTimeout(_timerID);

            _timerID = -1;
            new rEffFade(this, 1, 0, 250, close);
        }
    }
}