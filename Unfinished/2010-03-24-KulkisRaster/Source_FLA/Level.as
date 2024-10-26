package{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    
    import objects.Updaters;
    
    import tiles.Tile;
    
    public class Level{
        private static var current:Level
        
        private var display:Sprite = new Sprite;
        
        private var level:Array   = new Array(625);
        private var obs:Array = new Array(); 
        
        public function Level(){
            if (current){
                current.end();
            }
            
            Kulkis.setLevelGFX(display);
            
            current = this;
        }
        
        public static function update():void{
            if (current){
                current.$update();
            }
        }
        private function $update():void{
            for (var i:Number = obs.length - 1; i >= 0; i--){
                Updaters(obs[i]).update();
            }
        }
        
        public static function setTile(x:Number, y:Number, tile:Tile):void{
            current.level[x + y*25] = tile;
        }
        public static function getTile(x:Number, y:Number):Tile{
            x = Math.floor(x / 24);
            y = Math.floor(y / 24);
            if (x < 0 || y < 0 || x >24 || y>24){ return null; }
            return Tile(current.level[x + y*25]);
        }
        
        public static function addGFX(gfx:DisplayObject):void{
            current.display.addChild(gfx);
        }
        
        public static function remGFX(gfx:DisplayObject):void{
            current.display.removeChild(gfx);
        }
        
        public static function addObj(o:Updaters):void{
            current.obs.push(o);
        }
        public static function remObj(o:Updaters):void{
            current.obs.splice(current.obs.indexOf(o), 1);
        }
        
        private function end():void{
            
        }
    }
}