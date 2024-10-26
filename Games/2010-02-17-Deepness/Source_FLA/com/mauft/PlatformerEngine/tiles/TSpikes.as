/*Platformer Engine by Mauft.com
__TWall__

This is your very average wall block
*/

package com.mauft.PlatformerEngine.tiles{
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TObject;
	import com.mauft.PlatformerEngine.objects.TPlayer;
	
	import flash.display.MovieClip;
	
	public class TSpikes extends TTile{
		/*All we do here is add the tile to the Level array and relocate the graphic to the Tiles layer
		*/
		private var _left:Boolean
		private var _right:Boolean
		private var _up:Boolean
		private var _down:Boolean
		public function TSpikes(_x:Number,_y:Number,_gfx:MovieClip, _l:Boolean, _u:Boolean, _r:Boolean, _d:Boolean){
			Engine.tileSet(_x,_y,this)
			_gfx.parent.removeChild(_gfx)
			Engine.fillSector(_gfx,Math.floor(_x/Settings.SCREEN_WIDTH)+Math.floor(_y/Settings.SCREEN_HEIGHT)*5)
			_left=_l
			_right=_r
			_down=_d
			_up=_u
		}
		override public function stomped(o:TObject):void{
			super.stomped(o)
			if (_up && o as TPlayer){
				Engine.player.Damaged(5)
			}
		}
		override public function headbutt(o:TObject):void{
			super.headbutt(o)
			if (_down && o as TPlayer){
				Engine.player.Damaged(5)
			}
		}
		override public function pokedLeft(o:TObject):void{
			super.pokedLeft(o)
			if (_left && o as TPlayer){
				Engine.player.Damaged(5)
			}
		}
		override public function pokedRight(o:TObject):void{
			super.pokedRight(o)
			if (_right && o as TPlayer){
				Engine.player.Damaged(5)
			}
		}
	}
}