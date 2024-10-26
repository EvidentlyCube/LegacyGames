function Sc_Player_Beam_Draw() {
	for (i=0;i<b_tot;i+=1){
	draw_sprite(Beam_1,ds_list_find_value(b_dir,i),ds_list_find_value(b_x,i)*20-20,60+ds_list_find_value(b_y,i)*20)
	}



}
