package objects
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.LocalConnection;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getDefinitionByName;
   import mx.core.BitmapAsset;

   public dynamic class Loading extends MovieClip
   {

      public static var r2:Sprite;

      public static var r3:Sprite;

      public static var ad:Sprite = new Sprite();

      public static var ts:Sprite;

      public static var add:DisplayObject;

      public static var locked:uint = 0;

      public static var r4:Sprite;

      public static var lc:LocalConnection = new LocalConnection();

      public static var r1:Sprite;


      public var app:Object;

      public var rect:Sprite;

      public var loaded:Boolean = false;

      public var txt:TextField;

      private var GLOGO:Class;

      public var gfx:Sprite;

      public var logo:BitmapAsset;

      public function Loading()
      {
         var tt:TextField;
         var percent:Number;
         GLOGO = Loading_GLOGO;
         rect = new Sprite();
         gfx = new Sprite();
         txt = new TextField();
         super();
         ts = new Sprite();
         ts.graphics.beginFill(0,1);
         ts.graphics.drawRect(100,330,200,32);
         ts.graphics.endFill();
         ts.alpha = 0;
         ts.buttonMode = true;
         ts.addEventListener(MouseEvent.CLICK,function():void
         {
            gfx.removeChild(ad);
            ts.buttonMode = false;
            ad.removeChild(add);
         });
         tt = new TextField();
         tt.htmlText = "<p align=\'center\'><font size=\'25\'>Click to close Ad.</font></p>";
         tt.width = 200;
         tt.x = 100;
         tt.height = 32;
         tt.background = true;
         tt.backgroundColor = 0;
         tt.textColor = 16777215;
         tt.autoSize = TextFieldAutoSize.NONE;
         tt.y = 330;
         tt.borderColor = 15658734;
         tt.border = true;
         stop();
         r1 = new Sprite();
         r1.graphics.beginFill(16777215,0.2);
         r1.graphics.drawRect(12,131,374,104);
         r1.graphics.endFill();
         r1.buttonMode = true;
         r1.alpha = 0;
         r1.addEventListener(MouseEvent.CLICK,function():void
         {
            openWindow("http://beejeux.com/mario.php","_blank");
         });
         r1.addEventListener(MouseEvent.MOUSE_OVER,function():void
         {
            r1.alpha = 1;
         });
         r1.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            r1.alpha = 0;
         });
         r2 = new Sprite();
         r2.graphics.beginFill(16777215,0.2);
         r2.graphics.drawRect(12,250,374,45);
         r2.graphics.endFill();
         r2.buttonMode = true;
         r2.alpha = 0;
         r2.addEventListener(MouseEvent.CLICK,clickman);
         r2.addEventListener(MouseEvent.MOUSE_OVER,function():void
         {
            r2.alpha = 1;
         });
         r2.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            r2.alpha = 0;
         });
         r3 = new Sprite();
         r3.graphics.beginFill(16777215,0.2);
         r3.graphics.drawRect(127,327,75,48);
         r3.graphics.endFill();
         r3.buttonMode = true;
         r3.alpha = 0;
         r3.addEventListener(MouseEvent.CLICK,function():void
         {
            openWindow("http://mauft.com","_blank");
         });
         r3.addEventListener(MouseEvent.MOUSE_OVER,function():void
         {
            r3.alpha = 1;
         });
         r3.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            r3.alpha = 0;
         });
         r4 = new Sprite();
         r4.graphics.beginFill(16777215,0.2);
         r4.graphics.drawRect(202,327,76,48);
         r4.graphics.endFill();
         r4.buttonMode = true;
         r4.alpha = 0;
         r4.addEventListener(MouseEvent.CLICK,function():void
         {
            openWindow("http://kowalczyk.mauft.com","_blank");
         });
         r4.addEventListener(MouseEvent.MOUSE_OVER,function():void
         {
            r4.alpha = 1;
         });
         r4.addEventListener(MouseEvent.MOUSE_OUT,function():void
         {
            r4.alpha = 0;
         });
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         addEventListener(Event.ENTER_FRAME,onEnterFrame);
         logo = new GLOGO();
         logo.x = 200 - logo.width / 2;
         logo.y = 0;
         rect.graphics.beginFill(0);
         rect.graphics.drawRect(0,0,400,375);
         rect.graphics.endFill();
         txt.y = 260;
         txt.autoSize = TextFieldAutoSize.NONE;
         txt.width = 250;
         gfx.addChild(rect);
         gfx.addChild(logo);
         gfx.addChild(txt);
         addChild(gfx);
         txt.textColor = 16777215;
         txt.scaleX = 1;
         txt.scaleY = 1;
         percent = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
         txt.htmlText = "<p align=\'center\'><font color=\'#FFFFFF\' size=\'20\'>" + Math.floor(percent * 10000) / 100 + "%</font></p>";
         txt.x = 75;
         txt.selectable = false;
         stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown2);
         gfx.addChild(r1);
         gfx.addChild(r2);
         gfx.addChild(r3);
         gfx.addChild(r4);
         gfx.visible = false;
         graphics.beginFill(0);
         graphics.drawRect(0,0,400,375);
         showAll();

			ModernDisplay.Init(this, stage, 400, 375);
			CheatCodes.Init()

			stage.addEventListener(KeyboardEvent.KEY_DOWN, CheatCodes.HandleKey);
      }

      public static function openWindow(param1:String, param2:String = "", param3:String = "") : void
      {
         var _loc4_:String = null;
         navigateToURL(new URLRequest(param1),_loc4_);
      }

      private static function getBrowserName() : String
      {
         var _loc1_:String = null;
         var _loc2_:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
         if(_loc2_ != null && _loc2_.indexOf("Firefox") >= 0)
         {
            _loc1_ = "Firefox";
         }
         else if(_loc2_ != null && _loc2_.indexOf("Safari") >= 0)
         {
            _loc1_ = "Safari";
         }
         else if(_loc2_ != null && _loc2_.indexOf("MSIE") >= 0)
         {
            _loc1_ = "IE";
         }
         else if(_loc2_ != null && _loc2_.indexOf("Opera") >= 0)
         {
            _loc1_ = "Opera";
         }
         else
         {
            _loc1_ = "Undefined";
         }
         return _loc1_;
      }

      private function keyDown(param1:KeyboardEvent) : void
      {
         if(app != null)
         {
            app.keyDown(param1);
         }
      }

      private function keyUp(param1:KeyboardEvent) : void
      {
         if(app != null)
         {
            app.keyUp(param1);
         }
      }

      public function clickman(param1:Event) : void
      {
         var _loc2_:Class = null;
         if(loaded)
         {
            removeEventListener(Event.ENTER_FRAME,onEnterFrame);
            removeChild(gfx);
            gfx.removeEventListener(MouseEvent.MOUSE_DOWN,clickman);
            stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown2);
            nextFrame();
            _loc2_ = Class(getDefinitionByName("Mario"));
            if(_loc2_)
            {
               app = new _loc2_();
               addChild(app as DisplayObject);
               stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
               stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
            }
         }
      }

      private function init() : void
      {
         var _loc1_:LocalConnection = new LocalConnection();
         txt.htmlText = "<p align=\'center\'><font color=\'#FFFFFF\' size=\'20\'>Game Loaded. Click to play!</font></p>";
         txt.x = 75;
         loaded = true;
      }

      private function keyDown2(param1:KeyboardEvent) : void
      {
         switch(locked)
         {
            case 0:
               if(param1.keyCode == 80)
               {
                  locked = 1;
               }
               break;
            case 1:
               if(param1.keyCode == 53)
               {
                  locked = 2;
               }
               break;
            case 2:
               if(param1.keyCode == 75)
               {
                  locked = 3;
               }
               break;
            case 3:
               if(param1.keyCode == 71)
               {
                  locked = 4;
               }
               break;
            case 4:
               if(param1.keyCode == 66)
               {
                  locked = 5;
               }
               break;
            case 5:
               if(param1.keyCode == 49)
               {
                  locked = 6;
               }
         }
      }

      public function onEnterFrame(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(gfx.visible && gfx.alpha < 1)
         {
            gfx.alpha += 0.05;
         }
         if(loaded == true)
         {
            return;
         }
         if(framesLoaded == totalFrames)
         {
            init();
         }
         else
         {
            _loc2_ = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
            txt.htmlText = "<p align=\'center\'><font color=\'#FFFFFF\' size=\'20\'>" + Math.floor(_loc2_ * 10000) / 100 + "%</font></p>";
            txt.x = 75;
         }
      }

      private function showAll() : void
      {
         gfx.visible = true;
         gfx.alpha = 0;
      }
   }
}
