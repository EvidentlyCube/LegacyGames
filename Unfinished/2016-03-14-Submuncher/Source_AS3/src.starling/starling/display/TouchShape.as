/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 03.03.13
 * Time: 12:59
 * To change this template use File | Settings | File Templates.
 */
package starling.display {
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    import starling.core.RenderSupport;

    public class TouchShape extends DisplayObject{
        private var mWidth:Number;
        private var mHeight:Number;

        private static var sHelperMatrix:Matrix = new Matrix();

        public function TouchShape(width:Number, height:Number) {
            super();

            this.width = width;
            this.height = height;
        }

        override public function render(support:RenderSupport, parentAlpha:Number):void{}

        override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle=null):Rectangle
        {
            if (resultRect == null) resultRect = new Rectangle();

            if (targetSpace == this) // optimization
            {
                resultRect.setTo(0.0, 0.0, width, height);
            }
            else if (targetSpace == parent && rotation == 0.0) // optimization
            {
                resultRect.setTo(x, y, width, height);
            }
            else
            {
                getTransformationMatrix(targetSpace, sHelperMatrix);
                resultRect.setTo(sHelperMatrix.tx, sHelperMatrix.ty, sHelperMatrix.a * width, sHelperMatrix.d * height);
            }

            return resultRect;
        }

        override public function get width():Number { return mWidth; }
        override public function set width(value:Number):void
        {
            mWidth = Math.abs(value);
        }

        /** The height of the object in pixels. */
        override public function get height():Number { return mHeight; }
        override public function set height(value:Number):void
        {
            mHeight = Math.abs(value);
        }
    }
}
