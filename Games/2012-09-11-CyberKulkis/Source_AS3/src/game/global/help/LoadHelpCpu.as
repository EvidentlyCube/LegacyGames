// ActionScript file

package game.global.help{
    import game.objects.THelp;

    public function LoadHelpCpu(index:uint):void{
        switch(index){
            case(1):
                THelp.hook([
                    THelp._MOVE,
                    ""
                ],
                    [
                        "Move Around with Arrows",
                        "Bravo! Now try to do your best and reach the\nexit without getting stuck or killed by mines.\NHit R to restart if you get stuck."
                    ]);
                break;
            
            case(2):
                THelp.hook([
                    THelp._BONUS,
                    THelp._OVERSWITCH,
                    ""
                ],
                    [
                        "Collect all of the bonuses to unlock the exit.\nThe bonuses are, among others:\nCDs, Floppy Disks, Chips, Transistors and others.\nNow try to get one.",
                        "Move your mouse over the switch to see what it does.",
                        "As you can see it places a stopper around the top-right corner.\nSwitches will often appear in the game and it is crucial\nto always investigate what they do before proceeding."
                    ]);
                break;
            
            case(3):
                THelp.hook([
                    THelp._SWITCHFIRE,
                    ""
                ],
                    [
                        "Can you see the cannon? It will fire when you hit the switch.\nTry to not get killed while firing it.\nHit \"R\" if you get stuck.",
                        "If you move over a cannon, its auto-destruction\nmechanism will be activated and it will explode after a second.\nStay away from this explosion as it is lethal."
                    ]);
                break;  
        }
    }
}