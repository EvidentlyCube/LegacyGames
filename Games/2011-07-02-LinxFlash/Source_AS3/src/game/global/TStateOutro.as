package game.global{
    import flash.display.BitmapData;

    import game.objects.TRibbon;
    import game.states.TStateScores;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.camel.effects.rEffVolumeFade;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Text;

    public class TStateOutro extends rState{
        private static var _instance:TStateOutro = new TStateOutro();

        public static function get instance():TStateOutro{
            return _instance;
        }



        /****************************************************************************************************************/
        /**                                                                                                  VARIABLES  */
        /****************************************************************************************************************/

        private var _story1:Bitext;
        private var _story2:Bitext;
        private var _story3:Bitext;
        private var _story4:Bitext;
        private var _story5:Bitext;
        private var _story6:Bitext;
        private var _story7:Bitext;
        private var _story8:Bitext;
        private var _story9:Bitext;
        private var _storyA:Bitext;

        private var _timer:uint = 0;

        private var _bgBD:BitmapData;
        private var _bgY :Number = 0;

        /****************************************************************************************************************/
        /**                                                                                                  FUNCTIONS  */
        /****************************************************************************************************************/

        public function TStateOutro(){
            _story1 = Make().text(_('outro1'), 0xFFFFFF, 2);
            _story2 = Make().text(_('outro2'), 0xFFFFFF, 2);
            _story3 = Make().text(_('outro3'), 0xFFFFFF, 2);
            _story4 = Make().text(_('outro4'), 0xFFFFFF, 2);
            _story5 = Make().text(_('outro5'), 0xFFFFFF, 2);
            _story6 = Make().text(_('outro6'), 0xFFFFFF, 2);
            _story7 = Make().text(_('outro7'), 0xFFFFFF, 4);
            _story8 = Make().text(_('outro8'), 0xFFFFFF, 2);
            _story9 = Make().text(_('outro9'), 0xFFFFFF, 2);
            _storyA = Make().text(_('outroA'), 0xFFFFFF, 2);

            _story1.positionToCenterScreen();
            _story2.positionToCenterScreen();
            _story3.positionToCenterScreen();
            _story4.positionToCenterScreen();
            _story5.positionToCenterScreen();
            _story6.positionToCenterScreen();
            _story7.positionToCenterScreen();
            _story8.positionToCenterScreen();
            _story9.positionToCenterScreen();
            _storyA.positionToCenterScreen();

            _story1.y = 20;
            _story2.y = 50;
            _story3.y = 80;
            _story4.y = 110;
            _story5.y = 140;
            _story6.y = 170;
            _story7.y = (S().gameHeight - _story7.height) / 2 - 50;
            _story8.y = _story7.y + _story7.height + 5;
            _story9.y = _story8.y + _story8.height + 5;
            _storyA.y = _story9.y + _story9.height + 5;

            _story1.addShadow();
            _story2.addShadow();
            _story3.addShadow();
            _story4.addShadow();
            _story5.addShadow();
            _story6.addShadow();
            _story7.addShadow();
            _story8.addShadow();
            _story9.addShadow();
            _storyA.addShadow();

            _bgBD = rGfx.getBD(Level._bg_);
        }

        override public function create():void {
            Game.lMain.add2(_story1);
            Game.lMain.add2(_story2);
            Game.lMain.add2(_story3);
            Game.lMain.add2(_story4);
            Game.lMain.add2(_story5);
            Game.lMain.add2(_story6);
            Game.lMain.add2(_story7);
            Game.lMain.add2(_story8);
            Game.lMain.add2(_story9);
            Game.lMain.add2(_storyA);

            _story1.alpha = 0;
            _story2.alpha = 0;
            _story3.alpha = 0;
            _story4.alpha = 0;
            _story5.alpha = 0;
            _story6.alpha = 0;
            _story7.alpha = 0;
            _story8.alpha = 0;
            _story9.alpha = 0;
            _storyA.alpha = 0;

            _timer = 0;

            var r:TRibbon = makeRibbon(-2, 10);
            r.isVertical = true;
            r.farthestEdge = S().levelHeight;
            r.swayPower = 5;
            r.swaySpeed = -Math.PI / 60;
            r.swayOffset = Math.PI / 75;
            r.addMany(16);
            r.moveAll(-S().levelHeight);

            r = makeRibbon(2, S().levelWidth -25);
            r.isVertical = true;
            r.farthestEdge = S().levelHeight;
            r.swayPower = 5;
            r.swaySpeed = Math.PI / 60;
            r.swayOffset = Math.PI / 75;
            r.addMany(16);
            r.moveAll(S().levelHeight);

            new rEffFadeScreen(0, 1, 0, 500);
            rSound.playMusic(Game.music);
            new rEffVolumeFade(true, 500);

            _bgY = 0;
        }

        override public function update():void {
            Game.lGame.clear();
            Game.lBG.clear();

            _bgY += 0.71;

            Game.lBG.draw(_bgBD, 0, -(_bgY % S().levelHeight));
            Game.lBG.draw(_bgBD, 0, -(_bgY % S().levelHeight) + S().levelHeight);

            _defaultGroup.update();

            _timer++;

                   if (_timer == 20)  { new rEffFade(_story1, 0, 1, 500); new rEffFade(_story2, 0, 1, 500);
            } else if (_timer == 180) { new rEffFade(_story3, 0, 1, 500); new rEffFade(_story4, 0, 1, 500);
            } else if (_timer == 340) { new rEffFade(_story5, 0, 1, 500); new rEffFade(_story6, 0, 1, 500);
            } else if (_timer == 600) { new rEffFade(_story1, 1, 0, 500);
            } else if (_timer == 610) { new rEffFade(_story2, 1, 0, 500);
            } else if (_timer == 620) { new rEffFade(_story3, 1, 0, 500);
            } else if (_timer == 630) { new rEffFade(_story4, 1, 0, 500);
            } else if (_timer == 640) { new rEffFade(_story5, 1, 0, 500);
            } else if (_timer == 650) { new rEffFade(_story6, 1, 0, 500);

            } else if (_timer == 700) { new rEffFade(_story7, 0, 1, 500);
            } else if (_timer == 780) { new rEffFade(_story8, 0, 1, 500);
            } else if (_timer == 860) { new rEffFade(_story9, 0, 1, 500);
            } else if (_timer == 940) { new rEffFade(_storyA, 0, 1, 500);
            } else if (_timer == 955) { new rEffFade(_storyA, 1, 0, 500);
            } else if (_timer == 965) { new rEffFade(_story9, 1, 0, 500);
            } else if (_timer == 975) { new rEffFade(_story8, 1, 0, 500);
            } else if (_timer == 1020){ new rEffFadeScreen(1, 0, 0, 2500, lastEffectEnded);
            }

            if (_timer > 940 && _timer < 950) {
                _timer = 945;
                if (rInput.isKeyHit(rInput._SPACE))
                    _timer = 950;
            }
        }

        private function lastEffectEnded():void {
            TStateScores.instance.sendScores();
        }

        private function makeRibbon(spd:Number, y:Number):TRibbon {
            var r:TRibbon = new TRibbon(y, spd, Game.lGame);

            return r;
        }
    }
}