package objects
{
   import flash.display.Sprite;
   import mx.core.BitmapAsset;
   
   public class Mill extends Obj
   {
      
      private static const PI:Number = Math.PI;
       
      
      public var moment:Number;
      
      public var dist:uint;
      
      public var speed:Number;
      
      public var GFX:Sprite;
      
      public var millX:Number;
      
      public var millY:Number;
      
      public function Mill(param1:uint, param2:uint, param3:uint, param4:Number, param5:Number = 0)
      {
         GFX = new Sprite();
         super();
         oX = param1 + 12;
         oY = param2 + 12;
         dist = param3;
         speed = PI / 240 * param4;
         moment = param5;
         setPos();
         var _loc6_:BitmapAsset;
         (_loc6_ = new (Mario.classGFX.AccessGFX("Wall_P"))()).x = param1;
         _loc6_.y = param2;
         Mario.layerWall.addChild(_loc6_);
         var _loc7_:BitmapAsset;
         (_loc7_ = new (Mario.classGFX.AccessGFX("enemy_mill"))()).x = -12.5;
         _loc7_.y = -12.5;
         GFX.addChild(_loc7_);
         GFX.x = millX + 11;
         GFX.y = millY + 11;
         Mario.layerEffects.addChild(GFX);
         Mario.changeLevel(param1 / 25,param2 / 25,"x");
      }
      
      private function setPos() : void
      {
         millX = oX + Math.cos(moment) * dist - 11;
         millY = oY + Math.sin(moment) * dist - 11;
      }
      
      override public function Update(param1:uint) : void
      {
         moment += speed;
         setPos();
         GFX.rotation += speed * 200;
         GFX.x = millX + 11;
         GFX.y = millY + 11;
         if(Mario.playerCollide(millX,millY,23,23))
         {
            Mario.hitPlayer();
         }
      }
   }
}
