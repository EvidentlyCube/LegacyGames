package submuncher.ingame.renderers.general.hud {
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;

    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;

    import submuncher.core.constants.Gfx;
    import submuncher.core.constants.GuiNames;

    public class HudDigits extends Sprite{
        private static var _textures:Vector.<Texture>;
        private static var _charMap:Dictionary;

        {
            init();
        }

        private static function init():void {
            _textures = new Vector.<Texture>(12);
            for (var i:int = 0; i < 12; i++){
                _textures[i] = Texture.fromTexture(Gfx.guiAtlas.getTexture(GuiNames.DIGITS), new Rectangle(i * 7, 0, 6, 9));
            }

            _charMap = new Dictionary();
            _charMap["0"] = _textures[0];
            _charMap["1"] = _textures[1];
            _charMap["2"] = _textures[2];
            _charMap["3"] = _textures[3];
            _charMap["4"] = _textures[4];
            _charMap["5"] = _textures[5];
            _charMap["6"] = _textures[6];
            _charMap["7"] = _textures[7];
            _charMap["8"] = _textures[8];
            _charMap["9"] = _textures[9];
            _charMap[":"] = _textures[10];
            _charMap["."] = _textures[11];
        }

        private var _images:Vector.<Image>;

        public function HudDigits() {
            _images = new Vector.<Image>();

            usesEvents = false;
        }

        override public function dispose():void {
            for each (var image:Image in _images) {
                image.dispose();
            }

            _images = null;

            super.dispose();
        }

        public function set text(value:String):void {
            value = value.replace(/[^0-9\.:]+/g, "");

            var image:Image;
            while (value.length > _images.length){
                image = new Image(_textures[0]);
                image.x = _images.length * 7;
                _images.push(image);
                addChild(image);
            }

            for (var i:int = 0; i < value.length; i++) {
                image = _images[i];
                image.visible = true;
                image.texture = _charMap[value.charAt(i)];
            }

            for (;i < _images.length; i++){
                _images[i].visible = false;
            }
        }
    }
}
