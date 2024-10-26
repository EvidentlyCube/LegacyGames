if global.turn=1{
var ix,iy;
ix=sign(Player.x-x)
iy=sign(Player.y-y)
if iy!=0 {if !place_meeting(x,y+iy*20,Solid) or Crating(0,iy){if Arrowing(0,iy){oldx=x;oldy=y;y+=iy*20;draw=20;exit}}}
if ix!=0 {if !place_meeting(x+ix*20,y,Solid) or Crating(ix,0){if Arrowing(ix,0){oldx=x;oldy=y;x+=ix*20;draw=20;exit}}}
}
