package{
	import com.mauft.DataVault.Vault;
	import com.mauft.SaveLoad;
	import com.mauft.pixelBall.PixelBallEngine;
	import com.meychi.ascrypt.Rijndael;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	import src.Oranger;
	import src.linkedlist.rLinkedList;
	import src.linkedlist.rLinkedListLink;
	
	dynamic public class M extends MovieClip{
		public static const ALL_LEVS:Number = 12;
		public static var self:M;
		
		public static var completed:Number = 0;
		public static var level:MovieClip;
		public static var player:Player;
		
		public static var total1:TextField;
		
		public static var _play:Boolean = false;
		public static var _scored:Boolean = false;
		
		public static var levID:int = 0;
		
		public static var coins:Number = 0;
		
		public static var sfx:Boolean = true;
		public static var mch:SoundChannel
        
        public static function addUnderWall(child:DisplayObject):void{
            if (PixelBallEngine.terrain){
                var parent:DisplayObjectContainer = PixelBallEngine.terrain.parent;
                parent.addChildAt(child, parent.getChildIndex(PixelBallEngine.terrain) - 1)
            }
        }
        
		public function M():void{
			self = this;
            
            MochiBot.track(this, "e939ac22");
            
			stage.showDefaultContextMenu = false;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			this.tabChildren = false;
			this.tabEnabled = false;
			
			if (false){
    			new Sound
    			new Sprite
			}

			addEventListener(Event.ENTER_FRAME, step);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kDown);
			
			resetScores()
			       
            Vault.setCallback(resetScores);
            
            load();
            
            stage.quality = StageQuality.BEST;
		}
		
		public function kDown(e:KeyboardEvent):void{
			switch(e.keyCode){
				case(Keyboard.ESCAPE):
				    reset();
					gotoAndStop(4);
					return;
					
				case(82):
					reset();
					gotoAndPlay(currentFrame - 1);
					return;
					
				case(83):
					if (sfx){ sfx = false; } else {sfx = true;}
					return;
			}
		}
		
		public function step(e:Event):void{
			if (_play){
				if (coins == 0){
					if (!_scored){
						Vault.setValue("score"+levID.toString(), Math.min(Vault.retrieveValue("score"+levID.toString()), Vault.retrieveValue("timer")));
						_scored = true;
						
						completed = Math.max(levID+1, completed);
                        save();
					}
				} else {

					var t:Number = Vault.addVal("timer", 1);
					
					total1.text = "Level time: ";
					var ms:String = int(t%60).toString();
					t -= t%60;
					var s:String = int((t%3600)/60).toString();
					t -= t%3600;
					var m:String = int(t/3600).toString();
					t -= t/3600;
					if (ms.length < 2){ ms = "0" + ms; }
					if ( s.length < 2){  s = "0" + s; }
					if ( m.length < 2){  m = "0" + m; }
					
					total1.appendText(m + ":" + s + ":" + ms);
				}
			}
		}
		
		public function reset():void{
			Vault.setValue("timer", 0);
			_play = true;
			coins = 0;
			_scored = false;
            
            for each(var o:Oranger in Oranger.list.toArray()){
                if (o && o.parent)
                    o.parent.removeChild(o);
            }
		}
		
		public function resetScores():void{
		    for (var i:Number = 0; i<12; i++){
                Vault.forceValue("score" + i.toString(), 36000);
            }
		}
		
		public function save():void{
            SaveLoad.setStorage("mz_2010_03_09");
            
            var riji:Rijndael = new Rijndael(192, 192);
            
            for(var i:Number = 0; i < 12; i++){
                SaveLoad.addData("so_crunchy_" + i.toString(), Vault.getSafeAsString("score" + i.toString() ), "ab28bcfe83920ac89bcd89e0dfbcadea");
            }
            
            SaveLoad.addData('kompletariusz', M.completed)
            
            SaveLoad.flushData();
        }
        
        public function load():void{
            SaveLoad.setStorage("mz_2010_03_09");
    
            if (SaveLoad.getData("so_crunchy_1")){
                for(var i:Number = 0; i < 12; i++){
                    Vault.setSafeFromString( "score" + i.toString(), SaveLoad.getData("so_crunchy_" + i.toString(), "ab28bcfe83920ac89bcd89e0dfbcadea") as String);
                }
            }
            
            if (SaveLoad.getData('kompletariusz')){
                M.completed = SaveLoad.getData('kompletariusz') as Number   ;
            }
        }
		
		public static function endLev():void{
			self.reset();
			self.gotoAndStop(4);
		}
	}
}