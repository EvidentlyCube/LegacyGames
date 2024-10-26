package game.objects.effects{
    import flash.utils.getTimer;
	import game.widgets.TWidgetFace;
    
    import game.global.Game;
    import game.states.TStateGame;

    public class TEffectWalkStairs extends TEffect{
        private var lastFrameMoved:Number;
        private var moveUp:Boolean;
        private var stairsType:uint;
        
        public function TEffectWalkStairs(){
            super();
            
            TStateGame.effectsUnder.add(this);
            
            lastFrameMoved = getTimer();
            
            stairsType = room.tilesOpaque[Game.player.x + Game.player.y * S.LEVEL_WIDTH];
            
            moveUp = (stairsType == C.T_STAIRS_UP);
			
			TWidgetFace.setMood(TWidgetFace.MOOD_HAPPY);
        }
        
        override public function update():void{
            if (lastFrameMoved + 360 < getTimer()){
                move();
                lastFrameMoved = getTimer();
            }
        }
        
        private function move():void{
            var x:uint = Game.player.x;
            var y:uint = Game.player.y + (moveUp ? -1 : 1);
            
            if (!F.isValidColRow(x, y) || room.tilesOpaque[x + y * S.LEVEL_WIDTH] != stairsType){
                Game.player.setPosition(uint.MAX_VALUE, uint.MAX_VALUE);
            } else {
                Game.player.setPosition(x, y);
            }
        }
    }
}