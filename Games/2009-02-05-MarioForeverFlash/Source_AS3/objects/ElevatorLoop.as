package objects 
{
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class ElevatorLoop extends Elevator{
		private var grav:int=0;
		public function ElevatorLoop(x:uint,y:uint,wid:uint,graph:String,drspd:int){
			super(x,y,wid,graph)
			grav=drspd
		}
		override protected function Act():void{
			if (holds){
				Player.pY+=Math.round(grav)
			}
			oY+=Math.round(grav)
			GFX.y=oY
			if (oY>385){
				oY-=400
				free()
			} else if(oY<-25){
				oY+=400
				free()
			}
		}
		override public function free():void{
			if (holds){
				super.free();
				Player.gravity=grav;
			}
		}
	}
	
}