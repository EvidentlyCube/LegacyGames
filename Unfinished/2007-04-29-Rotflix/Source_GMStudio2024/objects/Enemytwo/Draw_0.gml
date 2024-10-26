if draw=0{draw_sprite(S_Enemytwo,dir*3+state,x,y)} else {
oldx=oldx+(x-oldx)/4
oldy=oldy+(y-oldy)/4
draw_sprite(sprite_index,dir*3+state,oldx,oldy)
draw-=1
}
