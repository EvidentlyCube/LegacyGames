function Texture_Ground() {
	/*
	Generating ground wall texture in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Texture_Ground()
	*/

	draw_rectangle_color(0,0,800,725,make_color_rgb(176,74,7),make_color_rgb(176,74,7),make_color_rgb(176,74,7),make_color_rgb(176,74,7),0)
	for (a=0;a<725;a+=15){
	    for (b=0;b<800;b+=15){
	        repeat(choose(5,6,7,8,9,10)){
	            color=choose(make_color_rgb(192,81,8),make_color_rgb(176,74,7),make_color_rgb(160,67,7),make_color_rgb(144,61,6),make_color_rgb(128,54,5),make_color_rgb(112,47,5));
	            draw_set_alpha(random(1))
	            draw_set_blend_mode(choose(bm_subtract,bm_normal))
	            switch(choose(1,2,3)){
	                case (1):
	                    draw_point_color(b+dran(20),a+dran(20),color);
	                break;
	                case (2):
	                    draw_line_color(b+dran(20),a+dran(20),b+dran(20),a+dran(20),color,color);
	                break;
	                case (3):
	                    draw_triangle_color(b+dran(20),a+dran(20),b+dran(20),a+dran(20),b+dran(20),a+dran(20),color,color,color,0);
	                break;
	                case (4):
	                    draw_rectangle(b+dran(20),a+dran(20),b+dran(20),a+dran(20),0);
	                break;
	                case (5):
	                    draw_circle(b+dran(20),a+dran(20),random(20),0);
	                break;
	                case (6):
	                    draw_ellipse(b+dran(20),a+dran(20),b+dran(20),a+dran(20),0);
	                break;
	                case (7):
	                    draw_roundrect(b+dran(20),a+dran(20),b+dran(20),a+dran(20),0);
	                break;
	            }
	        }
	    }
	}
	draw_set_blend_mode(bm_normal)


	draw_set_alpha(1)
	draw_set_blend_mode(bm_normal)
	surface_reset_target();

	/*Make Surface Untransparent*/
	surface_copy(global.sur_wall,0,0,global.sur_wall_back) //Copy Back surface to Main
	surface_set_target(global.sur_wall_back);   //Set drawing on Back surface
	draw_sprite_tiled(S_Wally,0,0,0)    //Set the background to be sprite
	draw_sprite(S_Wally,0,785,700)
	draw_set_blend_mode(bm_add)
	draw_surface_ext(global.sur_wall,0,0,1,1,0,c_white,1)   //Draw Main surface
	draw_set_blend_mode(bm_normal)
	draw_line_color(0,726,800,726,make_color_rgb(1,0,0),make_color_rgb(1,0,0))  // Draw Bottom line to acquire proper Transparency in sprite
	surface_reset_target();



}
