package net.retrocade.tacticengine.monstro.events
{
    import net.retrocade.tacticengine.monstro.entities.MonstroEntity;

	public class MonstroEventUnitHit extends MonstroEvent{
		public static const NAME:String = "unit_hit";

        public var attacker:MonstroEntity;
		public var attacked:MonstroEntity;
        public var onFinished:Function;
		
		public function MonstroEventUnitHit(attacker:MonstroEntity, attacked:MonstroEntity, onFinished:Function = null){
            this.attacker = attacker;
			this.attacked = attacked;
            this.onFinished = onFinished;

            dispatch(NAME);
		}
		
		override public function destruct():void{
			attacked = null;
            attacker = null;
            onFinished = null;
		}
	}
}