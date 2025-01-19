function SC_Walls_Create_A(wall_type_ref) {
	ex[0]=0;
	ix[0]=0;
	iy[0]=0;
	im[0]=0;
	ex[1]=0;
	ix[1]=0;
	iy[1]=0;
	im[1]=0;
	ex[2]=0;
	ix[2]=0;
	iy[2]=0;
	im[2]=0;
	
	if place_meeting(x,y-20,wall_type_ref){u=1} else {u=0}
	if place_meeting(x+20,y,wall_type_ref){r=1} else {r=0}
	if place_meeting(x,y+20,wall_type_ref){d=1} else {d=0}
	if place_meeting(x-20,y,wall_type_ref){l=1} else {l=0}

image_speed = 0;
	if u=0 && r=0 && d=0 && l=0 {image_index=0;
	if !place_meeting(x+20,y,wall_type_ref){ex[0]=1;ix[0]=20;iy[0]=0;im[0]=4}
	if !place_meeting(x+20,y+20,wall_type_ref){ex[1]=1;ix[1]=20;iy[1]=20;im[1]=2}
	if !place_meeting(x,y+20,wall_type_ref){ex[2]=1;ix[2]=0;iy[2]=20;im[2]=0}
	}
	if u=1 && r=0 && d=0 && l=0 {image_index=1;
	if !place_meeting(x+20,y+20,wall_type_ref){ex[1]=1;ix[1]=20;iy[1]=20;im[1]=2}
	if !place_meeting(x,y+20,wall_type_ref){ex[2]=1;ix[2]=0;iy[2]=20;im[2]=0}
	}
	if u=0 && r=1 && d=0 && l=0 {image_index=2;
	if !place_meeting(x,y+20,wall_type_ref){ex[2]=1;ix[2]=0;iy[2]=20;im[2]=0}
	if !place_meeting(x+20,y+20,wall_type_ref){ex[1]=1;ix[1]=20;iy[1]=20;im[1]=1}
	}
	if u=0 && r=0 && d=1 && l=0 {image_index=3;
	if !place_meeting(x+20,y,wall_type_ref){ex[0]=1;ix[0]=20;iy[0]=0;im[0]=4}
	if !place_meeting(x+20,y+20,wall_type_ref){ex[1]=1;ix[1]=20;iy[1]=20;im[1]=3}
	}
	if u=0 && r=0 && d=0 && l=1 {image_index=4;
	if !place_meeting(x+20,y,wall_type_ref){ex[0]=1;ix[0]=20;iy[0]=0;im[0]=4}
	if !place_meeting(x+20,y+20,wall_type_ref){ex[1]=1;ix[1]=20;iy[1]=20;im[1]=2}
	}
	if u=1 && r=0 && d=1 && l=0 {image_index=5;
	if !place_meeting(x+20,y+20,wall_type_ref){ex[0]=1;ix[0]=20;iy[0]=20;im[0]=3}
	}
	if u=0 && r=1 && d=0 && l=1 {image_index=6;
	if !place_meeting(x+20,y+20,wall_type_ref){ex[2]=1;ix[2]=20;iy[2]=20;im[2]=1}
	}
	if u=1 && r=1 && d=0 && l=0 {image_index=7;
	if !place_meeting(x,y+20,wall_type_ref){ex[2]=1;ix[2]=0;iy[2]=20;im[2]=0}
	if !place_meeting(x+20,y+20,wall_type_ref){ex[1]=1;ix[1]=20;iy[1]=20;im[1]=1}
	}
	if u=0 && r=1 && d=1 && l=0 {image_index=8
	if !place_meeting(x+20,y+20,wall_type_ref){ex[0]=1;ix[0]=20;iy[0]=20;im[0]=5}
	}
	if u=0 && r=0 && d=1 && l=1 {image_index=9;
	if !place_meeting(x+20,y,wall_type_ref){ex[0]=1;ix[0]=20;iy[0]=0;im[0]=4}
	if !place_meeting(x+20,y+20,wall_type_ref){ex[1]=1;ix[1]=20;iy[1]=20;im[1]=3}
	}
	if u=1 && r=0 && d=0 && l=1 {image_index=10;
	if !place_meeting(x+20,y+20,wall_type_ref){ex[1]=1;ix[1]=20;iy[1]=20;im[1]=2}
	}
	if u=1 && r=1 && d=1 && l=0 {image_index=11
	if !place_meeting(x+20,y+20,wall_type_ref){ex[0]=1;ix[0]=20;iy[0]=20;im[0]=5}
	}
	if u=0 && r=1 && d=1 && l=1 {image_index=12
	if !place_meeting(x+20,y+20,wall_type_ref){ex[0]=1;ix[0]=20;iy[0]=20;im[0]=5}
	}
	if u=1 && r=0 && d=1 && l=1 {image_index=13;
	if !place_meeting(x+20,y+20,wall_type_ref){ex[0]=1;ix[0]=20;iy[0]=20;im[0]=3}
	}
	if u=1 && r=1 && d=0 && l=1 {image_index=14;
	if !place_meeting(x+20,y+20,wall_type_ref){ex[2]=1;ix[2]=20;iy[2]=20;im[2]=1}
	}
	if u=1 && r=1 && d=1 && l=1 {image_index=15
	if !place_meeting(x+20,y+20,wall_type_ref){ex[0]=1;ix[0]=20;iy[0]=20;im[0]=5}
	}
	
	/*
	surface_set_target(global.surf)
	if ex[0]=1{draw_sprite(S_Shadow,im[0],x+ix[0],y+iy[0])}
	if ex[1]=1{draw_sprite(S_Shadow,im[1],x+ix[1],y+iy[1])}
	if ex[2]=1{draw_sprite(S_Shadow,im[2],x+ix[2],y+iy[2])}
	surface_reset_target()
	*/


/* end SC_Walls_Create_A */
}
