function Door_Add_Base() {
	surface_set_target(global.sur_wall)
	draw_set_alpha(1)
	var posix,posiy;
	posix=x
	posiy=y
	switch(image_index){
	    case(0):posix=x+25;break;
	    case(1):posiy=y+25;break;
	    case(2):posix=x-25;break;
	    case(3):posiy=y-25;break;
	}
	draw_sprite(S_Door_Base,image_index+4*type,posix,posiy)
	surface_reset_target();



}
