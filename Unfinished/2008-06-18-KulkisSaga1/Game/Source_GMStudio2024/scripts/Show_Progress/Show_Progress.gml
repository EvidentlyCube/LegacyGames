function Show_Progress(argument0) {
	/*
	Showing Progress while loading in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Show_Progress(text,percent)
	text - what text to show
	percent - percents of completion of current process (0-1)
	*/

	draw_set_font(global.font)
	draw_set_alpha(1)
	draw_set_blend_mode(bm_normal)
	draw_clear(c_black)
	draw_set_color(c_white)
	draw_set_halign(fa_center)
	draw_text(room_width/2,room_height/2,string_hash_to_newline(argument0))
	draw_set_halign(fa_left)

	/*
	draw_set_alpha(1)
	draw_clear(c_black)
	draw_set_color(c_white)
	draw_set_halign(fa_center)
	draw_text(room_width/2,room_height/2-50,argument0)
	draw_rectangle(100,room_height/2-17,room_width-100,room_height/2+17,1)
	draw_rectangle(102,room_height/2-15,102+(room_width-204)*argument1,room_height/2+15,0)
	draw_set_halign(fa_left)
	screen_refresh()


/* end Show_Progress */
}
