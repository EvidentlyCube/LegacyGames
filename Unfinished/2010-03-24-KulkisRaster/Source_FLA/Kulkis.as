package {
    import com.mauft.Control;
    import com.mauft.EventUtils;
    
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;

    public class Kulkis extends MovieClip{
        public static var self:Kulkis;
        
        public function Kulkis(){
            self = this;
            
            Control.init(stage);
            
            EventUtils.basic(this, step);
        }
        
        public static function step(e:Event):void{
        	Level.update();
        }
        
        public static function setLevelGFX(container:Sprite):void{
            self.addChild(container);
        }
        
        public static function unsetLevelGFX(container:Sprite):void{
            self.removeChild(container);
        }
    }
}
