package game.objects.effects {
    import flash.filters.GlowFilter;
    import flash.utils.getTimer;
    import game.global.Make;
    import game.states.TStateGame;
    import net.retrocade.camel.core.rInput;
    import net.retrocade.standalone.Text;
	/**
     * ...
     * @author Maurycy Zarzycki
     */
    public class TEffectLevelStats extends TEffect{

        private var text          :Text;
        private var fadeInStart   :Number;
        private var fadeInDuration:Number;

        public function TEffectLevelStats(textToShow:String, fadeTime:uint) {
            super();

            text         = Make.text(38);
            text.alignCenter();
            text.text    = textToShow;
            text.color   = 0xFFFF00;
            text.filters = [ new GlowFilter(0, 1, 2, 2, 10)];

            fadeInStart    = getTimer();
            fadeInDuration = fadeTime;

            text.x = (S.LEVEL_WIDTH_PIXELS  - text.width)  / 2;
            text.y = (S.LEVEL_HEIGHT_PIXELS - text.height) / 2;

            TStateGame.effectsAbove.add(this);
        }

        override public function update():void {
            var alpha:Number = (getTimer() - fadeInStart) / fadeInDuration;

            if (alpha > 1)
                alpha = 1;

            room.layerActive.drawDirect(text, text.x, text.y, alpha);
        }
    }
}