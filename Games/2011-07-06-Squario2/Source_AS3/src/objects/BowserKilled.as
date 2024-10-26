package objects
{
   import flash.display.Sprite;
   import flash.media.Sound;
   
   public class BowserKilled extends Obj
   {
       
      
      public var timer:uint = 0;
      
      public var gfx:Sprite;
      
      public var SFXComplete:Sound;
      
      public function BowserKilled()
      {
         SFXComplete = new (Mario.classSFX.accessSFX("level_complete"))();
         gfx = new Sprite();
         super();
         gfx.graphics.beginFill(0);
         gfx.graphics.drawRect(0,0,400,375);
         gfx.graphics.endFill();
      }
      
      override public function Update(param1:uint) : void
      {
         ++timer;
         if(timer > 130)
         {
            if(Mario.levelid < 12)
            {
               SFXComplete.play();
               Swap();
               Mario.removeObject(param1);
            }
            else if(timer == 131)
            {
               Mario.layerGover.addChild(gfx);
               gfx.alpha = 0;
            }
            else
            {
               gfx.alpha += 0.1;
               if(gfx.alpha > 1)
               {
                  ++Mario.levelid;
                  Mario.clearLevel();
                  Mario.decreaseI = 1;
               }
            }
         }
      }
      
      private function Swap() : void
      {
         Mario.playerControllable = false;
         Mario.layerFore.removeChild(Player.GFX2);
         Mario.instEffects.push(new PlayerFinish(Player.pX,Player.pY,Player.gravity,Player.speed,Player.frame));
         if(Mario.music)
         {
            SFXComplete.play();
         }
      }
   }
}
