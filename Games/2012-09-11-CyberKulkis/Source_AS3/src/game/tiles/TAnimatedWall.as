package game.tiles{
    import game.global.Game;
    import game.objects.TGameObject;

    import net.retrocade.camel.core.rGfx;
    import net.retrocade.utils.Rand;

    public class TAnimatedWall extends TWall{
        public var frames:Array;
        public var currentFrame:uint = 0;
        public var speed:uint;
        public var waitOnFrame:Array = [];

        public var waiter:uint = 0;

        public function TAnimatedWall(x:uint, y:uint, animation:uint, isAlternate:Boolean){
            super(x, y, -1, -1, isAlternate);

            _x = x;
            _y = y;

            getAt(x, y).addObject(this);

            addDefault();

            initAnimation(animation);

            _gfx = frames[currentFrame];
        }

        override public function update():void{
            if (waiter)
                waiter--;

            else {
                currentFrame = (currentFrame + 1) % frames.length;
                if (waitOnFrame[currentFrame])
                    waiter = 6 * Rand.u(4,50);
                else
                    waiter = speed;

                _gfx = frames[currentFrame];
            }
        }

        private function initAnimation(animation:uint):void{
            switch(animation){
                case(0): // Monitor
                    frames = [];
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 96, 360, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 120, 360, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 144, 360, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 168, 360, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 192, 360, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 216, 360, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 240, 360, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 264, 360, 24, 24));

                    currentFrame = Rand.u(0, 8);
                    speed = 1;
                    waitOnFrame[0] = true;
                    if (currentFrame == 0)
                        waiter = speed * Rand.u(4,50);
                    break;

                case(1): // pipes H
                    frames = [];
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 216, 384, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 240, 384, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 264, 384, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 288, 384, 24, 24));

                    currentFrame = 0;
                    speed = 6;
                    break;

                case(2): // electro pipes V
                    frames = [];
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 360, 384, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 384, 384, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 408, 384, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 432, 384, 24, 24));

                    currentFrame = 0;
                    speed = 6;
                    break;

                case(3): // green pipes H
                    frames = [];
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 216, 408, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 240, 408, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 264, 408, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 288, 408, 24, 24));

                    currentFrame = Rand.u(0, 4);
                    speed = 6;
                    waitOnFrame[0] = true;
                    if (currentFrame == 0)
                        waiter = speed * Rand.u(4,20);
                    break;

                case(4): // electro pipes V
                    frames = [];
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 360, 408, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 384, 408, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 408, 408, 24, 24));
                    frames.push(rGfx.getBDExt(Game.generalGfxClass, 432, 408, 24, 24));

                    currentFrame = Rand.u(0, 4);
                    speed = 6;
                    waitOnFrame[0] = true;
                    if (currentFrame == 0)
                        waiter = speed * Rand.u(4,20);
                    break;

            }
        }

        override public function draw():void{
            Game.lGame.draw(_gfx, x, y);
        }

        override public function enters(object:TGameObject, tx:int, ty:int):Boolean{
            return false;
        }

        override public function touched(object:TGameObject):void{
            if (bitmapCollision(object))
                object.stop();
        }

        override public function toggle():void{
            isAlternate = !isAlternate;
        }
    }
}