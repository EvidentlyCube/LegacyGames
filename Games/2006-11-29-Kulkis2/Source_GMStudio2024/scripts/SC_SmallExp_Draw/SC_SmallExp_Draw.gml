function SC_SmallExp_Draw() {
	x+=ix
	y+=iy
	iy+=0.2
	rote+=rot
	draw_sprite_ext(sprite_index,image_index,x,y,1,1,rote,c_white,1)

	if y>room_height+20{instance_destroy()}



}
