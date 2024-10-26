function draw_items(argument0, argument1, argument2, argument3) {
	switch(argument0){
	    case(0):
	        if argument3>0{
	                draw_rectangle_color(argument1,argument2,argument1+25,argument2+25,c_black,c_black,c_black,c_black,0)
	                draw_set_font(font0)
	                draw_set_halign(fa_right)
	                draw_text_color(argument1+25,argument2+10,string_hash_to_newline("!"+string(argument3)+"!"),c_white,c_white,c_white,c_white,1)
	                draw_set_halign(fa_left)

	        }
	    exit;
	    case(1):
	        draw_sprite(Grass,0,argument1,argument2)
	    exit;
	    case(2):
	        draw_sprite(Mush,0,argument1,argument2)
	    exit;
	    case(3):
	        draw_sprite(Grassmush,0,argument1,argument2)
	    exit;
	}

	    draw_rectangle_color(argument1,argument2,argument1+25,argument2+25,c_black,c_black,c_black,c_black,0)
	    draw_set_font(font0)
	                draw_set_halign(fa_right)
	                draw_text_color(argument1+25,argument2+10,string_hash_to_newline(string(argument0)),c_white,c_white,c_white,c_white,1)
	                draw_set_halign(fa_left)



}
