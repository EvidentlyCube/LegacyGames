package game.objects.effects {
    import flash.filters.GlowFilter;
    import flash.utils.getTimer;

    import game.global.Make;
    import game.states.TStateGame;

    import net.retrocade.standalone.Text;

	/**
     * ...
     * @author
     */
    public class TEffectTextFlash extends TEffect {
        private var text     :Text;
        private var yOffset  :int;
        private var showUntil:Number;
        private var size     :int;

        private var currentFrame :uint = 0;
        private var lastFrameTime:Number = 0;

        public function TEffectTextFlash(textToShow:String, yOffset:int = 0, duration:int = 5000, size:int = 64) {
            super();

            text         = Make.text();
            text.text    = textToShow;
            text.color   = 0xFFFF00;
            text.filters = [ new GlowFilter(0, 1, 2, 2, 100)];

            this.yOffset = yOffset;
            this.size    = size;
            showUntil    = getTimer() + duration;

            TStateGame.effectsAbove.add(this);
        }

        override public function update():void {
            if (showUntil < getTimer()){
                TStateGame.effectsUnder.nullify(this);
                return;
            }

            if (getTimer() > lastFrameTime + 250){
                switchFrame();
                lastFrameTime = getTimer();
            }

            render();
        }

        private function switchFrame():void {
            currentFrame = 1 - currentFrame;

            text.size = currentFrame ? size : size - 4;

            text.x = (S.LEVEL_WIDTH_PIXELS  - text.textWidth)  / 2;
            text.y = yOffset;
        }

        private function render():void {
            room.layerActive.drawPrecise(text, text.x, text.y, 1);
        }
    }
}