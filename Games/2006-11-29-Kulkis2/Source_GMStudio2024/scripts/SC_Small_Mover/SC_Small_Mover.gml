function SC_Small_Mover() {
	if mover=0{
	if instance_exists(MoverR){
	if instance_exists(MoverD){
	if instance_exists(MoverL){
	if instance_exists(MoverU){
	ix=0
	iy=0
	mover=0
	global.used=x
	with (MoverD) {if x=global.used{global.used=1}}
	if global.used=1{if !place_meeting(x,y+20,SolidWalls){mover=1;iy=20;exit}global.used=0}
	with (MoverU) {if x=global.used{global.used=1}}
	if global.used=1{if !place_meeting(x,y-20,SolidWalls){mover=1;iy=-20;exit}global.used=0}
	global.used=y
	with (MoverR) {if y=global.used{global.used=1}}
	if global.used=1{if !place_meeting(x+20,y,SolidWalls){mover=1;ix=20;exit}global.used=0}
	with (MoverL) {if y=global.used{global.used=1}}
	if global.used=1{if !place_meeting(x-20,y,SolidWalls){mover=1;ix=-20;exit}global.used=0}
	}
	}
	}
	}
	}



}
