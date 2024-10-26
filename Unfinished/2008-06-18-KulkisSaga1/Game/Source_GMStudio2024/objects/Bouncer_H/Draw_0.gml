
if (sek=1){
draw_sprite(S_Bouncer_Arms,0,x,y);
draw_sprite(S_Bouncer_Arms,2,x,y);
} else {
if (move>0){draw_sprite(S_Bouncer_Arms,0,add,y);} else {draw_sprite(S_Bouncer_Arms,0,x,y);}
if (move<0){draw_sprite(S_Bouncer_Arms,2,add,y);} else {draw_sprite(S_Bouncer_Arms,2,x,y);}
}

draw_me();
