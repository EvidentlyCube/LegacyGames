/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 30.01.13
 * Time: 22:06
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.tacticengine.monstro.render {
    import net.retrocade.camel.global.rCore;
    import net.retrocade.camel.interfaces.rIUpdatable;
    import net.retrocade.tacticengine.monstro.core.Monstro;
    import net.retrocade.tacticengine.monstro.core.MonstroConst;
    import net.retrocade.tacticengine.monstro.core.MonstroGfx;
    import net.retrocade.utils.Rand;

    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;

    import starling.textures.Texture;
    import starling.textures.TextureSmoothing;

    public class MonstroUnitClip extends Sprite implements rIUpdatable{
        private static var _dummyTexture:Texture = Texture.fromColor(Monstro.tileWidth, Monstro.tileHeight, 0xFFFF0000);

        private var _image:Image;
        private var _unitRect:MovieClip;

        private var _normalTextures:Vector.<Vector.<Texture>>;
        private var _disabledTextures:Vector.<Vector.<Texture>>;

        private var _isDisabled:Boolean = false;
        private var _direction:int = MonstroConst.NO_ORIENTATION;


        public function MonstroUnitClip(){
            super();

            _image = new Image(_dummyTexture);

            _normalTextures   = new Vector.<Vector.<Texture>>(MonstroConst.ORIENTATION_COUNT, true);
            _disabledTextures = new Vector.<Vector.<Texture>>(MonstroConst.ORIENTATION_COUNT, true);

            _image.smoothing = TextureSmoothing.NONE;

            addChild(_image);
        }

        public function update():void{
            if (_unitRect){
                _unitRect.advanceTime(rCore.deltaTime / 1000);
            }
        }

        private function addUnitRect():void{
            if (!_unitRect){
                _unitRect = MonstroGfx.getUnitRect();

                addChildAt(_unitRect, 0);
            }
        }

        public function set showUnitRect(value:Boolean):void{
            if (value && !_unitRect){
                addUnitRect();
            }

            if (_unitRect){
                _unitRect.visible = value;
            }
        }

        public function get showUnitRect():Boolean{
            return _unitRect && _unitRect.visible;
        }

        public function set disabled(value:Boolean):void{
            if (_isDisabled != value){
                _isDisabled = value;

                resetTexture();
            }
        }

        public function get disabled():Boolean{
            return _isDisabled;
        }

        public function set direction(value:int):void{
            if (_direction != value && value != MonstroConst.NO_ORIENTATION){
                _direction = value;

                resetTexture();
            }
        }

        public function get direction():int{
            return _direction;
        }

        private function resetTexture():void{
            var textureType:Vector.<Vector.<Texture>> = (_isDisabled ? _disabledTextures : _normalTextures);
            var textureGroup:Vector.<Texture> = textureType[_direction];

            if (!textureGroup){
                textureGroup = textureType[MonstroConst.NO_ORIENTATION];
                if (!textureGroup){
                    throw new Error("No texture found for given direction nor for NO ORIENTATION")
                }
            }

            _image.texture = textureGroup[Rand.u(0, textureGroup.length)];
        }

        public function addTexture(direction:int, texture:Texture):void{
            if (!_normalTextures[direction]){
                _normalTextures[direction] = new Vector.<Texture>();
            }

            _normalTextures[direction].push(texture);
        }

        public function addDisabledTexture(direction:int, texture:Texture):void{
            if (!_disabledTextures[direction]){
                _disabledTextures[direction] = new Vector.<Texture>();
            }

            _disabledTextures[direction].push(texture);
        }
    }
}
