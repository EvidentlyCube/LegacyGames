package objects
{
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.media.Sound;
   import mx.core.BitmapAsset;

   public class Player
   {

      public static var hitStomp:Boolean = false;
      public static var dir:int = 1;
      public static var SFXDeath:Sound = new (Mario.classSFX.accessSFX("death"))();
      public static var pSize:uint = 0;
      public static var hitHead:Boolean = false;
      public static var elev:Elevator;
      public static var trans:ColorTransform = new ColorTransform();
      public static var sequenceFrame:uint = 0;
      public static var crouch:uint = 0;
      public static var SFXPowerup:Sound = new (Mario.classSFX.accessSFX("powerup"))();
      public static var sequence:int = 0;
      public static var pWid:uint = 16;
      public static var speed:Number = 0;
      public static const PLAYER_SPEED:Number = 12;
      public static const PLAYER_MAXSPEED:Number = PLAYER_SPEED * 30;
      public static var gravity:Number = 0;
      public static var SFXPowerdown:Sound = new (Mario.classSFX.accessSFX("powerdown"))();
      public static var GFX:BitmapAsset;
      private static var jumper:uint = 0;
      private static var maxJumper:uint = 0;
      private static var seq:uint = 0;
      public static var pX:int;
      public static var pY:int;
      public static var frame:uint = 0;
      public static var fired:uint = 0;
      public static var shield:uint = 0;
      public static var GFX2:Sprite = new Sprite();
      public static var pHei:uint = 24;
      public static var starred:uint = 0;


      private var SFXJump:Sound;
      private var SFXBump:Sound;
      private var SFXRadish:Sound;

      public function Player(param1:Number, param2:Number)
      {
         SFXJump = new (Mario.classSFX.accessSFX("jump"))();
         SFXRadish = new (Mario.classSFX.accessSFX("radish"))();
         SFXBump = new (Mario.classSFX.accessSFX("bump"))();
         super();
         pX = param1;
         pY = param2;
         var _loc3_:Class = Mario.classGFX.AccessGFX("object_mario0_walk_1");
         GFX = new _loc3_();
         GFX.x = pX - 2;
         GFX.y = pY - 3;
         GFX2.addChild(GFX);
         Mario.layerFore.addChild(GFX2);
      }

      public static function CeilPull() : void
      {
         var _loc1_:uint = 0;
         if(Mario.levelColl(pX,pY) || Mario.levelColl(pX + pWid - 1,pY))
         {
            _loc1_ = Math.floor(pY / 25) * 25 + 25;
            if(Mario.levelColl(pX,_loc1_ + pHei - 1) || Mario.levelColl(pX + pWid - 1,_loc1_ + pHei - 1))
            {
               crouch = 2;
            }
            else
            {
               pY = _loc1_;
            }
         }
      }

      public static function starMe() : void
      {
         starred = 400;
         Mario.classSFX.Play(3);
      }

      public static function Reset() : void
      {
         Player.hitStomp = false;
         Player.hitHead = false;
      }

      public static function Bounce(param1:int) : void
      {
         Player.pY = param1 - Player.pHei;
         Player.gravity = -7;
         Player.jumper = 1;
         CeilPull();
         GFX.x = pX - (dir == -1 ? -23 : 5);
         GFX.y = pY - 3 - 21;
      }

      public static function Falls() : Boolean
      {
         if(Player.gravity > 1)
         {
            return true;
         }
         return false;
      }

      public static function ResetGraphic() : void
      {
         GFX.scaleX = dir;
         GFX.x = pX - (dir == -1 ? -23 : 5);
         GFX.y = pY - 3 - 21;
      }

      public static function ResetPlayer(param1:Number, param2:Number) : void
      {
         pX = param1;
         pY = param2;
         speed = 0;
         gravity = 0;
         jumper = 0;
         GFX.x = pX - (dir == -1 ? -23 : 5);
         GFX.y = pY - 3 - 21;
         if(Mario.levelColl(pX,pY + pHei - 1) || Mario.levelColl(pX + pWid - 1,pY + pHei - 1))
         {
            Player.pY -= 25;
         }
         Mario.layerFore.addChild(GFX2);
      }

      public function Update() : void
      {
         var _loc1_:Class = null;
         seq = 0;
         if(Mario.isKeyDown(0))
         {
            dir = 1;
            if(speed > -10)
            {
               if(speed < PLAYER_MAXSPEED)
               {
                  speed += PLAYER_SPEED * 4;
               }
            }
            else
            {
               dir = -1;
               seq = 1;
               speed += PLAYER_SPEED * 6;
            }
         }
         else if(Mario.isKeyDown(2))
         {
            dir = -1;
            if(speed < 10)
            {
               if(speed > -PLAYER_MAXSPEED)
               {
                  speed -= PLAYER_SPEED * 4;
               }
            }
            else
            {
               dir = 1;
               seq = 1;
               speed -= PLAYER_SPEED * 6;
            }
         }
         else if(speed > 2)
         {
            speed -= PLAYER_SPEED * 4;
         }
         else if(speed < -2)
         {
            speed += PLAYER_SPEED * 4;
         }
         if(Mario.isKeyPressed(4) && (elev != null || Mario.levelColl(pX,pY + pHei + 1) || Mario.levelColl(pX + pWid - 1,pY + pHei + 1)))
         {
            gravity = -5.5;
            jumper = 1;
            maxJumper = 16;
            if(elev)
            {
               elev.free();
            }
            if(Mario.sounds)
            {
               SFXJump.play();
            }
         }
         if(Mario.isKeyDown(4) && jumper < maxJumper && jumper > 0)
         {
            ++jumper;
            gravity = -5.5;
         }
         else
         {
            jumper = 20;
         }
         pX += Math.round(speed / 100);
         if(speed > 0)
         {
            if(Mario.levelColl(pX + pWid - 1,pY) || Mario.levelColl(pX + pWid - 1,pY + pHei - 1) || Mario.levelColl(pX + pWid - 1,pY + (pHei - 1) / 2))
            {
               speed = 0;
               pX = Math.floor(pX / 25) * 25 + 25 - pWid;
            }
         }
         else if(Mario.levelColl(pX,pY) || Mario.levelColl(pX,pY + pHei - 1) || Mario.levelColl(pX,pY + (pHei - 1) / 2))
         {
            speed = 0;
            pX = Math.floor(pX / 25) * 25 + 25;
         }
         if(gravity > 10)
         {
            gravity = 10;
         }
         if(elev == null && Mario.levelColl(pX,pY + pHei) == false && Mario.levelColl(pX + pWid - 1,pY + pHei) == false)
         {
            gravity += Mario.gravity;
            seq = 2;
         }
         else if(gravity >= 0)
         {
            gravity = 0;
         }
         pY += Math.round(gravity);
         if(gravity > 0)
         {
            if(Mario.levelColl(pX,pY + pHei - 1) || Mario.levelColl(pX + pWid - 1,pY + pHei - 1))
            {
               jumper = 0;
               gravity = 0;
               pY = Math.floor(pY / 25) * 25 + 1;
               seq = 0;
            }
         }
         else if(Mario.levelColl(pX,pY) || Mario.levelColl(pX + pWid - 1,pY))
         {
            jumper = 0;
            gravity = 0;
            Player.hitHead = true;
            if(Mario.sounds)
            {
               SFXBump.play();
            }
            pY = Math.floor(pY / 25) * 25 + 25;
         }
         var _loc2_:uint = pSize;
         var _loc3_:uint = 0;
         if(sequence != 0)
         {
            --sequenceFrame;
            if(sequenceFrame % 2 == 1)
            {
               switch(sequence)
               {
                  case -2:
                     _loc2_ = 2;
                     break;
                  case -1:
                     _loc2_ = 1;
                     break;
                  case 1:
                     _loc2_ = 0;
                     break;
                  case 2:
                     _loc2_ = 1;
               }
            }
            if(sequenceFrame == 0)
            {
               sequence = 0;
            }
         }
         else if(shield > 0)
         {
            _loc3_ = shield % 2;
            --shield;
         }
         if(Mario.isKeyPressed(5) && Mario.radishNO < pSize * 3)
         {
            Mario.instObjects.push(new Fireball(pX + (dir == 1 ? 22 : 0),pY + 10,dir));
            ++Mario.radishNO;
            if(Mario.sounds)
            {
               SFXRadish.play();
            }
         }
         switch(seq)
         {
            case 0:
               frame = (frame + Math.abs(speed / 8)) % 1500;
               if(Math.abs(speed) < 30)
               {
                  frame = 0;
                  if(_loc2_ == 0)
                  {
                     _loc1_ = Mario.classGFX.AccessGFX("object_mario0_stand");
                  }
                  else
                  {
                     _loc1_ = Mario.classGFX.AccessGFX("object_mario1_stand");
                  }
               }
               else
               {
                  _loc1_ = Mario.classGFX.AccessGFX("object_mario" + String(_loc2_) + "_walk_" + String(Math.floor(frame / 100)));
               }
               break;
            case 1:
               _loc1_ = Mario.classGFX.AccessGFX("object_mario" + String(_loc2_) + "_brake");
               break;
            case 2:
               _loc1_ = Mario.classGFX.AccessGFX("object_mario" + String(_loc2_) + "_jump");
         }
         GFX2.removeChild(GFX);
         GFX = new _loc1_();
         GFX.scaleX = dir;
         GFX.x = pX - (dir == -1 ? -21 : 6) + _loc3_ * 1000;
         GFX.y = pY - 3 - 21;
         if(starred > 0)
         {
            Mario.enemyStarHit(pX,pY,pWid,pHei,dir);
            if(starred > 100 || starred % 5 == 0)
            {
               trans.greenOffset = (Math.random() - 0.5) * 400;
               trans.redOffset = (Math.random() - 0.5) * 400;
               trans.blueOffset = (Math.random() - 0.5) * 0;
            }
            --starred;
            if(starred == 0)
            {
               Mario.classSFX.Play(Mario.musika);
            }
         }
         else
         {
            trans.greenOffset = 0;
            trans.redOffset = 0;
            trans.blueOffset = 0;
         }
         GFX2.transform.colorTransform = trans;
         GFX2.addChild(GFX);
         if(pY > Mario.levelHei * 25 + 25)
         {
            Mario.hitPlayer(true, true);
         }
         if(Mario.scrolling)
         {
            Mario.scrollX = Math.min(200 - Player.pX,-Mario.scrollEdge);
         }
      }
   }
}
