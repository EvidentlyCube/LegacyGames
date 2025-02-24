


package net.retrocade.retrocade {
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

    public class rGameViewerThumbBoxes extends RetrocamelSprite{
        private static var _colorTransform:ColorTransform = new ColorTransform();

        private var _games:Vector.<rGameViewerGame>;
        private var _boxes:Vector.<InteractiveObject>;
        private var _boxEdge:Number;

        public function rGameViewerThumbBoxes(boxEdge:Number){
            _games = new Vector.<rGameViewerGame>();
            _boxes = new Vector.<InteractiveObject>();

            _boxEdge = boxEdge;
        }

        public function addGame(game:rGameViewerGame):void{
            _games.push(game);

            var thumbLoader:InteractiveObject = getGameBox(game.imageUrl);
            RetrocamelTooltip.hook(thumbLoader, game.header + "\n" + UtilsString.addLineBreaks(game.paragraphText), true);

            addChild(thumbLoader);
            _boxes.push(thumbLoader);

            reorder();
        }

        public function getGameBox(imageUrl:String):RetrocamelSprite{
            var thumbLoader:rGameViewerThumbLoader = new rGameViewerThumbLoader();
            thumbLoader.loadImage(imageUrl);

            thumbLoader.x = 0;
            thumbLoader.y = 0;
            thumbLoader.width = _boxEdge;
            thumbLoader.height = _boxEdge;

            thumbLoader.filters = [ new BevelFilter(_boxEdge / 5, 45, 0xFFFFFF, 1, 0, 1, _boxEdge / 2, _boxEdge / 2, 0.1) ];

            var container:RetrocamelSprite = new RetrocamelSprite();

            container.buttonMode = true;
            container.addChild(thumbLoader);

            container.addEventListener(MouseEvent.CLICK, onBoxClicked);
            container.addEventListener(MouseEvent.ROLL_OVER, onBoxRollOver);
            container.addEventListener(MouseEvent.ROLL_OUT, onBoxRollOut);

            var blackOverlay:Shape = new Shape();
            blackOverlay.graphics.beginFill(0);
            blackOverlay.graphics.drawRect(0, 0, _boxEdge, _boxEdge);
            blackOverlay.graphics.drawRoundRect(2, 2, _boxEdge - 4, _boxEdge - 4, 5, 5);

            container.addChild(blackOverlay);

            var mask:Shape = new Shape();
            mask.graphics.beginFill(0);
            mask.graphics.drawRoundRect(0, 0, _boxEdge, _boxEdge, 5, 5);

            container.mask = mask;
            container.addChild(mask);

            return container;
        }

        private function reorder():void{
            var lastX:Number = 0;

            for each(var thumbLoader:InteractiveObject in _boxes){
                thumbLoader.x = lastX;

                lastX += thumbLoader.width + _boxEdge / 20;
            }
        }

        private function onBoxClicked(event:MouseEvent):void {
            var boxIndex:int = _boxes.indexOf(event.currentTarget as InteractiveObject);
            var gameUrl:String = _games[boxIndex].targetUrl;

            navigateToURL(new URLRequest(gameUrl), "_blank");
        }

        private function onBoxRollOver(event:MouseEvent):void{
            var box:* = event.target;

            _colorTransform.blueOffset = 50;
            _colorTransform.redOffset = 50;
            _colorTransform.greenOffset = 50;

            box.getChildAt(0).transform.colorTransform = _colorTransform;
        }

        private function onBoxRollOut(event:MouseEvent):void{
            var box:* = event.target;

            _colorTransform.blueOffset = 0;
            _colorTransform.redOffset = 0;
            _colorTransform.greenOffset = 0;

            box.getChildAt(0).transform.colorTransform = _colorTransform;
        }
    }
}
