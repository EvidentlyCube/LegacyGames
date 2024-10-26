if global.turn=1{
var movx,movy;
movx=sign(Player.x-x);movy=sign(Player.y-y)
if !place_meeting(x+movx*20,y+movy*20,Solid){oldim=image_index;image_index=choose(0,1,2);oldx=x;oldy=y;x+=movx*20;y+=movy*20;draw=20}
}
