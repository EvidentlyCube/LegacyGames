package game.global{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;

    import game.standalone.VolumeBar;
    import game.windows.TWinRedefiningKey;

    import net.retrocade.camel.core.rInput;
    import net.retrocade.camel.core.rSave;
    import net.retrocade.camel.core.rSound;
    import net.retrocade.camel.core.rWindows;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Text;

    public class Options extends Sprite{
        [Embed(source='/../assets/gfx/by_maurycy/music.png')] private var _gfx_music_:Class;
        [Embed(source='/../assets/gfx/by_maurycy/sfx.png')]   private var _gfx_sfx_  :Class;

        private var _iconMusic:Bitmap;
        private var _iconSfx  :Bitmap;

        private var _info     :Bitext;

        private var _barMusic :VolumeBar;
        private var _barSfx   :VolumeBar;

        private var _keyChangers:Array = [];
        private var _nowChanging:Button;

        public function Options(){
            _iconMusic = new _gfx_music_;
            _iconSfx   = new _gfx_sfx_;
            _barMusic  = new VolumeBar(changedMusic);
            _barSfx    = new VolumeBar(changedSfx);

            _info = new Bitext(_("Redefine keys:"));
            _info.scaleX = 2;
            _info.scaleY = 2;

            _iconMusic.x = 65;
            _iconSfx  .x = 65;
            _iconSfx  .y = 40;
            _info.x = (375 - _info.width) / 2 | 0;
            _info.y = 70;
            _info.addShadow();

            _barMusic.gfx.x = 105;
            _barSfx.gfx  .x = 105;
            _barSfx.gfx  .y = 40;

            reset();

            addChild(_iconMusic);
            addChild(_iconSfx);
            addChild(_barMusic.gfx);
            addChild(_barSfx.gfx);
            addChild(_info);

            for each(var s:String in Game.allKeys)
            addKeyChanger(s);
        }

        public function reset():void{
            _barMusic.value = rSound.musicVolume;
            _barSfx  .value = rSound.soundVolume;
        }

        private function addKeyChanger(keyName:String):void {
            var wid:Number = 125;

            var button:Button = Make().button(onKeyChangeClick, _('key'+Game[keyName]), 120);
            var desc  :Bitext = Make().text(_(keyName + 'Desc') + ":");

            button.data.keyName = keyName;
            button.data.desc    = desc;
            button.data.txt.positionToCenter();

            button.x = (_keyChangers.length % 3) * wid | 0;// + (wid - button.width) / 3 | 0;
            button.y = (_keyChangers.length / 3 | 0) * 60 + 110;

            desc.x   = (_keyChangers.length % 3) * wid + (wid - desc.width) / 2 | 0;
            desc.y   = button.y - 16;
            desc.addShadow();

            addChild(desc);
            addChild(button);
            _keyChangers.push(button);
        }

        private function onKeyChangeClick(button:Button):void {
            button.data.txt.text = "...";
            button.data.txt.positionToCenter();

            stage.mouseChildren = false;

            rInput.addStageKeyDown(onKeyChangePress);

            _nowChanging = button;

            TWinRedefiningKey.instance.set(button.data.keyName);

            Game.disableQuickSFXToggle = true;
        }

        private function onKeyChangePress(e:KeyboardEvent):void {
            rInput.removeStageKeyDown(onKeyChangePress);

            stage.mouseChildren = true;

            Game[_nowChanging.data.keyName] = e.keyCode;
            _nowChanging.data.txt.text = _('key'+e.keyCode);
            _nowChanging.data.txt.positionToCenter();

            rSave.write('opt' + _nowChanging.data.keyName, e.keyCode);

            TWinRedefiningKey.instance.close();

            Game.disableQuickSFXToggle = false;
            rInput.flushAll();

            e.stopImmediatePropagation();
        }

        private function changedMusic(value:Number):void{
            rSound.musicVolume = value;
            rSave.write('optVolumeMusic', value);
        }

        private function changedSfx(value:Number):void{
            rSound.soundVolume = value;
            rSave.write('optVolumeSound', value);
        }
    }
}