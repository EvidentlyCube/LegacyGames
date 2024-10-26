function SC_Acid_Draw() {
	draw_sprite_ext(S_PlayerAcid,image_index,x,y,1,1,0,color,1-(image_index/16))
	if image_index=14{instance_destroy()}



}
