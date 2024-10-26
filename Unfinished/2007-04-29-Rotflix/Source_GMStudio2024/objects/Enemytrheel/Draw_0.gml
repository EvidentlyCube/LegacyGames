draw_sprite_ext(S_Enemyonenose,dir,oldx,oldy,1,1,0,c_black,1)

if draw=0{
	draw_sprite(sprite_index,image_index,x,y)
} else {
	oldx=oldx+(x-oldx)/4
	oldy=oldy+(y-oldy)/4
	draw_sprite_ext(S_Enemythreegfx,image_index,oldx+10,oldy+10,1,1,90/((21-draw)/4)*-1+17,c_white,1)
	draw-=1
}
