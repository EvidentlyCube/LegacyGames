if global.turn=1{
if place_meeting(x+movx*20,y+movy*20,Solid) or !Arrowing(movx,movy){movx*=-1;movy*=-1;dir+=der;der*=-1} else {
oldx=x;
oldy=y;
x+=movx*20
y+=movy*20
drawb=20
}
}
