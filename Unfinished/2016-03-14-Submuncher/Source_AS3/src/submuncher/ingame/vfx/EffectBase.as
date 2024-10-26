package submuncher.ingame.vfx {
    import net.retrocade.random.IRandomEngine;
    import net.retrocade.random.RandomEngineKiss;

    import starling.display.Image;
    import starling.textures.Texture;
    import starling.textures.TextureSmoothing;

    public class EffectBase extends Image implements IEffect{
        protected static var _random:IRandomEngine = new RandomEngineKiss();

        public function EffectBase(texture:Texture) {
            super(texture);

            smoothing = TextureSmoothing.NONE;
        }

        public function update():void {
            throw new Error("Method update is not overriden");
        }

        public function get isFinished():Boolean{
            throw new Error("Method isFinished is not overriden");
        }

        public function get isDisplayEffect():Boolean {
            return true;
        }

        public function get isPersistent():Boolean {
            return false;
        }

        public function get blocksGameplay():Boolean {
            return false;
        }

        public function get isOnGameObjectLayer():Boolean {
            return false;
        }

        public function get objectClass():Class {
            throw new Error("Method objectClass is not overriden");
        }

        public function get blocksOtherEffects():Boolean {
            return false;
        }
    }
}
