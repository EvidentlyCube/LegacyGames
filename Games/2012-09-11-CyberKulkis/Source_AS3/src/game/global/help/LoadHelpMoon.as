// ActionScript file

package game.global.help{
    import game.objects.THelp;

    public function LoadHelpMoon(index:uint):void{
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
                    THelp._OVERSWITCH,
                    THelp._SWITCHFIRE,
                    THelp._CANNONROLLOVER,
                    ""
                ],
                    [
                        "Hit \"R\" if you get stuck or die.\nIf you put your mouse pointer over the switch\nyou will see what it does. Try it.",
                        "Red border means that moving on this switch will make indicated\ncannons fire bullets. Bullets destroy mines and bounce\nfrom trampolines. It is necessary to use the switches\nin this level so please proceed."
                    ]);
                break;
            
            case(4):
                THelp.hook([
                    THelp._OVERSWITCH,
                    ""
                ],
                    [
                        "The switch here is a different from those before.\nPut your mouse pointer over it to see\nwhat will happen when you use it.",
                        "As you can see the switch will place a bonus where the bouncer currently is.\nKeep in mind that you DO have to get this bonus to complete the level."
                    ]);
                break;
        }
    }
}