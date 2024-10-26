package {
    import flash.display.MovieClip;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.*;
    import flash.utils.getTimer;
    
    import src.*;
    import src.Objects.*;
    import src.PlatformerEngine.*;
    import src.effects.*;
    import src.misc.*;
    import src.tiles.*;
    import src.Objects.TPlayer;

    public class M extends MovieClip{
        public function M(){
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align     = StageAlign    .TOP_LEFT;
            
            Engine.init(stage, this);
            
            getTimer();
        }
        
        private function NEVAH():void{
            var aa:SignCheckpoint;
            var ab:SignHelp;
            var ac:SignRight;
            var ad:SignLeft;
            var ae:TPlatform;
            var af:TPlayer;
            var ag:TWall;
            var ah:TSliderTopLeft;
            var ai:TSliderTopRight;
            var aj:Crate;
            var ak:TEffectPlayerDeath;
        }
    }   
}