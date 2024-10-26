package game.objects.effects {
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.utils.getTimer;
    import game.widgets.TWidgetSpeech;

    import game.global.Make;
    import game.managers.VOCoord;
    import game.objects.TGameObject;
    import game.states.TStateGame;

    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UBitmapData;
    import net.retrocade.utils.UNumber;
    import net.retrocade.utils.UString;

    /**
     * ...
     * @author
     */
    public class TEffectSubtitle extends TEffect {
        private static const UPDATE_FACTOR:uint = 10;
        private static const BORDER_WIDTH :uint = 2;
        private static const WIDTH_BUFFER :uint = (BORDER_WIDTH + 1) * 2;

        private var xOffset:uint;
        private var yOffset:uint;

        private var x:uint;
        private var y:uint;
        private var w:uint;
        private var h:uint;

        private var text:Text;

        private var texts:Array;

        private var displayLines:uint;
        private var maxWidth    :uint;
        private var duration    :uint;
        private var fadeDuration:uint;

        private var timeWhenEnabled:Number;

        private var fgColor:uint;
        private var bgColor:uint;
        public  var alpha  :Number;
        public  var coords :TGameObject;

        private var buffer:BitmapData;

        public function TEffectSubtitle(coord:TGameObject, text:String, fgColor:uint, bgColor:uint,
                                        duration:uint = 2000, displayLines:uint = 3, maxWidth:uint = 0){
            coords  = coord;
            xOffset = S.LEVEL_TILE_WIDTH;
            yOffset = S.LEVEL_TILE_HEIGHT;

            this.displayLines = displayLines;
            this.maxWidth     = maxWidth;
            this.bgColor      = bgColor;
            this.fgColor      = fgColor;
            this.duration     = duration + 50;

            alpha = 0.88;

            this.text           = Make.text(19);
            this.text.wordWrap  = true;
            this.text.multiline = true;

            if (text && text != "")
                this.text.text = text;

            this.text.width     = S.LEVEL_WIDTH_PIXELS - 60;

            x = y = uint.MAX_VALUE;
            w = h = 0;

            setLocation();

            prepare();

            TStateGame.effectsAbove.add(this);
        }

        override public function update():void {
            if (!buffer)
                return;

            setLocation();

            if (getTimer() > timeWhenEnabled + duration)
                alpha -= 0.0625;

            if (alpha <= 0){
                TStateGame.effectsAbove.nullify(this);
                TWidgetSpeech.removeSubtitle(this);
            } else
                room.layerActive.drawDirect(buffer, x, y, alpha);
        }

        public function stop():void {
            TStateGame.effectsAbove.nullify(this);
            TWidgetSpeech.removeSubtitle(this);
        }

        private function prepare():void {
            if (buffer)
                buffer.dispose();

            var borderSize:uint = BORDER_WIDTH * 2 + 2;
            if (maxWidth > borderSize && w + borderSize > maxWidth)
                w = maxWidth - borderSize;

            var size:Point = getTextWidthHeight();

            w = size.x + borderSize;
            h = size.y + borderSize - 6;

            if (w == 0)
                w = 1;

            if (h == 0)
                h = 1;

            if (x + w >= S.LEVEL_WIDTH_PIXELS)
                x = S.LEVEL_WIDTH_PIXELS - w;

            if (y + h >= S.LEVEL_HEIGHT_PIXELS)
                y = S.LEVEL_HEIGHT_PIXELS - h;

            buffer = new BitmapData(w, h, true, 0);
            buffer.lock();

            text.color = fgColor;

            UBitmapData.shapeRectangle(buffer, 0, 0, w, h, 0, 1);
            UBitmapData.shapeRectangle(buffer, 1, 1, w - 2, h - 2, bgColor, 1);
            UBitmapData.draw(text, buffer, BORDER_WIDTH, BORDER_WIDTH - 5);

            timeWhenEnabled = getTimer();
        }

        public function setOffset(x:int, y:int):void {
            xOffset = x;
            yOffset = y;

            x = uint.MAX_VALUE;
            y = uint.MAX_VALUE;
        }

        public function addTextLine(line:String, duration:uint):void {
            alpha = 0.88;

            if (displayLines == 1)
                text.text = "";

            if (text.text.length == 0)
                text.text = line;
            else {
                if (text.text.indexOf("\n") >= 0 && text.text.indexOf("\r") === -1){
                    text.text += "\n" + line;
                    while (UString.count(text.text, "\n") >= displayLines)
                        text.text = text.text.substr(text.text.indexOf("\n") + 1);
                } else {
                    text.text += "\r" + line;
                    while (UString.count(text.text, "\r") >= displayLines)
                        text.text = text.text.substr(text.text.indexOf("\r") + 1);
                }
            }

            prepare();
            setLocation();

            this.duration = duration + 50;
        }

        public function setText(text:String, duration:uint):void {
            this.text.text = text;

            this.duration = duration;
        }

        private function getTextWidthHeight():Point {
            var w:uint;
            var h:uint;

            if (text.text.length) {
                w = text.textWidth;
                h = text.textHeight;
            }

            return new Point(w, h);
        }

        private function setLocation():void {
            var newX:uint = xOffset + (coords ? coords.x * S.LEVEL_TILE_WIDTH  : 0);
            var newY:uint = yOffset + (coords ? coords.y * S.LEVEL_TILE_HEIGHT : 0);

            if (x == uint.MAX_VALUE) {
                x = newX;
                y = newY;

            } else {
                if (newX < S.LEVEL_WIDTH_PIXELS + xOffset) {
                    var dx:int = newX - x;
                    if (dx < -UPDATE_FACTOR || dx > UPDATE_FACTOR)
                        dx /= UPDATE_FACTOR;
                    else
                        dx = UNumber.sign(dx);

                    x += dx;
                }

                if (newY < S.LEVEL_HEIGHT_PIXELS + yOffset) {
                    var dy:int = newY - y;
                    if (dy < -UPDATE_FACTOR || dy > UPDATE_FACTOR)
                        dy /= UPDATE_FACTOR;
                    else
                        dy = UNumber.sign(dy);

                    y += dy;
                }
            }

            if (x < 0) x = 0;
            if (y < 0) y = 0;
            if (x + w > S.LEVEL_WIDTH_PIXELS)  x = S.LEVEL_WIDTH_PIXELS  - w;
            if (y + h > S.LEVEL_HEIGHT_PIXELS) y = S.LEVEL_HEIGHT_PIXELS - h;
        }
    }
}