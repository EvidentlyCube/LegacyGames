// ActionScript file

package game.global.help{
    import game.objects.THelp;

    public function LoadHelpBlob(index:uint):void{
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
                        "Bravo! Now collect any of the bonuses - the blue-gray pyramides.",
                        "Your objective is to collect all the bonuses\nfrom each level.",
                        "Great! Now reach the exit to complete this level."
                    ]);
                break;
            
            case(3):
                THelp.hook([
                    ""
                ],
                    [
                        "The orange X'es at the floor will stop you\nif you move over them."
                    ]);
                break;
            
            case(5):
                THelp.hook([
                    THelp._OVERTELEPORT,
                    ""
                ],
                    [
                        "These green, bright tiles at the top are teleports.\nPut mouse pointer on them to see where they lead.",
                        "Feel free to use this technique whenever you see fit.\nNow commence with the level at hand."
                    ]);
                break;  
            
            case(6):
                THelp.hook([
                    THelp._BOUNCED
                ],
                    [
                        "By the way, the diagonal blueish things in this\nlevel are Trampolines. When you move into one, it will change\nyour direction accordingly. Try it!"
                    ]);
                break;
            
            case(7):
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
            
            case(8):
                THelp.hook([
                    THelp._OVERSWITCH,
                    ""
                ],
                    [
                        "These switches are different from the last ones.\nPut your mouse pointer over it to see\nwhat will happen when you use it.",
                        "Yes, two of them remove a wall and the third one gets rid of a trampoline."
                    ]);
                break;
        }
    }
}