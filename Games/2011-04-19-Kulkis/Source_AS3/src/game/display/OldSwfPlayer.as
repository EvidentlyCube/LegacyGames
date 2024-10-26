package game.display {
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;

public class OldSwfPlayer extends Sprite{
    private var _movieClip:DisplayObjectContainer;
    private var _movieClipFinishedCallback:Function;

    private var _elapsedFrames:int = 0;
    private var _duration:int = 0;

    public function get innerWidth():Number{ return _movieClip.width;}
    public function get innerHeight():Number{ return _movieClip.height;}

    public function OldSwfPlayer(movieClip:DisplayObjectContainer, duration:int, movieClipFinishedCallback:Function) {
        _movieClipFinishedCallback = movieClipFinishedCallback;
        _movieClip = movieClip;
        _movieClip.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        _duration = duration;

        addChild(_movieClip);
    }

    private function onEnterFrame(event:Event):void{
        _elapsedFrames++;

        if (_elapsedFrames >= _duration){
            finish();
        }
    }

    private function finish():void{
        _movieClip.removeEventListener(Event.ENTER_FRAME, onEnterFrame);

        var loader:Loader = _movieClip.getChildAt(0) as Loader;
        loader.unloadAndStop();

        removeChild(_movieClip);

        if (_movieClipFinishedCallback.length == 1){
            _movieClipFinishedCallback(this);
        } else {
            _movieClipFinishedCallback();
        }
    }
}
}
