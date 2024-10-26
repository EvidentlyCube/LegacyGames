function Insert_Grass(argument0, argument1, argument2, argument3, argument4, argument5) {
	/*
	Adding grass to the foreground image in Kulkis Saga I:Shadowy Prologue.
	Everything created and maintained by Maurice Zarzycki.
	You may not copy, use, claim as your, read and see this code!

	Insert_Grass(x,y,right,down,left,up)
	x,y - X/Y coordinates of the grass square
	right,down,left,up - whether to insert grass on indicated border
	*/

	surface_set_target(global.sur_fore)

	var number,v_curr,ix,ixr,iy,iyr;

	number=random(20)+5;
	v_curr=0
	repeat(number){
	    if argument2=1{
	        ix=argument0+24;
	        iy=argument1+random(25);
	        ixr=argument0+20-random(6);
	        iyr=iy+dran(10);
	        draw_set_color(make_color_rgb(0,255-(180/number)*v_curr,0))
	        draw_line(ix,iy,ixr,iyr)
	    }
	    if argument3=1{
	        ix=argument0+random(25);
	        iy=argument1+24;
	        ixr=ix+dran(10);
	        iyr=argument1+20-random(6);
	        draw_set_color(make_color_rgb(0,255-(180/number)*v_curr,0))
	        draw_line(ix,iy,ixr,iyr)
	    }
	    if argument4=1{
	        ix=argument0;
	        iy=argument1+random(25);
	        ixr=argument0+4+random(6);
	        iyr=iy+dran(10);
	        draw_set_color(make_color_rgb(0,255-(180/number)*v_curr,0))
	        draw_line(ix,iy,ixr,iyr)
	    }
	    if argument5=1{
	        ix=argument0+random(25);
	        iy=argument1;
	        ixr=ix+dran(10);
	        iyr=argument1+4+random(6);
	        draw_set_color(make_color_rgb(0,255-(180/number)*v_curr,0))
	        draw_line(ix,iy,ixr,iyr)
	    }
	    v_curr+=1
	}

	surface_reset_target()



}
