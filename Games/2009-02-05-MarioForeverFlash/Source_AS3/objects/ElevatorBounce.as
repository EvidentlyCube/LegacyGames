package objects 
{
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class ElevatorBounce extends Elevator{
		private var dir:int;
		public function ElevatorBounce(x:uint,y:uint,wid:uint,graph:String,dire:int=1){
			super(x,y,wid,graph)
			dir=dire
		}
		override protected function Act():void{
			if (Mario.levelColl(oX+dir,oY) || Mario.levelColl(oX+wid-1+dir,oY)){
				dir*=-1
			}
			if (holds){
				Player.pX+=dir
			}
			oX+=dir
			GFX.x=oX
		}
		override public function free():void{
			super.free();
		}
	}
	
}