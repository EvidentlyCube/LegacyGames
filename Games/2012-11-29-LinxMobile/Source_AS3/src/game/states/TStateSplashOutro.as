package game.states
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TouchEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import flash.utils.setTimeout;

    import game.global.Game;
    import game.global.Make;
    import game.global.Score;
    import game.mobiles.MobileButton;
    import game.mobiles.rMobileState;

    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.global.rSave;
    import net.retrocade.camel.objects.rBitmap;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UDisplay;

    public class TStateSplashOutro extends rMobileState{
        [Embed(source="/../assets/gfx/by_cage/bgs/background_victory1.png")] private static var _bg1:Class;
        [Embed(source="/../assets/gfx/by_cage/bgs/background_victory2.png")] private static var _bg2:Class;

        private var image:rBitmap;
        private var text :Text;

        private var playFull:MobileButton;
        private var backToMenu:MobileButton;

        public function TStateSplashOutro(firstEnding:Boolean){
            if (firstEnding){
                rSave.write("outroSeen" + Score.gameMode, true);
                Score.wasNormalCompleted = true;
            } else {
                rSave.write("outroSeen" + Score.gameMode, true);
            }

            image = rGfx.getB(firstEnding ? _bg1 : _bg2);
            image.smoothing = true;

            text = Make().text(_(firstEnding ? "congrats1" : "congrats2"), 0xFFFFFF, 28);

            playFull = Make().button(onFull, "Get Full Version", 320);
            backToMenu = Make().button(onBack, "Back to Level Selection", 320)

            text.textAlignRight();
            text.wordWrap  = true;
            text.multiline = true;
            text.width = Math.max(S().gameWidth * 0.7, 200);
            text.alignMiddle();
            text.fitSize();

            text.right = S().gameWidth - 10;

            Game.lMain.displayObject.visible = true;
            Game.lMain.alpha = 1;

            set();
        }

        override public function create():void{
            Game.lMain.add(image);
            Game.lMain.add(text);

            text.alpha = 0;

            new rEffFade(image, 0, 1, 2000, function():void{
                setTimeout(function():void{
                    new rEffFade(text, 0, 1, 3000, function():void{
                        rDisplay.stage.addEventListener(TouchEvent.TOUCH_BEGIN, endSplash);
                        rDisplay.stage.addEventListener(MouseEvent.MOUSE_DOWN,  endSplash);
                    });}, 500);
            });

            super.create();
        }

        override protected function resized(e:Event):void{
            UDisplay.scaleDisplayObject(image, S().swfWidth, S().swfHeight, UDisplay.NO_BORDER);

            image.alignCenter();
            image.alignMiddle();

            text.alignMiddle();

            text.right = S().gameWidth - 10;

            text.scaleX = text.scaleY = 1;
            playFull.y = text.bottom + 20;
            backToMenu.y = playFull.bottom + 10;

            playFull.right = S().gameWidth - 10;
            backToMenu.right = S().gameWidth - 10;

            if (text.height + 50 > S().gameHeight){
                text.scaleX = text.scaleY = S().gameHeight / (text.height + 50);
                text.alignMiddle();

                text.right = S().gameWidth - 10;
            }
        }

        private function endSplash(e:* = null):void{
            backToMenu.mouseEnabled = false;
            playFull.mouseEnabled = false;

            rDisplay.stage.removeEventListener(TouchEvent.TOUCH_BEGIN, endSplash);
            rDisplay.stage.removeEventListener(MouseEvent.MOUSE_DOWN,  endSplash);

            new rEffFade(image, 1, 0, 800);
            new rEffFade(text, 1, 0, 800, function():void{
                TStateLevelSelect.instance.set();
            });
        }

        private function onBack():void{
            endSplash();
        }

        private function onFull():void{
            navigateToURL(new URLRequest('http://www.retrocade.net/post/120/linx-mobile'), '_blank');
        }
    }
}