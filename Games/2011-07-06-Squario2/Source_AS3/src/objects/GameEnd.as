package objects
{
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.media.Sound;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import mx.core.BitmapAsset;

   public class GameEnd
   {

      [Embed(source="../../assets/gfx/game/GameEnd_GFXC.png")] private var GFXC:Class;
      [Embed(source="../../assets/gfx/game/GameEnd_GFXK.png")] private var GFXK:Class;
      [Embed(source="../../assets/sfx/SFX_GAMEEND.mp3")]private var Jebs:Class;

      private var bar2:Shape;


      private var timer:Number = 0;

      private var kiss:Sprite;


      private var bar:Shape;

      private var cX:Number;

      private var cY:Number = 0;

      private var SFXJ:Sound;

      private var list:Array;

      private var seq:uint = 0;

      private var kifu:Boolean = false;

      private var txt:TextField;

      private var castle:Sprite;

      private var flash:Sprite;

      public function GameEnd()
      {
         castle = new Sprite();
         kiss = new Sprite();
         flash = new Sprite();
         bar = new Shape();
         bar2 = new Shape();
         list = new Array();
         txt = new TextField();
         Jebs = GameEnd_Jebs;
         super();
         SFXJ = new Jebs();
         flash.graphics.beginFill(16777215);
         flash.graphics.drawRect(0,0,400,375);
         flash.graphics.endFill();
         Mario.playerControllable = false;
         Player.GFX2.alpha = 0;
         Mario.Hud.GFX.alpha = 0;
         var _loc1_:BitmapAsset = new GFXK();
         kiss.addChild(_loc1_);
         kiss.x = 200 - kiss.width / 2;
         kiss.y = 40;
         _loc1_ = new GFXC();
         _loc1_.x = 0;
         _loc1_.y = -_loc1_.height;
         castle.addChild(_loc1_);
         kiss.alpha = 0;
         cX = 200 - castle.width / 2;
         castle.x = cX;
         castle.y = _loc1_.height + 25;
         Barer();
         Mario.layerHide.addChild(castle);
         Mario.layerGover.addChild(flash);
         Mario.layerGover.addChild(kiss);
         Mario.layerGover.addChild(bar);
         Mario.layerGover.addChild(txt);
         Mario.layerGover.addChild(bar2);
         txt.textColor = 16777215;
         bar.alpha = 0;
         bar2.alpha = 0;
         flash.alpha = 0;
         txt.scaleX = 1.5;
         txt.x = 200;
         txt.y = 309;
         txt.scaleY = 1.5;
         txt.autoSize = TextFieldAutoSize.CENTER;
         txt.alpha = 0;
      }

      public function Barer() : void
      {
         var _loc1_:String = GradientType.LINEAR;
         var _loc2_:Array = [0,0];
         var _loc3_:Array = [0,1];
         var _loc4_:Array = [0,40];
         var _loc5_:Matrix;
         (_loc5_ = new Matrix()).createGradientBox(400,75,Math.PI / 2);
         var _loc6_:String = SpreadMethod.PAD;
         bar.graphics.beginGradientFill(_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_);
         bar.graphics.drawRect(0,0,400,75);
         bar.graphics.endFill();
         bar.y = 300;
         bar2.graphics.beginFill(0);
         bar2.graphics.drawRect(0,0,400,75);
         bar2.graphics.endFill();
         bar2.y = 315;
      }

      public function Throw() : void
      {
         if(list.length == 0)
         {
            list.push("enemy_goomba","enemy_goomba","bonus_used","effect_hammer","enemy_bbeetle_1","enemy_bbeetle_2");
            list.push("enemy_bullet_1","enemy_bullet_2","enemy_bullet_3","enemy_fly_green_1","enemy_fly_green_2");
            list.push("enemy_fly_red_1","enemy_fly_red_2","enemy_hammer_1","enemy_hammer_2","enemy_jumper_1");
            list.push("enemy_jumper_2","enemy_jumper_3","enemy_koopa_green_1","enemy_koopa_green_2","enemy_koopa_red_1");
            list.push("enemy_koopa_red_2","enemy_lakitu_1");
            list.push("enemy_spiny_1","enemy_spiny_2");
         }
         var _loc1_:uint = Math.floor(Math.random() * list.length);
         Mario.instEffects.push(new Gamend_Fire(cX + 70 + Math.random() * (castle.width - 140),cY + 80,Math.random() * 4 - Math.random() * 4,list[_loc1_]));
      }

      public function Update(param1:uint) : void
      {
         var o:Object = null;
         var boardID:String = null;
         var myID:uint = param1;
         if(Mario.music == 0)
         {
            kifu = true;
         }
         else if(kifu)
         {
            if(seq == 0)
            {
               Mario.classSFX.Play(8);
            }
            kifu = false;
         }
         if(seq == 0)
         {
            if(timer == 0)
            {
               Mario.classSFX.Play(8);
            }
            cY += (timer > 100 ? (timer - 100) / 135 : 0) * Math.PI;
            Mario.playerControllable = false;
            Player.GFX2.alpha = 0;
            Mario.Hud.GFX.alpha = 0;
            castle.x = cX + Math.sin(timer) * 5;
            castle.rotation = cY;
            timer += 1;
            Mario.instEffects.push(new Fire_Boom(cX + Math.random() * castle.width,300));
            if(Math.random() < 0.2)
            {
               Throw();
            }
            if(cY >= 90)
            {
               seq = 1;
               timer = 2;
               if(Mario.sounds)
               {
                  SFXJ.play();
               }
            }
         }
         else if(seq == 1)
         {
            flash.alpha = timer;
            timer -= 0.01;
            if(timer <= 0)
            {
               seq = 2;
               timer = -0.5;
            }
         }
         else if(seq == 2)
         {
            timer += 0.01;
            kiss.alpha = timer;
            bar.alpha = timer;
            if(timer >= 1)
            {
               txt.alpha = 1;
               bar2.alpha = 1;
               timer = 0;
               seq = 3;
               txt.htmlText = "<p align=\'center\'><font color=\'#FFFFFF\'>Squario 2\nJuly 2010 Mauft.com</font></p>";
               txt.x = 200 - txt.width / 2;
            }
         }
         else if(seq == 3)
         {
            timer += 0.01;
            bar2.alpha = 1 - Math.sin(timer) * 4;
            if(timer > Math.PI)
            {
               timer = 0;
               seq = 4;
               txt.htmlText = "<p align=\'center\'>Created by: Mauft.com\n Programming: Mauft.com\n Graphics: Aleksander Kowalczyk</p>";
               txt.x = 200 - txt.width / 2;
            }
         }
         else if(seq == 4)
         {
            timer += 0.01;
            bar2.alpha = 1 - Math.sin(timer) * 4;
            if(timer > Math.PI)
            {
               timer = 0;
               seq = 5;
               txt.htmlText = "<p align=\'center\'>\nSound Effects: Public Domain\nLevel Design: Mauft.com</p>";
               txt.x = 200 - txt.width / 2;
            }
         }
         else if(seq == 5)
         {
            timer += 0.01;
            bar2.alpha = 1 - Math.sin(timer) * 4;
            if(timer > Math.PI)
            {
               timer = 0;
               seq = 6;
               txt.scaleX = 2.5;
               txt.scaleY = 2.5;
               txt.htmlText = "<p align=\'center\'>Thank You for Playing!</p>";
               txt.x = 200 - txt.width / 2;
               txt.y += 10;
            }
         }
         else if(seq == 6)
         {
            seq = 7;
            GameOver.isGO = true;
            o = {
               "n":[7,3,0,14,13,9,11,3,7,15,7,9,6,6,5,2],
               "f":function(param1:Number, param2:String):String
               {
                  if(param2.length == 16)
                  {
                     return param2;
                  }
                  return this.f(param1 + 1,param2 + this.n[param1].toString(16));
               }
            };
            boardID = String(o.f(0,""));
            closiawa();
         }
         else if(seq == 8)
         {
            timer += 0.005;
            bar2.alpha = 1 - Math.sin(timer) * 4;
            if(timer > Math.PI)
            {
               Mario.clearLevel(false);
               Mario.TScreen = new TitleScreen();
               Mario.sequence = 4;
               Mario.decreaseI = 1;
               Mario.stepping = true;
            }
         }
      }

      public function closiawa() : void
      {
         GameOver.isGO = false;
         seq = 8;
      }
   }
}
