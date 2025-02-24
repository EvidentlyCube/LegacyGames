


package net.retrocade.retrocade {
    import net.retrocade.retrocade.rGameViewerGame;
    import net.retrocade.retrocamel.display.global.RetrocamelTooltip;
    import flash.display.InteractiveObject;
    import flash.display.Shape;
    import flash.events.MouseEvent;
    import flash.filters.BevelFilter;
    import flash.geom.ColorTransform;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    import net.retrocade.retrocamel.display.flash.RetrocamelSprite;
    import net.retrocade.utils.UtilsString;

    public class rGameViewerWideBox extends RetrocamelSprite{
        private static var _colorTransform:ColorTransform = new ColorTransform();

        private var _game:rGameViewerGame;
        private var _box:RetrocamelSprite;
        private var _width:Number;

        public function rGameViewerWideBox(game:rGameViewerGame, boxWidth:Number){
            _game = game;
            _box = getGameBox(game);
            _width = boxWidth;
        }

        public function getGameBox(game:rGameViewerGame):RetrocamelSprite{
            var height:Number = _width * 60 / 300;

            var thumbLoader:rGameViewerThumbLoader = new rGameViewerThumbLoader();
            thumbLoader.loadImage(game.imageUrl);

            thumbLoader.x = 0;
            thumbLoader.y = 0;
            thumbLoader.width = _width;
            thumbLoader.height = height;

            thumbLoader.filters = [ new BevelFilter(height / 5, 45, 0xFFFFFF, 1, 0, 1, _width/ 2, height/ 2, 0.1) ];

            var container:RetrocamelSprite = new RetrocamelSprite();

            container.buttonMode = true;
            container.addChild(thumbLoader);

            container.addEventListener(MouseEvent.CLICK, onBoxClicked);
            container.addEventListener(MouseEvent.ROLL_OVER, onBoxRollOver);
            container.addEventListener(MouseEvent.ROLL_OUT, onBoxRollOut);

            var blackOverlay:Shape = new Shape();
            blackOverlay.graphics.beginFill(0);
            blackOverlay.graphics.drawRect(0, 0, width, height);
            blackOverlay.graphics.drawRoundRect(2, 2, width - 4, height- 4, 5, 5);

            container.addChild(blackOverlay);

            var mask:Shape = new Shape();
            mask.graphics.beginFill(0);
            mask.graphics.drawRoundRect(0, 0, width, height, 5, 5);

            container.mask = mask;
            container.addChild(mask);

            RetrocamelTooltip.hook(thumbLoader, game.header + "\n" + UtilsString.addLineBreaks(game.paragraphText), true);

            return container;
        }

        private function onBoxClicked(event:MouseEvent):void {
            navigateToURL(new URLRequest(_game.targetUrl), "_blank");
        }

        private function onBoxRollOver(event:MouseEvent):void{
            _colorTransform.blueOffset = 50;
            _colorTransform.redOffset = 50;
            _colorTransform.greenOffset = 50;

            _box.getChildAt(0).transform.colorTransform = _colorTransform;
        }

        private function onBoxRollOut(event:MouseEvent):void{
            _colorTransform.blueOffset = 0;
            _colorTransform.redOffset = 0;
            _colorTransform.greenOffset = 0;

            _box.getChildAt(0).transform.colorTransform = _colorTransform;
        }
    }
}
