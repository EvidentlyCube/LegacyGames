package game.states{
    import flash.display.Bitmap;
    import flash.display.Sprite;

    import game.global.Make;
    import game.global.Pre;
    import game.global.Sfx;
    import game.objects.TBackground;

    import net.retrocade.camel.animations.rAnimPixelBug;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.retrocamel_int;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.core.rLang;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UGraphic;

    use namespace retrocamel_int;

    /**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TStateLang extends rState{
        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        private var _parent:Sprite;

        private var _flags:Array = [];
        private var _flagsGroup:Sprite;

        private var _langText:Bitext;

        private var _startupFunction:Function

        private var _bg:TBackground;

        private var _colorBlind:Button;


        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Creation
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        public function TStateLang(startupFunction:Function){
            _startupFunction = startupFunction;

            _colorBlind = Make().button(onBlindClick, _("Enable Color Blind mode?"));
            _colorBlind.colorizer.saturation = 0;

            _parent = Sprite(Preloader.loaderLayer.displayObject);
            _flagsGroup = new Sprite();

            var flag:Button;
            var lastFlag:Button;
            var tempFlag:Button
            var slide:Number;

            for each(var s:String in S().languages){
                flag = Make().button(onButtonClick, S().languagesNames[S().languages.indexOf(s)]);
                flag.rollOutCallback = onButtonOut;
                flag.rollOverCallback = onButtonOver;
                flag.data.lang = s;

                rTooltip.hook(flag, S().languagesNames[S().languages.indexOf(s)]);


                _flags.push(flag);

                if (lastFlag){
                    flag.x = lastFlag.x + lastFlag.width + 8;
                    flag.y = lastFlag.y;

                    if (flag.x + flag.width > S().gameWidth - 100){
                        slide = (S().gameWidth - 100 - lastFlag.x - lastFlag.width) / 2 | 0;
                        for each (tempFlag in _flags){
                            if (tempFlag.y == flag.y)
                                tempFlag.x += slide;
                        }

                        flag.x = 0;
                        flag.y += 50;
                    }
                }

                lastFlag = flag;

                _flagsGroup.addChild(flag);
            }


            slide = (S().gameWidth - 100 - lastFlag.x - lastFlag.width) / 2 | 0;
            for each (tempFlag in _flags){
                if (tempFlag.y == flag.y)
                    tempFlag.x += slide;
            }

            _flagsGroup.x = 50;
            _flagsGroup.y = S().gameHeight - 60 - _flagsGroup.height;

            _langText = Make().text('asd', 0xFFFFFF, 2, 0, 10);
            _langText.text = rLang.get(null, 'choseLanguage');
            _langText.addShadow();

            _parent.addChild(_flagsGroup);
            _parent.addChild(_langText);

            centerizeMessage();

            Preloader.loaderLayerBG.clear();

            _bg = new TBackground(rGfx.getBD(Pre._bg_), Preloader.loaderLayerBG, 0, 0);

            _parent.addChild(_colorBlind);

            _colorBlind.x = (S().gameWidth - _colorBlind.width) / 2 |0;
            _colorBlind.y = (S().gameHeight) - _colorBlind.height - 5 |0;
        }

        override public function update():void{
            super.update();

            _bg.xspeed = (rInput.mouseX - S().gameWidth / 2) / 100;
            _bg.yspeed = (rInput.mouseY - S().gameHeight / 2) / 100;

            _bg.update();
        }


        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Helpers
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        private function centerizeMessage():void{
            _langText.positionToCenterScreen();
        }




        // ::::::::::::::::::::::::::::::::::::::::::::::::
        // :: Events
        // ::::::::::::::::::::::::::::::::::::::::::::::::

        private function onFaded():void{
            _parent.removeChild(_flagsGroup);
            _parent.removeChild(_langText);

            _startupFunction();
        }

        private function onButtonClick(data:Button):void{
            new rEffFadeScreen(1, 0, 0, 1000, onFaded);

            _flagsGroup.mouseChildren = false;

            rLang.selected = data.data.lang;

            Sfx.sfxClickPlay();
        }

        private function onButtonOver(data:Button):void{
            Sfx.sfxRollOverPlay();
            _langText.text = rLang.get(data.data.lang as String, 'choseLanguage');
            centerizeMessage();
        }

        private function onButtonOut(data:Button):void{
            //_langText.text = rLang.get(null, 'choseLanguage');
            centerizeMessage();
        }

        private function onBlindClick():void{
            if (_colorBlind.colorizer.saturation == 1){
                _colorBlind.colorizer.saturation = 0;
                _colorBlind.colorizer.luminosity = 1;
                Pre.colorBlind = false;
            } else {
                _colorBlind.colorizer.saturation = 1;
                _colorBlind.colorizer.luminosity = 2.5;
                Pre.colorBlind = true;
            }
        }

    }

}