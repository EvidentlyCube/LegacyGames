function Texture_Techno() {
	/*
	Generating Technologist wall texture in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Texture_Techno()
	*/
	draw_rectangle_color(0,0,800,725,make_color_rgb(188,174,138),make_color_rgb(188,174,138),make_color_rgb(188,174,138),make_color_rgb(188,174,138),0)

	for (a=0;a<725;a+=1){
	    for (b=0;b<800;b+=1){
	            color=choose(make_color_rgb(198,180,140),make_color_rgb(178,169,135));
	            draw_set_alpha(random(0.25)+0.75)
	            draw_set_blend_mode(choose(bm_normal))
	                    draw_point_color(b,a,color);
	    }
	}
	for (b=0;b<801;b+=25){
	            color=make_color_rgb(198,180,140);
	            draw_set_alpha(0.5)
	            draw_set_blend_mode(bm_subtract)
	            draw_line_color(b-1,0,b-1,725,color,color);
	            color=make_color_rgb(178,169,135);
	            draw_set_alpha(0.3)
	            draw_set_blend_mode(bm_add);
	            draw_line_color(b,0,b,725,color,color);
	}
	for (b=0;b<726;b+=25){
	            color=make_color_rgb(198,180,140);
	            draw_set_alpha(0.5)
	            draw_set_blend_mode(bm_subtract)
	            draw_line_color(0,b-1,800,b-1,color,color);
	            color=make_color_rgb(178,169,135);
	            draw_set_alpha(0.3)
	            draw_set_blend_mode(bm_add);
	            draw_line_color(0,b,800,b,color,color);
	}

	draw_set_blend_mode(bm_normal)

	draw_set_alpha(1)
	draw_set_blend_mode(bm_normal)
	surface_reset_target();

	/*Make Surface Untransparent*/
	surface_copy(global.sur_wall,0,0,global.sur_wall_back) //Copy Back surface to Main
	surface_set_target(global.sur_wall_back);   //Set drawing on Back surface
	draw_surface_ext(global.sur_wall,0,0,1,1,0,c_white,1)   //Draw Main surface
	draw_line_color(0,726,800,726,make_color_rgb(1,0,0),make_color_rgb(1,0,0))  // Draw Bottom line to acquire proper Transparency in sprite
	surface_reset_target();



}
