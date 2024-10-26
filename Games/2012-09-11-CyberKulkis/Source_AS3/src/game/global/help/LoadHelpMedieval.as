// ActionScript file

package game.global.help{
    import game.objects.THelp;

    public function LoadHelpMedieval(index:uint):void{
        switch(index){
            case(1):
                THelp.hook([
                    THelp._MOVE,
                    THelp._BONUS,
                    THelp._EXITOPEN,
                    THelp._OVERSWITCH,
                    THelp._EXITENTER
                ],
                    [
                        "Move Around with Arrows",
                        "Bravo! Now collect any of the bonuses:\nFruits, discs, chips, whatever it is.",
                        "Your objective is to collect all the\nbonuses from each level.\nMove your mouse over the switch to see what it does.",
                        "The red border means that this switch will fire the\nhighlighted cannon. Hit \"R\" if you die to restart level.",
                        "Great! Now reach the exit to complete this level."
                    ]);
                break;
            
            case(3):
                THelp.hook([
                    THelp._OVERTELEPORT,
                    ""
                ],
                    [
                        "This green, bright tile is a teleport.\nPut mouse pointer on them to see where they lead.",
                        "Feel free to use this technique whenever you see fit.\nNow commence with the level at hand."
                    ]);
                break;
        }
    }
}