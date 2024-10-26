function Add_Crack(argument0, argument1, argument2, argument3) {
	/*
	Adding crack to wall texture in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Add_Crack(x,y,number,size)
	x,y - X/Y coordnates of the center of the crack
	number - number of the branches in the crack
	size - maximal length in pixels of the branch
	*/
	var a_l,a_d,b_l,b_d,c_l,c_d,c_pos,iiz_iizz,iix_a,iiy_a,iix_b,iix_b,surf;
	surf=surface_create(800,726)
	surface_set_target(surf)
	draw_set_blend_mode(bm_normal);
	draw_set_alpha(1)
	draw_set_color(c_black)
	draw_clear_alpha(make_color_rgb(1,0,0),0);
	iiz=0
	repeat(ceil(max(random(argument2),random(argument2),random(argument2),random(argument2),random(argument2)))){
	    a_l[iiz]=fran(argument3*0.5)+argument3*0.5;
	    a_d[iiz]=random(360);
	    b_l[iiz]=fran(a_l[iiz]*0.7)+a_l[iiz]*0.2;
	    b_d[iiz]=a_d[iiz]+dran(70);
	    c_l[iiz]=fran(a_l[iiz]*0.6)+a_l[iiz]*0.1;
	    c_d[iiz]=a_d[iiz]+90*choose(-1,1)+dran(80);
	    c_pos[iiz]=0.1+random(0.8);
	    iiz+=1
	}
	iizz=iiz;
	iiz=0
	repeat(iizz){
	    iix_a=argument0;
	    iiy_a=argument1;
	    iix_b=argument0+lengthdir_x(a_l[iiz],a_d[iiz])
	    iiy_b=argument1+lengthdir_y(a_l[iiz],a_d[iiz])
	    Crack_Draw(iix_a,iiy_a,iix_b,iiy_b,1)
	    iix_a=argument0+lengthdir_x(a_l[iiz],a_d[iiz]);
	    iiy_a=argument1+lengthdir_y(a_l[iiz],a_d[iiz]);
	    iix_b=argument0+lengthdir_x(a_l[iiz],a_d[iiz])+lengthdir_x(b_l[iiz],b_d[iiz])
	    iiy_b=argument1+lengthdir_y(a_l[iiz],a_d[iiz])+lengthdir_y(b_l[iiz],b_d[iiz])
	    Crack_Draw(iix_a,iiy_a,iix_b,iiy_b,1)
	    iix_a=argument0+lengthdir_x(a_l[iiz],a_d[iiz])*c_pos[iiz]
	    iiy_a=argument1+lengthdir_y(a_l[iiz],a_d[iiz])*c_pos[iiz]
	    iix_b=argument0+lengthdir_x(a_l[iiz],a_d[iiz])*c_pos[iiz]+lengthdir_x(c_l[iiz],c_d[iiz])
	    iiy_b=argument1+lengthdir_y(a_l[iiz],a_d[iiz])*c_pos[iiz]+lengthdir_y(c_l[iiz],c_d[iiz])
	    Crack_Draw(iix_a,iiy_a,iix_b,iiy_b,1)
	    iiz+=1
	}
	surface_set_target(global.sur_wall_back)
	draw_set_blend_mode(bm_subtract);
	draw_surface_ext(surf,0,0,1,1,0,c_white,0.1)

	surface_set_target(surf)
	draw_set_alpha(1)
	draw_set_blend_mode(bm_normal);
	draw_set_color(c_white)
	draw_clear_alpha(make_color_rgb(1,0,0),0);
	iiz=0
	repeat(iizz){
	    iix_a=argument0;
	    iiy_a=argument1;
	    iix_b=argument0+lengthdir_x(a_l[iiz],a_d[iiz])
	    iiy_b=argument1+lengthdir_y(a_l[iiz],a_d[iiz])
	    Crack_Draw(iix_a,iiy_a,iix_b,iiy_b,-1)
	    iix_a=argument0+lengthdir_x(a_l[iiz],a_d[iiz]);
	    iiy_a=argument1+lengthdir_y(a_l[iiz],a_d[iiz]);
	    iix_b=argument0+lengthdir_x(a_l[iiz],a_d[iiz])+lengthdir_x(b_l[iiz],b_d[iiz])
	    iiy_b=argument1+lengthdir_y(a_l[iiz],a_d[iiz])+lengthdir_y(b_l[iiz],b_d[iiz])
	    Crack_Draw(iix_a,iiy_a,iix_b,iiy_b,-1)
	    iix_a=argument0+lengthdir_x(a_l[iiz],a_d[iiz])*c_pos[iiz]
	    iiy_a=argument1+lengthdir_y(a_l[iiz],a_d[iiz])*c_pos[iiz]
	    iix_b=argument0+lengthdir_x(a_l[iiz],a_d[iiz])*c_pos[iiz]+lengthdir_x(c_l[iiz],c_d[iiz])
	    iiy_b=argument1+lengthdir_y(a_l[iiz],a_d[iiz])*c_pos[iiz]+lengthdir_y(c_l[iiz],c_d[iiz])
	    Crack_Draw(iix_a,iiy_a,iix_b,iiy_b,-1)
	    iiz+=1
	}
	surface_set_target(global.sur_wall_back)
	draw_set_blend_mode(bm_add);
	draw_surface_ext(surf,0,0,1,1,0,c_white,0.1)

	surface_set_target(surf)
	draw_set_blend_mode(bm_normal);
	draw_set_color(c_black)
	draw_clear_alpha(make_color_rgb(1,0,0),0);
	iiz=0
	repeat(iizz){
	    iix_a=argument0;
	    iiy_a=argument1;
	    iix_b=argument0+lengthdir_x(a_l[iiz],a_d[iiz])
	    iiy_b=argument1+lengthdir_y(a_l[iiz],a_d[iiz])
	    draw_line(iix_a,iiy_a,iix_b,iiy_b)
	    iix_a=argument0+lengthdir_x(a_l[iiz],a_d[iiz]);
	    iiy_a=argument1+lengthdir_y(a_l[iiz],a_d[iiz]);
	    iix_b=argument0+lengthdir_x(a_l[iiz],a_d[iiz])+lengthdir_x(b_l[iiz],b_d[iiz])
	    iiy_b=argument1+lengthdir_y(a_l[iiz],a_d[iiz])+lengthdir_y(b_l[iiz],b_d[iiz])
	    draw_line(iix_a,iiy_a,iix_b,iiy_b)
	    iix_a=argument0+lengthdir_x(a_l[iiz],a_d[iiz])*c_pos[iiz]
	    iiy_a=argument1+lengthdir_y(a_l[iiz],a_d[iiz])*c_pos[iiz]
	    iix_b=argument0+lengthdir_x(a_l[iiz],a_d[iiz])*c_pos[iiz]+lengthdir_x(c_l[iiz],c_d[iiz])
	    iiy_b=argument1+lengthdir_y(a_l[iiz],a_d[iiz])*c_pos[iiz]+lengthdir_y(c_l[iiz],c_d[iiz])
	    draw_line(iix_a,iiy_a,iix_b,iiy_b)
	    iiz+=1
	}

	surface_set_target(global.sur_wall_back)
	draw_surface_ext(surf,0,0,1,1,0,c_white,1)
	surface_reset_target()
	surface_free(surf)
	draw_set_blend_mode(bm_normal);
	draw_set_alpha(1)
	draw_set_color(c_black)



}
