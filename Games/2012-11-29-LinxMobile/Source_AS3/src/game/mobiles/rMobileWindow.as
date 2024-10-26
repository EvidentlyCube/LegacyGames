package game.mobiles
{
    import flash.events.Event;

    import net.retrocade.camel.global.rDisplay;
    import net.retrocade.camel.objects.rWindow;

    public class rMobileWindow extends rWindow
    {
        override public function show():void{
            super.show();

            rDisplay.stage.addEventListener(Event.RESIZE, resized);

            resized(null);
        }

        override public function close():void{
            rDisplay.stage.removeEventListener(Event.RESIZE, resized);

            super.close();
        }

        protected function resized(e:Event):void{}
    }
}