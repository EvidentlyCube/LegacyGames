package game.objects{
    import game.global.Game;
    import game.global.Level;
    
    import net.retrocade.camel.core.rCore;
    import net.retrocade.camel.objects.rObject;
    import net.retrocade.standalone.Text;
    
    public class THelp extends rObject{
        public static const _MOVE           :String = "move";
        public static const _BONUS          :String = "bonus";
        public static const _EXITOPEN       :String = "exitopen";
        public static const _EXITENTER      :String = "exitenter";
        public static const _BOUNCED        :String = "bounced";
        public static const _OVERSWITCH     :String = "overswitch";
        public static const _OVERTELEPORT   :String = "overteleport";
        public static const _SWITCHFIRE     :String = "switchfire";
        public static const _SWITCHTILE     :String = "switchtile";
        public static const _CANNONROLLOVER :String = "cannonrollover";
        //public static const _SWITCHFIRE     :String = "switchfire";
        
        private static var instance:THelp = new THelp();
        public static function event(string:String):void{
            if (instance.conditions && instance.conditions.length && string == instance.conditions[0])
                instance.nextEvent();
        }
        
        public static function hook(conditions:Array, texts:Array):void{
            instance.hook(conditions, texts);
        }
        
        private var conditions:Array;
        private var texts     :Array;
        
        private var txt:Text;
        
        public function THelp(){
            txt = new Text("", "font", 16);
            txt.setShadow(2, 45, 0, 1, 2, 2, 1.5);
            txt.textAlignCenter();
            txt.wordWrap = true;
            txt.multiline = true;
        }
        
        private function hook(conditions:Array, texts:Array):void{
            this.conditions = conditions;
            this.texts      = texts;
            
            Game.lMain.add2(txt);
            
            displayCurrent();
        }
        
        private function nextEvent():void{
            conditions.shift();
            
            if (conditions.length == 0){
                rCore.groupAfter.remove(this);
            } else
                displayCurrent();
        }
        
        private function displayCurrent():void{
            txt.text = texts.shift();
            txt.width = S().gameWidth;
            
            txt.textAlignCenter();
            txt.fitSize();
            txt.alignCenter();
            
            txt.y = (Level.levelDrawOffsetY - txt.textHeight) / 2 + Level.levelDrawOffsetY + Level.heightPixels;
            txt.y = Math.min(txt.y, S().gameHeight - 48 - txt.textHeight);
        }
    }
}