package game.interfaces{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import net.retrocade.utils.Base64;

    import game.global.Make;

    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Text;

    public class TRestoreLevel extends Button{
        public static const WIDTH :uint = 200;
        public static const HEIGHT:uint = 30;

        private var text :Text;
        private var isSet:Boolean = false;

        public var levelID:uint;

        public function TRestoreLevel(onClick:Function, level:XML){
            levelID = level.@LevelID;

            text = Make.text(20);
            text.text = _(Base64.decodeWChar(level.@NameMessage));
            text.autoSizeNone();
            text.width = 200;
            text.height = 30;

            addChild(text);

            super(onClick);

            data = level;
        }

        public function unset():void{
            isSet = false;
            graphics.clear();
        }

        public function set():void{
            isSet = true;
            drawBackground(0x443300, 0.2);
        }

        private function drawBackground(color:uint, alpha:Number):void{
            graphics.clear();
            graphics.beginFill(color, alpha);
            graphics.drawRect(0, 0, WIDTH, HEIGHT);
        }

        override protected function onClick(e:MouseEvent):void{
            super.onClick(e);

            set();
        }

        override protected function onRollOver(e:MouseEvent):void{
            if (!isSet)
                drawBackground(0, 0.08);
        }

        override protected function onRollOut(e:MouseEvent):void{
            if (!isSet)
                graphics.clear();
        }
    }
}