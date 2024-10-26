package game.objects {
    import flash.display.BitmapData;
    
    import game.global.Game;
    import game.global.Make;
    import game.global.Score;
    
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.core.rGfx;
    import net.retrocade.camel.layers.rLayerBlit;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.standalone.Bitext;
    import net.retrocade.standalone.Text;
    import net.retrocade.utils.UString;

	/**
     * ...
     * @author 
     */
    public class THud extends rObject{      
        private static var _instance:THud = new THud;
        
        private static var _layer:rLayerBlit
        
        public static function get instance():THud {
            return _instance;
        }
        
        
        public function THud() {
            
        }
        
        override public function update():void {
            
        }
        
        public function hookTo(layer:rLayerBlit):void {
            rCore.groupAfter.add(this);
            _layer = layer;
        }
        
        public function unhook():void {
            rCore.groupAfter.nullify(this);
        }
    }
}