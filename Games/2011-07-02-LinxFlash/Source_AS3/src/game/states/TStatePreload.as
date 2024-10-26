package game.states{
    import flash.display.Sprite;

    import game.global.Make;
    import game.global.Pre;
    import game.objects.TRibbon;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rState;
    import net.retrocade.camel.effects.rEffFade;
    import net.retrocade.camel.effects.rEffFadeScreen;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Text;

    public class TStatePreload extends rState{
        private var txt:Bitext;
        private var desc:Bitext;
        private var load:Bitext;
        private var parent:Sprite = new Sprite;

        private var loadWaver:Number = 0;

        private var ribbon1:TRibbon;
        private var ribbon2:TRibbon;

        public function TStatePreload(){
            txt  = Make().text(_("preloadTitle"), 0xFFFFFF, 8);
            desc = Make().text(_("preloadDesc"));
            load = Make().text(_("loading") + " " + Preloader.percent.toFixed(1) + "%");

            txt.x = (S().gameWidth - txt.width) / 2;
            txt.y = 145;

            desc.x = (S().gameWidth- desc.width) / 2;
            desc.y = 255;

            ribbon1 = new TRibbon(20, 2, Preloader.loaderLayerBG);
            ribbon1.isVertical = true;
            ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 0, 0, 16, 16), 1);
            ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 16, 0, 16, 16), 1);
            ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 32, 0, 16, 16), 1);
            ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 48, 0, 16, 16), 1);
            ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 64, 0, 16, 16), 1);
            ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 80, 0, 16, 16), 1);
            ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 96, 0, 16, 16), 1);
            ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 112, 0, 16, 16), 1);
            ribbon1.addItem(rGfx.getBDExt(Pre._ribbon_, 128, 0, 16, 16), 1);

            ribbon1.farthestEdge = S().gameWidth / 2;
            ribbon1.swayPower = 10;
            ribbon1.swaySpeed = 5;
            ribbon1.swayOffset = 10;
            ribbon1.swayPosition = 20;
            ribbon1.addMany(20);
            ribbon1.moveAll(S().gameWidth / 2);

            ribbon2 = new TRibbon(222, -2, Preloader.loaderLayerBG);
            ribbon2.isVertical = true;
            ribbon2.addItem(rGfx.getBDExt(Pre._ribbon_, 0, 0, 16, 16), 1);
            ribbon2.addItem(rGfx.getBDExt(Pre._ribbon_, 16, 0, 16, 16), 1);
            ribbon2.addItem(rGfx.getBDExt(Pre._ribbon_, 32, 0, 16, 16), 1);
            ribbon2.addItem(rGfx.getBDExt(Pre._ribbon_, 48, 0, 16, 16), 1);
            ribbon2.addItem(rGfx.getBDExt(Pre._ribbon_, 64, 0, 16, 16), 1);
            ribbon2.addItem(rGfx.getBDExt(Pre._ribbon_, 80, 0, 16, 16), 1);
            ribbon2.addItem(rGfx.getBDExt(Pre._ribbon_, 96, 0, 16, 16), 1);
            ribbon2.addItem(rGfx.getBDExt(Pre._ribbon_, 112, 0, 16, 16), 1);
            ribbon2.addItem(rGfx.getBDExt(Pre._ribbon_, 128, 0, 16, 16), 1);

            ribbon2.farthestEdge = 0;
            ribbon2.swayPower = 10;
            ribbon2.swaySpeed = 5;
            ribbon2.swayOffset = -10;
            ribbon2.swayPosition = 20;
            ribbon2.addMany(20);
            ribbon2.moveAll(S().gameWidth / -2);

            parent.addChild(txt);
            parent.addChild(desc);
            parent.addChild(load);
        }

        override public function update():void{
            super.update();
            Preloader.loaderLayerBG.clear();
            ribbon1.update();
            ribbon2.update();

            load.text = _("loading") + " " + Preloader.percent.toFixed(1) + "%";
            load.x = (S().gameWidth - load.width) / 2;
            load.y = 290 + Math.cos(loadWaver += Math.PI/ 110) * 5;
        }

        override public function create():void{
            Preloader.loaderLayer.add2(parent);
            new rEffFadeScreen(0, 1, 0, 500);
        }

        override public function destroy():void{
            Preloader.loaderLayer.remove2(parent);
        }
    }
}