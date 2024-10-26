/*Platformer Engine by Mauft.com
__TPipe__

The pipe object, consult the .fla's third frame code for details on how to use it.
This is too complicated for me to explain well. Basically pipe object constantly listens for player trying to enter a pipe, and when it happens
it calls the proper function.
*/

package com.mauft.PlatformerEngine.objects.objects{
	import com.mauft.PlatformerEngine.Controls;
	import com.mauft.PlatformerEngine.DebugDraw;
	import com.mauft.PlatformerEngine.Engine;
	import com.mauft.PlatformerEngine.Geometry;
	import com.mauft.PlatformerEngine.Settings;
	import com.mauft.PlatformerEngine.objects.TObject;
	
	import flash.display.InteractiveObject;

	public class TPipe extends TObject{
		public var inX:Number
		public var inY:Number
		public var inDir:Number
		public var outX:Number
		public var outY:Number
		public var outDir:Number
		public function TPipe(_in:InteractiveObject, _out:InteractiveObject, _inDir:uint, _outDir:uint){
			trace(_in)
			trace(_out)
			x=_in.x+Settings.TILE_WIDTH
			y=_in.y+Settings.TILE_HEIGHT
			inX=_in.x
			inY=_in.y
			inDir=_inDir
			outX=_out.x
			outY=_out.y
			outDir=_outDir
			
			switch(inDir){
				case(0): //Enters to Right
					x-=Settings.TILE_WIDTH+5
					y-=3
					width=Settings.TILE_WIDTH
					height=6
					break
				case(1): //Enters to Down
					x-=3
					y-=Settings.TILE_HEIGHT+5
					width=6
					height=Settings.TILE_HEIGHT
					break
				case(2): //Enters to Left
					y-=3
					width=Settings.TILE_WIDTH+5
					height=6
					break
				case(3): //Enters to Up
					x-=3
					width=6
					height=Settings.TILE_HEIGHT+5
					break
			}
			
			Engine.listObjects.push(this)
		}
		override public function Step():void{
			DebugDraw.Rect(x,y,width,height)
			if (Engine.player.sequence!=0){return}
			
			switch (inDir){
				case(0):		//Enters to Right
					if (Controls.holdRight && Geometry.RectRect1(this,Engine.player)){
						enterPipe()
					}
					break;
				case(1):		//Enters to Down
					if (Controls.holdDown && Geometry.RectRect1(this,Engine.player)){
						enterPipe()
					}
					break;
				case(2):		//Enters to Left
					if (Controls.holdLeft && Geometry.RectRect1(this,Engine.player)){
						enterPipe()
					}
					break;
				case(3):		//Enters to Up
					if (Controls.holdUp && Geometry.RectRect1(this,Engine.player)){
						enterPipe()
					}
					break;
			}
		}
		private function enterPipe():void{
			switch (inDir){
				case(0):
					Engine.player.x=inX-Engine.player.width
					Engine.player.y=inY+Settings.TILE_HEIGHT*2-Engine.player.height
					Engine.player.enteredPipe(inDir, this)
					break;
				case(1):
					Engine.player.x=inX+Settings.TILE_WIDTH-Engine.player.width/2
					Engine.player.y=inY-Engine.player.height
					Engine.player.enteredPipe(inDir, this)
					break;
				case(2):
					Engine.player.x=inX+Settings.TILE_WIDTH*2
					Engine.player.y=inY+Settings.TILE_HEIGHT*2-Engine.player.height
					Engine.player.enteredPipe(inDir, this)
					break;
				case(3):
					Engine.player.x=inX+Settings.TILE_WIDTH-Engine.player.width/2
					Engine.player.y=inY+Settings.TILE_HEIGHT*2
					Engine.player.enteredPipe(inDir, this)
					break;
			}
		}
		public function leavePipe():void{
			switch (outDir){
				case(0):
					Engine.player.x=outX+Settings.TILE_WIDTH*2-Engine.player.width-Settings.PIPE_FIX_RIGHT
					Engine.player.y=outY+Settings.TILE_HEIGHT*2-Engine.player.height
					Engine.player.enteredPipe(outDir+10, this)
					break;
				case(1):
					Engine.player.x=outX+Settings.TILE_WIDTH-Engine.player.width/2
					Engine.player.y=outY+Settings.TILE_HEIGHT*2-Engine.player.height-Settings.PIPE_FIX_DOWN
					Engine.player.enteredPipe(outDir+10, this)
					break;
				case(2):
					Engine.player.x=outX+Settings.PIPE_FIX_LEFT
					Engine.player.y=outY+Settings.TILE_HEIGHT*2-Engine.player.height
					Engine.player.enteredPipe(outDir+10, this)
					break;
				case(3):
					Engine.player.x=outX+Settings.TILE_WIDTH-Engine.player.width/2
					Engine.player.y=outY+Settings.PIPE_FIX_UP
					Engine.player.enteredPipe(outDir+10, this)
					break;
			}
		}
		
	}
}