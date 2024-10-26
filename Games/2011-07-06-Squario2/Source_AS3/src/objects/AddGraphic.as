package objects
{
   import mx.core.BitmapAsset;
   
   public function AddGraphic(param1:uint, param2:uint, param3:String) : BitmapAsset
   {
      var _loc4_:BitmapAsset;
      (_loc4_ = new (Mario.classGFX.AccessGFX(param3))()).x = param1;
      _loc4_.y = param2;
      return _loc4_;
   }
}
