if draw=0{draw_sprite(S_Enemysix,image_index,x,y)} else {
oldx=oldx+(x-oldx)/4
oldy=oldy+(y-oldy)/4
draw_sprite_ext(S_Enemysixcent,oldim,oldx+10,oldy+10,1-1/(draw/3),1-1/(draw/3),0,c_white,1-1/(draw/5))
draw_sprite_ext(S_Enemysixcent,image_index,oldx+10,oldy+10,1/max(1,(draw/3)),1/max(1,(draw/3)),0,c_white,1/(draw/5))
draw-=1
}
