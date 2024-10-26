function Add_Mushroom() {
	surface_set_target(global.sur_fore)
	draw_sprite_ext(S_Mush_Leg,0,x+12,y+24,l_scx,l_scy,l_rot,l_col,1)
	draw_sprite_ext(S_Mush_Head,0,x+12+lengthdir_x(l_len,90+l_rot),y+24+lengthdir_y(l_len,90+l_rot),h_scx,h_scy,h_rot,h_col,1)
	instance_destroy()
	surface_reset_target()



}
