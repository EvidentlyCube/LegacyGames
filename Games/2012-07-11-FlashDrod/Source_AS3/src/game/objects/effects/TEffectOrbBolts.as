package game.objects.effects{
    import game.global.Room;
    import game.managers.VOCoord;
    import game.managers.VOOrb;
    import game.managers.VOOrbAgent;
    import game.states.TStateGame;

    public class TEffectOrbBolts extends TEffect{
        private static const DURATION:uint = 7;
        
        private var endPositions:Array;
        
        private var orbCenterX:uint;
        private var orbCenterY:uint;
        
        private var duration:uint = 0;
        
        public function TEffectOrbBolts(_orbData:VOOrb){
            orbCenterX = _orbData.x * S.LEVEL_TILE_WIDTH  + S.LEVEL_TILE_WIDTH_HALF;
            orbCenterY = _orbData.y * S.LEVEL_TILE_HEIGHT + S.LEVEL_TILE_HEIGHT_HALF;
            
            endPositions = new Array();
            
            for each(var i:VOOrbAgent in _orbData.agents){
                endPositions.push(new VOCoord(i.tX * S.LEVEL_TILE_WIDTH + S.LEVEL_TILE_WIDTH_HALF, 
                                              i.tY * S.LEVEL_TILE_HEIGHT + S.LEVEL_TILE_HEIGHT_HALF, 
                                              0));
            }
            
            TStateGame.effectsAbove.add(this);
        }
        
        override public function update():void{
            if (duration++ == DURATION){
                TStateGame.effectsAbove.nullify(this);
                return;
            }
            
            for each(var coord:VOCoord in endPositions){
                BoltEffect.drawBolt(orbCenterX, orbCenterY, coord.x, coord.y, room.layerActive.bitmapData);
            }
        }
    }
}