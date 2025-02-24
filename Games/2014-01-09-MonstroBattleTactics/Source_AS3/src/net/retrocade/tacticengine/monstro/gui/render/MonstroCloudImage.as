/**
 * Created by Skell on 18.12.13.
 */
package net.retrocade.tacticengine.monstro.gui.render {
    import net.retrocade.random.Random;

    import starling.display.Image;
    import starling.textures.Texture;

    public class MonstroCloudImage extends Image{
        public static const ANGLE_FRACTION_LIMIT:Number = Math.PI * 0.025;
        public var edgeSleep:uint;
        public var speedFraction:Number;
        public var angleFraction:Number;

        public function MonstroCloudImage(texture:Texture) {
            super(texture);

            rerollCloud();
            edgeSleep = 0;
        }

        public function rerollCloud():void{
            edgeSleep = Random.defaultEngine.getUintRange(0, 100);
            speedFraction = Random.defaultEngine.getNumberRange(0.5, 1.1);
            angleFraction = Random.defaultEngine.getNumberRange(-ANGLE_FRACTION_LIMIT, ANGLE_FRACTION_LIMIT);
        }
    }
}
