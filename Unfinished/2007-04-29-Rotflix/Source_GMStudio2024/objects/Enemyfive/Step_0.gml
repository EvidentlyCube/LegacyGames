if global.turn=1{
var ix,iy,variable;
ix=x/20
iy=y/20
variable=Player.lev[ix,iy]
if variable>0{
if Player.lev[ix,iy+1]=variable-1{if !place_meeting(x,y+20,Solid){oldx=x;oldy=y;y+=20;draw=20;exit}}
if Player.lev[ix,iy-1]=variable-1{if !place_meeting(x,y-20,Solid){oldx=x;oldy=y;y-=20;draw=20;exit}}
if Player.lev[ix+1,iy]=variable-1{if !place_meeting(x+20,y,Solid){oldx=x;oldy=y;x+=20;draw=20;exit}}
if Player.lev[ix-1,iy]=variable-1{if !place_meeting(x-20,y,Solid){oldx=x;oldy=y;x-=20;draw=20;exit}}
if Player.lev[ix+1,iy+1]=variable-1{if !place_meeting(x+20,y+20,Solid){oldx=x;oldy=y;x+=20;y+=20;draw=20;exit}}
if Player.lev[ix-1,iy+1]=variable-1{if !place_meeting(x-20,y+20,Solid){oldx=x;oldy=y;x-=20;y+=20;draw=20;exit}}
if Player.lev[ix-1,iy-1]=variable-1{if !place_meeting(x-20,y-20,Solid){oldx=x;oldy=y;x-=20;y-=20;draw=20;exit}}
if Player.lev[ix+1,iy-1]=variable-1{if !place_meeting(x+20,y-20,Solid){oldx=x;oldy=y;x+=20;y-=20;draw=20;exit}}
} else{
var movx,movy;
movx=sign(Player.x-x);movy=sign(Player.y-y)
if !place_meeting(x+movx*20,y+movy*20,Solid){oldx=x;oldy=y;x+=movx*20;y+=movy*20;draw=20} else {
if !place_meeting(x,y+movy*20,Solid){oldx=x;oldy=y;y+=movy*20;draw=20} else {
if !place_meeting(x+movx*20,y,Solid){oldx=x;oldy=y;x+=movx*20;draw=20}}}
}
}
