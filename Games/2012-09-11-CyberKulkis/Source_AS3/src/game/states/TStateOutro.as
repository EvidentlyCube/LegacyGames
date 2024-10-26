package game.states{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import flash.utils.setTimeout;

    import game.global.Game;
    import game.global.Make;
    import game.global.Sfx;

    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UString;

    public class TStateOutro extends rState{
        [Embed(source="/../assets/gfx/badge.png")] private static var _badge:Class;

        private var _icon:Bitmap;

        private var _text1:Text;
        private var _text2:Text;
        private var _text3:Text;

        private var _continue:Button;

        public function TStateOutro(){
            _icon = new _badge;

            _text1 = new Text("Congratulations!", "font", 18);
            _text2 = new Text("You have accomplished quite a feat.", "font", 18);
            _text3 = new Text("If you have enjoyed this game, why don't you try other levelsets?", "font", 18);

            _continue = Make().button(onContinue, "Return to title screen");

            _icon.x = (S().gameWidth  - _icon.width)  / 2 | 0;
            _icon.y = (S().gameHeight - _icon.height) / 2 | 0;

            _text1.x = (S().gameWidth  - _text1.width)  / 2 | 0;
            _text2.x = (S().gameWidth  - _text2.width)  / 2 | 0;
            _text3.x = (S().gameWidth  - _text3.width)  / 2 | 0;

            _continue.x = (S().gameWidth  - _continue.width)  / 2 | 0;


            _text1.y = 100;
            _text2.y = 140;
            _text3.y = 180;

            _continue.y = 550;

            _text1.alpha = 0;
            _text2.alpha = 0;
            _text3.alpha = 0;

            _continue.alpha = 0;

            new rEffFadeScreen(0, 1, 0, 1500, onFadedIn);

            Game.lMain.mouseChildren = false;
        }

        override public function create():void{
            Game.lMain.add2(_icon);
            Game.lMain.add2(_text1);
            Game.lMain.add2(_text2);
            Game.lMain.add2(_text3);
            Game.lMain.add2(_continue);
        }

        override public function destroy(): void {
            super.destroy();

            Game.lMain.clear();
        }

        private function onFadedIn():void{
            setTimeout(fadeIcon, 1000);
        }

        private function fadeIcon():void{
            new rEffFade(_icon, 1, 0.5, 1000, onFadedIcon);
        }

        private function onFadedIcon():void{
            setTimeout(fadeText1, 1000);
        }

        private function fadeText1():void{
            new rEffFade(_text1, 0, 1, 1000, onFadedText1);
        }

        private function onFadedText1():void{
            setTimeout(fadeText2, 1000);
        }

        private function fadeText2():void{
            new rEffFade(_text2, 0, 1, 1000, onFadedText2);
        }

        private function onFadedText2():void{
            setTimeout(fadeText3, 1000);
        }

        private function fadeText3():void{
            new rEffFade(_text3, 0, 1, 1000, onFadedText3);
        }

        private function onFadedText3():void{
            setTimeout(fadeButtons, 2000);
        }

        private function fadeButtons():void{
            new rEffFade(_continue, 0, 1, 1000, onButtonsFaded);
        }

        private function onButtonsFaded():void{
            Game.lMain.mouseChildren = true;
        }

        private function onRetrocade():void{
            navigateToURL(new URLRequest("http://retrocade.net/search?name=Cyberix"), "_blank");
        }

        private function onContinue():void{
            Game.lMain.mouseChildren = false;
            new rEffFade(Game.lMain.displayObject, 1, 0, 1000, function():void {
                Game.lMain.mouseChildren = true;
                Game.lMain.displayObject.alpha = 1;
                Game.lMain.displayObject.visible = true;
                TStateTitle.instance.set();
            })
        }
    }
}