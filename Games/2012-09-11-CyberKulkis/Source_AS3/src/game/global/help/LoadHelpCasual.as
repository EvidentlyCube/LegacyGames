// ActionScript file

package game.global.help{
    import game.objects.THelp;

    public function LoadHelpCasual(index:uint):void{
        switch(index){
            case(1):
                THelp.hook([
                    THelp._MOVE,
                    THelp._BONUS,
                    THelp._EXITOPEN,
                    THelp._EXITENTER
                ],
                    [
                        "Move Around with Arrows",
                        "Bravo! Now collect any of the bonuses:\nFruits, discs, chips, whatever it is.",
                        "Your objective is to collect all the\nbonuses from each level.",
                        "Great! Now reach the exit to complete this level."
                    ]);
                break;
            
            case(2):
                THelp.hook([
                    THelp._BOUNCED,
                    ""
                ],
                    [
                        "By the way, the diagonal blueish thing in the bottom-right corner\nof the levels is Trampoline. When you move into it it will change\nyour direction accordingly. Try it!",
                        "Did you notice the Steps counter at the bottom hud? The less moves you require to complete a room the better your score will be!"
                    ]);
                break;
            
            case(3):
                THelp.hook([
                    ""
                ],
                    [
                        "If you get stuck in an endless loop of trampolines\nfeel free to hit R to restart the level."
                    ]);
                break;  
            
            case(4):
                THelp.hook([
                    THelp._OVERTELEPORT,
                    ""
                ],
                    [
                        "These green, bright tiles at the top are teleports.\nPut mouse pointer on them to see where they lead.",
                        "Feel free to use this technique whenever you see fit.\nNow commence with the level at hand."
                    ]);
                break;
            
            case(5):
                THelp.hook([
                    THelp._OVERSWITCH,
                    THelp._SWITCHFIRE,
                    THelp._CANNONROLLOVER,
                    ""
                ],
                    [
                        "If you put your mouse pointer on the switch\nyou will see what it does. Try it.",
                        "Red border means that moving on this switch will make indicated\ncannons fire bullets. Bullets destroy mines and bounce\nfrom trampolines. It is necessary to use the switches\nin this level so please proceed.",
                        "When ready, move into the open space. Keep your eyes opened for\nthe moment you move over a cannon.",
                        "Did you hear that sound? It is an auto-destruction alarm!\nA moment after you hear that the cannon will explode.\nStay away from that explosion as it is lethal."
                    ]);
                break;
            
            case(6):
                THelp.hook([
                    THelp._OVERSWITCH,
                    ""
                ],
                    [
                        "The third switch in the trio is different from the other two.\nPut your mouse pointer over it to see\nwhat will happen when you use it.",
                        "Yes, it will place a stopper in the top-left corner of the level.\nKeep in mind that if you leave level on the left\nyou will be wrapped and come back from the right.\nYou need to use this to complete many levels in the game."
                    ]);
                break;
        }
    }
}