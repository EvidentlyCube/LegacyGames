package objects 
{
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class ElevatorFall extends Elevator{
		private var timer:uint=0;
		private var grav:Number=0;
		public function ElevatorFall(x:uint,y:uint,wid:uint,graph:String){
			super(x,y,wid,graph)
		}
		override protected function Act():void{
			if (holds || timer>0){
				timer++;
			}
			if (timer>30){
				grav+=0.2;
			}
			if (holds){
				Player.pY+=Math.round(grav)
			}
			oY+=Math.round(grav)
			GFX.y=oY
		}
		override public function free():void{
			super.free();
			Player.gravity=grav;
		}
	}
	
}