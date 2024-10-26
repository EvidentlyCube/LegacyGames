package game.global{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.utils.getTimer;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UString;

    public class Hud extends rObject{
        [Embed(source="/../assets/gfx/HUD.png")] private static var _hud:Class;
        private static var _instance:Hud = new Hud;

        public static function hook():void{
            if (!rCore.groupAfter.contains(_instance))
                rCore.groupAfter.add(_instance);

            if (!Game.lMain.contains2(_instance.gfx))
                Game.lMain.add2(_instance.gfx);
        }

        public static function unhook():void{
            rCore.groupAfter.remove(_instance);
            Game.lMain.remove2(_instance.gfx);
        }

        private var bg:Bitmap;

        private var steps:Text;
        private var time :Text;

        private var levelName:Text;
        private var levelAuthor:Text;

        public var gfx:Sprite = new Sprite();

        public function Hud(){
            bg    = rGfx.getB(_hud);
            steps = new Text("0 / 45", "font", 18);
            time  = new Text("0.00", "font", 18);
            levelName = new Text("", "font", 18);
            levelAuthor = new Text("", "font", 15);

            gfx.addChild(bg);
            gfx.addChild(steps);
            gfx.addChild(time);
            gfx.addChild(levelName);
            gfx.addChild(levelAuthor);

            gfx  .y = S().gameHeight - bg.height;
            steps.y = time.y = 13;

            steps.x = 10;
            time .x = 200;

            levelAuthor.color = 0xE8E8E8;
        }

        override public function update():void{
            steps.htmlText = makeText("Moves: ", Score.movesMade.get() + (Score.movesMade.get() == 1 ? " step" : " steps"));
            time .htmlText = makeText("Time: ",
                UString.styleTime(getTimer() - Score.time.get(), true, true, true, false)
            );

            levelName  .htmlText = makeTitleAuthor(Score.levelName, 14);
            levelAuthor.htmlText = makeTitleAuthor(Score.levelAuthor, 11);

            levelName  .fitSize();
            levelAuthor.fitSize();

            levelName  .right = S().gameWidth - 4;
            levelAuthor.right = S().gameWidth - 4;
            levelName  .y = 4;
            levelAuthor.y = levelName.bottom - 5;
        }

        private function makeText(header:String, mini:String):String{
            var text:String = header.charAt(0);

            text += "<font size='18'>" + header.substr(1) + "</font>";

            text += "<font size='14' color='#E8E8E8'>" + mini + "</font>";

            return text;
        }

        private function makeTitleAuthor(text:String, size:Number):String{
            return text.replace(/([a-z ]+)/g, "<font size='"+size+"'>$1</font>").toUpperCase();
        }
    }
}