
if (sek=1){
draw_sprite(S_Bouncer_Arms,1,x,y);
draw_sprite(S_Bouncer_Arms,3,x,y);
} else {
if (move>0){draw_sprite(S_Bouncer_Arms,1,x,add);} else {draw_sprite(S_Bouncer_Arms,1,x,y);}
if (move<0){draw_sprite(S_Bouncer_Arms,3,x,add);} else {draw_sprite(S_Bouncer_Arms,3,x,y);}
}

draw_me();
