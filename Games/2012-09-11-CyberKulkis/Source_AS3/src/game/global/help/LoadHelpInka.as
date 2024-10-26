// ActionScript file

package game.global.help{
    import game.objects.THelp;

    public function LoadHelpInka(index:uint):void{
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
            
            case(3):
                THelp.hook([
                    ""
                ],
                    [
                        "Hit \"R\" to restart room if you get stuck."
                    ]);
                break;
            
            case(4):
                THelp.hook([
                    THelp._OVERSWITCH,
                    THelp._SWITCHFIRE,
                    THelp._CANNONROLLOVER,
                    ""
                ],
                    [
                        "If you put your mouse pointer on the switch\nyou will see what it does. Try it.",
                        "Red border means that moving on this switch will make indicated\ncannons fire bullets. Yellow means that the shown\ntiles will be switched.",
                        "When ready, move onto the cannon. Keep your eyes opened for\nthe moment you move over a cannon.",
                        "Did you hear that sound? It is an auto-destruction alarm!\nA moment after you hear that the cannon will explode.\nStay away from that explosion as it is lethal."
                    ]);
                break;
        }
    }
}