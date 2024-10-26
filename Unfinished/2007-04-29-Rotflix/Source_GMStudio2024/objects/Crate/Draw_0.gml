if draw=0{draw_sprite(sprite_index,image_index,x,y)} else {
oldx=oldx+(x-oldx)/4
oldy=oldy+(y-oldy)/4
draw_sprite(sprite_index,image_index,oldx,oldy)
draw-=1
}
