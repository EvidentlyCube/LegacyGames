package objects
{
   import flash.display.Sprite;
   import mx.core.BitmapAsset;
   
   public class SpinyShell extends Enemy
   {
       
      
      private var GFX:Sprite;
      
      public function SpinyShell(param1:uint, param2:uint)
      {
         GFX = new Sprite();
         super();
         eX = param1;
         eY = param2;
         eWid = 21;
         eHei = 21;
         gravity = -2 - Math.random() * 3;
         var _loc3_:BitmapAsset = new (Mario.classGFX.AccessGFX("enemy_spiny_shell_1"))();
         _loc3_.x = -_loc3_.width / 2;
         _loc3_.y = -_loc3_.height / 2;
         GFX.addChild(_loc3_);
         GFX.x = eX + 10;
         GFX.y = eY + 10;
         Mario.layerFore.addChild(GFX);
      }
      
      override public function Update(param1:uint) : void
      {
         gravity += Mario.gravity / 2;
         eY += gravity;
         gravity = Math.min(20,gravity);
         GFX.rotation += 6;
         GFX.x = eX + 10;
         GFX.y = eY + 10;
         if(Mario.levelColl(eX,eY + eHei) || Mario.levelColl(eX + eWid - 1,eY + eHei))
         {
            eY = Math.floor((eY + eHei) / 25 - 1) * 25 + 5;
            gravity = 0;
            Mario.removeEnemy(param1);
            Mario.layerFore.removeChild(GFX);
            Mario.instEnemies.push(new Spiny(eX,Math.floor(eY / 25) * 25 + 4));
            alive = false;
         }
         if(Mario.playerCollide(eX,eY,eWid,eHei))
         {
            Mario.hitPlayer();
         }
         if(eY > Mario.levelHei * 25 + 250)
         {
            Fire(param1,1);
         }
      }
      
      override public function Fire(param1:uint, param2:int) : Boolean
      {
         Mario.layerFore.removeChild(GFX);
         Mario.removeEnemy(param1);
         Mario.instEffects.push(new Enemy_Fire(eX,eY - 4,Mario.Sign(param2) * 3,Mario.classGFX.AccessGFX("enemy_spiny_shell_1")));
         return true;
      }
   }
}
