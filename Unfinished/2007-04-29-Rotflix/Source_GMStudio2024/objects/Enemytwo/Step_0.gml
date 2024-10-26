if global.turn=1{
state+=1
if state=1{movx=sign(Player.x-x);movy=sign(Player.y-y);dir=point_direction(x,y,x+movx,y+movy)/45}
if state=3{state=0
if Arrowing(movx,movy) && !place_meeting(x+movx*20,y+movy*20,Solid){oldx=x;oldy=y;x+=movx*20;y+=movy*20;draw=20} else {
if Arrowing(0,movy) && !place_meeting(x,y+movy*20,Solid){oldx=x;oldy=y;y+=movy*20;draw=20} else {
if Arrowing(movx,0) && !place_meeting(x+movx*20,y,Solid){oldx=x;oldy=y;x+=movx*20;draw=20}}}
}}
