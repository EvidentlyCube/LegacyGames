function lev_comp() {
	    if global.sound=1 {sound_play(s3)}
	draw_set_alpha(0.5);
	    draw_set_color(c_blue)
	    draw_rectangle(0,room_height/2-60,room_width,room_height/2+60,0)
	    draw_set_blend_mode(bm_add)
	    draw_rectangle_color(0,room_height/2-80,room_width,room_height/2-60,c_black,c_black,c_blue,c_blue,0)
	    draw_rectangle_color(0,room_height/2+60,room_width,room_height/2+80,c_blue,c_blue,c_black,c_black,0)
	    draw_set_blend_mode(bm_normal)
	    draw_set_alpha(1);
    
	global.finish[global.level]=1;
	if global.timer<global.time[global.level]{
	    global.time[global.level]=global.timer;
	    draw_set_halign(fa_center);
	    draw_set_color(c_black);
	    draw_text(room_width/2+2,room_height/2-48,string_hash_to_newline("You have made a new personal#record in this level!##Press \"Enter\" to continue.."));
	    draw_set_color(c_white);
	    draw_text(room_width/2,room_height/2-50,string_hash_to_newline("You have made a new personal#record in this level!##Press \"Enter\" to continue.."));
	    draw_set_halign(fa_left);
	} else {
	    draw_set_halign(fa_center);
	    draw_set_color(c_black);
	    draw_text(room_width/2+2,room_height/2-48,string_hash_to_newline("##Press \"Enter\" to continue.."));
	    draw_set_color(c_white);
	    draw_text(room_width/2,room_height/2-50,string_hash_to_newline("##Press \"Enter\" to continue.."));
	    draw_set_halign(fa_left);
	}
	if global.level=global.maxi-1{global.completed+=1;}
	global.number=0
	global.maxi=0
	screen_refresh()
	while(x=x){
	keyboard_wait()
	if keyboard_check_pressed(vk_enter){break}
	}
	room_goto(savix)



}
