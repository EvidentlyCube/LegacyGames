package game.data{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    
    import game.global.Game;
    import game.global.Level;
    import game.global.Minimap;
    import game.global.Pre;
    import game.global.Score;
    import game.global.Sfx;
    import game.objects.TConnector;
    
    import net.retrocade.camel.global.rEvents;
    import net.retrocade.camel.global.rGfx;
    
    public class TPath extends TConnector{
        public function TPath(x:uint, y:uint, tileColor:uint){
            super(null, x, y);
            
            _color = tileColor;
            
            Level.groupPaths.add(this);
            Level.level.setTile(tileX, tileY, this);
            
            TConnectorManager.parseForPath(this);
            
            Score.pathsPlaced.add(1);
            Sfx.sfxPlacePath.play();
            
            resetGfx();
            resetNeighbors();
            
            Game.lStarling.addChild(this);
            
            rEvents.add(C.eventPathNumberChanged);
            
            update();
            reposition();
        }
        
        override public function set scaleX(value:Number):void{
            super.scaleX = (S().useSmallTileset ? value * 50 / 24 : value / 2);
        }
        
        override public function set scaleY(value:Number):void{
            super.scaleY = (S().useSmallTileset ? value * 50 / 24 : value / 2);
        }
        
        public function resetNeighbors():void{
            var n:* = Level.level.getTile(tileX, tileY - 1);
            if (n is TConnector && TConnector(n).colorMatches(tileColor)) n.update();
            
            n = Level.level.getTile(tileX, tileY + 1);
            if (n is TConnector && TConnector(n).colorMatches(tileColor)) n.update();
            
            n = Level.level.getTile(tileX - 1, tileY);
            if (n is TConnector && TConnector(n).colorMatches(tileColor)) n.update();
            
            n = Level.level.getTile(tileX + 1, tileY);
            if (n is TConnector && TConnector(n).colorMatches(tileColor)) n.update();
        }
        
        override public function resetGfx():void{
            var tileString:String = getTileString();
            
            this.texture = Gfx.getPathBig(tileColor, tileString, Pre.colorBlind, S().useSmallTileset);
            //scaleX = scaleY = 0.5;
            
            Minimap.instance.drawPath(x, y, tileColor, tileString);
            
            readjustSize();
        }
        
        public function getTileString():String{
            var item:*;
            
            var tileString:String = '';
            
            item = Level.level.getTile(tileX + 1, tileY); tileString += (item is TConnector && item.colorMatches(tileColor) ? '1' : '0');
            item = Level.level.getTile(tileX, tileY + 1); tileString += (item is TConnector && item.colorMatches(tileColor) ? '1' : '0');
            item = Level.level.getTile(tileX - 1, tileY); tileString += (item is TConnector && item.colorMatches(tileColor) ? '1' : '0');
            item = Level.level.getTile(tileX, tileY - 1); tileString += (item is TConnector && item.colorMatches(tileColor) ? '1' : '0');
            
            return tileString;
        }
        
        override public function update():void{
            resetGfx();
        }
        
        override public function redrawTransparent():void{
        }
        
        public function removePath():void{
            Level.level.setTile(tileX, tileY, null);
            Level.groupPaths.nullify(this);
            
            Game.lStarling.removeChild(this);
            
            TConnectorManager.parseForPath(this);
            Score.pathsPlaced.add(-1);
            
            resetNeighbors();
            
            rEvents.add(C.eventPathNumberChanged);
            
            Minimap.instance.clearPath(tileX, tileY);
            
            dispose();
        }
        
    }
}