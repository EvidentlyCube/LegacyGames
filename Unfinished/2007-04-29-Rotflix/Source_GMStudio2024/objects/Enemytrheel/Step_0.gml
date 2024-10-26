if global.turn=1{
 if dumd=1{if !place_meeting(x+global.con_ix[dir]*20,y+global.con_iy[dir]*20,Solid) && Arrowing(global.con_ix[dir],global.con_iy[dir]){oldx=x;oldy=y;x+=global.con_ix[dir]*20;y+=global.con_iy[dir]*20;draw=20;dumd=0;exit}}
 var dix;
  dix=dir-1
  if dix=-1{dix=3}
  if place_meeting(x+global.con_ix[dix]*20,y+global.con_iy[dix]*20,Solid) or !Arrowing(global.con_ix[dix],global.con_iy[dix]){
   if place_meeting(x+global.con_ix[dir]*20,y+global.con_iy[dir]*20,Solid) or !Arrowing(global.con_ix[dir],global.con_iy[dir]){dir+=1;dumd=1} else {oldx=x;oldy=y;x+=global.con_ix[dir]*20;y+=global.con_iy[dir]*20;draw=20}
  } else {dir-=1;dumd=1}
if dir=4{dir=0}
if dir=-1{dir=3}
}
