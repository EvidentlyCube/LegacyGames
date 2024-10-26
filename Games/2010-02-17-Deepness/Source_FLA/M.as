package {
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.objects.TPlayerBullet;
	import com.mauft.PlatformerEngine.objects.TPlayer;
	import com.mauft.PlatformerEngine.objects.SFX;
	import com.mauft.PlatformerEngine.objects.effects.TMessage;

	import flash.display.*;
	import flash.events.*;
	import flash.net.LocalConnection;
	public dynamic class M extends MovieClip{
		public function M(){
			ModernDisplay.Init(this, stage, 600, 600);

            CheatCodes.Init()
            CheatCodes.AddCheat('then', function():void {
		 		Engine.ending=true
				if (SFX.sfx){SFX.COIN.play()}
            });
            CheatCodes.AddCheat('killer', function():void {
				if (TPlayerBullet.damage === 1) {
					TPlayerBullet.damage = 999;
					new TMessage(Engine.player.midX,Engine.player.y, "Killer Mode: On", 0xFF8888)
				} else {
					TPlayerBullet.damage = 1;
					new TMessage(Engine.player.midX,Engine.player.y, "Killer Mode: Off", 0x88FF88)
				}
				if (SFX.sfx){SFX.COIN.play()}
            });
            CheatCodes.AddCheat('guard', function():void {
				if (!TPlayer.invincibleCheat) {
					TPlayer.invincibleCheat = true;
					new TMessage(Engine.player.midX,Engine.player.y, "Invincibility: On", 0xFF8888)
				} else {
					TPlayer.invincibleCheat = false;
					new TMessage(Engine.player.midX,Engine.player.y, "Invincibility: Off", 0x88FF88)
				}
				if (SFX.sfx){SFX.COIN.play()}
            });
            CheatCodes.AddCheat('turbo', function():void {
				if (TPlayer.fireRate === 12) {
					TPlayer.fireRate = 4;
					new TMessage(Engine.player.midX,Engine.player.y, "Rapid Fire: On", 0xFF8888)
				} else {
					TPlayer.fireRate = 12;
					new TMessage(Engine.player.midX,Engine.player.y, "Rapid Fire: Off", 0x88FF88)
				}
				if (SFX.sfx){SFX.COIN.play()}
            });
            CheatCodes.AddCheat('triple', function():void {
				if (!TPlayer.tripleBeam) {
					TPlayer.tripleBeam = true;
					new TMessage(Engine.player.midX,Engine.player.y, "Triple Shot: On", 0xFF8888)
				} else {
					TPlayer.tripleBeam = false;
					new TMessage(Engine.player.midX,Engine.player.y, "Triple Shot: Off", 0x88FF88)
				}
				if (SFX.sfx){SFX.COIN.play()}
            });
            CheatCodes.AddCheat('bighead', function():void {
				if (!TPlayerBullet.bigBullets) {
					TPlayerBullet.bigBullets = true;
					new TMessage(Engine.player.midX,Engine.player.y, "Big Bullets: On", 0xFF8888)
				} else {
					TPlayerBullet.bigBullets = false;
					new TMessage(Engine.player.midX,Engine.player.y, "Big Bullets: Off", 0x88FF88)
				}
				if (SFX.sfx){SFX.COIN.play()}
            });
            CheatCodes.AddCheat('range', function():void {
				if (!TPlayerBullet.rangeCheat) {
					TPlayerBullet.rangeCheat = true;
					new TMessage(Engine.player.midX,Engine.player.y, "Super Range: On", 0xFF8888)
				} else {
					TPlayerBullet.rangeCheat = false;
					new TMessage(Engine.player.midX,Engine.player.y, "Super Range: Off", 0x88FF88)
				}
				if (SFX.sfx){SFX.COIN.play()}
            });
            CheatCodes.AddCheat('wave', function():void {
				if (!TPlayerBullet.waveBeam) {
					TPlayerBullet.waveBeam = true;
					new TMessage(Engine.player.midX,Engine.player.y, "Ghost Bullets: On", 0xFF8888)
				} else {
					TPlayerBullet.waveBeam = false;
					new TMessage(Engine.player.midX,Engine.player.y, "Ghost Bullets: Off", 0x88FF88)
				}
				if (SFX.sfx){SFX.COIN.play()}
            });
            stage.addEventListener(KeyboardEvent.KEY_DOWN, CheatCodes.HandleKey);
		}
	}
}
