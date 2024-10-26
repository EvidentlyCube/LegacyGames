package objects 
{
	
	/**
	* ...
	* @author $(DefaultUser)
	*/
	public class JumperThrower extends Enemy{
		private var wait:uint
		private var waiter:uint
		private var pause:uint
		private var pauser:uint
		private var amount:uint
		private var amounter:uint
		private var sizeh:Number
		private var sizev:Number
		public function JumperThrower(x:uint,y:uint,height:Number,width:Number,wai:uint,amo:uint,pau:uint){
			eX=x
			eY=y
			sizeh=width
			sizev=height
			wait=waiter=wai
			amount=amounter=amo
			pause=pauser=pau
		}
		override public function Update(myID:uint):void{
			if (waiter>0){
				waiter--;
			} else {
				if (pauser>0){
					pauser--;
				} else {
					amounter-=1;
					pauser=pause
					Mario.instEnemies.push(new Jumper(eX,eY,(Math.random()-0.5)*2*sizeh,sizev-Math.random()+Math.random()));
					if (amounter==0){
						amounter=amount
						waiter=wait
					}
				}
			}
		}
	}
	
}