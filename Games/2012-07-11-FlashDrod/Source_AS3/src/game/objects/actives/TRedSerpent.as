package game.objects.actives{
    import game.global.CueEvents;
    public class TRedSerpent extends TSerpent{
        override public function getType():uint{ return C.M_SERPENT; }

        override public function process(lastCommand:uint):void{
            if (!getSerpentMovement()){
                prevX = x;
                prevY = y;
                return;
            }

            lengthenHead(F.getOX(o), F.getOY(o));

            setGfx();

            if (shortenTail()) {
                CueEvents.add(C.CID_SNAKE_DIED_FROM_TRUNCATION, this);
                return;
            }
        }
    }
}