function SC_Walls_Create_B(argument0) {
	if variable_instance_exists(id, "wall_magic_stop") { exit; }
	//if global.wall_magic_stop { exit }
	if place_meeting(x,y-20,argument0){u=1} else {u=0}
	if place_meeting(x+20,y,argument0){r=1} else {r=0}
	if place_meeting(x,y+20,argument0){d=1} else {d=0}
	if place_meeting(x-20,y,argument0){l=1} else {l=0}
	if place_meeting(x+20,y-20,argument0){ur=1} else {ur=0}
	if place_meeting(x+20,y+20,argument0){dr=1} else {dr=0}
	if place_meeting(x-20,y+20,argument0){dl=1} else {dl=0}
	if place_meeting(x-20,y-20,argument0){ul=1} else {ul=0}

	image_speed = 0;
	if u=1 && ur=1 && r=1 && dr=1 && d=1 && dl=1 && l=1 && ul=0{image_index=19;exit}
	if u=1 && ur=0 && r=1 && dr=1 && d=1 && dl=1 && l=1 && ul=1{image_index=20;exit}
	if u=1 && ur=1 && r=1 && dr=1 && d=1 && dl=0 && l=1 && ul=1{image_index=25;exit}
	if u=1 && ur=1 && r=1 && dr=0 && d=1 && dl=1 && l=1 && ul=1{image_index=26;exit}
	if u=1 && ur=0 && r=1 && dr=0 && d=1 && dl=0 && l=1 && ul=0{image_index=35;exit}
	if u=1 && ur=0 && r=1 && dr=1 && d=1 && dl=1 && l=1 && ul=0{image_index=36;exit}
	if u=1 && ur=1 && r=1 && dr=0 && d=1 && dl=1 && l=1 && ul=0{image_index=37;exit}
	if u=1 && ur=1 && r=1 && dr=1 && d=1 && dl=0 && l=1 && ul=0{image_index=38;exit}
	if u=1 && ur=0 && r=1 && dr=0 && d=1 && dl=1 && l=1 && ul=1{image_index=39;exit}
	if u=1 && ur=0 && r=1 && dr=1 && d=1 && dl=0 && l=1 && ul=1{image_index=40;exit}
	if u=1 && ur=1 && r=1 && dr=0 && d=1 && dl=0 && l=1 && ul=1{image_index=41;exit}
	if u=1 && ur=0 && r=1 && dr=0 && d=1 && dl=1 && l=1 && ul=0{image_index=42;exit}
	if u=1 && ur=0 && r=1 && dr=1 && d=1 && dl=0 && l=1 && ul=0{image_index=43;exit}
	if u=1 && ur=1 && r=1 && dr=0 && d=1 && dl=0 && l=1 && ul=0{image_index=44;exit}
	if u=1 && ur=0 && r=1 && dr=0 && d=1 && dl=0 && l=1 && ul=1{image_index=45;exit}
	if u=1 && ur=1 && r=1 && dr=1 && d=1 && dl=1 && l=1 && ul=1{image_index=46;exit}
	if u=1 && ur=1 && r=1 && d=0  && l=1 && ul=1{image_index=1;exit}
	if u=1 && ur=0 && r=1 && d=0  && l=1 && ul=1{image_index=2;exit}
	if u=1 && ur=1 && r=1 && d=0  && l=1 && ul=0{image_index=3;exit}
	if u=1 && ur=0 && r=1 && d=0  && l=1 && ul=0{image_index=4;exit}
	if u=1 && r=0  && d=1 && dl=1 && l=1 && ul=1{image_index=6;exit}
	if u=1 && ur=0 && r=1 && dr=0 && d=1 && l=0 {image_index=11;exit}
	if u=1 && r=0  && d=1 && dl=0 && l=1 && ul=1{image_index=12;exit}
	if u=1 && ur=1 && r=1 && dr=0 && d=1 && l=0 {image_index=17;exit}
	if u=1 && r=0  && d=1 && dl=1 && l=1 && ul=0{image_index=18;exit}
	if u=1 && ur=0 && r=1 && dr=1 && d=1 && l=0 {image_index=23;exit}
	if u=1 && r=0  && d=1 && dl=0 && l=1 && ul=0{image_index=24;exit}
	if u=0 && r=1 && dr=0 && d=1 && dl=0 && l=1 {image_index=31;exit}
	if u=0 && r=1 && dr=0 && d=1 && dl=1 && l=1 {image_index=32;exit}
	if u=0 && r=1 && dr=1 && d=1 && dl=0 && l=1 {image_index=33;exit}
	if u=0 && r=1 && dr=1 && d=1 && dl=1 && l=1 {image_index=34;exit}
	if u=1 && ur=1 && r=1 && dr=1 && d=1 && l=0 {image_index=29;exit}
	if u=1 && ur=1 && r=1 && d=0 && l=0  {image_index=13;exit}
	if u=1 && r=0  && d=0 && l=1 && ul=1 {image_index=14;exit}
	if u=1 && ur=0 && r=1 && d=0 && l=0  {image_index=15;exit}
	if u=1 && r=0  && d=0 && l=1 && ul=0 {image_index=16;exit}
	if u=0 && r=1 && dr=1 && d=1  && l=0 {image_index=7;exit}
	if u=0 && r=0 && d=1  && dl=1 && l=1 {image_index=8;exit}
	if u=0 && r=1 && dr=0 && d=1  && l=0 {image_index=9;exit}
	if u=0 && r=0 && d=1  && dl=0 && l=1 {image_index=10;exit}
	if u=0 && r=0 && d=0 && l=0 {image_index=0;exit}
	if u=1 && r=0 && d=1  && l=0 {image_index=5;exit}
	if u=0 && r=0  && d=1 && l=0 {image_index=21;exit}
	if u=0 && r=0 && d=0  && l=1 {image_index=22;exit}
	if u=0 && r=1 && d=0  && l=0 {image_index=27;exit}
	if u=1 && r=0 && d=0  && l=0 {image_index=28;exit}
	if u=0 && r=1  && d=0 && l=1 {image_index=30;exit}



}
