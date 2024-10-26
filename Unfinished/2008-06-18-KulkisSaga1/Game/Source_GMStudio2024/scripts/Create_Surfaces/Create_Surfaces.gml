function Create_Surfaces(argument0) {
	/*
	Generating wall surfaces in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Create_Surfaces(mode)
	mode - indicates which generation to activate.
	*/

	if argument0=0{ //Create Wall
	    global.sur_wall=surface_create(800,726);
	    surface_set_target(global.sur_wall);
	    draw_clear_alpha(make_color_rgb(1,0,0),0);
	    surface_reset_target();
	}

	if argument0=1{ //Clear Wall
	    surface_set_target(global.sur_wall);
	    draw_clear_alpha(make_color_rgb(1,0,0),0);
	    /*surface_reset_target();
	    surface_set_target(global.sur_wall_back);   //Set drawing on Back surface
	    draw_surface_ext(global.sur_wall,0,0,1,1,0,c_white,1)   //Draw Main surface*/
	    draw_line_color(0,726,800,726,make_color_rgb(1,0,0),make_color_rgb(1,0,0))  // Draw Bottom line to acquire proper Transparency in sprite
	    surface_reset_target();
	}

	if argument0=2{ //Create Wall Back
	    global.sur_wall_back=surface_create(800,726);
	    surface_set_target(global.sur_wall_back);
	    draw_clear_alpha(make_color_rgb(1,0,0),0);  //Clear surface
	    surface_reset_target();
	}

	if argument0=3{ //Clear Wall Back
	    surface_set_target(global.sur_wall_back);
	    draw_clear_alpha(make_color_rgb(1,0,0),0);  //Clear surface
	    surface_reset_target();
	}

	if argument0=4{ //Generate Wall Texture
	    surface_set_target(global.sur_wall_back);
    
	    /*Draw Surface Background*/
	    draw_set_alpha(1)
	    script_execute(global.texture) //Initialise Surface generation
    
	    surface_set_target(global.sur_wall)
	    draw_line_color(0,726,800,726,make_color_rgb(1,0,0),make_color_rgb(1,0,0))  // Draw Bottom line to acquire proper Transparency in sprite
	    surface_reset_target();
	}

	if argument0=5{ //Create Background
	    global.sur_back=surface_create(800,726);
	    surface_set_target(global.sur_back);
	    draw_clear_alpha(make_color_rgb(1,0,0),0);
	    surface_reset_target();
	}

	if argument0=6{ //Clear Background
	    surface_set_target(global.sur_back);
	    draw_clear_alpha(make_color_rgb(1,0,0),0);
	    surface_reset_target();
	}

	if argument0=7{ //Create Foreground
	    global.sur_fore=surface_create(800,726);
	    surface_set_target(global.sur_fore);
	    draw_clear_alpha(make_color_rgb(1,0,0),0);
	    surface_reset_target();
	}

	if argument0=8{ //Clear Foreground
	    surface_set_target(global.sur_fore);
	    draw_clear_alpha(make_color_rgb(1,0,0),0);
	    surface_reset_target();
	}



}
