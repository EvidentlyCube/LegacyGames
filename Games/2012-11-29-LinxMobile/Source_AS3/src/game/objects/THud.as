package game.objects {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Shape;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;

    import game.data.TBase;
    import game.global.Game;
    import game.global.Level;
    import game.global.Make;
    import game.global.Minimap;
    import game.global.Permit;
    import game.global.Pre;
    import game.global.Score;
    import game.global.Sfx;
    import game.mobiles.MobileButton;
    import game.windows.TWinPause;

    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.global.rEvents;
    import net.retrocade.camel.global.rGfx;
    import net.retrocade.camel.global.rSave;
    import net.retrocade.camel.global.rSfx;
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.camel.objects.rBitmap;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.camel.objects.rSprite;
    import net.retrocade.standalone.Grid9;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UDisplay;
    import net.retrocade.utils.UGraphic;

    import starling.display.Image;
    import starling.textures.Texture;

    /**
     * /assets.
     * @author
     */
    public class THud extends rObject{

        private static var _instance:THud = new THud;

        private static var _layer:rLayerBlit

        public static function get instance():THud {
            return _instance;
        }

        public static var nowPlayedLevel:uint;



        private var levelsetN:Text;
        private var levelN:Text;
        public var pathsN:Text;

		private var spriteMetadata:rSprite;

        private var undo  :TStarlingButton;
        private var clear :TStarlingButton;
        private var menu  :TStarlingButton;
        private var blind :TStarlingButton;

        private var drawColor:rBitmap;
        private var drawColorData:BitmapData;

        private var rememberedPathsCount:int = -1;

        private var backgroundShade:Shape;

        private var lastAlpha:Number;

        public function THud() {
            levelsetN = Make().text("", 0xDDDDDD,30 * S().sizeScaler);
            levelN    = Make().text("", 0xDDDDDD,30 * S().sizeScaler);
            pathsN    = Make().text("", 0xDDDDDD,32 * S().sizeScaler);

            menu   = new TStarlingButton(onMenuClick);
            clear  = new TStarlingButton(onClearClick);
            undo   = new TStarlingButton(onUndo);
            blind  = new TStarlingButton(onBlindClick);

            drawColorData = new BitmapData(50, 50);
            drawColor     = new rBitmap(drawColorData, "auto", true);



            var icon:Image;
            var icon2:Image;

            icon = new Image(Texture.fromBitmapData(rGfx.getBD(Game._button_undo)));

            undo.data = {icon: icon};
            undo.addChild(icon);



            icon = new Image(Texture.fromBitmapData(rGfx.getBD(Game._button_restart)));
            icon2 = new Image(Texture.fromBitmapData(rGfx.getBD(Game._button_restart_confirm)));
            icon2.visible = false;

            clear.data = {icon: icon, icon2: icon2};
            clear.addChild(icon);
            clear.addChild(icon2);



            icon = new Image(Texture.fromBitmapData(rGfx.getBD(Game._button_not_cblind)));
            icon2 = new Image(Texture.fromBitmapData(rGfx.getBD(Game._button_cblind)));

            blind.data = {icon: icon, icon2: icon2};
            blind.addChild(icon);
            blind.addChild(icon2);



            icon = new Image(Texture.fromBitmapData(rGfx.getBD(Game._button_back)));

            menu.data = {icon: icon};
            menu.addChild(icon);

            blind .getChildAt(Pre.colorBlind ? 1 : 0).visible = false;

			spriteMetadata = new rSprite();
			spriteMetadata.addChild(levelN);
			spriteMetadata.addChild(pathsN);
            spriteMetadata.addChild(drawColor);

			rDisplay.stage.addEventListener(Event.RESIZE, reposition);

            undo.enabled = false;

            backgroundShade = new Shape();
        }

        public function reposition(e:Event = null):void{
            changePathNumber(true);

            var spaceSize:Number;
            var minimapBorder:Number;
            var iconSize:Number;

            minimapBorder = Minimap.instance.height + Minimap.instance.y + 10;
            iconSize = (S().gameHeight - minimapBorder) * 0.9 / 4;
            spaceSize = (S().gameHeight - minimapBorder - iconSize * 4) / 5;

            undo.width = iconSize;
            undo.height = iconSize;
            menu.width = iconSize;
            menu.height = iconSize;
            blind.width = iconSize;
            blind.height = iconSize;
            clear.width = iconSize;
            clear.height = iconSize;

            undo.center = S().hudThickness / 2;
            clear.center = S().hudThickness / 2;
            blind.center = S().hudThickness / 2;
            menu.center = S().hudThickness / 2;

            undo.y = minimapBorder + spaceSize;
            clear.y = minimapBorder + spaceSize * 2 + iconSize;
            blind.y = minimapBorder + spaceSize * 3 + iconSize * 2;
            menu.y = minimapBorder + spaceSize * 4 + iconSize * 3;
        }

        private function changePathNumber(force:Boolean = false):void{
            if (rememberedPathsCount != Score.pathsPlaced.get() || force){
                pathsN.text = "Paths: " + Score.pathsPlaced.get() + " / " + Score.pathsMax.get();
                pathsN.size = 30 * S().sizeScaler;
                rememberedPathsCount = Score.pathsPlaced.get();

                pathsN.y = 10;

                pathsN.alignCenterParent(0, S().hudThickness);
            }
        }

        private function changeColor():void{
            if (Level.selectedColor == -1)
                drawColorData.fillRect(new Rectangle(0, 0, S().tileWidth, S().tileHeight), 0);

            else {

                /*drawColorData.copyPixels(
                    Pre.colorBlind ? rGfx.getBD(TBase._tiles_cb) : rGfx.getBD(TBase._tiles_hi),
                    TBase.getRect(Level.selectedColor),
                    new Point()
                );*/
            }
        }

        override public function update():void {
            if (TCursor.self.undoCount() != 0)
                undo.enabled = true;
            else
                undo.enabled = false;


			clear.enabled = Permit.canHud();
			menu .enabled = Permit.canHud() && Permit.canRemovePath();
			undo .enabled = Permit.canUndo();

            if (rEvents.occured(C.eventPathNumberChanged))
                changePathNumber();

            if (Game.lMain.alpha != lastAlpha){
                lastAlpha = Game.lMain.alpha;
                var lastAlphaRound:Number = lastAlpha; //(lastAlpha < 0.05 ? 0 : 1);
                menu.data.icon.alpha = lastAlphaRound;
                clear.data.icon.alpha = lastAlphaRound;
                clear.data.icon2.alpha = lastAlphaRound;
                undo.data.icon.alpha = lastAlphaRound;
                blind.data.icon.alpha = lastAlphaRound;
                blind.data.icon2.alpha = lastAlphaRound;
            }

            if (rEvents.occured(C.eventDrawColorChanged))
                changeColor();
        }

        public function hookTo():void {
            Game.lMain.alpha = 0;

            Game.lHud.addChild(menu);
            Game.lHud.addChild(clear);
            Game.lHud.addChild(undo);
            Game.lHud.addChild(blind);

            Game.lMain.add(backgroundShade);
            Game.lMain.add(spriteMetadata);

            setClearToNoClick();

            rememberedPathsCount = -1;

            reposition();

            changeColor();
        }

        public function unhook():void {
			Game.lMain.clear();

            Game.lHud.clear();
        }

        private function onMenuClick():void{
            TWinPause.instance.show();
            Sfx.sfxClick.play();

            //TStateTitle.instance.set();
        }

        private function onClearClick(data:TStarlingButton):void{
            if (data.data.oneClick){
                rSfx.suppressSounds = true;
                Level.clearPaths();
                Sfx.sfxClick.play();
                setClearToNoClick();
                changePathNumber();
                rSfx.suppressSounds = false;

            } else {
                Sfx.sfxClick.play();
                setClearToConfirm();
            }
        }

        private var clearTimeoutID:Number;
        private function setClearToNoClick():void{
            clear.getChildAt(0).visible = true;
            clear.getChildAt(1).visible = false;
            clear.data.oneClick = false;

            if (clearTimeoutID){
                clearTimeout(clearTimeoutID);
            }

            clearTimeoutID = 0;
        }

        private function setClearToConfirm():void{
            clear.getChildAt(1).visible = true;
            clear.getChildAt(0).visible = false;
            clear.data.oneClick = true;

            if (clearTimeoutID){
                clearTimeout(clearTimeoutID);
            }

            clearTimeoutID = setTimeout(setClearToNoClick, 1000);
        }

        private function onUndo():void{
            TCursor.self.undo();

            if (TCursor.self.undoCount() == 0)
                undo.enabled = false;

            Sfx.sfxClick.play();
        }

        private function onBlindClick():void{
            if (Pre.colorBlind){
                Pre.colorBlind = false;
                blind.getChildAt(0).visible = false;
                blind.getChildAt(1).visible = true;
            } else {
                Pre.colorBlind = true;
                blind.getChildAt(1).visible = false;
                blind.getChildAt(0).visible = true;
            }

            rSave.write("colorBlind", Pre.colorBlind);

            var reset:Function = function():void{
                if (this && this is TConnector)
                    TConnector(this).resetGfx();
            };

            Level.groupBases.callOnAll(reset);
            Level.groupPaths.callOnAll(reset);

            Sfx.sfxClick.play();

            changeColor();
        }
    }
}