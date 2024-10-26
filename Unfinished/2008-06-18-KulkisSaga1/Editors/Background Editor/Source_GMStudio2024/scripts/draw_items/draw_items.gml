function draw_items(argument0, argument1, argument2, argument3, argument4, argument5) {
	switch(argument0){
	    case(0):
	        if argument3>0 or argument4>0 or argument5>0{
	                draw_set_alpha(0.5)
	                draw_rectangle_color(argument1,argument2+10,argument1+25,argument2+25,c_black,c_black,c_black,c_black,0)
	                draw_set_font(font0)
	                draw_set_halign(fa_right)
	                draw_text_color(argument1+25,argument2+10,string_hash_to_newline("!__!"),c_white,c_white,c_white,c_white,1)
	                draw_set_halign(fa_left)
	                draw_set_alpha(1)

	        }
	    exit;
	    case(1):
	        draw_sprite(Crack,0,argument1,argument2)
	    exit;
	}

	    draw_rectangle_color(argument1,argument2,argument1+25,argument2+25,c_black,c_black,c_black,c_black,0)
	    draw_set_font(font0)
	                draw_set_halign(fa_right)
	                draw_text_color(argument1+25,argument2+10,string_hash_to_newline(string(argument0)),c_white,c_white,c_white,c_white,1)
	                draw_set_halign(fa_left)



}
