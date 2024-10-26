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
    import net.retrocade.standalone.Button;
    import net.retrocade.standalone.Text;

    public class Options extends Sprite{
        private var _keyChangers:Array = [];
        private var _nowChanging:Button;

        public function Options(){
            for each(var s:String in Game.allKeys)
                addKeyChanger(s);
        }

        private function addKeyChanger(keyName:String):void {
            var wid:Number = 125;

            var button:Button = Make().button(onKeyChangeClick, _('key'+Game[keyName]), 120);
            var desc  :Text = new Text(_(keyName + 'Desc') + ":", "font", 16);

            button.data.keyName = keyName;
            button.data.desc    = desc;
            button.data.txt.alignCenterParent();

            button.x = (_keyChangers.length % 3) * wid | 0;// + (wid - button.width) / 3 | 0;
            button.y = (_keyChangers.length / 3 | 0) * 60;

            desc.x   = (_keyChangers.length % 3) * wid + (wid - desc.width) / 2 | 0;
            desc.y   = button.y - 20;
            desc.setShadow();

            addChild(desc);
            addChild(button);
            _keyChangers.push(button);
        }

        private function onKeyChangeClick(button:Button):void {
            button.data.txt.text = "...";
            button.data.txt.alignCenterParent();

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
            _nowChanging.data.txt.alignCenterParent();

            rSave.write('opt' + _nowChanging.data.keyName, e.keyCode);

            TWinRedefiningKey.instance.close();

            Game.disableQuickSFXToggle = false;
            rInput.flushAll();

            e.stopImmediatePropagation();
        }
    }
}