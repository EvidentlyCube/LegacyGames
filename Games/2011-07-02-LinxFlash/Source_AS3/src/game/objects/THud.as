package game.objects {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.GradientType;
    import flash.display.Shape;
    import flash.geom.Matrix;
    import flash.geom.Point;

    import game.functions.colorFromColor;
    import game.global.Game;
    import game.global.Level;
    import game.global.Make;
    import game.global.Pre;
    import game.global.Score;
    import game.global.Sfx;
    import game.windows.TWinPause;

    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rDisplay;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.core.rTooltip;
    import net.retrocade.camel.core.retrocamel_int;
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UGraphic;
    import net.retrocade.utils.UString;

    /**
     * ...
     * @author
     */
    public class THud extends rObject{
        [Embed(source="/../assets/gfx/by_cage/ui/hud.png")] public static var _gfx_:Class;

        private static var _instance:THud = new THud;

        private static var _layer:rLayerBlit

        public static function get instance():THud {
            return _instance;
        }

        public static var nowPlayedLevel:uint;



        private var level :Bitext;
        private var levelN:Bitext;
        private var paths :Bitext;
        private var pathsN:Bitext;

        private var eraser:Button;
        private var clear:Button;
        private var menu:Button;
        private var cBlind:Button;

        private var colorBox:Shape;

        private var bg:Bitmap;

        public function THud() {
            level = new Bitext(_("Level:"));
            paths = new Bitext(_("Paths:"));

            levelN = new Bitext();
            pathsN = new Bitext();

            menu   = Make().button(onMenuClick,  _("Menu"));
            clear  = Make().button(onClearClick, _("Clear"));
            eraser = Make().button(onEraserClick, _("Eraser"));
            cBlind = Make().button(onBlindClick, _("C.Blind?"));

            clear.rollOutCallback = onClearRollOut;

            rTooltip.hook(cBlind, _("Enable Color Blind mode?"));

            colorBox = new Shape();

            level         .texture = Make().textTexture([0x8888FF, 0xFFFFFF, 0x8888FF], [1,1,1], [0,70,255], level.lineHeight);
            paths         .texture = Make().textTexture([0x8888FF, 0xFFFFFF, 0x8888FF], [1,1,1], [0,70,255], level.lineHeight);
            levelN        .texture = Make().textTexture([0x8888FF, 0xFFFFFF, 0x8888FF], [1,1,1], [0,70,255], level.lineHeight);
            pathsN        .texture = Make().textTexture([0x8888FF, 0xFFFFFF, 0x8888FF], [1,1,1], [0,70,255], level.lineHeight);
            menu .data.txt.texture = Make().textTexture([0xFF0000, 0xFFFFFF, 0xFF0000], [1,1,1], [0,70,255], level.lineHeight);
            clear.data.txt.texture = Make().textTexture([0xFF0000, 0xFFFFFF, 0xFF0000], [1,1,1], [0,70,255], level.lineHeight);


            level .addShadow();
            paths .addShadow();
            levelN.addShadow();
            pathsN.addShadow();

            level .setScale(2);
            paths .setScale(2);
            levelN.setScale(2);
            pathsN.setScale(2);

            level.x = 5;
            level.y = 5;

            levelN.x = 5;
            levelN.y = 30;

            paths.x = 5;
            paths.y = 70;

            pathsN.x = 5;
            pathsN.y = 95;

            menu.x = (128 - menu.width) / 2;
            menu.y = S().gameHeight - menu.height - 5;

            clear.x = (128 - clear.width) / 2;
            clear.y = menu.y - clear.height - 5;

            eraser.x = (128 - eraser.width) / 2;
            eraser.y = clear.y - eraser.height - 5;

            cBlind.x = (128 - cBlind.width) / 2;
            cBlind.y = eraser.y - cBlind.height - 5;

            colorBox.x = 32;
            colorBox.y = 170;

            bg = rGfx.getB(_gfx_);
            bg.scaleX = bg.scaleY = 2;
        }

        override public function update():void {


            levelN.text =nowPlayedLevel.toString();
            pathsN.text = Score.pathsPlaced.get() + " / " + Score.pathsMax.get();

            levelN.x = 120 - levelN.width;
            pathsN.x = 120 - pathsN.width;

            UGraphic.clear(colorBox).rectFill(0, 0, 64, 64, 0)
                .rectFillGradient(2, 2, 60, 60, [0xFFFFFF, 0xE0E0E0], [1.0, 1.0], [0, 255], 90)
                .rectOutline(6, 6, 52, 52, 2, 0, 0.5)
                .rectFillGradient(8, 8, 48, 48, [colorFromColor(Level.selectedColor) & 0xFFFFFF, colorFromColor(Level.selectedColor) & 0xFFFFFF], [1.0, 0.8], [0, 255], 90);
        }

        public function hookTo(layer:rLayerBlit):void {
            rCore.groupAfter.add(this);
            _layer = layer;

            Game.lMain.add2(bg);
            Game.lMain.add2(level);
            Game.lMain.add2(paths);
            Game.lMain.add2(levelN);
            Game.lMain.add2(pathsN);
            Game.lMain.add2(menu);
            Game.lMain.add2(clear);
            Game.lMain.add2(eraser);
            Game.lMain.add2(colorBox);
            Game.lMain.add2(cBlind);

            if (!Pre.colorBlind){
                cBlind.colorizer.luminosity = 1.0;
                cBlind.colorizer.saturation = 0;
            } else {
                cBlind.colorizer.luminosity = 2.0;
                cBlind.colorizer.saturation = 1;
            }

            rTooltip.unhook(eraser);
            rTooltip.hook(eraser, _("eraserTooltip", _("key" + Game.keyClear)));
        }

        public function unhook():void {
            rCore.groupAfter.nullify(this);

            if (Game.lMain.contains2(level)){
                Game.lMain.remove2(bg);
                Game.lMain.remove2(level);
                Game.lMain.remove2(paths);
                Game.lMain.remove2(levelN);
                Game.lMain.remove2(pathsN);
                Game.lMain.remove2(menu);
                Game.lMain.remove2(clear);
                Game.lMain.remove2(colorBox);
            }
        }

        private function onMenuClick():void{
            TWinPause.instance.show();
            Sfx.sfxClickPlay();
        }

        private function onClearClick(data:Button):void{
            if (data.data.oneClick){
                Level.clearPaths();
                Sfx.sfxClickPlay();
                setClearToNoClick();


            } else {
                Sfx.sfxClickPlay();
                setClearToConfirm();
            }
        }

        private function onClearRollOut():void{
            setClearToNoClick();
        }

        private function setClearToNoClick():void{
            var text:Bitext = clear.data.txt as Bitext;
            text.text = _("Clear");
            text.positionToCenter();

            clear.data.oneClick = false;
        }

        private function setClearToConfirm():void{
            var text:Bitext = clear.data.txt as Bitext;
            text.text = _("yousure");
            text.positionToCenter();

            clear.data.oneClick = true;
        }

        private function onEraserClick():void{
            if (TCursor.self)
                TCursor.self.isEraser = true;

            Sfx.sfxClickPlay();
        }

        private function onBlindClick():void{
            if (Pre.colorBlind){
                Pre.colorBlind = false;
                cBlind.colorizer.luminosity = 1.0;
                cBlind.colorizer.saturation = 0;
            } else {
                Pre.colorBlind = true;
                cBlind.colorizer.luminosity = 2.0;
                cBlind.colorizer.saturation = 1;
            }

            var reset:Function = function():void{
                if (this && this is TConnector)
                    TConnector(this).resetGfx();
            };

            Level.bases.callOnAll(reset);
            Level.paths.callOnAll(reset);

            Sfx.sfxClickPlay();
        }
    }
}