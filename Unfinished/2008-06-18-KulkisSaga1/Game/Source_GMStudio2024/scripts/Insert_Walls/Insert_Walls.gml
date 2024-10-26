function Insert_Walls() {
	/*
	Walls creation code in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as yours, read and see this code!

	Insert_Walls()
	*/
	surface_set_target(global.sur_wall)
	draw_set_alpha(1)
	draw_set_blend_mode(bm_normal)
	draw_surface_part(global.sur_wall_back,x,y,25,25,x,y)
	draw_set_blend_mode_ext(bm_dest_color,bm_zero)
	draw_set_alpha(1)
	/*-----------------------------------------------  SHADING */
	/*Checking For Walls Around!*/
	sprite_index=S_Shadings
	r=sign(place_meeting(x+25,y,Par_GFX_Walls))
	dr=sign(place_meeting(x+25,y+25,Par_GFX_Walls))
	d=sign(place_meeting(x,y+25,Par_GFX_Walls))
	dl=sign(place_meeting(x-25,y+25,Par_GFX_Walls))
	l=sign(place_meeting(x-25,y,Par_GFX_Walls))
	ul=sign(place_meeting(x-25,y-25,Par_GFX_Walls))
	u=sign(place_meeting(x,y-25,Par_GFX_Walls))
	ur=sign(place_meeting(x+25,y-25,Par_GFX_Walls))
	while (1=1){
	if r=1 && d=1 && dr=1{image_index=14;break}
	if r=1 && d=1{image_index=13;break}
	if r=1 && d=0{image_index=12;break}
	if r=0 && d=1{image_index=11;break}
	image_index=10;
	break;
	}draw_me()

	while (1=1){
	if r=1 && u=1 && ur=1{image_index=19;break}
	if r=1 && u=1{image_index=18;break}
	if r=1 && u=0{image_index=16;break}
	if r=0 && u=1{image_index=17;break}
	image_index=15;
	break;
	}draw_me()

	while (1=1){
	if l=1 && d=1 && dl=1{image_index=9;break}
	if l=1 && d=1{image_index=8;break}
	if l=1 && d=0{image_index=6;break}
	if l=0 && d=1{image_index=7;break}
	image_index=5;
	break;
	}draw_me()

	while (1=1){
	if l=1 && u=1 && ul=1{image_index=4;break}
	if l=1 && u=1{image_index=3;break}
	if l=1 && u=0{image_index=2;break}
	if l=0 && u=1{image_index=1;break}
	image_index=0;
	break;
	}draw_me()

	draw_set_blend_mode(bm_normal)
	surface_reset_target()




}
