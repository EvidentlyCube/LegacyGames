package submuncher.initialization {
    import flash.display.MovieClip;

    import net.retrocade.utils.UtilsString;

    public class EightWayTIleGenerator extends MovieClip{
        public function EightWayTIleGenerator() {
            var u:Array = [];
            var ss:String = "";
            for (var i:int = 0; i < 256; i++){
                var NW:Boolean = (i & 0x01) > 0;
                var N:Boolean = (i & 0x02) > 0;
                var NE:Boolean = (i & 0x04) > 0;
                var W:Boolean = (i & 0x08) >0;
                var E:Boolean = (i & 0x10)>0;
                var SW:Boolean = (i & 0x20)>0;
                var S:Boolean = (i & 0x40)>0;
                var SE:Boolean = (i & 0x80)>0;

                var val:uint = 0;
                if (!N && !W && !E && !S){
                    val = 1;
                } else if (!N && !W && E && !S){
                    val = 2
                } else if (!N && !W && !E && S){
                    val = 3
                } else if (!N && W && !E && !S){
                    val = 4
                } else if (N && !W && !E && !S){
                    val = 5
                } else if (!N && W && E && !S){
                    val = 6
                } else if (N && !W && !E && S){
                    val = 7
                } else if (!N && !W && E && S){
                    if (!SE){
                        val = 8
                    } else {
                        val = 9
                    }
                } else if (!N && W && !E && S){
                    if (!SW){
                        val = 10
                    } else {
                        val = 11
                    }
                } else if (N && W && !E && !S){
                    if (!NW){
                        val = 12
                    } else {
                        val = 13
                    }
                } else if (N && !W && E && !S){
                    if (!NE){
                        val = 14
                    } else {
                        val = 15
                    }
                } else if (!N && W && E && S){
                    if (!SE && !SW){
                        val = 16
                    } else if (SE && !SW){
                        val = 17
                    } else if (!SE && SW){
                        val = 18
                    } else {
                        val = 19
                    }
                } else if (N && W && !E && S){
                    if (!NW && !SW){
                        val = 20
                    } else if (!NW && SW){
                        val = 21
                    } else if (NW && !SW){
                        val = 22
                    } else {
                        val = 23
                    }
                } else if (N && W && E && !S){
                    if (!NW && !NE){
                        val = 24
                    } else if (NW && !NE){
                        val = 25
                    } else if (!NW && NE){
                        val = 26
                    } else {
                        val = 27
                    }
                } else if (N && !W && E && S){
                    if (!NE && !SE){
                        val = 28
                    } else if (NE && !SE){
                        val = 29
                    } else if (!NE && SE){
                        val = 30
                    } else {
                        val = 31
                    }
                } else if (N && W && E && S){
                    if (!SE && !SW && !NE && !NW){
                        val = 32
                    } else if (SE && !SW && !NE && !NW){
                        val = 33
                    } else if (!SE && SW && !NE && !NW){
                        val = 34
                    } else if (SE && SW && !NE && !NW){
                        val = 35
                    } else if (!SE && !SW && NE && !NW){
                        val = 36
                    } else if (SE && !SW && NE && !NW){
                        val = 37
                    } else if (!SE && SW && NE && !NW){
                        val = 38
                    } else if (SE && SW && NE && !NW){
                        val = 39
                    } else if (!SE && !SW && !NE && NW){
                        val = 40
                    } else if (SE && !SW && !NE && NW){
                        val = 41
                    } else if (!SE && SW && !NE && NW){
                        val = 42
                    } else if (SE && SW && !NE && NW){
                        val = 43
                    } else if (!SE && !SW && NE && NW){
                        val = 44
                    } else if (SE && !SW && NE && NW){
                        val = 45
                    } else if (!SE && SW && NE && NW){
                        val = 46
                    } else if (SE && SW && NE && NW){
                        val = 47
                    } else {
                        throw new Error("wtf " + i);
                    }
                } else {
                    throw new Error('wtf ' + i);
                }

                if (val < 1 || val > 47){
                    throw new Error('wtf ' + i + ", " + val);
                }
                ss += UtilsString.padRight((val - 1).toString() + ",", 4, " ");
                if (i % 16 === 15){
                    ss += "\n"
                }
                u.push(val - 1)
            }

            trace(ss);
        }
    }
}
