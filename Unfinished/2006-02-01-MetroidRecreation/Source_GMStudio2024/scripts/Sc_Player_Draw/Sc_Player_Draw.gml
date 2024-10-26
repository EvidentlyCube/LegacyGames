function Sc_Player_Draw() {
	if p_stat=0{
	    draw_sprite(sprite0,p_dir,p_x*20-20,60+p_y*20)
	} else {
	    draw_sprite(sprite17,p_dir,p_x*20-20,60+p_y*20)
	}
	draw_sprite_ext(Swordie,0,sw_x*20-10,sw_y*20+70,1,1,sw_dir*45,c_white,1)



}
