draw_sprite_ext(S_Enemyonenose,dir,oldx,oldy,1,1,0,c_white,0.3+random(8)/10)
if drawb=0{draw_sprite(S_Enemyone,0,x,y)} else {
oldx=oldx+(x-oldx)/4
oldy=oldy+(y-oldy)/4
draw_sprite(sprite_index,image_index,oldx,oldy)
drawb-=1
}

