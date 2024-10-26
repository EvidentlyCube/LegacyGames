package{
    import com.mauft.DataVault.Vault;

    import flash.display.Bitmap;
    import flash.display.BlendMode;
    import flash.display.MovieClip;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filters.DropShadowFilter;
    import flash.media.Sound;
    import flash.ui.Mouse;
    import flash.utils.getDefinitionByName;

    public class Level extends MovieClip{
        public static var pointsCount:Number   = 0;
        public static var pointsHovered:Number = 0;

        public static var lastBonus:int     = 0;

        private static var currentLevel:Level;

        public static function get levelNow():int{ return currentLevel._level; }

        private var _level     :int
        private var _picture   :Bitmap;
        private var _paper     :Bitmap;
        private var _sketch    :Bitmap;
        private var _sketchMask:Shape;
        private var _points    :Sprite;
        private var _return    :_BUTTON_RETURN;
        private var _score     :_SCORE_DISPLAY;

        private var _pencil    :PENCIL;

        public static function get timer()   :Number{ return currentLevel._timer;    }
        public static function get timerMax():Number{ return currentLevel._timerMax; }
        private var _timer     :Number = 0;
        private var _timerMax  :Number = 1;

        private var _completed :Boolean = false;
        public function Level(level:int):void{
            _level = level;

            if (currentLevel){
                currentLevel.$clearLevel();
            }

            currentLevel = this;

            var gfxClass:Class = getDefinitionByName("PIC_" + level.toString()) as Class;

            _picture = new Bitmap(new gfxClass(600,600));

            _paper      = new Bitmap(new _PAPER   (600, 600));
            _sketch     = new Bitmap(new _SCRIBBLE(600, 600));
            _sketchMask = new Shape;
            _points     = new Sprite;
            _pencil     = new PENCIL;
            _return     = new _BUTTON_RETURN;

            _return.x   = 600;

            _pencil.mouseEnabled = false;
            _pencil.filters      = [ new DropShadowFilter(4, 45, 0, 0.5) ];

            Mouse.hide();

            _sketch.blendMode = BlendMode.MULTIPLY;
            _sketch.mask = _sketchMask;

            _picture.alpha = 0;

            addChild(_paper);
            addChild(_picture);
            addChild(_sketchMask);
            addChild(_sketch);
            addChild(_points);
            addChild(_return);
            addChild(_pencil);

            addEventListener(Event.ENTER_FRAME, step);

            LevelsData.initLevel(_level);

            M.self.addChild(this);

            M.self.gotoAndStop(6);

            Vault.setVal("timer", 0);

            lastBonus = 0;

            M.checkDifficulty();
        }

        private function step(e:Event):void{
            _pencil.x = mouseX;
            _pencil.y = mouseY;

            if (_completed){
                if (_pencil.alpha  > 0){ _pencil.alpha  -= 0.05; }

                if (_sketch.alpha  > 0){ _sketch.alpha  -= 0.02; }
                if (_picture.alpha < 1){ _picture.alpha += 0.03; }

                _timerMax = 1;

                _return.x += (600 - _return.x)/10;

            } else {
                if (_timer > 0){
                    _return.x += (800 - _return.x)/10;
                }

                _timer--;

                if (_timer == 0){
                    $restart();
                }
            }
        }

        private function $sketch(startX, startY, startRad, endX, endY, endRad):void{
            var angle:Number = Math.atan2(endY - startY, endX - startX);

            _sketchMask.graphics.beginFill(0x000000);
            _sketchMask.graphics.moveTo(startX + Math.cos(angle + Math.PI/2)*startRad, startY + Math.sin(angle + Math.PI/2)*startRad);
            _sketchMask.graphics.lineTo(startX + Math.cos(angle - Math.PI/2)*startRad, startY + Math.sin(angle - Math.PI/2)*startRad);

            _sketchMask.graphics.lineTo(endX + Math.cos(angle - Math.PI/2)*endRad, endY + Math.sin(angle - Math.PI/2)*endRad);
            _sketchMask.graphics.lineTo(endX + Math.cos(angle + Math.PI/2)*endRad, endY + Math.sin(angle + Math.PI/2)*endRad);
        }
        private function $sketchCircle(x, y, rad):void{
            _sketchMask.graphics.beginFill(0x000000);
            _sketchMask.graphics.drawCircle(x, y, rad);
        }

        private function $clearLevel():void{
            removeChild(_picture);
            removeChild(_paper);
            removeChild(_sketch);
            removeChild(_sketchMask);
            removeChild(_points);
            removeChild(_pencil);

            parent.removeChild(this);

            pointsCount   = 0;
            pointsHovered = 0;

            GamePoint.bodies      = new Array();
            GamePoint.currentBody = null;

            Mouse.show();

            removeEventListener(Event.ENTER_FRAME, step);
        }
        private function $addPoint(gp:GamePoint):void{
        	_points.addChildAt(gp, 0);
        }
        private function $removePoint(gp:GamePoint):void{
            _points.removeChild(gp);
        }
        private function $hovered():void{
            pointsHovered++;

            if (_timer > 0){
                lastBonus = _timer * M.$scoreMultiplier$;
                Vault.addVal("timer", lastBonus);
            }

            if (GamePoint.currentBody == null){
                lastBonus = _timer * M.$scoreMultiplier$;
                Vault.addVal("timer", lastBonus);

                _timer     = -1;
                _timerMax  = 1;
                _completed = true

                M.completion = Math.max(_level + 1, M.completion);

                Mouse.show();
                Vault.setVal("score" + _level.toString(), Math.max(Vault.getVal("score" + _level.toString()), Vault.getVal("timer")));

                _score = new _SCORE_DISPLAY;
                _score.x = 600;


                _sketch    .cacheAsBitmap = true
                _sketchMask.cacheAsBitmap = true

                if (M.$sfx$){
                    Sound(new COMPLETED).play();
                }

                addChild(_score);

                M.save();
            } else {
                if (GamePoint.currentBody.isFirst){
                    _timer    = M.$timerNewBody$;
                    _timerMax = _timer;
                } else {
                    _timer    = M.$timerBase$;
                    _timerMax = _timer;
                }
            }
        }
        private function $restart():void{
            if (M.$sfx$){
                Sound(new FAIL).play();
            }

            new Level(_level);
        }

        private function $endLevel():void{
            $clearLevel();
            currentLevel = null;
            M.self.gotoAndStop(5);
        }

        public static function endLevel():void                                          { if (currentLevel){ currentLevel.$endLevel();                                           } }
        public static function clearLevel():void                                        { if (currentLevel){ currentLevel.$clearLevel();                                         } }
        public static function removePoint(gp:GamePoint):void                           { if (currentLevel){ currentLevel.$removePoint(gp);                                      } }
        public static function hovered():void                                           { if (currentLevel){ currentLevel.$hovered();                                            } }
        public static function restart():void                                           { if (currentLevel){ currentLevel.$restart();                                            } }
        public static function addPoint(gp:GamePoint):void                              { if (currentLevel){ currentLevel.$addPoint(gp);                                         } }
        public static function sketchCircle(x, y, rad):void                             { if (currentLevel){ currentLevel.$sketchCircle(x, y, rad);                              } }
        public static function sketch(startX, startY, startRad, endX, endY, endRad):void{ if (currentLevel){ currentLevel.$sketch(startX, startY, startRad, endX, endY, endRad); } }
    }
}