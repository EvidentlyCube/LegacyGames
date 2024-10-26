package game.objects{
    import game.global.Game;

    import net.retrocade.camel.global.rGroup;
    import net.retrocade.camel.interfaces.rIUpdatable;
    import net.retrocade.camel.objects.rObjectDisplay;

    import starling.display.Image;
    import starling.textures.Texture;

    public class TGameObject extends Image implements rIUpdatable{

        private static var nullTexture:Texture;

        public var tileX:int;
        public var tileY:int;

        { nullTexture = Texture.fromColor(100, 100, 0xFFFF0000); }

        public function TGameObject(texture:Texture, tileX:int, tileY:int){
            if (texture == null)
                texture = nullTexture;

            super(texture);

            this.tileX = tileX;
            this.tileY = tileY;

            reposition();
        }

        public function reposition():void{
            scaleX = S().gameScale;
            scaleY = S().gameScale;

            x = tileX * S().tileWidth * S().gameScale;
            y = tileY * S().tileHeight * S().gameScale;
        }

        public function update():void{}

        public function get defaultGroup():rGroup {
            return Game.gAll;
        }

        public function addDefault():void{
            defaultGroup.add(this);
        }

        public function nullifyDefault():void{
            defaultGroup.nullify(this);
        }
    }
}