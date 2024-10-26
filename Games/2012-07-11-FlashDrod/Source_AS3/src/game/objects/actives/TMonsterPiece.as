package game.objects.actives{
    import game.global.Gfx;
    import game.global.Room;

    import net.retrocade.camel.core.rGfx;

    public class TMonsterPiece extends TMonster{
        override public function isPiece():Boolean{ return true; }
        override public function isAggresive():Boolean{ return false; }

        public var monster:TMonster;
        public var tileNo :uint;

        public function TMonsterPiece(x:uint, y:uint, o:uint, parent:TMonster, tileNo:uint){
            this.x = prevX = x;
            this.y = prevY = y;
            this.o = prevO = o;

            monster = parent;
            this.tileNo = tileNo;

            ASSERT(monster);

            setGfx();
        }

        override public function initialize(pieces:XML=null):void{
            room.tilesActive[x + y * S.LEVEL_WIDTH] = this;
        }

        public function quickRemove():void{
            room.tilesActive[x + y * S.LEVEL_WIDTH] = null;
        }

        override public function setGfx():void{
            switch(tileNo){
                case(C.T_SNK_EW): gfx = T.TI_SNK_EW; break;
                case(C.T_SNK_NS): gfx = T.TI_SNK_NS; break;
                case(C.T_SNK_SW): gfx = T.TI_SNK_NE; break;
                case(C.T_SNK_SE): gfx = T.TI_SNK_NW; break;
                case(C.T_SNK_NW): gfx = T.TI_SNK_SE; break;
                case(C.T_SNK_NE): gfx = T.TI_SNK_SW; break;
                case(C.T_SNKT_W): gfx = T.TI_SNKT_W; break;
                case(C.T_SNKT_N): gfx = T.TI_SNKT_N; break;
                case(C.T_SNKT_E): gfx = T.TI_SNKT_E; break;
                case(C.T_SNKT_S): gfx = T.TI_SNKT_S; break;
            }
        }

        override public function onStabbed(sX:uint, sY:uint):Boolean{
            return monster.onStabbed(x, y);
        }

        override public function getSnapshot():Object {
            var object:Object = super.getSnapshot();

            object.tileNo = tileNo;

            return object;
        }
    }
}