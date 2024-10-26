function Sc_Debug_Drawing() {
	/*draw_rectangle_color(0,0,50,400,c_black,c_black,c_black,c_black,false)
	for (i=0;i<e_tot;i+=1){
	draw_set_font(font0)
	draw_text_color(0,10*i,string(e_x[i])+','+string(e_y[i])+','+string(e_is[i]),c_white,c_white,c_white,c_white,1)
	}*/

	/*
	for (i=0;i<e_tot;i+=1){
	draw_sprite_stretched_ext(TEHP,0,(e_x[i]-1)*20,(e_y[i]+3)*20+13,20,6,c_white,0.8)
	draw_sprite_stretched_ext(TEHP,1,(e_x[i]-1)*20+1,(e_y[i]+3)*20+14,18*e_hp[i]/e_hpmax[i],4,c_white,1)
	}
	draw_sprite_stretched_ext(TEHP,0,(p_x-1)*20,(p_y+3)*20+13,20,6,c_white,0.8)
	draw_sprite_stretched_ext(TEHP,1,(p_x-1)*20+1,(p_y+3)*20+14,18*p_hp/p_hpmax,4,c_white,1)

	if keyboard_check(vk_f2) or p_hp<=0{game_restart()}
	/*
	max_hp - 18
	hp - 5

	18 - 18
	5 - 5

	max_hp*z=18*hp
	z=18*hp/max_xp

	18*5=18*5
	5=18*5/18


/* end Sc_Debug_Drawing */
}
