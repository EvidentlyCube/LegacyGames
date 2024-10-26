if global.pause=0{
switch (czo){
    case (0): if x>245{if !place_meeting(x-1,y,Enemy_3){x-=0.2}} else {czo=1} break;
    case (1): y-=sign(y-Player.y)/10 ko+=random(1) if ko>=50{czo=2;ko=0} break;
    case (2): x-=ko ko+=0.1 break;
}

if hp<=0{repeat(10){IN_Flame(x,y,random(360))}Player.xp+=xp;instance_destroy()}

if x<-10{instance_destroy()}

}
