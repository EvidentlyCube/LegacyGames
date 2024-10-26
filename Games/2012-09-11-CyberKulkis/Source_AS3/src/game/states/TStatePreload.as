package game.states{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;

    import game.global.Make;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.Rand;

    public class TStatePreload extends rState{
        [Embed(source="/../assets/gfx/title.png")] private static var _title_:Class;

        [Embed(source="/../assets/gfx/border3.png")] public static var _border_:Class;

        private static var _instance:TStatePreload = new TStatePreload();

        public static function get instance():TStatePreload{
            return _instance;
        }

        private var bg:Bitmap
        private var logo:Bitmap;

        private var title:Text;
        private var desc:Text;

        private var load:Text;
        private var loadWaver:Number = 0;

        private var parent:Sprite = new Sprite;

        private var fakePercent:Number = 0;



        private var state:uint = 0;

        public function TStatePreload(){
            bg      = rGfx.getB(_border_);

            logo = new _title_;
            logo.x = (S().gameWidth - logo.width) / 2 | 0;
            logo.y = 40;

            title = new Text("", "font", 22);

            title.alignCenter();
            title.y = 128;

            desc = new Text("", "font", 18);

            desc.textAlignCenter();
            desc.text = "A mighty action-logic hybrid in the retro world.";

            desc.x = (S().gameWidth- desc.width) / 2;
            desc.y = 190;

            load = new Text(_("loading") + " " + fakePercent.toFixed(1) + "%", "font", 18);

            parent.addChild(bg);
            parent.addChild(logo);
            parent.addChild(desc);
            parent.addChild(load);
            parent.addChild(title);

            title.setShadow();
            desc.setShadow();
            load.setShadow();
        }

        override public function create():void{
            Preloader.loaderLayer.add2(parent);
            new rEffFadeScreen(0, 1, 0, 500);
        }

        override public function destroy():void{
            Preloader.loaderLayer.remove2(parent);
        }

        override public function update():void{
            super.update();

            fakePercent = Math.min(fakePercent + Rand.om * 5 + 5, Preloader.percent);

            if (state == 0){
                load.alpha = 1;
                load.text = "Start game!";
                load.size = 26;
                load.fitSize();
                load.alignCenter();
                load.buttonMode = true;
                load.mouseChildren = false;
                load.mouseEnabled = true;
                load.useHandCursor = true;
                load.addEventListener(MouseEvent.CLICK, onStart);
                state = 1;

                load.x = (S().gameWidth - load.width) / 2;
                load.y = 240 + Math.cos(loadWaver += Math.PI/ 110) * 5;
            }
        }

        private function onStart(e:MouseEvent):void{
            new rEffFadeScreen(1, 0, 0, 300, function():void{
                dispatchEvent(new Event("start"));
            });
        }
    }
}