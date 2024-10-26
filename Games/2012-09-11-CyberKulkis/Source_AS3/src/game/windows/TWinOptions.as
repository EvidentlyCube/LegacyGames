package game.windows{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import game.global.Make;
	import game.global.Options;
	import game.global.Sfx;
	import game.standalone.VolumeBar;

	import net.retrocade.camel.core.rInput;
	import net.retrocade.camel.core.rSave;
	import net.retrocade.camel.core.rSound;
	import net.retrocade.camel.core.rTooltip;
	import net.retrocade.camel.core.rWindow;
	import net.retrocade.camel.easings.exponentialIn;
	import net.retrocade.camel.easings.exponentialOut;
	import net.retrocade.camel.effects.rEffFade;
	import net.retrocade.camel.effects.rEffMove;
	import net.retrocade.camel.effects.rEffectSequence;
	import net.retrocade.standalone.Button;
	import net.retrocade.standalone.Grid9;
	import net.retrocade.standalone.Text;
	import net.retrocade.utils.Key;
	import net.retrocade.utils.UGraphic;

	/**
	 * ...
	 * @author Maurycy Zarzycki
	 */
	public class TWinOptions extends rWindow{
        protected var options:Options;

        protected var closer:Button;

        protected var bg   :Grid9;
        protected var music:Button;
        protected var sound:Button;

        public function TWinOptions(){
            this._blockUnder = true;
            this._pauseGame  = false;

            var txt:Text = new Text(_("Options"), "font", 22);
            txt.setShadow();

            bg      = Grid9.getGrid("window");
            music   = Make().buttonSound(onMusicClick);
            sound   = Make().buttonSound(onSoundClick);
            options = new Options();
            closer  = Make().button(onClose, _('Close'));

            music.addChild(new TWinPause._gfxMusic);
            sound.addChild(new TWinPause._gfxSound);

            addChild(bg);
            addChild(music);
            addChild(sound);
            addChild(txt);
            addChild(options);
            addChild(closer);

            music  .y = 50;
            sound  .y = 50;
            options.y = music.y + music.height + 30;
            closer .y = options.y + options.height + 10;

            bg.width = options.width + 20;
            bg.height = closer.y + closer.height + 10;

            options.x = (width - options.width) / 2 | 0;
            music   .x = width / 2 - music.width  - 5 | 0;
            sound   .x = width / 2                + 5 | 0;
            txt     .x = (width - txt.width) / 2 | 0;
            closer  .x = (width - closer.width) / 2 | 0;

            center();

            new rEffFade(this, 0, 1, 250);
        }

        override public function show():void{
            super.show();

            mouseEnabled  = false;
            mouseChildren = false;

            center();
            x += 100;

            (new rEffMove(this, x - 100, y, 400)).easing = exponentialOut;
            new rEffFade(this, 0, 1, 400, function():void{
                mouseEnabled  = true;
                mouseChildren = true;
            });
        }

        private function onClose():void {
            mouseEnabled  = false;
            mouseChildren = false;
            Sfx.click();
            (new rEffMove(this, x - 100, y, 400)).easing = exponentialIn;
            new rEffFade(this, 1, 0, 400, onHide);
        }

        override public function update():void{
            super.update();

            sound.alpha = (rSound.soundVolume ? 1 : 0.5);
            music.alpha = (rSound.musicVolume ? 1 : 0.5);

            if ((rInput.isKeyHit(Key.ESCAPE) || rInput.isKeyHit(Key.P)) && mouseEnabled)
                onClose();
        }

        private function onMusicClick():void{
            rSound.musicVolume = (rSound.musicVolume ? 0 : 1);
            Sfx.click();
            rSave.write('optVolumeMusic', rSound.musicVolume);
        }

        private function onSoundClick():void{
            rSound.soundVolume = (rSound.soundVolume ? 0 : 1);
            Sfx.click();
            rSave.write('optVolumeSound', rSound.musicVolume);
        }

        private function onHide():void {
            close();
        }
	}
}